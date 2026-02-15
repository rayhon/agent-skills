# Topics

Technical guides, best practices, and trending topics for AI developers.

## Setup Guides

| Topic | Description |
|-------|-------------|
| [GLM-5 Setup](glm5.md) | Configure Claude Code to use GLM-5 model from z.ai as an alternative to Anthropic models |

## Best Practices

| Topic | Description |
|-------|-------------|
| [Skill Best Practices](skill-best-practice.md) | Five key patterns for creating effective AI agent skills: description engineering, impact quantification, progressive disclosure, first-party authority, and anti-pattern documentation |

## Deployment & Infrastructure

| Topic | Description |
|-------|-------------|
| [Modal Deployment](modal.md) | Complete guide to deploying AI models serverlessly with Modal, using Flux.1 image generation as a showcase. Covers container lifecycle hooks, GPU configuration, and production deployment |

## Trending Topics

| Topic | Description |
|-------|-------------|
| [News & Interviews](industry.md) | Latest industry insights and interviews from AI leaders |

---

## Quick Reference

### Setup GLM-5 on Claude Code

Add to `~/.claude/settings.json`:
```json
{
  "env": {
    "ANTHROPIC_AUTH_TOKEN": "your_zai_api_key",
    "ANTHROPIC_BASE_URL": "https://api.z.ai/api/anthropic",
    "ANTHROPIC_DEFAULT_OPUS_MODEL": "glm-5"
  }
}
```

### Deploy with Modal

```bash
# Install and authenticate
pip install modal
modal setup

# Create HuggingFace secret (for gated models)
modal secret create huggingface-secret HF_TOKEN=your_token

# Deploy
modal deploy app.py
```

### Skill Creation Patterns

1. **Description Engineering** - Include exact trigger phrases
2. **Impact Quantification** - Use numbers over adjectives
3. **Progressive Disclosure** - Keep main file under 500 lines
4. **First-Party Authority** - Prefer official framework guidance
5. **Anti-Pattern Documentation** - Document what *not* to do
