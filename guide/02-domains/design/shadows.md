# Ombres et elevation

**[RECOMMANDE]** Ombres diffuses sur 4 niveaux (sm/md/lg/xl), jamais de `box-shadow` durs | Score GRADE : 3/7

Les ombres subtiles et multicouches creent une hierarchie visuelle naturelle. Eviter les ombres opaques ou a offset dur.

```css
:root {
  --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
  --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.07), 0 2px 4px -2px rgb(0 0 0 / 0.05);
  --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.08), 0 4px 6px -4px rgb(0 0 0 / 0.04);
  --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.04);
}
```

| Usage | Niveau |
|-------|--------|
| Cartes au repos | sm |
| Cartes survolees, dropdowns | md |
| Modales, popovers | lg |
| Overlays, notifications flottantes | xl |

Sources : Material Design 3 Elevation (niv. 5), Apple HIG — Depth (niv. 5), Web Almanac 2024 — 93% des sites utilisent box-shadow (niv. 4)
