# Revue systematique Kitchenham v3.0 — Decisions design system OLS

**Agent** : A | **Date** : 2026-04-14 | **Methode** : EBSE Kitchenham (PICOC → PRISMA → I/E → Qualite → Extraction → GRADE)

---

## Decision 1: Color system / theming

**PICOC:** P=Frontend developers building design systems I=M3 HCT-based token generation with 3-tier hierarchy (reference/semantic/component) Co=Manual palette curation, single-tier CSS variables O=Consistency, maintainability, theme scalability, a11y contrast compliance C=React/Tailwind web app with dark mode

**Sources included:**
- [S1] Material Design 3 — Design Tokens spec (m3.material.io/foundations/design-tokens) — Level: Industry standard (L1)
- [S2] Material Theme Builder + @material/material-color-utilities npm package — Level: Reference implementation (L2)
- [S3] Nathan Curtis / EightShapes — "Tokens in Design Systems" (medium.com/eightshapes-llc/tokens-in-design-systems) — Level: Expert practitioner (L3)
- [S4] Penpot — "The developer's guide to design tokens and CSS variables" (penpot.app/blog) — Level: Industry guide (L4)
- [S5] Seenode — "Google's Material 3 Tokens System" (seenode.com/blog) — Level: Analysis (L4)

**Sources excluded:**
- Random Medium tutorials (insufficient rigor, no data)
- Dribbble/Behance showcases (no methodology)

**Quality scores:**
| Source | Q1 clear aim | Q2 method | Q3 design | Q4 recruitment | Q5 data | Q6 relationship | Q7 ethical | Q8 analysis | Q9 findings | Q10 value | Q11 transferable |
|--------|---|---|---|---|---|---|---|---|---|---|---|
| S1 | Y | Y | Y | N/A | Y | N/A | N/A | Y | Y | Y | Y |
| S2 | Y | Y | Y | N/A | Y | N/A | N/A | Y | Y | Y | Y |
| S3 | Y | Y | Y | N/A | P | N/A | N/A | Y | Y | Y | Y |
| S4 | Y | P | Y | N/A | P | N/A | N/A | P | Y | Y | Y |

**Data extraction:**
- M3 spec: "Design tokens are the building blocks of all UI elements [...] On the web, design tokens are CSS custom properties."
- HCT model: Hue (0-360), Chroma (0-~120), Tone (0-100) — perceptually uniform, unlike HSL.
- 3-tier: Reference (`--md-ref-palette-primary-40`), System/Semantic (`--md-sys-color-primary`), Component (`--md-comp-button-container-color`).
- EightShapes: "Aliasing structure enables theming — changing just the theme token's value cascades through the entire system."
- Best practice: "Separate primitive and semantic tokens; always use meaningful token names in components rather than raw values."

**GRADE: 5/7**
- Large body of industry convergence (M3, EightShapes, W3C Design Tokens spec draft)
- No randomized studies (design decision, not measurable UX metric)
- Strong consistency across sources

**Sensitivity:** ROBUST — removing any single source does not change the recommendation. All sources converge on 3-tier token architecture with semantic naming.

**Recommendation:** Use a 3-tier CSS custom property architecture: (1) reference tokens (raw palette values generated from HCT or curated), (2) semantic/alias tokens (role-based: `--color-surface`, `--color-on-surface`, `--color-primary`), (3) component tokens (optional, for complex components). Generate palettes using `@material/material-color-utilities` from a seed brand color. Implement as CSS custom properties scoped via `[data-theme]` selectors. This is the industry-converged approach used by M3, Spectrum (Adobe), Carbon (IBM), and Lightning (Salesforce).

**Level: STANDARD**

---

## Decision 2: Dark mode strategy

**PICOC:** P=Web apps supporting light+dark themes I=Simultaneous design with semantic token architecture Co=Light-first (dark as afterthought), dark-first O=Visual quality in both modes, maintenance cost, user preference coverage C=React/Tailwind educational platform

**Sources included:**
- [S1] Material Design 3 — Dark theme spec, tonal elevation (m3.material.io) — Level: Industry standard (L1)
- [S2] Apple HIG — Dark Mode guidelines (developer.apple.com/design/human-interface-guidelines/dark-mode) — Level: Industry standard (L1)
- [S3] Nielsen Norman Group — Dark mode research, tweet: "Users like dark mode but maintain similar behaviors without it. They think about it at the system level, not the application level." — Level: UX research (L2)
- [S4] Muzli — "Dark Mode Design Systems: A Complete Guide" — Level: Practitioner synthesis (L4)
- [S5] MNIT.gov — "Understanding WCAG requirements for UI component states" — Level: Government accessibility guide (L3)

**Sources excluded:**
- Blog posts advocating "dark-first for developer tools" (opinion, no data)
- "Light mode is dead" articles (clickbait, no methodology)

**Quality scores:**
| Source | Q1 | Q2 | Q3 | Q4 | Q5 | Q8 | Q9 | Q10 | Q11 |
|--------|---|---|---|---|---|---|---|---|---|
| S1 | Y | Y | Y | N/A | Y | Y | Y | Y | Y |
| S2 | Y | Y | Y | N/A | Y | Y | Y | Y | Y |
| S3 | Y | Y | Y | Y | Y | Y | Y | Y | Y |
| S4 | Y | P | Y | N/A | P | P | Y | Y | Y |

**Data extraction:**
- NNg: "about one-third of users keep their phone in dark mode, one-third in light, and the rest switch based on context."
- Muzli: "Dark is not a variant of light but a first-class design system context with its own visual logic, its own elevation language, and its own token architecture."
- Muzli: "Shadows do not read on dark backgrounds [...] the replacement is luminance hierarchy — as a surface elevates, it gets lighter, not more shadowed."
- M3: "Elevation overlays in dark themes have changed to tonal color overlays [...] overlay color coming from the primary color slot."
- Apple HIG: "Dark Mode uses a base and elevated background colors for a sense of depth."
- Key insight: "Semantic tokens are the only approach that scales [...] A semantic token carries a role rather than a value."

**GRADE: 6/7**
- Two industry standards (M3 + Apple HIG) converge
- NNg provides actual user research data
- Strong consensus on simultaneous + semantic tokens

**Sensitivity:** ROBUST — all sources independently recommend simultaneous design with semantic tokens. Removing NNg still leaves M3 + Apple HIG. Removing M3 still leaves Apple + NNg.

**Recommendation:** Design both themes simultaneously using semantic tokens. Never treat dark mode as an inversion of light. Define role-based tokens (`--color-surface`, `--color-on-surface`, etc.) where the name stays constant and the resolved value changes per theme. In dark mode, replace shadow-based elevation with luminance/tonal elevation (lighter surfaces = higher). Use `[data-theme="dark"]` or `prefers-color-scheme` media query to swap token values. Default to system preference. Both M3 and Apple HIG converge on this approach.

**Level: STANDARD**

---

## Decision 3: Surface/elevation system

**PICOC:** P=Design systems needing visual hierarchy I=Limited discrete elevation levels (4-6) with semantic naming and tonal differentiation Co=Arbitrary shadow values, unlimited z-index, no system O=Clear visual hierarchy, dark mode compatibility, maintainability C=Web design system with light+dark themes

**Sources included:**
- [S1] Material Design 3 — Elevation spec (m3.material.io/styles/elevation/applying-elevation) — Level: Industry standard (L1)
- [S2] Material Design 3 — Tone-based surfaces blog (m3.material.io/blog/tone-based-surface-color-m3) — Level: Industry standard (L1)
- [S3] GitLab Pajamas — Elevation spec (design.gitlab.com/product-foundations/elevation) — Level: Production design system (L3)
- [S4] DesignSystems.surf — "Elevation Design Patterns: Tokens, Shadows, and Roles" — Level: Practitioner synthesis (L4)
- [S5] Apple HIG — Materials (developer.apple.com/design/human-interface-guidelines/materials) — Level: Industry standard (L1)

**Sources excluded:**
- Material Design 1 (superseded)
- GitHub gist CSS shadow collections (no design rationale)

**Quality scores:**
| Source | Q1 | Q2 | Q3 | Q5 | Q8 | Q9 | Q10 | Q11 |
|--------|---|---|---|---|---|---|---|---|
| S1 | Y | Y | Y | Y | Y | Y | Y | Y |
| S2 | Y | Y | Y | Y | Y | Y | Y | Y |
| S3 | Y | Y | Y | Y | Y | Y | Y | Y |
| S4 | Y | P | Y | P | P | Y | Y | Y |
| S5 | Y | Y | Y | Y | Y | Y | Y | Y |

**Data extraction:**
- M3: Elevation levels 0-5 via `--md-elevation-level` CSS property. "Elevation will automatically fill the nearest position: relative element."
- M3 tonal surfaces: "Within the Material 3 color palette, there are five predefined surface tonal variations (Surface1-5)." "Surface color takes tonal tint from primary color depending on the elevation."
- DesignSystems.surf: "Most design systems operate well with just 4-6 clearly defined layers, enough to cover layouts, cards, modals, and interactive overlays."
- Token naming: "Some systems choosing functional names (card, tooltip, modal), while others stick to numeric tiers (elevation-100, elevation-200)."
- Apple HIG: "A material is a visual effect that creates a sense of depth, layering, and hierarchy between foreground and background elements."

**GRADE: 5/7**
- Three industry standards converge (M3, Apple, GitLab Pajamas)
- Clear consensus on 4-6 levels
- No academic studies but strong practitioner convergence

**Sensitivity:** ROBUST — removing any single source preserves the 4-6 level recommendation.

**Recommendation:** Define 5 elevation levels (0-4 or 1-5) mapped to semantic roles: level-0 (base/background), level-1 (cards, raised sections), level-2 (navigation bars, sticky headers), level-3 (dialogs, drawers), level-4 (popovers, tooltips). In light mode, express via box-shadow tokens. In dark mode, express via surface tonal tint (lighter = higher). Implement as CSS custom properties: `--elevation-shadow-N` + `--surface-color-N`. This matches M3's approach and scales well.

**Level: STANDARD**

---

## Decision 4: Glass/frosted effects

**PICOC:** P=Web applications considering glassmorphism I=Restricted use of backdrop-blur to overlays only, with a11y fallbacks Co=Widespread glassmorphism on all surfaces O=Performance, accessibility (WCAG contrast), visual consistency C=Educational web platform with diverse user base

**Sources included:**
- [S1] Axess Lab — "Glassmorphism Meets Accessibility: Can Glass Be Inclusive?" (axesslab.com) — Level: Accessibility research (L3)
- [S2] IxDF — "What Is Glassmorphism?" (ixdf.org) — Level: Academic design reference (L3)
- [S3] Playground.halfaccessible — "Glassmorphism Design Trend: Implementation Guide 2025" — Level: Practitioner guide (L4)
- [S4] Apple HIG — Materials and vibrancy (developer.apple.com) — Level: Industry standard (L1)
- [S5] State of CSS 2024 — Filter effects usage 75.4% (2024.stateofcss.com) — Level: Survey data (L2)

**Sources excluded:**
- "44 CSS Glassmorphism Examples" (showcase, no analysis)
- Dribbble trend articles (no data)

**Quality scores:**
| Source | Q1 | Q2 | Q3 | Q5 | Q8 | Q9 | Q10 | Q11 |
|--------|---|---|---|---|---|---|---|---|
| S1 | Y | Y | Y | Y | Y | Y | Y | Y |
| S2 | Y | Y | Y | P | Y | Y | Y | Y |
| S3 | Y | P | Y | Y | P | Y | Y | Y |
| S4 | Y | Y | Y | Y | Y | Y | Y | Y |

**Data extraction:**
- Axess Lab: "For consumers with visual, cognitive, or motion-related disabilities, this style offers great challenges; transparency may reduce text contrast, blur effects may cause sensory pain."
- Performance: "Glassmorphism's static backdrop-filter effects consume approximately 15-25% more GPU resources compared to standard operations."
- Axess Lab: "Text inside a glassmorphic element must meet WCAG AAA contrast ratios (7:1 minimum)."
- Best practice: "Keep blur values between 8-15px (higher values are exponentially more expensive)" and "limit to 2-3 key elements per screen."
- Mandatory: "Respect the prefers-reduced-motion media query and provide fallbacks."
- Apple HIG uses vibrancy/materials for overlays and system chrome, NOT for content areas.

**GRADE: 4/7**
- Good accessibility research
- Performance data exists but is not from controlled studies
- Apple HIG provides a clear model but it's platform-specific
- No academic papers with controlled experiments

**Sensitivity:** FRAGILE on performance numbers (single source), ROBUST on a11y recommendation (multiple sources converge).

**Recommendation:** Use `backdrop-filter: blur()` ONLY on overlays (modals, dropdowns, command palette) — never on content surfaces. Keep blur 8-12px max. Always ensure text over glass meets WCAG AA (4.5:1) minimum via semi-opaque background (`rgba` with alpha >= 0.7). Provide `@media (prefers-reduced-motion: reduce)` fallback with solid background. Limit to 2-3 blurred elements per viewport for performance. This matches Apple's approach (vibrancy on system chrome only) and the accessibility research consensus.

**Level: RECOMMANDE**

---

## Decision 5: Accent/brand color usage

**PICOC:** P=Design systems defining accent color scope I=Accent color for interactive states and key CTAs only (functional usage) Co=Accent color as broad decoration/theming O=Visual clarity, action affordance, a11y contrast C=Educational web app with multiple modules

**Sources included:**
- [S1] UX4Sight — "What Are Accent Colors in UI Design and How to Use Them" (ux4sight.com) — Level: UX research synthesis (L3)
- [S2] Nathan Curtis / EightShapes — "Color in Design Systems" (medium.com/eightshapes-llc/color-in-design-systems) — Level: Expert practitioner (L3)
- [S3] Material Design 3 — Color roles (m3.material.io/styles/color/roles): "Primary is the base color, used for main components like prominent buttons, active states, and the tint of elevated surfaces." — Level: Industry standard (L1)
- [S4] Adobe Spectrum — Color system (spectrum.adobe.com) — Level: Industry standard (L1)
- [S5] UXPin — "Creating A Design System: Building a Color Palette" — Level: Practitioner guide (L4)

**Sources excluded:**
- Brand identity blogs (marketing focus, not UI design)

**Quality scores:**
| Source | Q1 | Q2 | Q5 | Q8 | Q9 | Q10 | Q11 |
|--------|---|---|---|---|---|---|---|
| S1 | Y | Y | Y | Y | Y | Y | Y |
| S2 | Y | Y | Y | Y | Y | Y | Y |
| S3 | Y | Y | Y | Y | Y | Y | Y |
| S4 | Y | Y | Y | Y | Y | Y | Y |

**Data extraction:**
- UX4Sight: "An accent color is [...] applied to UI components such as CTAs, links, icons, sliders, or alerts to make them stand out."
- 60-30-10 rule: "60% primary colors, 30% secondary, 10% accent."
- EightShapes: "Separating brand colors from functional colors [...] brand colors representing company identity, while functional colors are used for error messages, success notifications."
- M3: "Primary is used for prominent buttons, active states, and tint of elevated surfaces" — limited to interactive/state elements.
- WCAG: "Normal text must have contrast ratio of at least 4.5:1, large text 3:1."

**GRADE: 5/7**
- Strong convergence across M3, Spectrum, EightShapes
- 60-30-10 is widely cited but lacks controlled study
- Consistent separation of brand vs. functional colors

**Sensitivity:** ROBUST — all sources agree accent = interactive elements + key CTAs, not decoration.

**Recommendation:** Use accent/brand color strictly for: (1) primary CTAs (filled buttons), (2) active/selected states (tabs, nav items), (3) interactive element highlights (links, toggles, sliders), (4) tonal elevation tint. Do NOT use for: decorative borders, background fills of content areas, or non-interactive elements. Follow the 60-30-10 rule: 60% neutral surfaces, 30% secondary/muted tones, 10% accent. Separate brand palette from semantic/functional palette (error=red, success=green, warning=amber, info=blue regardless of brand color). Ensure accent on all backgrounds meets WCAG AA contrast (4.5:1 for text, 3:1 for non-text).

**Level: STANDARD**

---

## Decision 6: Icon usage guidelines

**PICOC:** P=UI designers and developers deciding icon usage I=Icons paired with text labels, used for recognized actions only Co=Icons as standalone decoration, icon-only UI O=Recognizability, task completion speed, accessibility C=Educational web platform, diverse user expertise

**Sources included:**
- [S1] Nielsen Norman Group — "Icon Usability" (nngroup.com/articles/icon-usability/) — Level: UX research (L1)
- [S2] Nielsen Norman Group — "Bad Icons: How to Identify and Improve Them" (nngroup.com/articles/bad-icons/) — Level: UX research (L1)
- [S3] Nielsen Norman Group — "How to Test Digital Icons" (nngroup.com/articles/how-to-test-digital-icons/) — Level: UX research methodology (L1)
- [S4] Apple HIG — iconography guidelines — Level: Industry standard (L1)
- [S5] Material Design 3 — icon guidelines — Level: Industry standard (L1)

**Sources excluded:**
- Icon gallery/showcase sites (no methodology)
- "Best icon libraries 2025" comparison posts (tooling, not guidelines)

**Quality scores:**
| Source | Q1 | Q2 | Q3 | Q5 | Q8 | Q9 | Q10 | Q11 |
|--------|---|---|---|---|---|---|---|---|
| S1 | Y | Y | Y | Y | Y | Y | Y | Y |
| S2 | Y | Y | Y | Y | Y | Y | Y | Y |
| S3 | Y | Y | Y | Y | Y | Y | Y | Y |
| S4 | Y | Y | Y | Y | Y | Y | Y | Y |

**Data extraction:**
- NNg: "If that object, action, or idea is not immediately clear to users, the icon is reduced to mere eye candy — confusing, frustrating, eye candy — and to visual noise."
- NNg: "Universal icons are rare. To help overcome the ambiguity that almost all icons face, a text label must be present alongside an icon to clarify its meaning."
- NNg 5-second rule: "If it takes you more than 5 seconds to think of an appropriate icon for something, it is unlikely that an icon can effectively communicate that meaning."
- NNg: "Icons make good targets [...] compact enough to allow toolbars, palettes [...] fast to recognize at a glance — particularly true for standard icons."
- NNg: "Not every link deserves an icon. Before including icons [...] will the icon provide any additional benefit?"

**GRADE: 6/7**
- Three NNg research articles with empirical backing
- Two industry standards (Apple, M3)
- Strong, research-backed consensus
- Only missing: large-scale quantitative studies

**Sensitivity:** ROBUST — NNg alone provides sufficient evidence. Apple/M3 reinforce independently.

**Recommendation:** (1) Always pair icons with text labels except for universally recognized icons (search magnifier, close X, hamburger menu, home, settings gear — and even these benefit from labels). (2) Use the 5-second rule: if you cannot think of an icon for a concept in 5 seconds, use text only. (3) Use icons for actions and navigation, not as decoration. (4) Keep designs simple and schematic — reduce graphic detail. (5) Use standard icons for standard concepts (do not reinvent). (6) Icon-only is acceptable only in toolbars with tooltips and when space is severely constrained. (7) Test icon recognizability with users.

**Level: STANDARD**

---

## Decision 7: Badge/status design patterns

**PICOC:** P=Design systems implementing status indicators I=Semantic badge variants mapped to functional roles (success/warning/error/info/neutral) Co=Arbitrary color badges, numeric-only badges O=Scannability, semantic clarity, consistency C=Educational/science platform with lab statuses, module states

**Sources included:**
- [S1] Carbon Design System — Status Indicator Pattern (carbondesignsystem.com/patterns/status-indicator-pattern/) — Level: Production design system (L2)
- [S2] Adobe Spectrum — Badge component (spectrum.adobe.com/page/badge) — Level: Industry standard (L1)
- [S3] Smashing Magazine / Smart Interface Design Patterns — "Badges vs. Pills vs. Chips vs. Tags" (smart-interface-design-patterns.com) — Level: Expert practitioner (L3)
- [S4] Mobbin — "Badge UI Design: Best practices" (mobbin.com/glossary/badge) — Level: Practitioner synthesis (L4)
- [S5] Cieden — "What should I consider when creating badge UI design?" (cieden.com) — Level: Practitioner guide (L4)

**Sources excluded:**
- Generic UI kit marketing pages (no guidelines)

**Quality scores:**
| Source | Q1 | Q2 | Q5 | Q8 | Q9 | Q10 | Q11 |
|--------|---|---|---|---|---|---|---|
| S1 | Y | Y | Y | Y | Y | Y | Y |
| S2 | Y | Y | Y | Y | Y | Y | Y |
| S3 | Y | Y | P | Y | Y | Y | Y |
| S4 | Y | P | P | P | Y | Y | Y |

**Data extraction:**
- Carbon: Status indicators have defined categories — critical/danger (red), warning (yellow/amber), stable/success (green), informational (blue), unknown/neutral (gray).
- Spectrum: Badges are static, non-interactive labels for status.
- Emplifi (Medium): "Badges are typically split into three main categories: Status, Non-actionable, and Special."
- Semantic colors: "Red for errors, green for success, and blue for info."
- Shapes: "The most common badge container shape is a pill."
- A11y: "For accessibility reasons, badges must be enclosed in an ancestor or parent semantic tag." Must not rely on color alone — need icon or text.

**GRADE: 4/7**
- Two production design systems (Carbon, Spectrum)
- Consistent pattern but limited empirical research
- No controlled user studies on badge comprehension

**Sensitivity:** ROBUST on semantic mapping (all agree), FRAGILE on specific implementation details.

**Recommendation:** Define 5 semantic badge variants: (1) `success` (green) — completed, active, validated, (2) `warning` (amber) — pending, attention needed, (3) `error/danger` (red) — failed, blocked, critical, (4) `info` (blue) — new, informational, in-progress, (5) `neutral` (gray) — draft, inactive, archived. Each badge must have: semantic color + icon/text (never color alone per WCAG). Use pill shape for text badges, dot shape for presence indicators. Badges are always static (non-interactive) — use chips/tags for interactive labels. This aligns with Carbon, Spectrum, and the broader design system consensus.

**Level: RECOMMANDE**

---

## Decision 8: Active state patterns

**PICOC:** P=Interactive web components needing state differentiation I=Distinct visual treatments for hover, focus, selected/active states with WCAG compliance Co=Identical or ambiguous states, CSS-only without a11y consideration O=Usability for keyboard/mouse/touch users, WCAG 2.2 compliance C=Web application with navigation, tabs, lists, buttons

**Sources included:**
- [S1] W3C WCAG 2.2 — SC 2.4.13 Focus Appearance (w3.org/WAI/WCAG22/Understanding/focus-appearance.html) — Level: Standard (L1)
- [S2] W3C WCAG 2.2 — SC 2.4.7 Focus Visible (w3.org/WAI/WCAG22/Understanding/focus-visible.html) — Level: Standard (L1)
- [S3] Sara Soueidan — "A guide to designing accessible focus indicators" (sarasoueidan.com) — Level: Expert practitioner (L2)
- [S4] Deque — "How To Design Useful and Usable Focus Indicators" (deque.com) — Level: A11y authority (L2)
- [S5] MNIT.gov — "Understanding WCAG requirements for UI component states" (mn.gov/mnit) — Level: Government guide (L3)
- [S6] Wise Design — Focus states (wise.design/foundations/focus-states) — Level: Production design system (L3)

**Sources excluded:**
- Generic "button states" blog posts without a11y consideration

**Quality scores:**
| Source | Q1 | Q2 | Q3 | Q5 | Q8 | Q9 | Q10 | Q11 |
|--------|---|---|---|---|---|---|---|---|
| S1 | Y | Y | Y | Y | Y | Y | Y | Y |
| S2 | Y | Y | Y | Y | Y | Y | Y | Y |
| S3 | Y | Y | Y | Y | Y | Y | Y | Y |
| S4 | Y | Y | Y | Y | Y | Y | Y | Y |
| S5 | Y | Y | Y | Y | Y | Y | Y | Y |

**Data extraction:**
- WCAG 2.4.13: "Focus indicator must be at least as large as a 2 CSS pixel thick perimeter [...] contrast ratio of at least 3:1 between focused and unfocused states."
- MNIT: "Hover does not need to contrast when compared to default/selected/focused states" but "other states, except hover, must not use colour as the only means of communicating state."
- Deque: "The impact of :focus is much greater than :hover for people who rely on it to navigate."
- Wise: "For tabs [...] to keep it clear which tab is selected and which is in focus, the focus state container should go around the label itself, not the whole tab."
- Best practice: "Visual consistency between hover and focus states" — they can share visual treatment but focus needs a visible, high-contrast indicator.

**GRADE: 6/7**
- W3C standard + multiple accessibility authorities
- Clear, measurable requirements (2px, 3:1 contrast)
- Strong practitioner convergence

**Sensitivity:** ROBUST — WCAG spec alone is sufficient. Other sources reinforce and clarify implementation.

**Recommendation:** Define 4 distinct interaction states: (1) **Hover**: subtle background change or underline (mouse affordance, no WCAG contrast requirement vs. default). (2) **Focus**: 2px+ visible outline/ring with 3:1 contrast ratio against adjacent colors (WCAG 2.4.13), must NOT rely on color alone. Use `outline` or `box-shadow` — never remove `:focus-visible`. (3) **Selected/Active**: persistent visual change (filled background, bold border, accent color indicator) — must be distinguishable from focus. (4) **Pressed**: brief feedback (scale, darker shade). For composite components (tabs, nav): selected state uses persistent indicator (bottom border, filled background), focus ring goes around the label only. Always use `:focus-visible` (not `:focus`) to avoid showing focus ring on mouse clicks.

**Level: STANDARD**

---

## Decision 9: Button variant system

**PICOC:** P=Design systems defining button components I=3-4 emphasis variants (primary/secondary/tertiary/ghost) + semantic variants (danger) Co=Single button style, unlimited variants O=Action clarity, visual hierarchy, decision speed C=Web application with forms, dialogs, navigation

**Sources included:**
- [S1] Nathan Curtis / EightShapes — "Buttons in Design Systems" (eightshapes.com/articles/buttons-in-design-systems/) — Level: Expert practitioner (L2)
- [S2] Carbon Design System — Button component (carbondesignsystem.com/components/button/usage/) — Level: Production design system (L2)
- [S3] Material Design 3 — Button types (filled, outlined, text, elevated, tonal) — Level: Industry standard (L1)
- [S4] LogRocket — "Types of buttons in UI design" (blog.logrocket.com) — Level: Practitioner synthesis (L4)
- [S5] UX Planet — "Ghost Buttons in UX Design" by Nick Babich (uxplanet.org) — Level: UX practitioner (L4)

**Sources excluded:**
- "91 Types & Patterns" collection (too granular, no system design)
- Isolated button style showcases

**Quality scores:**
| Source | Q1 | Q2 | Q5 | Q8 | Q9 | Q10 | Q11 |
|--------|---|---|---|---|---|---|---|
| S1 | Y | Y | Y | Y | Y | Y | Y |
| S2 | Y | Y | Y | Y | Y | Y | Y |
| S3 | Y | Y | Y | Y | Y | Y | Y |
| S4 | Y | P | P | P | Y | Y | Y |
| S5 | Y | P | P | P | Y | Y | P |

**Data extraction:**
- EightShapes: "Buttons are the most atomic interactive component used everywhere by everyone."
- Carbon: Defines Primary, Secondary, Tertiary, Ghost, and Danger variants with strict usage hierarchy.
- M3: Five button types — Filled (highest emphasis), Tonal (medium-high), Elevated (medium), Outlined (medium-low), Text (lowest emphasis).
- UX Planet: "Ghost buttons should be avoided as your primary CTA as they have lower click rates due to their minimal appearance."
- Common pattern: "Primary usually has full background [...] secondary uses stroke with white background or less prominent color."
- EightShapes: "Favor elegance of simple things over flexibility of complex things."

**GRADE: 5/7**
- Three major design systems converge (M3, Carbon, EightShapes research)
- Clear hierarchy pattern
- Ghost button click rate claim lacks specific study citation

**Sensitivity:** ROBUST — all sources agree on 3-5 emphasis tiers. Removing any single source preserves the recommendation.

**Recommendation:** Define 4 emphasis-based button variants + 1 semantic variant: (1) **Primary** (filled, accent background) — main page CTA, one per view section. (2) **Secondary** (outlined/tonal, border or muted fill) — supporting actions. (3) **Tertiary/Ghost** (text-only, no background/border) — least emphasis, cancel actions, tertiary options. (4) **Danger** (destructive semantic, red) — delete, remove, irreversible actions. Optionally add (5) **Icon button** (icon-only, circular/square, with tooltip). Each variant supports states: default, hover, focus, pressed, disabled, loading. Limit to max 1 primary button per logical section. This maps to the M3/Carbon convergence.

**Level: STANDARD**

---

## Decision 10: Plugin/registry architecture

**PICOC:** P=Modular web applications needing extensibility I=VS Code-style declarative registry with contribution points and lazy activation Co=Micro-frontends with Module Federation, monolithic architecture O=Maintainability, independent module development, performance (lazy loading) C=React SPA with multiple domain modules (bacteriology, mycology, chat)

**Sources included:**
- [S1] VS Code — Extension API: Contribution Points (code.visualstudio.com/api/references/contribution-points) — Level: Reference implementation (L1)
- [S2] VS Code — Extension Anatomy (code.visualstudio.com/api/get-started/extension-anatomy) — Level: Reference implementation (L1)
- [S3] VS Code — Extensibility Principles and Patterns (vscode-docs1.readthedocs.io) — Level: Architecture documentation (L2)
- [S4] Module Federation 2.0 — Official docs (module-federation.io) — Level: Reference implementation (L2)
- [S5] Feature-Sliced Design — "Micro-Frontends: Are They Still Worth It in 2025?" (feature-sliced.design) — Level: Architecture analysis (L3)
- [S6] Elysiate — "Micro-Frontends Architecture with Module Federation 2025" — Level: Practitioner synthesis (L4)

**Sources excluded:**
- iframe-based micro-frontends (too heavy for SPA context)
- "Micro-frontends 2026: MF 3.0" (too speculative/forward-looking)

**Quality scores:**
| Source | Q1 | Q2 | Q3 | Q5 | Q8 | Q9 | Q10 | Q11 |
|--------|---|---|---|---|---|---|---|---|
| S1 | Y | Y | Y | Y | Y | Y | Y | Y |
| S2 | Y | Y | Y | Y | Y | Y | Y | Y |
| S3 | Y | Y | Y | Y | Y | Y | Y | P |
| S4 | Y | Y | Y | Y | Y | Y | Y | Y |
| S5 | Y | Y | Y | P | Y | Y | Y | Y |

**Data extraction:**
- VS Code: "Contribution Points are a set of JSON declarations [...] in the contributes field of the package.json Extension Manifest."
- VS Code: "VS Code defines activation events to support lazy loading of extensions. An activation event is fired by VS Code based on specific activities."
- VS Code: "The approach to run extensions isolated in a separate process allows VS Code to strictly control the API exposed to extenders."
- VS Code: "VS Code reads and interprets the manifest during start-up and prepares its UI accordingly" — declarative registry pattern.
- Feature-Sliced: "Micro-frontends are worth the complexity when the primary constraint is organizational scale with many teams shipping independently."
- Module Federation: "A central version registry (JSON file or API) should track compatible versions across remotes."

**GRADE: 4/7**
- VS Code model is well-documented but is a desktop app, not a web SPA
- Module Federation solves a different problem (multi-team deployment)
- Limited academic research on plugin architectures for SPAs
- OLS is a single-team project — micro-frontends complexity is not justified

**Sensitivity:** FRAGILE — the VS Code model is the dominant reference; removing it weakens the recommendation significantly. However, the pattern (declarative manifest + registry + lazy activation) is a well-known software architecture pattern independent of VS Code.

**Recommendation:** For a single-team SPA like OLS, use a lightweight VS Code-inspired registry pattern WITHOUT micro-frontends overhead: (1) Each module declares a manifest (TypeScript object, not JSON) with contribution points: routes, sidebar items, panel contributions, event subscriptions. (2) A central registry collects manifests at build time and lazily loads module code via React.lazy / dynamic import. (3) Activation is route-based or event-based (module code loads only when needed). (4) Shell provides extension points (sidebar, bottom panel, navigation) that modules populate via their manifests. (5) Modules communicate via typed events (pub/sub), not direct imports. This is the pattern OLS already uses (ModuleDefinition, registry, SPI) — the VS Code architecture validates this approach. Do NOT adopt Module Federation (single team, shared codebase, no independent deployment need).

**Level: RECOMMANDE**

---

## Summary table

| # | Decision | GRADE | Sensitivity | Level |
|---|----------|-------|-------------|-------|
| 1 | Color system / theming | 5/7 | ROBUST | STANDARD |
| 2 | Dark mode strategy | 6/7 | ROBUST | STANDARD |
| 3 | Surface/elevation system | 5/7 | ROBUST | STANDARD |
| 4 | Glass/frosted effects | 4/7 | FRAGILE (perf) / ROBUST (a11y) | RECOMMANDE |
| 5 | Accent/brand color usage | 5/7 | ROBUST | STANDARD |
| 6 | Icon usage guidelines | 6/7 | ROBUST | STANDARD |
| 7 | Badge/status design patterns | 4/7 | ROBUST (semantics) / FRAGILE (impl) | RECOMMANDE |
| 8 | Active state patterns | 6/7 | ROBUST | STANDARD |
| 9 | Button variant system | 5/7 | ROBUST | STANDARD |
| 10 | Plugin/registry architecture | 4/7 | FRAGILE | RECOMMANDE |

Sources:
- [Material Design 3 — Design Tokens](https://m3.material.io/foundations/design-tokens)
- [Material Design 3 — Color Roles](https://m3.material.io/styles/color/roles)
- [Material Design 3 — Elevation](https://m3.material.io/styles/elevation/applying-elevation)
- [Material Design 3 — Tone-based Surfaces](https://m3.material.io/blog/tone-based-surface-color-m3)
- [Apple HIG — Dark Mode](https://developer.apple.com/design/human-interface-guidelines/dark-mode)
- [Apple HIG — Materials](https://developer.apple.com/design/human-interface-guidelines/materials)
- [Nielsen Norman Group — Icon Usability](https://www.nngroup.com/articles/icon-usability/)
- [Nielsen Norman Group — Bad Icons](https://www.nngroup.com/articles/bad-icons/)
- [Nielsen Norman Group — How to Test Digital Icons](https://www.nngroup.com/articles/how-to-test-digital-icons/)
- [WCAG 2.2 — SC 2.4.13 Focus Appearance](https://www.w3.org/WAI/WCAG22/Understanding/focus-appearance.html)
- [WCAG 2.2 — SC 2.4.7 Focus Visible](https://www.w3.org/WAI/WCAG22/Understanding/focus-visible.html)
- [Carbon Design System — Button](https://v10.carbondesignsystem.com/components/button/usage/)
- [Carbon Design System — Status Indicator Pattern](https://carbondesignsystem.com/patterns/status-indicator-pattern/)
- [Adobe Spectrum — Badge](https://spectrum.adobe.com/page/badge/)
- [Nathan Curtis / EightShapes — Buttons in Design Systems](https://eightshapes.com/articles/buttons-in-design-systems/)
- [Nathan Curtis / EightShapes — Tokens in Design Systems](https://medium.com/eightshapes-llc/tokens-in-design-systems-25dd82d58421)
- [VS Code — Contribution Points](https://code.visualstudio.com/api/references/contribution-points)
- [VS Code — Extension Anatomy](https://code.visualstudio.com/api/get-started/extension-anatomy)
- [Sara Soueidan — Accessible Focus Indicators](https://www.sarasoueidan.com/blog/focus-indicators/)
- [Deque — Usable Focus Indicators](https://www.deque.com/blog/give-site-focus-tips-designing-usable-focus-indicators/)
- [Axess Lab — Glassmorphism Meets Accessibility](https://axesslab.com/glassmorphism-meets-accessibility-can-frosted-glass-be-inclusive/)
- [UX4Sight — Accent Colors in UI Design](https://ux4sight.com/blog/ux-training-how-to-optimize-the-use-of-accent-colors)
- [State of CSS 2024 — Features](https://2024.stateofcss.com/en-US/features/)
- [State of CSS 2025](https://2025.stateofcss.com/en-US/)
- [Muzli — Dark Mode Design Systems Guide](https://muz.li/blog/dark-mode-design-systems-a-complete-guide-to-patterns-tokens-and-hierarchy/)
- [Smart Interface Design Patterns — Badges vs Pills vs Chips vs Tags](https://smart-interface-design-patterns.com/articles/badges-chips-tags-pills/)
- [Module Federation](https://module-federation.io/)
- [Feature-Sliced Design — Micro-Frontends 2025](https://feature-sliced.design/blog/micro-frontend-architecture)
- [Wise Design — Focus States](https://wise.design/foundations/focus-states)
- [@material/material-color-utilities npm](https://www.npmjs.com/package/@material/material-color-utilities)
- [Seenode — M3 Tokens System](https://seenode.com/blog/what-is-material-3-and-why-it-matters-in-2025)