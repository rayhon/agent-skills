# Skill Best Practice
After dissecting these repositories, I found five patterns that explain why certain skills dominate.

**Pattern 1: Description engineering.** The skill description is the primary trigger mechanism. Top skills include exact phrases users might type: “review my UI,” “check accessibility,” “optimise bundle size.” Vague descriptions mean the skill never activates.

**Pattern 2: Impact quantification.** Numbers beat adjectives. “200–800ms improvement” is more useful to an AI agent than “faster.” It helps the agent prioritise which fixes to suggest first.

**Pattern 3: Progressive disclosure.** Top skills keep the main file under 500 lines. Detailed guidance lives in reference files that the agent loads on demand. This respects context window limits while maintaining depth.

**Pattern 4: First-party authority.** Framework creators dominate. Vercel skills outperform community React skills. Expo skills outperform community React Native skills. The source matters.

**Pattern 5: Anti-pattern documentation.** Telling AI what not to do is as important as telling it what to do. The Remotion skill lists forbidden patterns. The frontend-design skill lists clichés to avoid.