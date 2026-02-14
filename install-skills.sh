#!/bin/bash

# Script to reinstall the specific agent skills used in this project
# Requires Node.js and npm/npx
# Usage: ./install-skills.sh [agent_name] (e.g., ./install-skills.sh claude-code)

AGENT_ARG=""
if [ ! -z "$1" ]; then
  AGENT_ARG="--agent $1"
  echo "🎯 Targeting agent: $1"
fi

echo "🚀 Starting Agent Skills installation..."

SKILLS=(
  "vercel-labs/agent-skills@web-design-guidelines"
  "remotion-dev/skills@remotion-best-practices"
  "vercel-labs/agent-skills@vercel-react-best-practices"
  "anthropics/skills@frontend-design"
  "vercel-labs/agent-browser@agent-browser"
  "nextlevelbuilder/ui-ux-pro-max-skill@ui-ux-pro-max"
  "anthropics/skills@skill-creator"
  "obra/superpowers@brainstorming"
)

for skill in "${SKILLS[@]}"; do
  echo "📦 Installing $skill..."
  npx skills add "$skill" -y $AGENT_ARG
done

echo "✅ All skills have been installed successfully!"
if [ ! -z "$1" ]; then
  echo "✨ Skills are now active and symlinked in the .$1/skills directory."
else
  echo "📂 You can check the installed skills in the .agents/skills directory."
fi

