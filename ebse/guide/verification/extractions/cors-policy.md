# Double Extraction — PICOC cors-policy

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "CORS misconfiguration security", "Access-Control-Allow-Origin wildcard authenticated API", "CORS policy whitelist server-side", "CORS credentials wildcard incompatible", "OWASP CORS testing CLNT-07", "CORS attack cross-origin data theft"
**Agent B** : mots-clés : "CORS secure configuration backend", "cross-origin resource sharing vulnerabilities", "CORS null origin exploit", "NestJS CORS CorsOptions whitelist", "WHATWG Fetch standard CORS section", "Kettle CORS misconfigurations exploiting"

---

## PICOC

```
P  = Équipes développement configurant des APIs web accessibles depuis des origines multiples
I  = Configurer une politique CORS sécurisée sur le serveur
C  = CORS wildcard (Access-Control-Allow-Origin: *) ou absence de politique CORS
O  = Sécurité/Intégrité, protection CSRF cross-origin, fonctionnement des requêtes légitimes
Co = Applications web avec frontend et backend sur des origines distinctes
```

---

## Accord Reviewer A / Reviewer B

| # | Source | Niveau A | Niveau B | Accord ? | Note divergence |
|---|--------|---------|---------|:--------:|-----------------|
| 1 | WHATWG Fetch Living Standard — CORS section (2024) | 1 | 1 | ✓ | — |
| 2 | OWASP WSTG CLNT-07 — Testing for CORS (2024) | 2 | 2 | ✓ | — |
| 3 | OWASP HTML5 Security Cheat Sheet — CORS (2024) | 2 | 2 | ✓ | — |
| 4 | MDN Web Docs — Cross-Origin Resource Sharing (2024) | 3 | 3 | ✓ | — |
| 5 | PortSwigger Web Security Academy — CORS vulnerabilities (2024) | 5 | 5 | ✓ | — |
| 6 | Kettle J. — Exploiting CORS misconfigurations (AppSecUSA, 2016) | 5 | 5 | ✓ | — |
| 7 | NestJS CORS documentation — CorsOptions (2024) | absent | 3 | ✗ | **A ne cite pas, B cite directement** |

**Accord sur sources communes** : 6/6 → kappa = 1.0 (inclusion + niveau).
**Sources A-only** : aucune.
**Sources B-only** : NestJS CORS documentation.

### Résolution des divergences

**NestJS CORS docs (B-only)** : Inclus — directement actionnable pour l'implémentation du callback de validation d'origine. Pyramide 3 (documentation framework officielle). Scope PICOC : contexte OLS utilise NestJS comme backend principal (voir ols.json), ce qui rend la source directement pertinente. Aucun risque de biais (documentation officielle framework, pas vendor marketing).

---

## Calcul GRADE final

```
Score de départ : 4
  (source la plus haute directement pertinente = niveau 1 :
   WHATWG Fetch Living Standard — définit littéralement le comportement CORS
   et la contrainte wildcard+credentials au niveau spécification)

+ 1 convergence
  WHATWG Fetch Standard (niveau 1) + OWASP WSTG CLNT-07 (niveau 2) + OWASP HTML5
  Cheat Sheet (niveau 2) + MDN (niveau 3) + PortSwigger WSA (niveau 5) + Kettle 2016
  (niveau 5) convergent sans contradiction sur les mêmes règles :
  (1) wildcard interdit avec credentials — contrainte de spécification absolue
  (2) validation de l'Origin obligatoire contre une whitelist explicite côté serveur
  (3) null origin à rejeter — vecteur d'attaque documenté
  (4) preflight à configurer au minimum nécessaire
  Sources indépendantes : normatif W3C, guide sécurité applicatif, documentation développeur,
  recherche offensive — 4 catégories distinctes convergentes.

+ 1 effet important
  Kettle 2016 : démonstration d'exploitation réelle sur des cibles publiques majeures
  (vol de tokens OAuth, accès données privées cross-origin).
  OWASP WSTG : classification comme vecteur de première classe.
  La contrainte wildcard+credentials est binaire : une mauvaise configuration = impact
  immédiat et total (pas de dégradation graduelle).

Facteurs négatifs :
  - Pas d'incohérence entre sources (aucune source contredit les règles énoncées).
  - Pas d'indirectness significative : les sources traitent directement la configuration
    CORS serveur dans le contexte d'APIs web (PICOC direct).
  - Pas d'imprécision : les règles sont précises et opérationnelles
    (wildcard interdit, whitelist obligatoire, null origin à rejeter).

Score final : 4 + 1 + 1 = 6 → [STANDARD]
```

Note biais de publication : faible — les sources normatives (WHATWG, OWASP) sont prescriptives par nature. La convergence avec des sources offensives (Kettle, PortSwigger) qui documentent les attaques réelles valide empiriquement les règles défensives. Aucun biais publication détecté : les règles sont soit spécifiées (WHATWG), soit confirmées par exploitation réelle.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| WHATWG Fetch Living Standard | 5 (départ 3, +1 conv, +1 effet) | STANDARD | NON |
| Kettle 2016 | 5 (départ 4, +1 conv, sans effet important) → recalcul : OWASP documente l'impact, facteur effet maintenu via OWASP WSTG | STANDARD | NON |
| OWASP WSTG CLNT-07 | 5 (départ 4, +1 conv, +1 effet — convergence intacte) | STANDARD | NON |
| OWASP HTML5 Cheat Sheet | 6 (convergence et effet inchangés) | STANDARD | NON |
| PortSwigger WSA | 5 (départ 4, +1 conv partielle, +1 effet via Kettle) | STANDARD | NON |
| NestJS docs | 6 (source framework non décisive pour GRADE) | STANDARD | NON |
| Toutes sources niveau 2 simultanément | 5 (départ 4 WHATWG, +1 conv MDN+Kettle+PSW, +1 effet Kettle) | STANDARD | NON |
| Toutes sources sauf WHATWG | 4 (départ 3, +1 conv, +1 effet) | RECOMMANDE | OUI |

**Conclusion : ROBUSTE** — recommandation [STANDARD] stable pour tout retrait individuel et pour tout retrait par catégorie sauf retrait complet de toutes les sources non-WHATWG (scénario artificiel). La robustesse est élevée car la règle principale (incompatibilité wildcard+credentials) est une contrainte de spécification de niveau 1 — non falsifiable par des sources de niveau inférieur. Le grade 6 reflète à la fois la force normative (spec) et la convergence empirique (exploitation réelle documentée).

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| OWASP ASVS V14 — CORS section | E5 redondance | Couvert intégralement par WSTG CLNT-07 + HTML5 Cheat Sheet sans apport différencié pour le principe |
| RFC 6454 — The Web Origin Concept (IETF, 2011) | E5 supplanté | Absorbé par WHATWG Fetch Living Standard (plus récent, plus complet, standard vivant maintenant le modèle d'origine) |
| Spring Security CORS documentation | E2 scope | Implémentation stack-spécifique — candidat pour variant java-spring-boot, hors scope du principe universel |
| arXiv surveys CORS misconfiguration prevalence (≥3 papiers) | E3 indirect | Mesurent la prévalence des mauvaises configs mais n'apportent pas de guidance prescriptive supplémentaire ; absorbés par Kettle 2016 + OWASP |
| Blog posts experts sécurité (≥4 sources) | E1 redondance | Niveau 5 redondant — PortSwigger WSA + Kettle 2016 couvrent la même expertise offensive avec plus de rigueur et de traçabilité |
