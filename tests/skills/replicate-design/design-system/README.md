# SkillCreator Design System

This document outlines the core design tokens, typography, colors, and component styles extracted from the SkillCreator interface, acting as a single source of truth for achieving a coherent theme feel across all pages.

## 1. Color Palette

The theme uses a very dark, high-contrast aesthetic with neon accents.

### Core Backgrounds & Borders
- **Body Background:** `#0b0b0c` / `#0a0a0c`
- **Card Background:** `#121214`
- **Card Hover Background:** `#18181b`
- **Component Sub-Bg:** `#161618` (used for inline tags/badges)
- **Component Sub-Bg Alternative:** `#1a1a1c` (used for buttons and repo card)
- **Primary Borders:** `#222224` to `#262626`
- **Hover/Active Borders:** `#3f3f46` or `#2a2a2a` for form inputs

### Text Colors
- **Primary Text:** `#ffffff`
- **Secondary Text (Dim):** `#888888` / `#a1a1aa` (used for paragraphs and inactive nav links)
- **Tertiary Text (Dimmer):** `#555555` / `#777777` (used for breadcrumbs and minor details)

### Brand & Accent Colors
- **Brand Blue (Primary Accent):** `#00e5ff` (used for borders, active tags, and tech highlights)
- **Brand Blue Alt:** `#00bfff` 
- **Brand Purple:** `#8a2be2`
- **Brand Pink:** `#ff1493`
- **Brand Orange:** `#ff8c00`
- **Brand Green:** `#00fa9a`
- **Official Green:** `#10b981` (used for verified checks and official badges)
- **Star Yellow:** `#fbbf24` (used for rating stars)
- **Gradient Primary:** `#2563eb` to `#7c3aed` (used for primary actions/buttons)

---

## 2. Typography

We use three core fonts to achieve a mix of utility, readability, and elegance.
- **Sans-serif:** `Inter`, sans-serif (used for UI elements, cards, and body text)
- **Monospace:** `JetBrains Mono`, monospace (used for metadata, stats, tags, and code-like accents)
- **Serif:** `Playfair Display`, serif (used exclusively for Chapter/Section titles)

### Type Scale & Usage
- **Page Title:** `44px`, font-bold, leading-none, tracking-tight (`Inter`).
- **Section Heading:** `32px`, font-serif, italic, tracking-wide, leading-none (`Playfair Display`).
- **Card Title:** `20px` (or `xl`), font-bold, tracking-tight (`Inter`).
- **Body Text:** `13px`, leading `1.6` (`Inter`, colored `#888888`).
- **Metadata/Stats:** `10px` or `11px`, uppercase, font-mono, tracking `0.15em` (`JetBrains Mono`, colored `#555555`).
- **Button/Nav Actions:** `13px`, font-medium (`Inter`).

---

## 3. Visual Effects & Styles

### Elevations & Glows
- **Background Glow:** A subtle blue radial gradient positioned at the top of the viewport to break the solid dark background.
  *CSS Equivalent:* `radial-gradient(ellipse at top, rgba(37,99,235,0.15) 0%, rgba(13,13,15,0) 60%)`
- **Button Shadow:** Primary buttons utilize a colored shadow to mimic a glow.
  *Tailwind:* `shadow-lg shadow-blue-500/20`
- **Active State Glow:** Active tags or active icon dots utilize a tight colored shadow.
  *CSS/Tailwind Equivalent:* `shadow-[0_0_8px_#00e5ff]`

### Borders & Indicators
- **Left Border Indicator:** Skill cards utilize a prominent left-border (`3px solid #00bfff`), which changes color on hover (`#00e5ff`).
- **Glassmorphism/Blurs:** Floating sticky elements (like the repo card) utilize a translucent background (`rgba(18, 18, 20, 0.85)`) paired with `backdrop-filter: blur(12px)`.

---

## 4. Components

### 4.1. Cards (Skill Cards)
- **Wrapper:** `bg-[#121214] border border-[#262626] rounded-xl flex flex-col overflow-hidden`
- **Active Identifier:** `border-left: 3px solid #00bfff;`
- **Hover State:** Background lightens to `#18181b`, border brightens to `#3f3f46`, left border brightens to `#00e5ff`.
- **Transitions:** `transition: all 0.2s;`

### 4.2. Outline Action Pills (Filters)
- **Styling:** `bg-[#161618] border border-[#262626] text-[#888888] rounded-full px-3.5 py-1.5`
- **Hover:** `text-white`
- **Active State:** Border becomes `#00bfff` and background becomes `rgba(0, 191, 255, 0.1)` with white text.

### 4.3. Primary Action Buttons (Join Waitlist)
- **Styling:** `bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-full px-5 py-2.5 font-medium`
- **Hover:** `from-blue-500 to-indigo-500`
- **Effects:** Heavy blue shadow `shadow-lg shadow-blue-500/20`

### 4.4. Search Input
- **Wrapper/Input:** `bg-[#121214] border border-[#2a2a2a] rounded-lg text-sm text-white focus:border-[#00e5ff]`
- **Keyboard Shortcuts (kbd):** `bg-[#1a1a1c] border border-[#333] text-[10px] font-mono text-white`

### 4.5. Small Badges ("Official" / "Verified")
- **Styling:** Small, slightly tinted backgrounds based on context.
- **Example (Official Green):** `bg-[#10b98115] text-[#10b981] font-semibold text-[10px] px-1.5 py-0.5 rounded`

---

## 5. Tailwind Configuration Base

```javascript
tailwind.config = {
    theme: {
        extend: {
            colors: {
                bgDark: '#0a0a0c',
                cardBg: '#121214',
                cardHover: '#18181b',
                borderColor: '#222224',
                textDim: '#888888',
                brandBlue: '#00e5ff',
                brandPurple: '#8a2be2',
                brandPink: '#ff1493',
                brandOrange: '#ff8c00',
                brandGreen: '#00fa9a',
                starYellow: '#fbbf24',
                officialGreen: '#10b981',
            },
            fontFamily: {
                sans: ['Inter', 'sans-serif'],
                mono: ['JetBrains Mono', 'monospace'],
                serif: ['Playfair Display', 'serif'],
            }
        }
    }
}
```
