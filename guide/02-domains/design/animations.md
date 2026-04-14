# Animations

**[STANDARD]** Duree 200-300ms, ease-out (entree) / ease-in (sortie), respecter prefers-reduced-motion | Score GRADE : 5/7

Les animations trop longues (>500ms) frustrent, trop courtes (<100ms) sont imperceptibles. Toujours offrir une alternative sans animation.

```css
/* Tokens d'animation */
:root {
  --duration-fast: 150ms;   /* micro-interactions (hover, toggle) */
  --duration-normal: 250ms; /* transitions standard */
  --duration-slow: 350ms;   /* modales, expansions */
}
.enter { transition: all var(--duration-normal) ease-out; }
.exit  { transition: all var(--duration-fast) ease-in; }

@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after { animation-duration: 0.01ms !important; transition-duration: 0.01ms !important; }
}
```

Sources : Material Design 3 Motion — 200-500ms selon complexite (niv. 5), Apple HIG — 250ms standard (niv. 5), WCAG 2.2 SC 2.3.3 / Nielsen Norman Group — reduced motion obligatoire (niv. 1/3)
