# TypeScript strict mode

**[RECOMMANDE]** Activer `"strict": true` dans tsconfig.json | Score GRADE : 5/7

Le mode strict active un ensemble de verifications qui detectent des categories entieres de bugs a la compilation plutot qu'au runtime.

## Configuration

```json
{
  "compilerOptions": {
    "strict": true
  }
}
```

## Ce que `strict: true` active

| Flag | Detecte |
|------|---------|
| `strictNullChecks` | Acces a null/undefined non verifies |
| `noImplicitAny` | Variables sans type explicite |
| `strictFunctionTypes` | Incompatibilites de signatures de fonctions |
| `strictBindCallApply` | Mauvais arguments sur bind/call/apply |
| `strictPropertyInitialization` | Proprietes de classe non initialisees |
| `noImplicitThis` | `this` de type `any` implicite |
| `alwaysStrict` | Emet `"use strict"` dans chaque fichier |
| `useUnknownInCatchVariables` | `catch(e)` type `unknown` au lieu de `any` |

## Exemple concret

```typescript
// Avec strict: true — ERREUR a la compilation
function greet(name: string) {
  return name.toUpperCase();
}
greet(undefined); // TS2345: Argument of type 'undefined' is not assignable

// Sans strict — compile mais crash au runtime
function greet(name) {     // name: any implicite
  return name.toUpperCase(); // TypeError au runtime si undefined
}
```

## Migration progressive

Pour un projet existant, activer flag par flag dans cet ordre :
1. `noImplicitAny` — le plus impactant, elimine les `any` implicites
2. `strictNullChecks` — elimine les acces null non verifies
3. `strict: true` — active tout le reste d'un coup

## Sources

- [niv. 3] TypeScript docs — strict compiler options, migration guide
- [niv. 4] State of JS 2024 — TypeScript 89%+ satisfaction, strict mode recommande
- [niv. 5] Google TypeScript Style Guide — "always use strict"
