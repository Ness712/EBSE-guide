# /audit-code — Audit qualité code

> **Type** : Audit qualité code (Type 2)
> **Source** : EBSE-guide — Méthode d'audit fiable (PICOC #5 + #10)
> **Usage** : Revue de code complète — bugs, sécurité, conventions, recommandations EBSE.
> **Quand** : après une feature complète, avant une PR, ou sur demande PO.

---

## Ce que fait cet audit

Un agent indépendant (contexte frais, n'a pas participé à l'implémentation) lit les fichiers réels et vérifie une checklist explicite. Pas de grep — lecture complète des fichiers concernés.

---

## Procédure

Remplace les `[CONFIGURER]` selon le repo et le périmètre, puis exécute.

```
Spawn un agent indépendant avec contexte frais :

Agent({
  model: "sonnet",
  prompt: """
Audit qualité code. Tu n'as pas participé à l'implémentation — contexte frais, sois critique.

LIS D'ABORD (dans cet ordre) :
1. [CONFIGURER — ex: OLS-frontend/CONVENTIONS.md]
2. [CONFIGURER — ex: OLS/CLAUDE.md]
3. [CONFIGURER — ex: EBSE-guide/data/stacks/ols-recommendations.json]
4. Les fichiers à auditer : [CONFIGURER — ex: liste des fichiers modifiés dans la PR / feature]

CHECKLIST — pour chaque fichier audité :

Sécurité (OWASP Top 10) :
- Injection (SQL, command, XSS, SSTI)
- Authentification / autorisation incorrecte
- Données sensibles exposées (logs, réponses API, erreurs)
- Dépendances avec vulnérabilités connues
- Mauvaise configuration de sécurité

Qualité code :
- Violations des conventions du projet (CONVENTIONS.md)
- Code mort, TODO non implémentés, deprecated non supprimé
- Rustines / hacks / workarounds au lieu d'une vraie solution
- eslint-disable / @SuppressWarnings / noqa non justifiés
- Tests manquants ou insuffisants pour le code ajouté

Alignement EBSE :
- [CONFIGURER — ex: vérifier que les choix techniques correspondent aux recommandations ols-recommendations.json]

OUTPUT OBLIGATOIRE :

## Bloquants (à corriger avant merge)
- [item 1] — fichier:ligne — raison
- ...

## Avertissements (à traiter, non-bloquants)
- [item 1] — fichier:ligne — raison
- ...

## Verdict : OK / KO
[Justification en 1-2 phrases]
  """
})
```

---

## Règles d'interprétation

- **Bloquant** : sécurité, violation de convention majeure, bug avéré, test manquant sur chemin critique
- **Avertissement** : dette technique, suggestion de refactor, amélioration non-urgente
- **Verdict KO** → corriger les bloquants, relancer l'audit avant de créer la PR
- **Verdict OK** → créer la PR en incluant le rapport complet dans la description

## Ce que l'audit ne remplace PAS

- La review humaine ligne par ligne sur les chemins critiques (auth/**, migrations/**, security/**)
- Le SonarQube quality gate (SAST automatique)
- Les tests unitaires / E2E (à lancer séparément)

Ces trois éléments sont complémentaires, pas substituables.
