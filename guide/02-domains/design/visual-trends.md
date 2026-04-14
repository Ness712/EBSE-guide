# Tendances visuelles (2026)

**[BONNE PRATIQUE]** Subtle borders, tonal elevation, coins arrondis 8-16px | Score GRADE : 2/7

> **DATED** — a revoir annuellement. Les tendances evoluent, les principes restent.

Les interfaces convergent vers Material Design 3 + Apple HIG : surfaces tonales plutot qu'ombres portees, bordures subtiles, glassmorphism leger, coins arrondis genereux.

```css
/* Tendances 2025-2026 — convergence M3 + Apple HIG */
.card {
  border: 1px solid rgba(0, 0, 0, 0.06);       /* subtle border */
  border-radius: 12px;                           /* 8-16px range */
  background: rgba(255, 255, 255, 0.72);         /* glassmorphism subtil */
  backdrop-filter: blur(20px);                    /* Apple-style blur */
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.04);    /* tonal elevation */
}
```

| Tendance | Ce qui remplace | Source |
|----------|----------------|--------|
| Tonal elevation (surface teintee) | Drop shadows lourdes | Material Design 3 |
| Subtle borders (1px, 6% opacity) | Ombres comme seul separateur | Apple HIG, M3 |
| Glassmorphism subtil (blur 20px) | Flat design pur | Apple HIG (visionOS) |
| Coins arrondis 8-16px | Coins vifs ou > 20px | M3 (12px defaut), Apple (10-13px) |

Sources : Material Design 3 — tonal elevation, shape system (niv. 5), Apple HIG 2025 — materials, vibrancy, corner radius (niv. 5), Dribbble/Behance trends 2025-2026 — observation empirique (niv. 6)
