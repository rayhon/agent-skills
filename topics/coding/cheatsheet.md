# Claude Code
## Agent team
### Setup

```json
//settings.json (global or project)
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  }
}

// install tmux
brew install tmux
// confirm
tmux -V
```
### Use / Trigger it over claude termimal
```
Create an agent team to xxxx
```
<br/>
<br/>

## Define subagent
### Frontmatter fields
* name, description (required)
* tools (for internal tools only - default: all allowed - [reference](https://code.claude.com/docs/en/settings#tools-available-to-claude))
* model (sonnet, opus, haiku, inherit = default to same model as main conversation)
* skills
* mcpServers
* hooks
* memory (user, project, local)
* isolation: worktree

```toml
---
name: code-reviewer
description: You are a senior code reviewer ensuring high standards of code quality and security.
tools: Read, Edit, Bash, Grep, Glob
model: sonnet
skills:
  - api-conventions
  - error-handling-patterns
---

You are a senior code reviewer ensuring high standards of code quality and security.

xxxx

```

<br/>
<br/>

## Git Worktree
```

```

<br/>
<br/>

## Useful Command
```bash
## no permission grant needed
claude --dangerously-skip-permissions


```

