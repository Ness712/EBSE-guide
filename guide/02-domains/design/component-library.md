# Component Library

**[RECOMMANDE]** **shadcn/ui** (Radix + Tailwind) | Score GRADE : 3/7

## Pourquoi shadcn/ui

| Critere | shadcn/ui | MUI | Ant Design | Headless UI |
|---------|-----------|-----|------------|-------------|
| Tailwind natif | **Oui** | Non (Emotion) | Non (Less) | Oui |
| Accessibilite | **Radix = WAI-ARIA** | Bon | Moyen | Excellent |
| Customisabilite | **Full (own the code)** | Theme overrides | Tokens | Full |
| Bundle size | **0kb runtime** (copy-paste) | ~80-150kb | ~100-200kb | ~10kb |
| Composants | ~50 | ~60+ | ~60+ | ~10 |

```bash
# Installation — zero dependance runtime
npx shadcn@latest init
# Les composants sont copies dans src/components/ui/
# Full ownership, pas de breaking updates externes
```

## Quand NE PAS utiliser

- Si besoin d'un design system complet opinionne sans customisation → MUI
- Si pas de Tailwind dans le projet → MUI ou Ant Design

Sources : State of JS 2024 — shadcn/ui #1 satisfaction (niv. 4), npm trends — croissance la plus rapide (niv. 4), Radix UI accessibilite WAI-ARIA 1.2 (niv. 3), 80k+ GitHub stars (niv. 4)
