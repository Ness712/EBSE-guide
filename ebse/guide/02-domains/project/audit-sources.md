# Inventaire des sources de vérité avant audit (Audit Sources Inventory)

**[RECOMMANDE]** Constituer un inventaire documenté de toutes les sources de vérité applicables avant d'exécuter tout audit | Score GRADE : 5/9

L'énumération explicite de toutes les sources de vérité AVANT l'audit garantit que rien n'est manqué par exploration partielle. IEEE 1028-2008 §6.4 prescrit de documenter tous les standards de référence avant de commencer ; ISO/IEC 25040:2024 §5.3 exige de spécifier toutes les mesures de qualité avant l'exécution. Fagan (1976) démontre empiriquement que la pré-spécification des critères donne 67-82% de défauts détectés en plus vs approche exploratoire (ratio ×1.67-2.47). Sans inventaire préalable, un audit exploratoire par dimensions manque systématiquement les exigences qui ne se manifestent pas visuellement dans le code (conformités légales, configs tools, conventions projet).

---

## Principe fondamental

| Principe | Source | GRADE |
|----------|--------|:-----:|
| Constituer l'inventaire des sources AVANT d'ouvrir un seul fichier du projet | IEEE 1028-2008 §6.4, ISO/IEC 25040:2024 §5.3 | 5 |
| Organiser les sources en 4 tiers selon leur universalité | IEEE 1028-2008 (inputs), NIST SP 800-53A (catalogue) | 5 |
| Vérifier la couverture à la fin : chaque finding doit être lié à une source explicite | ISO/IEC 25040:2024 §5.5, Kitchenham 2007 | 5 |
| Les sources universelles (Tier 1-2) sont dérivées du profil projet via l'arbre de décisions | IEEE 1028-2008, NIST SP 800-53A | 5 |

---

## Taxonomie des sources — 4 tiers

### Tier 1 — Normes universelles (dérivées du profil projet)

Catalogue exhaustif dans [`ebse/guide/data/sources-catalog.json`](../data/sources-catalog.json) — chaque entrée a un `id`, une URL officielle et des `condition_keys` d'applicabilité.

Pour un projet avec `<stack>-recommendations.json` : lire directement `applicable_sources.tier1` — liste pré-calculée depuis le profil.

> Exemple OLS → `ols-recommendations.json → applicable_sources.tier1` : owasp-asvs, owasp-top10, owasp-api, wcag-22-aa, rgpd-cnil, lcen.

### Tier 2 — Documentation officielle des outils

Catalogue exhaustif dans [`ebse/guide/data/sources-catalog.json`](../data/sources-catalog.json) — chaque outil a son URL officielle et `what_to_check`.

Pour un projet avec `<stack>-recommendations.json` : lire directement `applicable_sources.tier2` — liste pré-calculée depuis le profil.

> Exemple OLS → `ols-recommendations.json → applicable_sources.tier2` : typescript, nestjs, prisma, react, vite, tailwind, shadcn-ui, eslint, postgresql, redis, minio, docker, docker-compose, caddy, github-actions, dependabot, codeql, sonarqube, pnpm, playwright, vitest, jest.

### Tier 3 — Conventions projet (spécifiques au projet)

Documents qui définissent les règles propres au projet — non universelles, non dérivables de standards :

- `CONVENTIONS.md` de chaque repo (règles nommage, structure fichiers, patterns TypeScript spécifiques au projet)
- Toute convention documentée qui n'est pas couverte par Tier 1-2

### Tier 4 — Décisions d'architecture projet

Documents qui capturent les choix d'architecture spécifiques au projet :

- `modules.md` — schéma inter-modules et contrats
- `design-direction.md` — direction design et système de design
- `CLAUDE.md` — contraintes et conventions pour agents IA
- `schema.prisma` — modèle de données (pertinent RGPD : données personnelles)
- `docs/openapi.json` — spécification API (contrats, sécurité endpoints)
- Tout ADR (Architecture Decision Record) documenté

### Manifest Tier 3/4 (recommandé)

Chaque projet doit maintenir un fichier manifest qui liste explicitement tous ses chemins Tier 3/4 :

```
reference/audit-sources-manifest.md   (OLS — exemple)
docs/audit-sources-manifest.md        (autres projets)
```

Ce fichier est lu en premier lors de tout audit — il remplace la recherche manuelle des conventions et docs architecture. Voir `OLS-documentation/reference/audit-sources-manifest.md` pour un exemple complet.

> Tier 1 et Tier 2 ne figurent pas dans ce manifest : ils sont dérivés automatiquement via `sources-catalog.md` + profil projet.

---

## Procédure d'inventaire

```
ÉTAPE 0 — Avant d'ouvrir le moindre fichier du projet

1. Lire le profil projet (ex: ols.json)
2. Dériver les sources Tier 1 applicables via l'arbre de décisions
3. Lister les outils utilisés → dériver les sources Tier 2
4. Localiser les CONVENTIONS.md de chaque repo → Tier 3
5. Localiser les docs architecture → Tier 4
6. Documenter l'inventaire complet AVANT exécution

FORMAT INVENTAIRE :
  Tier 1 applicables : [liste avec justification profil]
  Tier 2 outils : [liste des configs à vérifier]
  Tier 3 conventions : [chemin vers chaque CONVENTIONS.md]
  Tier 4 architecture : [chemins vers docs architecture]
  Total exigences estimées : N
```

---

## Vérification de couverture en fin d'audit

Chaque finding doit référencer explicitement la source et la règle. À la fin de l'audit :

```
COUVERTURE :
  Tier 1 — [source] : N_vérifié / N_total checks applicables
  Tier 2 — [outil] : vérifié / non vérifié
  Tier 3 — [repo/CONVENTIONS.md] : N règles vérifiées
  Tier 4 — [doc] : vérifié / non vérifié
  Findings non sourcés : 0 (sinon invalides)
```

---

## Relation avec les autres entrées du guide

| Entrée | Rôle |
|--------|------|
| `project-health-audit.md` | Structure l'audit : 7 dimensions ISO 25010, format findings, fréquence |
| **`audit-sources.md` (cette entrée)** | Garantit la complétude : inventaire exhaustif AVANT exécution |

Les deux entrées sont complémentaires. `project-health-audit.md` répond à "comment structurer les findings". `audit-sources.md` répond à "comment s'assurer de ne rien manquer".

---

## Analyse de sensibilité (robustesse GRADE = 5)

- Retirer IEEE 1028 → base reste 4 (ISO 25040 niv.1) → GRADE : 5
- Retirer ISO 25040 → base reste 4 (IEEE 1028 niv.1) → GRADE : 5
- Retirer Fagan → perd +effet important → GRADE : 4 [BONNE PRATIQUE]
- Augmenter indirectness à -2 → GRADE : 4 [BONNE PRATIQUE]

**Conclusion** : GRADE 5 robuste. Dégradation à 4 uniquement si on retire Fagan (evidence empirique sur l'effet). Le GRADE minimum = 4 dans tous les scénarios, restant dans la zone [RECOMMANDE] ou [BONNE PRATIQUE].

---

## Sources

- [niv. 1] IEEE 1028-2008 — Software Reviews and Audits (§6.4 Audit Inputs : standards de référence documentés avant audit)
- [niv. 1] ISO/IEC 25040:2024 — SQuaRE Evaluation Process (§5.3 : mesures spécifiées avant exécution)
- [niv. 2] NIST SP 800-53A Rev. 5 (2022) — Assessing Security and Privacy Controls (catalogue exhaustif pré-établi)
- [niv. 3] Kitchenham et al. 2007 — SLR guidelines EBSE (protocole pré-enregistré, non-circularité)
- [niv. 4] Fagan, M.E. 1976 — IBM Systems Journal 15(3) (checklists pré-définies : +67-82% détection défauts)
- [niv. 4] Porter, Siy, Votta 1995 — Advances in Computers 42 (revue 40+ études : pré-spécification = facteur commun inspections efficaces)
