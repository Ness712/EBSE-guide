# Responsive design

**[STANDARD]** Mobile-first, breakpoints Tailwind, touch targets 48x48px minimum | Score GRADE : 5/7

Commencer par le mobile et enrichir progressivement. Les breakpoints Tailwind alignes sur les standards M3 et Apple.

```css
/* Breakpoints Tailwind (mobile-first → min-width) */
/* sm: 640px  — grand mobile / petit tablet */
/* md: 768px  — tablet portrait */
/* lg: 1024px — tablet paysage / petit desktop */
/* xl: 1280px — desktop */
/* 2xl: 1536px — grand ecran */

/* Touch targets — minimum 48x48px (WCAG), ideal 48dp (M3) */
.touch-target { min-width: 48px; min-height: 48px; }
```

| Regle | Valeur |
|-------|--------|
| Touch target minimum | 48x48px (WCAG 2.5.8 AA) |
| Espacement entre cibles | >= 8px |
| Viewport meta | `width=device-width, initial-scale=1` |
| Images | `srcset` + `sizes` pour chaque breakpoint |

Sources : WCAG 2.2 SC 2.5.8 — target size 24px minimum, 44px recommande (niv. 1), Material Design 3 — 48dp touch targets (niv. 5), Apple HIG — 44pt minimum tap targets (niv. 5)
