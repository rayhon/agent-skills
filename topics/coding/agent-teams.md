# Claude Code Agent Teams Setup Guide

> Based on [Claude Code's Agent Teams Are Insane](https://www.youtube.com/watch?v=-1K_ZWDKpU0) by Cole Medin (Feb 9, 2026)

Agent Teams is an experimental feature in Claude Code that allows multiple AI agents to work together in real-time, sharing a task list and coordinating their work through peer-to-peer communication.

## What Are Agent Teams?

Unlike subagents that work in isolation and report back summaries, Agent Teams:

- **Communicate in real-time** - Agents talk to each other ("Let me complete this before you work on that")
- **Share a task list** - All agents work from and update the same coordinated task list
- **Divide work intelligently** - The lead agent decides the team structure based on your request
- **Allow direct interaction** - You can chat with any agent in the team directly

## Agent Teams vs. Subagents

| Aspect | Subagents | Agent Teams |
|--------|-----------|-------------|
| **Context** | Isolated - only summary returns | Shared - full collaboration |
| **Communication** | None between agents | Peer-to-peer coordination |
| **Token Efficiency** | High - minimal context pollution | Low - 2-4x more tokens |
| **Best For** | Research, codebase analysis | Implementation, coding tasks |
| **Visibility** | Black box process | Can interact with each agent |

### Rule of Thumb
- **Use Subagents for**: Research, diving into codebases, web searches
- **Use Agent Teams for**: Implementation, building features, coding tasks

<br/>
<br/>
## Setup Instructions

### Step 1: Enable the Experimental Feature

Agent Teams is experimental and must be enabled. Choose one of these methods:

**Option A: Environment Variable (per session)**
```bash
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=true
```

**Option B: Settings File (persistent)**

Add to `~/.claude/settings.json` (global) or `.claude/settings.json` in your project:

```json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  }
}

```

### Step 2: Install Terminal Multiplexer

For the split-pane view where you can see all agents working simultaneously, install either:

**tmux (Recommended)**
```bash
# macOS users
brew install tmux

# confirm
tmux -V
```

### Step 3: Install build-with-agent-team skill
```bash 
# glboal level
cp -r build-with-agent-team ~/.claude/skills/

# project level
cp -r build-with-agent-team .claude/skills/
```
<br/>
<br/>

## Using Agent Teams

## Step 1: Create Plan
Write a markdown document describing what you want to build. This works for:

* Greenfield projects: A new app, API, or system from scratch
* Brownfield features: A new feature in an existing codebase

Your plan should be detailed enough that multiple agents could divide the work. Include:

* What you're building and why
* Tech stack and architecture
* Project structure
* Key components and how they interact
* Data models or API contracts
* Acceptance criteria

See example-plan/session-manager-plan.md for an example.

Simply tell Claude you want to use an agent team:

```
Create an agent team to review my codebase.
Have one agent focus on security, one on code quality, and the other on documentation.
```

The lead agent will:
1. Analyze your request
2. Define a shared task list
3. Spawn the appropriate agents
4. Coordinate their work in real-time

### Navigating Between Agents

**In tmux:**
- Press `Ctrl+B` then arrow keys to switch between agent terminals
- Chat directly with any agent to ask about their progress

**Get Status Updates:**
Ask the primary agent: "Give me a status update on the task list and what the agents are working on."

### When Tasks Complete

Once all agents finish their work, the lead agent automatically spins down the terminals and returns you to the single view.

## Best Practices

### 1. Be Specific with Your Request

Claude Code sometimes struggles with vague requests. Be explicit:

```
Create an agent team with 3 teammates to:
- Agent 1: Build the database schema
- Agent 2: Create the backend API
- Agent 3: Build the frontend components
```

### 2. Use Contract-First Spawning

Not everything can run in true parallel. Use a **contract chain** approach:

1. Database agent builds schema first → sends contract to lead
2. Backend agent uses that schema contract
3. Frontend agent uses the API contract

This prevents agents from building on incorrect assumptions and having to rework.

### 3. Research First, Then Build

Recommended workflow:
1. **Use subagents** for research (analyze codebase, understand requirements)
2. **Create a plan** from that research
3. **Spawn agent team** to implement the plan

### 4. Define Team Size Explicitly

```bash
/build with agent team --plan path/to/plan.md --agents 3
```

Or let Claude Code decide based on your plan complexity.

## Limitations to Be Aware Of

1. **Token Heavy**: Agent Teams uses 2-4x more tokens than single agent or subagents
2. **Limited Visibility**: Hard to see real-time collaboration in logs
3. **Parallelism Issues**: Some tasks can't truly run in parallel (schema must exist before backend)
4. **Occasional Hallucinations**: Without specific instructions, may create strange team structures


## Example Use Cases

### Code Review Team
```
Create an agent team to review my codebase with:
- Security reviewer
- Code quality reviewer
- Documentation reviewer
```

### Full Stack Feature Build
```
Create an agent team to build the user authentication feature:
- Database agent: Design user schema
- Backend agent: Build auth API endpoints
- Frontend agent: Create login/signup components
```

### Multi-File Refactoring
```
Create an agent team to refactor the payment system:
- Agent 1: Refactor payment processing logic
- Agent 2: Update API contracts
- Agent 3: Update frontend payment forms
- Agent 4: Update tests
```


## Resources

- [Official Agent Teams Documentation](https://code.claude.com/docs/en/agent-teams)
- [Cole Medin's Agent Team Skill Template](https://github.com/coleam00/context-engineering-intro/tree/main/use-cases/build-with-agent-team)
- [Agent Teams vs Subagents Diagram](https://github.com/coleam00/context-engineering-intro/blob/main/use-cases/build-with-agent-team/AgentTeamsVsSubagents.png)
- [Anthropic's C Compiler Build (16 agents)](https://www.anthropic.com/engineering/building-c-compiler)