# Coding Topics

Practical guides and best practices for AI-assisted software development with Claude Code and other agentic tools.

## Guides

### [Agent Teams](agent-teams.md)
Multi-agent collaboration in Claude Code. Learn how to spawn multiple AI agents that work together in parallel, share task lists, and coordinate in real-time through tmux split panes. Covers setup, usage patterns, and the difference between Agent Teams and Subagents.

**Key Topics:**
- Enabling the experimental Agent Teams feature
- Installing and using the `build-with-agent-team` skill
- Contract-first spawning for coordinated builds
- When to use Agent Teams vs. Subagents

---

### [Git Worktree](git-worktree.md)
The ultimate guide to running parallel AI agents without conflicts. Git Worktrees provide file system isolation so multiple agents can work on the same repository simultaneously without overwriting each other's changes.

**Key Topics:**
- Creating and managing worktrees
- Symlinks for shared configuration
- Database namespacing for data isolation
- The `.worktreeinclude` pattern for sharing files across sandboxes

---

### [GLM 5 Setup](glm5.md)
How to configure Claude Code to use GLM-5 from z.ai as an alternative to Anthropic models. GLM-5 offers comparable performance to Claude Opus 4.5 and can be configured as a drop-in replacement.

**Key Topics:**
- API configuration in `~/.claude/settings.json`
- Setting GLM-5 as default model
- API endpoint and authentication

---

### [Skill Best Practices](skill-best-practice.md)
Patterns that make AI skills effective. Based on analysis of top-performing skills, this guide covers description engineering, impact quantification, progressive disclosure, and anti-pattern documentation.

**Key Topics:**
- Writing descriptions that trigger correctly
- Using numbers instead of adjectives
- Keeping skills under 500 lines with on-demand references
- Documenting what NOT to do

---

### [Plugins](plugins.md)
Overview of plugins as bundled packages of skills, subagents, and commands distributed as cohesive units.
