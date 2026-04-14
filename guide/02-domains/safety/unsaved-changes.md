# Protection des modifications non sauvegardees

**[BONNE PRATIQUE]** Avertir avant de perdre des donnees saisies par l'utilisateur | Score GRADE : 3/7

Quitter une page avec un formulaire modifie sans avertissement est une perte de donnees silencieuse. Le navigateur offre `beforeunload` ; React Router offre `useBlocker`.

```typescript
// Hook React — protection beforeunload + navigation SPA
import { useEffect } from 'react';
import { useBlocker } from 'react-router-dom';

function useUnsavedChanges(isDirty: boolean) {
  // Protection fermeture onglet / refresh
  useEffect(() => {
    if (!isDirty) return;
    const handler = (e: BeforeUnloadEvent) => e.preventDefault();
    window.addEventListener('beforeunload', handler);
    return () => window.removeEventListener('beforeunload', handler);
  }, [isDirty]);

  // Protection navigation SPA (React Router)
  useBlocker(() => isDirty && !window.confirm('Modifications non sauvegardees. Quitter ?'));
}
```

| Scenario | Protection |
|----------|-----------|
| Fermeture onglet / refresh | `beforeunload` natif |
| Navigation SPA (changement de route) | `useBlocker` (React Router) |
| Bouton retour navigateur | `beforeunload` + `useBlocker` |
| Auto-save disponible | Pas de dialog, sauvegarder silencieusement |

Sources : Apple HIG — "hazard warning" avant perte de donnees (niv. 5), MDN — beforeunload event (niv. 3), React Router docs — useBlocker (niv. 3), Nielsen — prevention des erreurs, heuristique #5 (niv. 3)
