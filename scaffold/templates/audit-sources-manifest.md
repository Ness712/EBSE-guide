# Manifest des sources de vérité [NOM PROJET] (Tier 3 & 4)

**Usage** : sources spécifiques à [NOM PROJET] à lire lors de tout audit.
Les Tier 1 & 2 sont dans `[chemin]/<project>-recommendations.json → applicable_sources`.

> Copier ce fichier dans `[repo-doc]/reference/audit-sources-manifest.md` ou `[repo]/docs/audit-sources-manifest.md`.
> Voir `OLS-documentation/reference/audit-sources-manifest.md` pour un exemple complet.

---

## Tier 3 — Conventions projet

Fichiers qui définissent les règles propres au projet (nommage, structure, patterns) non couvertes par les normes universelles.

| Repo | Fichier | Contenu |
|------|---------|---------|
| [repo-1] | [CONVENTIONS.md](../../[repo-1]/CONVENTIONS.md) | [description des conventions couvertes] |
| [repo-2] | [CONVENTIONS.md](../../[repo-2]/CONVENTIONS.md) | [description des conventions couvertes] |

> Ajouter une ligne par repo qui a un CONVENTIONS.md. Si un repo n'en a pas, ne pas l'inclure.

---

## Tier 4 — Décisions d'architecture

Fichiers qui capturent les choix d'architecture spécifiques au projet contraignant les implémentations auditables.

| Fichier | Contenu | Pertinence audit |
|---------|---------|-----------------|
| [modules.md ou équivalent](chemin/vers/modules.md) | Schéma inter-modules, contrats | Architecture, couplage |
| [schema.prisma ou équivalent](chemin/vers/schema) | Modèle de données | Données personnelles (RGPD), intégrité |
| [openapi.json ou équivalent](chemin/vers/openapi) | Spécification API | Contrats, sécurité endpoints |
| [CLAUDE.md ou équivalent](chemin/vers/CLAUDE.md) | Contraintes agents, gates | Processus, CI/CD |

> Inclure tout document qui définit une contrainte vérifiable lors d'un audit.
> Exclure la documentation informative (tutoriels, how-to) — uniquement les specs et décisions.

---

## Maintien

Mettre à jour quand : nouveau repo, nouveau CONVENTIONS.md, nouvel ADR majeur, changement de stack.
