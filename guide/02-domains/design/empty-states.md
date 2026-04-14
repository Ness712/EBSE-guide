# Etats vides (empty states)

**[BONNE PRATIQUE]** Illustration + message + CTA — jamais d'ecran vide | Score GRADE : 3/7

Un ecran vide sans guidance viole la 1ere heuristique de Nielsen ("visibilite de l'etat du systeme"). L'utilisateur ne sait pas s'il y a un bug, si c'est normal, ou quoi faire.

```tsx
// Empty state — toujours 3 elements : illustration, message, action
function EmptyState() {
  return (
    <div className="flex flex-col items-center gap-4 py-16">
      <InboxIcon className="size-12 text-muted-foreground" />
      <p className="text-muted-foreground">Aucun message pour le moment</p>
      <Button>Demarrer une conversation</Button>
    </div>
  );
}
```

| Regle | Pourquoi |
|-------|----------|
| Illustration ou icone | Donne le contexte visuel immediatement |
| Message explicatif | Explique l'etat ("pas encore de X") vs erreur |
| CTA (call to action) | Guide l'utilisateur vers l'etape suivante |
| Jamais un ecran blanc vide | Nielsen heuristique #1 : visibilite de l'etat |
| Ton positif | "Commencez par..." plutot que "Rien ici" |

Sources : Nielsen Norman Group — heuristique #1 visibilite de l'etat du systeme (niv. 3), Material Design 3 — empty states guidelines (niv. 5), Luke Wroblewski — mobile empty states patterns (niv. 5)
