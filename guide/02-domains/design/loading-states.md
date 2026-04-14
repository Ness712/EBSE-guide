# Etats de chargement

**[RECOMMANDE]** Skeleton screens plutot que spinners | Score GRADE : 4/7

Les skeleton screens reduisent la perception du temps d'attente de ~35% vs spinners (Baymard). Ils preservent le layout et reduisent le CLS.

```css
.skeleton {
  background: #e0e0e0;
  border-radius: 4px;
  animation: pulse 1.5s ease-in-out infinite;
}
@keyframes pulse {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.4; }
}
```

| Duree | Pattern |
|-------|---------|
| < 200ms | Rien (imperceptible) |
| 200ms - 1s | Skeleton inline |
| 1s - 5s | Skeleton pleine page |
| > 5s | Skeleton + barre de progression |

Sources : Baymard Institute — skeleton reduit abandon de 10-20% (niv. 3), Nielsen Norman Group — seuils perception 0.1/1/10s (niv. 3), Material Design 3 Progress Indicators (niv. 5)
