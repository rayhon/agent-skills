# Deploy Any AI Model with Modal: A Flux.1 Showcase

Modal is a low-code, serverless platform built to deploy the latest generative AI models. Before Modal, engineers had to write clunky backend infrastructure to fit GPUs to their models. Modal has abstracted this process, supplying GPU-fitted containers to run generative AI inference, fine-tuning, and large-scale batch processing.

Whether you’re at a startup or a nascent AI tinkerer, Modal offers simplistic solutions to integrate robust AI inference into your products.

---

## 1. Prerequisites & Setup

Before coding, you need to initialize your Modal environment and prepare your HuggingFace credentials.

**Step 1: Install the Modal client**
```bash
pip install modal
```

**Step 2: Authenticate with Modal**
```bash
modal setup
```

**Step 3: Configure HuggingFace Secret**
Since Flux is a gated model (for `-dev` versions) or requires authenticated access, you must add your HuggingFace token to Modal:
1. Go to your [HuggingFace Settings](https://huggingface.co/settings/tokens) and create a "Read" token.
2. Run this command to store it securely in Modal:
   ```bash
   modal secret create huggingface-secret HF_TOKEN=your_token_here
   ```

---

## 2. The Strategy: Container Lifecycle Hooks

To squeeze the most effectiveness out of Modal, it’s important to understand **“container lifecycle hooks”**. These hooks allow elements that aren’t necessary to re-run (like downloading 20GB of model weights) to run only once when the container is instantiated.

*   **`@modal.build()`**: Executed during the image build. Data downloaded here is stored in your persistent volume. 
*   **`@modal.enter()`**: Runs when a container wakes up. Perfect for pulling weights from disk into GPU VRAM.
*   **`@modal.method()`**: The core logic that executes for every user request.

---

## 3. The Complete Implementation (`app.py`)

Here is the full, assembled code using the modular "Plug-and-Play" architecture described by Shridhar Athi. This implementation separates the model engine from the infrastructure bridge.

```python
import os  
import time  
import logging
from enum import Enum  
from typing import Optional  
from dataclasses import dataclass
  
from modal import App, Image, Volume, build, enter, Secret, asgi_app, gpu, method, web_endpoint  
from pydantic import BaseModel, Field

# --- A. SETUP & CONSTANTS ---
logger = logging.getLogger(__name__)
HG_TOKEN_SECRET = "huggingface-secret"  
MODEL_DIR = "/model"  
MODEL_NAME = "black-forest-labs/FLUX.1-dev"  
MODEL_SNAPSHOT = "0ef5fff789c832c5c7f4e127f94c8b54bbcced44"

# Section 1: Define a Container Image and Volume
# We define an image with necessary packages and a volume to house model weights.
model_image = (  
    Image.debian_slim() 
    .pip_install(  
        "diffusers",  
        "huggingface_hub",  
        "Pillow",  
        "Requests",  
        "torch",  
        "transformers",  
        "peft",  
    )  
)  
  
APP_NAME = "flux"  
app = App(APP_NAME, image=model_image)  
flux_volume = Volume.from_name("flux-volume", create_if_missing=True)  
  
with model_image.imports(): # Import relevant libraries within the image  
    import time  
    import torch  
    import transformers  
    from diffusers import FluxPipeline  
    from huggingface_hub import snapshot_download
    import io

# Section 2: Define Model Class (The "Engine")
# This class sets up our Flux pipeline and runs inference independent of Modal logic.
class FluxDev:  
    def build(self):  
        if not os.path.exists(f"{MODEL_DIR}/models--{MODEL_NAME.replace('/', '--')}"):  
            snapshot_download(MODEL_NAME, cache_dir=MODEL_DIR)  
        logger.info(f"Downloaded model checkpoints: {MODEL_NAME}")  

    def __init__(self):  
        self.pipeline = None  
  
    def load(self):  
        torch.backends.cuda.enable_cudnn_sdp(False)  
        model_path = f"{MODEL_DIR}/models--{MODEL_NAME.replace('/', '--')}/snapshots/{MODEL_SNAPSHOT}"  
        self.pipeline = FluxPipeline.from_pretrained(  
            model_path,  
            torch_dtype=torch.bfloat16,  
            token=os.environ["HF_TOKEN"]  
        ).to("cuda")  
        logger.info("FluxPipeline loaded into GPU")

    def generate_image(self, prompt: str, num_inference_steps: int, seed: int):  
        try:  
            generator = torch.Generator("cuda").manual_seed(seed)  
            output = self.pipeline(  
                prompt=prompt,
                width=512,  
                height=512,  
                num_inference_steps=num_inference_steps,  
                generator=generator,  
            )  
            return output.images[0]  
        except Exception as e:  
            logger.error(f"Error during image generation: {str(e)}")  
            raise

# Section 3: Configure GPU & Infrastructure Bridge
# We connect an A100 to our app, connecting our MODEL_DIR to our volume.
@app.cls(  
    gpu=gpu.A100(size="40GB"),  
    container_idle_timeout=60,  
    keep_warm=0,  
    allow_concurrent_inputs=5,  
    volumes={MODEL_DIR: flux_volume}, #connect your MODEL_DIR to your volume  
    secrets=[  
        Secret.from_name(HG_TOKEN_SECRET, environment_name="main")  
    ]  
)
class FluxModel:  
    def __init__(self):  
        self.model = FluxDev() # Modularity: plug and play different models here
  
    @build()  
    def on_build(self):  
        self.model.build()  
  
    @enter()  
    def enter(self):  
        self.model.load()  
  
    @method()  
    async def inference(self, params) -> dict:  
        before_inference = time.time()   
        image = self.model.generate_image(  
                prompt=params.prompt,  
                num_inference_steps=params.num_inference_steps,  
                seed=params.seed,  
        )  
        return {  
            "image": image,  
            "inference_time": time.time() - before_inference,  
        }

# Section 4: Public Gateway (The Deployment Endpoint)
@dataclass  
class Params:  
    prompt: str = "a dog running through mango trees"  
    num_inference_steps: int = 20  
    seed: int = 42  
  
@app.function()  
@web_endpoint(method="POST")  
def endpoint(params: Params):  
    from fastapi import Response
    import io
    # Calls the GPU model and gets the PIL image
    result = FluxModel().inference.remote(params)  
    
    # Convert PIL to bytes for the web response
    byte_stream = io.BytesIO()
    result["image"].save(byte_stream, format="PNG")
    return Response(content=byte_stream.getvalue(), media_type="image/png")
```

---

## 4. Deployment Guide

Modal allows you to push this service live with two primary commands:

1.  **`modal serve app.py`**: Creates an ephemeral deployment. Ideal for testing locally with live logs.
2.  **`modal deploy app.py`**: Makes your endpoint **persistent**. This is what you use for production. It generates a permanent URL that you can call from any product.

### Calling your new API
Once deployed, you can interact with your Flux model via a simple POST request:

```python
import requests
url = "https://your-username--flux-endpoint.modal.run"
payload = {"prompt": "A cinematic shot of a neon cyberpunk dragon", "num_inference_steps": 20}
response = requests.post(url, json=payload)

if response.status_code == 200:
    with open("result.png", "wb") as f:
        f.write(response.content)
```

---

## 5. Conclusion

And that’s it! You can follow these steps to seamlessly integrate any of the latest cutting-edge AI models into your products. Modal eliminates the need for clunky GPU management and allows for easy image generation, fine-tuning, and large-scale inference tasks.
