# Graphiques et visualisation de donnees

**[BONNE PRATIQUE]** Recharts pour React (composable, declaratif) | Score GRADE : 3/7

Recharts est le choix par defaut pour les projets React : composants declaratifs, SVG natif, responsive, bonne integration TypeScript.

```tsx
// Recharts — composable, declaratif, React-natif
import { LineChart, Line, XAxis, YAxis, Tooltip, ResponsiveContainer } from 'recharts';

function ProgressChart({ data }: { data: { date: string; score: number }[] }) {
  return (
    <ResponsiveContainer width="100%" height={300}>
      <LineChart data={data}>
        <XAxis dataKey="date" />
        <YAxis />
        <Tooltip />
        <Line type="monotone" dataKey="score" stroke="#6366f1" />
      </LineChart>
    </ResponsiveContainer>
  );
}
```

| Librairie | Forces | Limites |
|-----------|--------|---------|
| **Recharts** (14M/mois) | Declaratif React, composable, SVG | Personnalisation complexe limitee |
| **Chart.js** (14M/mois) | Canvas (performant gros volumes), simple | Imperatif, moins React-natif |
| **D3** (9M/mois) | Controle total, dataviz avancee | Courbe d'apprentissage elevee |
| **Nivo** (1M/mois) | Beau par defaut, D3 sous le capot | Moins flexible que Recharts |

Sources : npm trends 2025-2026 — Recharts et Chart.js co-leaders en telechargements (niv. 4), State of JS 2024 — Recharts #1 satisfaction React charting (niv. 4), Recharts docs — built on React + D3 (niv. 5)
