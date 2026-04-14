# Systeme d'espacement

**[STANDARD]** Grille de base **8px**, sous-unite 4px | Score GRADE : 5/7

Tous les espacements, marges et paddings doivent etre des multiples de 4px, privilegiant les multiples de 8px.

```typescript
// tailwind.config — les valeurs par defaut Tailwind suivent deja ce systeme
// 1=4px, 2=8px, 3=12px, 4=16px, 6=24px, 8=32px, 12=48px
const spacing = { 1: '4px', 2: '8px', 3: '12px', 4: '16px', 6: '24px', 8: '32px', 12: '48px' };
```

| Token | Valeur | Usage |
|-------|--------|-------|
| xs | 4px | Espacement intra-composant |
| sm | 8px | Padding interne compact |
| md | 16px | Padding standard, gap grilles |
| lg | 24px | Separation de sections |
| xl | 32px | Marges de page |
| 2xl | 48px | Separation de blocs majeurs |

Sources : Material Design 3 — grille 8dp (niv. 5), Apple HIG — espacement 8pt systematique (niv. 5), ISO 9241-112:2017 — espacement regulier pour lisibilite (niv. 1)
