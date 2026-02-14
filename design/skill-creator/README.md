# Prompt
```
use ui-ux-pro-max skill to reproduce the design of the image 
@design.png in exact in single html with css and javscript. 
```

# UI/UX Pro Max Skill Execution
This document records how the `ui-ux-pro-max` skill translates a visual design into a technical implementation plan through a 4-step workflow.

## Step 1: Foundation (Design System)
In this initial stage, the agent executes the `--design-system` command to establish the **Source of Truth**. It searches across 5 domains (Product, Style, Color, Landing, Typography) to generate a comprehensive map of colors, fonts, and layout patterns.

````md
python3 .agents/skills/ui-ux-pro-max/scripts/search.py "ai agent skills marketplace dark mode premium developer" --design-system -p "SkillCreator" -f markdown

## Design System: SkillCreator
### Pattern
- **Name:** Marketplace / Directory
- **Conversion Focus:**  map hover pins,  card carousel, Search bar is the CTA. Reduce friction to search. Popular searches suggestions.
- **CTA Placement:** Hero Search Bar + Navbar 'List your item'
- **Color Strategy:** Search: High contrast. Categories: Visual icons. Trust: Blue/Green.
- **Sections:** 1. Hero (Search focused), 2. Categories, 3. Featured Listings, 4. Trust/Safety, 5. CTA (Become a host/seller)

### Style
- **Name:** Vibrant & Block-based
- **Keywords:** Bold, energetic, playful, block layout, geometric shapes, high color contrast, duotone, modern, energetic
- **Best For:** Startups, creative agencies, gaming, social media, youth-focused, entertainment, consumer
- **Performance:** ⚡ Good | **Accessibility:** ◐ Ensure WCAG

### Colors
| Role | Hex |
|------|-----|
| Primary | #1E293B |
| Secondary | #334155 |
| CTA | #22C55E |
| Background | #0F172A |
| Text | #F8FAFC |

*Notes: Code dark + run green*

### Typography
- **Heading:** JetBrains Mono
- **Body:** IBM Plex Sans
- **Mood:** code, developer, technical, precise, functional, hacker
- **Best For:** Developer tools, documentation, code editors, tech blogs, CLI apps
- **Google Fonts:** https://fonts.google.com/share?selection.family=IBM+Plex+Sans:wght@300;400;500;600;700|JetBrains+Mono:wght@400;500;600;700
- **CSS Import:**
```css
@import url('https://fonts.googleapis.com/css2?family=IBM+Plex+Sans:wght@300;400;500;600;700&family=JetBrains+Mono:wght@400;500;600;700&display=swap');
```

### Key Effects
Large sections (48px+ gaps), animated patterns, bold hover (color shift), scroll-snap, large type (32px+), 200-300ms

### Avoid (Anti-patterns)
- Flat design without depth
- Text-heavy pages

### Pre-Delivery Checklist
- [ ] No emojis as icons (use SVG: Heroicons/Lucide)
- [ ] cursor-pointer on all clickable elements
- [ ] Hover states with smooth transitions (150-300ms)
- [ ] Light mode: text contrast 4.5:1 minimum
- [ ] Focus states visible for keyboard nav
- [ ] prefers-reduced-motion respected
- [ ] Responsive: 375px, 768px, 1024px, 1440px
````

## Step 2: UX Best Practices
Once the foundation is set, the agent performs a UX-specific search to ensure the components are accessible and handle interactions (like touch vs. hover) correctly.

```md
python3 .agents/skills/ui-ux-pro-max/scripts/search.py "animation hover accessibility cards" --domain ux

## UI Pro Max Search Results
**Domain:** ux | **Query:** animation hover accessibility cards
**Source:** ux-guidelines.csv | **Found:** 3 results

### Result 1
- **Category:** Animation
- **Issue:** Hover vs Tap
- **Platform:** All
- **Description:** Hover effects don't work on touch devices
- **Do:** Use click/tap for primary interactions
- **Don't:** Rely only on hover for important actions
- **Code Example Good:** onClick handler
- **Code Example Bad:** onMouseEnter only
- **Severity:** High

### Result 2
- **Category:** Animation
- **Issue:** Continuous Animation
- **Platform:** All
- **Description:** Infinite animations are distracting
- **Do:** Use for loading indicators only
- **Don't:** Use for decorative elements
- **Code Example Good:** animate-spin on loader
- **Code Example Bad:** animate-bounce on icons
- **Severity:** Medium

### Result 3
- **Category:** Interaction
- **Issue:** Hover States
- **Platform:** Web
- **Description:** Visual feedback on interactive elements
- **Do:** Change cursor and add subtle visual change
- **Don't:** No hover feedback on clickable elements
- **Code Example Good:** hover:bg-gray-100 cursor-pointer
- **Code Example Bad:** No hover style
- **Severity:** Medium
```

## Step 3: Style Exploration
The agent drills into specific modern visual effects (e.g., glassmorphism) to ensure the design achieves the "premium" aesthetic requested in the prompt.

````md
python3 .agents/skills/ui-ux-pro-max/scripts/search.py "dark mode glassmorphism card grid" --domain style

## UI Pro Max Search Results
**Domain:** style | **Query:** dark mode glassmorphism card grid
**Source:** styles.csv | **Found:** 3 results

### Result 1
- **Style Category:** Dark Mode (OLED)
- **Type:** General
- **Keywords:** Dark theme, low light, high contrast, deep black, midnight blue, eye-friendly, OLED, night mode, power efficient
- **Primary Colors:** Deep Black #000000, Dark Grey #121212, Midnight Blue #0A0E27
- **Effects & Animation:** Minimal glow (text-shadow: 0 0 10px), dark-to-light transitions, low white emission, high readability, visible focus
- **Best For:** Night-mode apps, coding platforms, entertainment, eye-strain prevention, OLED devices, low-light
- **Performance:** ⚡ Excellent
- **Accessibility:** ✓ WCAG AAA
- **Framework Compatibility:** Tailwind 10/10, MUI 10/10, Chakra 10/10
- **Complexity:** Low
- **AI Prompt Keywords:** Create an OLED-optimized dark interface with deep black (#000000), dark grey (#121212), midnight blue accents. Use minimal glow effects, vibrant neon accents (green, blue, gold, purple), high contrast text. Optimize for eye comfort and OLED power saving.
- **CSS/Technical Keywords:** background: #000000 or #121212, color: #FFFFFF or #E0E0E0, text-shadow: 0 0 10px neon-color (sparingly), filter: brightness(0.8) if needed, color-scheme: dark
- **Implementation Checklist:** ☐ Deep black #000000 or #121212, ☐ Vibrant neon accents used, ☐ Text contrast 7:1+, ☐ Minimal glow effects, ☐ OLED power optimization, ☐ No white (#FFFFFF) background
- **Design System Variables:** --bg-black: #000000, --bg-dark-grey: #121212, --text-primary: #FFFFFF, --accent-neon: neon colors, --glow-effect: minimal, --oled-optimized: true

### Result 2
- **Style Category:** Bento Grids
- **Type:** General
- **Keywords:** Apple-style, modular, cards, organized, clean, hierarchy, grid, rounded, soft
- **Primary Colors:** Off-white #F5F5F7, Clean White #FFFFFF, Text #1D1D1F
- **Effects & Animation:** Hover scale (1.02), soft shadow expansion, smooth layout shifts, content reveal
- **Best For:** Product features, dashboards, personal sites, marketing summaries, galleries
- **Performance:** ⚡ Excellent
- **Accessibility:** ✓ WCAG AA
- **Framework Compatibility:** CSS Grid 10/10, Tailwind 10/10
- **Complexity:** Low
- **AI Prompt Keywords:** Design a Bento Grid layout. Use: modular grid system, rounded corners (16-24px), different card sizes (1x1, 2x1, 2x2), card-based hierarchy, soft backgrounds (#F5F5F7), subtle borders, content-first, Apple-style aesthetic.
- **CSS/Technical Keywords:** display: grid, grid-template-columns: repeat(auto-fit, minmax(...)), gap: 1rem, border-radius: 20px, background: #FFF, box-shadow: subtle
- **Implementation Checklist:** ☐ Grid layout (CSS Grid), ☐ Rounded corners 16-24px, ☐ Varied card spans, ☐ Content fits card size, ☐ Responsive re-flow, ☐ Apple-like aesthetic
- **Design System Variables:** --grid-gap: 20px, --card-radius: 24px, --card-bg: #FFFFFF, --page-bg: #F5F5F7, --shadow: soft

### Result 3
- **Style Category:** Cyberpunk UI
- **Type:** General
- **Keywords:** Neon, dark mode, terminal, HUD, sci-fi, glitch, dystopian, futuristic, matrix, tech noir
- **Primary Colors:** #00FF00 (Matrix Green), #FF00FF (Magenta), #00FFFF (Cyan), #0D0D0D (Dark)
- **Effects & Animation:** Neon glow (text-shadow), glitch animations (skew/offset), scanlines (::before overlay), terminal fonts
- **Best For:** Gaming platforms, tech products, crypto apps, sci-fi applications, developer tools, entertainment
- **Performance:** ⚠ Moderate
- **Accessibility:** ⚠ Limited (dark+neon)
- **Framework Compatibility:** Tailwind 8/10, Custom CSS 10/10
- **Complexity:** Medium
- **AI Prompt Keywords:** Design a cyberpunk interface. Use: neon colors on dark (#0D0D0D), terminal/HUD aesthetic, glitch effects, scanlines overlay, matrix green accents, monospace fonts, angular shapes, dystopian tech feel.
- **CSS/Technical Keywords:** background: #0D0D0D, color: #00FF00 or #FF00FF, font-family: monospace, text-shadow: 0 0 10px neon, animation: glitch (transform skew), ::before scanlines (repeating-linear-gradient)
- **Implementation Checklist:** ☐ Dark background only, ☐ Neon accents visible, ☐ Glitch effect subtle, ☐ Scanlines optional, ☐ Monospace font, ☐ Terminal aesthetic
- **Design System Variables:** --bg-dark: #0D0D0D, --neon-green: #00FF00, --neon-magenta: #FF00FF, --neon-cyan: #00FFFF, --scanline-opacity: 0.1, --glitch-duration: 0.3s
````

## Step 4: Implementation
In the final step, the agent synthesizes all recorded constraints and definitions into a single implementation-ready file, ensuring the code matches the "Pre-Delivery Checklist" for quality and compliance.


