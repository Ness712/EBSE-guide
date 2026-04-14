# Confirmation des actions destructives

**[STANDARD]** Dialog de confirmation + pattern undo pour toute action irreversible | Score GRADE : 5/7

Toute action destructive (suppression, ecrasement) doit requérir une confirmation explicite. Privilegier le soft-delete + undo quand possible.

```tsx
// Dialog de confirmation — jamais de window.confirm()
<AlertDialog>
  <AlertDialogTrigger asChild>
    <Button variant="destructive">Supprimer</Button>
  </AlertDialogTrigger>
  <AlertDialogContent>
    <AlertDialogTitle>Supprimer ce module ?</AlertDialogTitle>
    <AlertDialogDescription>Cette action est irreversible.</AlertDialogDescription>
    <AlertDialogCancel>Annuler</AlertDialogCancel>
    <AlertDialogAction onClick={handleDelete}>Supprimer</AlertDialogAction>
  </AlertDialogContent>
</AlertDialog>
```

| Regle | Implementation |
|-------|---------------|
| Suppression simple | Toast "Annuler" pendant 5s (soft-delete) |
| Suppression definitive | Dialog modale avec texte explicite |
| Suppression en masse | Dialog + saisie de confirmation ("supprimer") |
| Bouton destructif | Rouge, jamais a cote du bouton principal |

Sources : Apple HIG — confirmation pour actions destructives (niv. 5), Material Design 3 — dialogs de confirmation (niv. 5), WCAG 2.2 SC 3.3.4 — prevention des erreurs, reversibilite (niv. 1)
