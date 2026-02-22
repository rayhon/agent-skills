# 🤖 Agent Skills Repository

This repository manages a suite of specialized **Agent Skills** that extend the capabilities of AI coding assistants (like Claude Code, Antigravity, etc.) with deterministic workflows, domain expertise, and automated tools.

## 🚀 Getting Started

To equip your agent with the necessary "superpowers" for this project, run the installation script. 

### Modern Installation (Targeted)
If you are using **Claude Code**, you can target it specifically to ensure skills are symlinked into the `.claude/skills` directory:

```bash
./install-skills.sh claude-code
```

### Standard Installation
If you use multiple agents or want a general setup:

```bash
./install-skills.sh
```

This will download and symlink the required skills into your local `.agents/skills` directory and any detected agent-specific folders.


## 📂 Architecture & Directory Structure

This project uses a **Seed & Symlink** architecture to manage AI intelligence. This ensures that skills are downloaded once but can be used by any enabled AI agent without duplicating content.

### The Seed: `.agents/skills`
The `.agents/skills` folder is the **Single Source of Truth**. When you run the installation script, the actual skill files (documentation, python scripts, configuration) are downloaded into this directory.

### The Symlinks: `.[agent]/skills`
Agent-specific folders (like `.claude/skills` or `.cursor/skills`) do not contain actual files. Instead, they contain **symbolic links** (shortcuts) that point back to the seed.
- **Why?** This prevents your repository from being cluttered with redundant copies.
- **Why?** It ensures that if a skill is updated in the seed, it is instantly updated for every agent.

### Visual Diagram
```text
project-root/
├── .agents/skills/           <-- THE SEED (Source of Truth)
│   ├── ui-ux-pro-max/        (Actual files)
│   └── brainstorming/        (Actual files)
│
├── .claude/skills/           <-- THE SYMLINK (Claude Code access)
│   ├── ui-ux-pro-max  ------> (Points to .agents/skills/ui-ux-pro-max)
│   └── brainstorming  ------> (Points to .agents/skills/brainstorming)
│
└── install-skills.sh         (The orchestration script)
```

## 🌍 Using these Skills in Other Projects

If you want to quickly setup an existing project with this exact suite of agent intelligence, you can run this one-liner from your project's root:

```bash
# install all agents
curl -s https://raw.githubusercontent.com/rayhon/agent-skills/refs/heads/main/install-skills.sh | bash


# install skills for antigravity and claude-code agents
curl -s https://raw.githubusercontent.com/rayhon/agent-skills/refs/heads/main/install-skills.sh | bash -s -- antigravity
curl -s https://raw.githubusercontent.com/rayhon/agent-skills/refs/heads/main/install-skills.sh | bash -s -- claude-code
```

*Note: Replace `your-username` and `repo-name` with the actual path to your repository once hosted.*

## 🛠️ Currently Installed Skills

| Skill | Source | Purpose |
| :--- | :--- | :--- |
| **Brainstorming** | `obra/superpowers` | Mandatory "thinking-first" workflow for all creative/complex tasks. |
| **Frontend Design** | `anthropics/skills` | High-quality, distinctive UI generation (avoiding generic "AI slop"). |
| **UI/UX Pro Max** | `nextlevelbuilder` | Design intelligence for 50+ styles, charts, and 9 different tech stacks. |
| **Web Design Guidelines** | `vercel-labs` | Automated accessibility and UX audits against industry standards. |
| **Vercel React Best Practices** | `vercel-labs` | Performance optimization for React and Next.js applications. |
| **Remotion Best Practices** | `remotion-dev` | Programmatic video creation guidelines with React. |
| **Agent Browser** | `vercel-labs` | Full browser automation for data extraction and E2E testing. |
| **Skill Creator** | `anthropics/skills` | Toolkit for building and packaging your own custom agent skills. |

## 🔍 Discovering Top Skills

You can find the most popular and useful skills for your workflow using the following methods:

### 1. Browse the Marketplace (Recommended)
Visit **[skills.sh](https://skills.sh/)** to browse the full ecosystem. You can see:
- **Top Installed Skills**: See what the community is using most.
- **Categories**: Filter by Web, DevOps, Testing, etc.
- **Documentation**: Read the full instructions for each skill before installing.

### 2. Search via CLI
You can search directly from your terminal:
```bash
# Search for top/trending skills
npx skills find --top

# Search by keyword
npx skills find "react performance"
```

## 🧩 Extending the Ecosystem

## 🔄 Team Sync: Adding New Skills

To ensure everyone on the team has the same capabilities, follow this process when you find or create a new skill:

### Option A: Adding a Public Skill
1. Open `install-skills.sh`.
2. Add the package identifier (e.g., `owner/repo@skill`) to the `SKILLS` array.
3. Commit and push the change.
4. Tell the team to run `./install-skills.sh`.

### Option B: Creating & Sharing a Custom/Internal Skill
If you want to create a skill specifically for this project's workflows:

1. **Initialize** the skill in a dedicated folder:
   ```bash
   npx skills init skills/my-team-skill
   ```
2. **Implement** your logic (edit `skills/my-team-skill/SKILL.md`).
3. **Commit** the `skills/my-team-skill` folder to the Git repository.
4. **Update the Script**: Add the local path to `install-skills.sh` so others auto-install it:
   ```bash
   # Add this to the end of install-skills.sh loop or as a standalone line:
   npx skills add ./skills/my-team-skill -y
   ```
5. **Push**: Once pushed, any developer who pulls the repo and runs `./install-skills.sh` will have your custom skill installed locally.

## 📜 Principles
- **Concise Context**: Keep `SKILL.md` files under 500 lines to save token budget.
- **Deterministic Tools**: Use `/scripts` for complex logic instead of relying on the LLM to write it from scratch.
- **Progressive Disclosure**: Put detailed docs in `/references` and load them only when needed.

## Skill Repositories
* [HuggingFace Skills](https://github.com/huggingface/skills/tree/main/skills)

---
*Happy Coding with Managed Intelligence!*
