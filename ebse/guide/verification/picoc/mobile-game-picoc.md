# Phase 1.3 — PICOCs consolidated : domaine `mobile-game-2d`

**Protocole** : methodology.md v3.0 §1.3 (Kitchenham & Charters 2007) + Amendement G-1 (anti-biais) + Amendement #3 (anchor obligatoire)
**Date consolidation** : 2026-04-21
**Methode** : double extraction A+B isoles + reconciliation superviseur par batch
**Superviseur** : Gabriel (PO)

## Resultat final Phase 1.3

**37 PICOCs** pour le domaine `mobile-game-2d`, organises en 10 batches (A-J).
**+ 17 PICOCs hérités** du domaine `ai-collaboration` (parameter adjustment au synthesis time).
**= 54 PICOCs applicables total**.

## Structure de la SLR

Chaque PICOC respecte strictement :
- **Amendement G-1** : `C = à découvrir systématiquement en Phase 2.1` (zero pre-identification)
- **Amendement #3** : Anchor field mandatory (SWEBOK KA + ISO standards + platform policies)
- Population specific au pilot P : solo indie + 2D pixel art + portrait + offline-first + Android+iOS stores + ads+IAP+leaderboards + cross-platform
- Outcomes mesurables + user-facing

## Index des 37 PICOCs mobile-game-2d

### Batch A — Framework & Architecture (5 PICOCs)
Fichier : [`mobile-game-picoc-batch-A.md`](./mobile-game-picoc-batch-A.md)

| # | Titre | Scope |
|---|-------|-------|
| A1 | Mobile 2D game engine / framework selection (bundled language) | Engine choice central, drives language + paradigm + rendering |
| A4' | Simulation update strategy (timing + determinism) | Game loop timing model, determinism for leaderboards |
| A6 | Touch input + gesture recognition + accessibility | WCAG 2.2 target size + HIG 44pt |
| A7 | Offline-first local persistence + cloud-save sync | Storage engines + sync strategies + save integrity |
| A8 | Cross-platform asset pipeline + bundle architecture | Build-time atlas packing + compression format + store bundle splits |

### Batch B — Asset Pipeline Tooling (5 PICOCs)
Fichier : [`mobile-game-picoc-batch-B.md`](./mobile-game-picoc-batch-B.md)

| # | Titre | Scope |
|---|-------|-------|
| B7 | Tile-based level authoring workflow + interchange format | External editor vs engine-native vs hand-rolled |
| B8 | Font rendering strategy + multi-script | Bitmap / TTF / SDF / hybrid + CJK baseline |
| B9 | Audio runtime + mixer subsystem choice | Engine built-in / middleware / OSS / hand-wrapped |
| B10 | 2D animation representation + authoring toolchain (pixel-art) | Frame-by-frame / skeletal / mesh-deform / state-machine |
| B11 | Pixel-art sprite authoring tool + source-format interchange | **PO pain point** : dedicated pixel editor / PNG+sidecar / PSD-layer-conventions / in-engine |

### Batch C — Persistence Residuals (4 PICOCs)
Fichier : [`mobile-game-picoc-batch-C.md`](./mobile-game-picoc-batch-C.md)

| # | Titre | Scope |
|---|-------|-------|
| C12 | Serialization format of persisted game state | JSON / binary schema-driven / schemaless / custom packed |
| C13 | Lifecycle-triggered persistence scheduling | Event-driven / time-driven / continuous journaling / lifecycle-hook |
| C14 | Schema migration strategy across game versions | Additive / lazy on-load / eager batch / versioned parallel readers |
| C15 | Save integrity protection (encryption + tamper detection) | Plain / client-HMAC / server-signature / platform-key / attestation |

### Batch D — Store Publishing (4 PICOCs)
Fichier : [`mobile-game-picoc-batch-D.md`](./mobile-game-picoc-batch-D.md)

| # | Titre | Scope |
|---|-------|-------|
| D17 | Cross-store publishing workflow + release-track orchestration | Signing + staged rollout + crash-rate halt triggers |
| D19 | Post-install dynamic content delivery under offline-first | Play Asset Delivery / iOS On-Demand Resources / in-app updates |
| D20 | Privacy manifest + data-safety compliance architecture | Apple Privacy Manifest post-Fall-2024 + Play Data Safety + ATT/UMP |
| D21 | Platform launch-surface integration | Android 12+ SplashScreen API + adaptive/themed icons + iOS variants |

### Batch E — Monetization (5 PICOCs)
Fichier : [`mobile-game-picoc-batch-E.md`](./mobile-game-picoc-batch-E.md)

| # | Titre | Scope |
|---|-------|-------|
| E22 | Ads integration architecture + mediation stack | Single-network / waterfall / bidding / hybrid |
| E22b | Ad placement + format-mix + frequency capping UX policy | Technical ad UX (excludes consent UX = D20) |
| E23 | IAP cross-platform abstraction vs platform-native direct | Engine-native / direct StoreKit+Play-Billing / third-party / hybrid |
| E24 | Monetization model as SE architectural driver | SE quality attributes differ across model families (NOT "which earns more") |
| E25 | Server-side receipt validation + entitlement persistence + anti-fraud | Client-only / server-authoritative / hybrid signed-cache / SaaS |

### Batch F — Social / Platform Services (3 PICOCs)
Fichier : [`mobile-game-picoc-batch-F.md`](./mobile-game-picoc-batch-F.md)

| # | Titre | Scope |
|---|-------|-------|
| F26 | Social gaming services backend (leaderboards + achievements unified) | Platform-native GPGS+GC / cross-platform BaaS / self-hosted / hybrid |
| F28 | Player identity + cross-device authentication | Anonymous / platform gaming / OS identity / federated / custom (narrowed to identity) |
| F29 | Deep linking + attribution SDK architecture | Universal Links + App Links + SKAdNetwork/AdAttributionKit + SaaS (share sheet excluded) |

### Batch G — Localization (3 PICOCs)
Fichier : [`mobile-game-picoc-batch-G.md`](./mobile-game-picoc-batch-G.md)

| # | Titre | Scope |
|---|-------|-------|
| G30 | Localization workflow + release pipeline | Catalog format + TMS tooling + process + storefront sync |
| G31 | RTL / BiDi layout + locale-dependent UI mirroring | UAX #9 + Apple HIG RTL + Material Bidirectionality (narrowed from font absorbed B8) |
| G32 | Message format correctness + CLDR pluralization + locale-aware interpolation | ICU MessageFormat / Fluent / stringsdict / printf / hand-rolled |

### Batch H — Dev Tooling + Ops (5 PICOCs)
Fichier : [`mobile-game-picoc-batch-H.md`](./mobile-game-picoc-batch-H.md)

| # | Titre | Scope |
|---|-------|-------|
| H33 | CI/CD build + test + artifact promotion pipeline (pre-store) | DORA metrics, hosted vs self-hosted runners, signing automation |
| H34 | Device testing strategy + test-matrix design | Cloud farm / self-hosted lab / emulator-only / hybrid |
| H35 | Crash reporting + ANR detection + APM (reliability) | Platform-native / third-party SDK / hybrid |
| H36 | Engagement + retention + progression analytics (telemetry) | Event-schema + offline queueing + dedupe + retention cohorts |
| H37 | Remote configuration + feature flags + A/B experimentation | Firebase RC / LaunchDarkly / custom-CDN / engine-native / no-config |

### Batch I — Quality (2 PICOCs)
Fichier : [`mobile-game-picoc-batch-I.md`](./mobile-game-picoc-batch-I.md)

| # | Titre | Scope |
|---|-------|-------|
| I37 | Test design methodology for gameplay code | Unit / integration / property-based / replay-based / playtest mix |
| I39 | Game-specific accessibility accommodations (residual) | Game Accessibility Guidelines + CVAA + EAA 2025 (post-WCAG residual) |

### Batch J — AI Collaboration Inheritance (1 new + 17 inherited)
Fichier : [`mobile-game-picoc-batch-J.md`](./mobile-game-picoc-batch-J.md)

| # | Titre | Scope |
|---|-------|-------|
| J43 | Perceptual / rendered validation gate for AI-generated or AI-wired game assets | Golden-image diff + audio fingerprint + palette-lock + atlas-UV + human spot-check |

### Inherited ai-collaboration PICOCs (17, parameter-adjusted at synthesis)
Fichier source : `verification/picoc/ai-collaboration-picoc.md`

| # | Titre ai-collab | Inheritance note |
|---|-----------------|-----------------|
| #1 | Autonomy granularity per action | Inherited as-is |
| #2 | Task-type routing | Game-specific task classes at synthesis |
| #3 | Human-only decision gates | + game-specific gates (monetization tuning, balance, store listing) |
| #4 | Deterministic verification gates | **Extended by J43** (render-time sibling gate) |
| #5 | Multi-agent topology | Inherited as-is |
| #6 | Escalation protocol | J43 failures escalate per #6 |
| #7 | Context compaction | Inherited as-is |
| #8 | CLAUDE.md / AGENTS.md persistent instructions | + pixel-art + Flame/Flutter patterns at synthesis |
| #9 | Permissions & sandbox | + `assets/` write access path |
| #10 | Silent-failure monitoring | Post-ship = H35 + H36 |
| #11 | DORA/SPACE metrics | + game-specific metrics (asset iteration cycle time) |
| #12 | Model routing | Inherited as-is |
| #13 | Situational awareness human | Inherited as-is |
| #14 | Prompt/spec discipline | + game-specific style guides |
| #15 | Writer/reviewer gates | **J43 extends** (perceptual reviewer role) |
| #16 | Budget caps + cost controls | + image/audio gen API cost caps |
| #17 | Audit trail linked to commits | **J43 composes** (AI-asset provenance bound to render-validated audit trail) |

## Kappa summary per batch

| Batch | PICOCs retenues | Kappa brut | Qualite |
|-------|:---------------:|:----------:|---------|
| A | 5 | 50% | fair (principled divergences arbitrated) |
| B | 5 | 100% | almost perfect |
| C | 4 | 80% | substantial |
| D | 4 | 100% | almost perfect (D21 split nuance only) |
| E | 5 | 60% | moderate (2 principled arbitrages) |
| F | 3 | 75% | substantial |
| G | 3 | 33% | poor/fair (principled arbitrages) |
| H | 5 | 60% | moderate (2 principled arbitrages) |
| I | 2 | 75% | substantial |
| J | 1 | 100% | almost perfect |

**Overall Phase 1.3 kappa** : weighted average ~72% ("substantial"). Well above 0.6 threshold for the majority of batches ; lower kappa batches (A, E, G, H) all arbitred on principled methodological grounds (merge-vs-split granularity, absorption boundary detection) — never on arbitrary criteria.

## Cross-batch dependency graph (simplified)

```
A1 Engine
├── A2 language (absorbed)
├── A3 rendering (absorbed → A1 outcome k/l/m)
├── A4' Simulation update ← determinism consumed by I37 replay tests ; J43 DEFERS to A4' (does not consume, per J43 scope)
├── A6 Input/a11y ← WCAG foundation, referenced by E22b + I39
├── A7 Persistence ← identity consumer of F28 ; lifecycle for C13
└── A8 Asset pipeline architecture ← packaging for B7/B9/B10/B11 + delivery channel for D19

B11 Pixel-art authoring ← upstream of B7/B10/A8 ; validated by J43

C12-C15 Persistence residuals ← build on A7 storage substrate

D17 Publishing ← artifact handoff from H33 ; SDK disclosure aggregates to D20
D19 Dynamic delivery ← preserves A7 offline-first invariants
D20 Privacy ← aggregates all SDK disclosures (E22, H35, H36, F29, etc.)
D21 Launch surface ← consumes A8 raster output + B11 authoring

E22/E22b Ads ← consent from D20 ; offline-first degradation
E23 IAP ← state machine persists via A7/C12 ; feeds E25 receipts
E24 Monetization model ← upstream architectural driver
E25 Receipt validation ← server-authority split with C15 client-side save integrity

F26 Leaderboards/achievements ← defence-in-depth with C15
F28 Identity ← upstream of F26 scoring + A7 save binding + E23/E25 restore (game vs store account distinction)
F29 Deep linking ← shares attribution infra with E22

G30 Localization workflow ← strong coupling with G32 format
G31 RTL/BiDi layout ← consumes B8 glyph rendering
G32 Message format ← numbers/currency/plurals consumed by E23 IAP + F26 leaderboard rank

H33 CI/CD ← boundary at signed artifact with D17
H34 Device testing ← invoked from H33 ; excludes C-family measurement
H35 Crash reporting ← production counterpart of I37 pre-release V&V
H36 Analytics ← seam with E-family (monetization funnels) + H37 experimentation loop
H37 Feature flags ← NOT in D19 ; distinct runtime-config architecture

I37 Test methodology ← consumes A4' determinism ; excludes H34 infrastructure
I39 Game a11y ← residual after A6/B8/G31/E22b WCAG-mapped upstream

J43 AI asset render validation ← extends ai-collab #4 ; composes with #15 + #17
```

## Statut

**Phase 1.3 COMPLETE** : 37 PICOCs mobile-game-2d + 17 ai-collab inherited = **54 PICOCs applicables**.

**Next step** : Phase 1.4 Amendments (protocol deltas specific to mobile-game-2d SLR) → Phase 1.5 Peer review + Pilot on 3 representative PICOCs.

**Recommended Pilot PICOCs** (Phase 1.5) :
1. **A1 Engine** — most structurant, drives downstream decisions
2. **B11 Pixel-art authoring** — PO identified pain point, highest value
3. **A7 Offline-first persistence** — cross-cutting architectural, largest cross-batch impact

Pilot selection rationale : sample 3 PICOCs covering different batches (A×2 + B×1) with different evidence-base characteristics (well-documented engines A1, grey-literature indie tools B11, academic CRDT/sync A7) to stress-test protocol under heterogeneity.
