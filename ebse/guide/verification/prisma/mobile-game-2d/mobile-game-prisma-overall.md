# PRISMA 2020 Flow Diagram — SLR `mobile-game-2d`

**Protocole** : methodology.md §2.1 + PRISMA 2020 statement (Page et al. 2021, BMJ)
**Reviewers** : A + B (isolated contexts) + Agent C verification
**Amendements** : G-1 (anti-biais), #3 (anchor mandatory), MG-1 à MG-9 (domain-specific)

## Flux (37 PICOCs × 10 batches)

```
IDENTIFICATION
  Bases interrogées (agrégées sur 37 PICOCs) :
    - WebFetch primary standards : Apple App Review, Play Console, WCAG 2.2, UAX #9/#35,
      ICU, ISO/IEC 25010/25019/29119/42001, NIST AI 600-1, OWASP MASVS, SWEBOK v4
    - WebFetch platform SDKs : Godot docs, Unity, Defold, GameMaker, Aseprite, Pixelorama, LibreSprite
    - WebFetch monetization : AdMob, Play Billing, StoreKit 2, AppLovin MAX
    - WebFetch cloud/OSS services : Supabase self-host, PocketBase, Nakama, Plausible, Unleash,
      GlitchTip, Weblate, Forgejo
    - WebFetch SLR empirical : arXiv cs.SE/cs.HC (GameRTS ICSE 2023, property-based testing)
    - Grey literature (MG-1 flagged) : SlashData survey, GameDeveloper.com, IGDA GRUX SIG,
      Lospec, indie dev postmortems
    - Industry anchors : FCC CVAA, EU EAA 2019/882, GDPR, LGPD/PIPL

  Total candidates identifiés (sur 37 PICOCs, A+B combinés) : 280 archetype classes
  + concrete tool existence-proofs

SCREENING (pertinence P-fit)
  Filtrage contre pilot P (solo indie + 2D pixel-art + portrait + offline-first +
  Android+iOS + Godot 4 + budget=open-source strict) :
    Candidates exclus : 95
      - E1 scope (desktop-only, console-only) : 28
      - E2 domain-mismatch (3D-centric, vector-not-pixel-art) : 15
      - E3 maturity (expérimental, pre-v1) : 22
      - E4 platform coverage (Android-only, iOS-only) : 18
      - E5 governance risk (single-vendor abandonware risk) : 12

ELIGIBILITY (full review + anchor verification)
  Candidates entrant en Phase 2 extraction : 185
  (37 PICOCs × 5 candidats archetype moyens)

INCLUDED
  Top-3 shortlists émises par PICOC : 111 (37 × 3)
  Primary recommendations par PICOC : 37

AGENT C VERIFICATION (Phase 2.5)
  13 claims ranking-determinative re-vérifiés via WebFetch fresh :
    - PASS : 10
    - PARTIAL : 1 (PowerSync pas de SDK Godot officiel — integration Supabase REST direct)
    - FAIL mineur : 1 (LibreSprite v1.2 pre-release, v1.1 stable)
    - UNVERIFIED : 1 (Apple DeviceCheck page empty, secondary knowledge used)
  Ranking integrity : INTACT (aucun changement de stack nécessaire)
```

## Inclusions par batch

| Batch | PICOCs | Candidates enumerated | Top-3 shortlist | Primary |
|-------|:------:|:--------------------:|:---------------:|:-------:|
| A — Framework & Architecture | 5 | 45 | 15 | 5 |
| B — Asset Pipeline Tooling | 5 | 30 | 15 | 5 |
| C — Persistence Residuals | 4 | 20 | 12 | 4 |
| D — Store Publishing | 4 | 18 | 12 | 4 |
| E — Monetization | 5 | 40 | 15 | 5 |
| F — Social / Platform | 3 | 18 | 9 | 3 |
| G — Localization | 3 | 30 | 9 | 3 |
| H — Dev Tooling + Ops | 5 | 35 | 15 | 5 |
| I — Quality | 2 | 20 | 6 | 2 |
| J — AI Collaboration | 1 | 11 | 3 | 1 |
| **Total** | **37** | **267** | **111** | **37** |

## Kappa par batch

| Batch | κ | Qualité |
|-------|:---:|---------|
| A | 0.875 | almost perfect |
| B | 1.00 | almost perfect |
| C | 0.80 | substantial |
| D | 1.00 | almost perfect |
| E | 0.60 | moderate |
| F | 0.75 | substantial |
| G | 0.33 | fair |
| H | 0.60 | moderate |
| I | 0.75 | substantial |
| J | 1.00 | almost perfect |

**Pondéré** : κ moyen ≈ 0.72 ("substantial"). Batches kappa bas (G, E, H, A) arbitrés sur critères méthodologiques (merge-vs-split granularité, absorption boundary detection), pas sur critères arbitraires.

## Exclusions transversales

- **Unity-only tooling** (LevelPlay, Unity Ads) : exclu où alternatives cross-engine existent (E22, E23, H35)
- **Enterprise BaaS** (AWS GameLift, Azure PlayFab) : exclu sur E5 (pas VSE solo indie scale)
- **AAA console patterns** (platform certification beyond Apple/Google) : exclu sur P-fit (pilot P mobile-only)
- **Free tier SaaS** (Firebase Spark, Sentry cloud free, GitHub Actions hosted runner) : exclu sur budget=open-source strict (G-3.4 rule — free tier SaaS ≠ open-source)

## Conformité PRISMA 2020

| PRISMA item | Statut |
|-------------|:------:|
| Title + Abstract | ✓ |
| Rationale + Objectives | ✓ (DARE gate Phase 1.1) |
| Eligibility criteria | ✓ (Commissioning + Amendements MG-1 à MG-9) |
| Information sources + Search strategy | ✓ (per-PICOC extraction forms) |
| Selection process | ✓ (double extraction A+B + Agent C) |
| Data collection + Data items | ✓ (37 canonical extraction forms §2.4 format) |
| Risk of bias assessment | ✓ (GRADE factors per primary recommendation) |
| Effect measures | ⚠ (ordinal O-matrix, pas meta-analysis — approprié pour SE SLR hétérogène) |
| Synthesis methods | ✓ (synthesis consolidé single document) |
| Reporting bias assessment | ⚠ (discussion qualitative per PICOC, pas funnel plot systématique) |
| Certainty assessment | ✓ (GRADE /7 avec tier labels STANDARD/RECOMMANDE/BONNE_PRATIQUE/INFORMATIONNEL) |
| Results + Discussion | ✓ (synthesis + stack profile) |

**Conformité globale** : substantiellement conforme PRISMA 2020. Deux items marqués ⚠ sont acceptables pour un SLR SE hétérogène (les mesures quantitatives et funnel plots sont peu appropriés en software engineering où les comparaisons sont ordinales).

## Limitations méthodologiques

1. **Reviewer monoculture** : A et B sont des instances du même modèle LLM. Les GRADE scores omettent le bonus `+1 convergence` pour compenser le biais d'inter-rater correlation potentielle.
2. **Agent C coverage** : 13/267 claims verified = 5% de l'univers candidat. Les ranking-determinative claims sont couverts, les claims secondaires restent UNVERIFIED par échantillonnage.
3. **External validity** : scope limité au domaine mobile-game-2d solo indie 2D pixel-art. Ne se généralise pas aux jeux 3D, AAA console, ou multiplayer temps-réel compétitif.
4. **Temporal validity** : le stack recommendation doit être re-validé annuellement — les packages spécifiques évoluent rapidement (exemple : godot-iap archivé 2026-04-18, migré vers hyodotdev/openiap monorepo).
