# /audit-alignment — Audit d'alignement source-first

> **Type** : Audit d'alignement (Type 1)
> **Source** : ebse-scaffold — Méthode d'audit fiable (PICOC #5 + #10)
> **Usage** : Vérifier qu'une implémentation X couvre exhaustivement une référence Y.
> **Exemples** : template ↔ PICOCs, CLAUDE.md ↔ template, code ↔ CONVENTIONS.md

---

## Ce que fait cet audit

Part de la **référence** (source de vérité), énumère chaque item, puis vérifie si l'implémentation le reflète sémantiquement.

Différent d'un grep : on lit le contenu réel de chaque item, pas des mots-clés.

---

## Procédure

Remplace les `[CONFIGURER]` selon le cas d'usage, puis exécute.

```
Spawn un agent indépendant avec contexte frais (tu n'as pas participé à la construction) :

Agent({
  model: "sonnet",
  prompt: """
Audit d'alignement source-first. Tu n'as pas participé à la construction — contexte frais, sois rigoureux.

RÉFÉRENCE (source de vérité) :
Lire exhaustivement : [CONFIGURER — ex: chaque fichier JSON dans ebse-scaffold/ebse/guide/data/decisions/ai-agent-*.json]

IMPLÉMENTATION (ce qu'on vérifie) :
Lire : [CONFIGURER — ex: ebse-scaffold/scaffold/claude-md-autonomous-agent.md]

PROCÉDURE pour chaque item de la référence :
1. Lire le principe complet (pas juste le titre)
2. Chercher dans l'implémentation si ce principe est reflété sémantiquement
3. "Couvert" = le principe essentiel est là, correctement formulé
4. "Partiel" = mentionné mais incomplet ou mal formulé
5. "Absent" = introuvable dans l'implémentation

OUTPUT OBLIGATOIRE — table markdown :
| Item | Statut | Note |
|------|--------|------|
| [nom item 1] | Couvert / Partiel / Absent | [ce qui manque si Partiel/Absent] |
| ... | ... | ... |

Puis : liste des gaps prioritaires (Absent ou Partiel avec impact fort).
Rien ne doit manquer — si tu n'es pas sûr d'un item, mets "Partiel" avec note.
  """
})
```

---

## Cas d'usage typiques

| Référence | Implémentation | Question |
|-----------|---------------|----------|
| `ebse-scaffold/ebse/guide/data/decisions/ai-agent-*.json` (18 fichiers) | `scaffold/claude-md-autonomous-agent.md` | Le template couvre-t-il tous les PICOCs ? |
| `scaffold/claude-md-autonomous-agent.md` | `OLS/CLAUDE.md` | OLS suit-il 100% le template ? |
| `OLS-frontend/CONVENTIONS.md` | Fichiers modifiés dans la PR | La PR respecte-t-elle les conventions ? |
| `OLS-backend/CONVENTIONS.md` | Fichiers modifiés dans la PR | Idem côté backend |

---

## Interpréter les résultats

- **Absent** : gap réel — à corriger avant de déclarer "aligné"
- **Partiel** : évaluer l'impact — si le principe essentiel est là, peut être acceptable
- **Couvert** : validé — ne pas re-vérifier sauf changement de la référence

**Ne pas biaiser** : si un item est "Absent" mais que tu penses qu'il est implicite dans autre chose, mets "Partiel" avec une note — l'humain juge.
