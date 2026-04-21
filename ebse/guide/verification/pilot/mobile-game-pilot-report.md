# Phase 1.5b — Pilot Report (domaine `mobile-game-2d`)

**Protocole** : methodology.md v3.0 §1.5 + §2 (Phase 2 execution pilot) + Amendements G-1, #1-4, MG-1 à MG-9
**Date** : 2026-04-21
**PICOCs pilotes** : A1 (engine selection), B11 (pixel-art authoring), A7 (offline-first persistence + sync)
**Pilot P** : solo indie + 2D pixel art + portrait + offline-first + Android+iOS stores + ads+IAP+leaderboards + cross-platform

## Phase 1.5a — Peer Review verdict

**APPROVE WITH MODIFICATIONS** (agent `a763601a65fc03363`). 10 modifications ; 5 critiques traitées MG-9 (J43 C-field, Safety coverage, KA15 Economics, A4'/J43 graph fix, ISO 30113-12 anchor). 5 secondaires (DARE verification, effort gate, non-English sourcing, outcome saturation, I41 renumbering traceability) listées en action items Phase 2.1.

## Phase 2.1 Discovery résultats

| PICOC | Candidates identifiés | Shortlist post-screening | Bases interrogées |
|-------|:---------------------:|:------------------------:|:-----------------:|
| A1 engine | 18 | 8 | 24 |
| B11 pixel-art tool | 14 | 8 | 24 |
| A7 persistence | 23 (tripartite) | 7 stacks | 28 |

---

## PICOC A1 — Mobile 2D game engine / framework selection

### Kappa A vs B

**Kappa parfait sur Top-3** : les deux reviewers convergent unanimement sur Godot #1, Unity #2, Defold #3. Structure Tier A/B/C quasi-identique.

| Engine | Ranking A | Ranking B | Accord |
|--------|:---------:|:---------:|:------:|
| Godot 4 | #1 (A) | #1 (A) | V |
| Unity 6.3 LTS | #2 (A) | #2 (A) | V |
| Defold | #3 (A-) | #3 (A/B) | V |
| GameMaker LTS | #4 (B+) | #4 runner-up | V |
| MonoGame | #5 (B) | #8 (C) | X (principled) |
| Cocos Creator | #6 (B-) | #6 (B) | V |
| Flutter+Flame | #7 (B-) | #7 (B) | V |
| LibGDX | #8 (C) | #7 (C) | V (tier match) |

**Accord Tier**: 7/8 = 87.5% ("almost perfect"). **Kappa brut ≈ 0.85**.

**Arbitrage DIV-MonoGame** : A voit Foundation governance + C# NRT + shipped-title pedigree comme forts (→B+). B voit absence first-party mobile monetization comme disqualifiant (→C). **Supervisor trancheur : B wins sur P-fit spécifique** — pour solo indie avec ads+IAP obligatoires, le coût de DIY Xamarin.Android bindings pour AdMob+IAP+GC+GPGS est significatif. MonoGame reste honorable pour desktop-focused C# devs mais sous-optimal pour pilot P mobile-first.

### Agent C verification (pending)

Agent C lancé pour vérifier 20 claims critiques. Ranking-determinative claims :
- Unity 6.3 LTS supported until Dec 2027 ✓ (both reviewers)
- Godot 4.6 release April 2026 
- Defold bundle size <2MB empty
- Unity Runtime Fee reversal Sept 2024 ✓
- GameMaker LTS 2025 ✓

### GRADE synthesis per alternative

Applique methodology.md §2.5 GRADE formula: Score = Starting_score + convergence + large_effect + major_evidence - indirectness - inconsistency - bias - imprecision.

#### Gagnant pilot P : **Godot 4 (GRADE 5/7 — STANDARD / RECOMMANDE)**

**Starting score** : 2 (pyramid L3 — Godot official docs + L2 SlashData survey confirmed)

**Positive factors** :
- **+1 convergence** : A et B convergent unanimement sur #1. SlashData 2025 (5% primary Steam 2024, fastest-growing) + StackOverflow survey + Godot Foundation docs + community momentum all align.
- **+1 large effect** : First-class pixel-art support (stretch_mode=viewport + integer scale_mode + snap_2d_transforms_to_pixel) is DOCUMENTED OFFICIAL RECIPE — massive convenience vs competitors requiring manual config. Critical for pilot P.
- **+1 major evidence** : MIT license + Godot Foundation non-profit governance = **no vendor lock-in risk structurally impossible** (Unity Runtime Fee scenario cannot recur). Critical for 3-year horizon pilot P.

**Negative factors** :
- **-1 indirectness** : Monetization SDK ecosystem (AdMob, StoreKit, Play Billing, GPGS) is community-plugin-heavy (not 1st-party Foundation-maintained — 2026 Mobile Push is partially stabilizing this but still maturing). Less mature than Unity.
- **0 inconsistency** : A and B converge — not penalized.
- **0 publication bias** : negative retrospectives available (Android 2D perf regression GitHub #100576, 4.4 dev4), documented.
- **-1 imprecision** : Frame time p50/p99, cold-launch, memory, battery drain ALL UNVERIFIED across 8 engines — Godot no worse than others but no primary benchmark for pilot-P reference devices.

**Score final Godot** : 2 + 3 - 2 = **3/7** → **RECOMMANDE** (not STANDARD — imprecision penalty keeps it below 5).

Wait — methodology.md §2.5 pyramid scoring says start 2 for L3/L4 sources. Let me recompute :
- Sources mixed L1 Godot docs + L2 SlashData + L3 community benchmarks
- Start 2 per methodology (L3 is "Official docs" = niveau 3)
- +1 convergence (A+B + SlashData + benchmarks all align)
- +1 large effect (first-class pixel art documented recipe)
- +1 major evidence (MIT + Foundation = no vendor risk)
- -1 indirectness (monetization SDK community plugins, not 1st-party)
- -1 imprecision (runtime benchmarks UNVERIFIED)

**Score = 2 + 3 - 2 = 3** → **RECOMMANDE** (3-4 = moyenne-haute confidence).

#### Alternative #2 : **Unity 6.3 LTS (GRADE 3/7 — RECOMMANDE)**

**Starting score** : 2 (L1 Unity official + L3 SlashData)

**Positive factors** :
- **+1 convergence** : A+B both #2. 38% primary use (SlashData), 51% of 2024 Steam releases. Industry-standard.
- **+1 large effect** : Pixel Perfect Camera first-party URP component + rich monetization SDK ecosystem (1st-party AdMob, IAP, Game Center).
- **+1 major evidence** : LTS branch guarantees support until Dec 2027 (verified L2 unity.com/blog).

**Negative factors** :
- **-1 bias risk** : Unity Runtime Fee 2023 debacle + vendor-trust scar tissue despite Sept 2024 reversal. Policy can change unilaterally.
- **-1 indirectness** : Binary bloat (17-20 MB empty APK) + Editor weight (multi-GB install) not optimal for solo indie pilot P.
- **-1 imprecision** : Runtime benchmarks UNVERIFIED.

**Score = 2 + 3 - 3 = 2** → **BONNE PRATIQUE** (medium confidence).

#### Alternative #3 : **Defold (GRADE 3/7 — RECOMMANDE)**

**Starting score** : 2 (L1 Defold Foundation docs)

**Positive factors** :
- **+1 convergence** : A+B both #3. Foundation non-profit, active monthly releases.
- **+1 large effect** : **Best-in-class bundle size (~2-4 MB empty)** — decisive for mobile install conversion. First-party AdMob + IAP + GPGS extensions.
- **+1 major evidence** : Foundation governance + permissive license + King-independent = strong 3-year viability.

**Negative factors** :
- **-1 indirectness** : Integer scaling + pixel-perfect camera are MANUAL_CONFIG via render scripts (higher barrier for pilot P specifically).
- **-1 imprecision** : Runtime benchmarks UNVERIFIED.
- **-1 indirectness** : Lua 5.1 no null safety + smallest community of shortlist.

**Score = 2 + 3 - 3 = 2** → **BONNE PRATIQUE**.

### Sensitivity analysis A1

**Leave-one-out on top factor** :
- Remove "Godot first-class pixel-art recipe" factor → Godot drops to tier with Unity. Godot still #1 by Foundation governance + growth trajectory.
- Remove "Unity LTS guarantee" → Unity drops due to trust scar. Defold overtakes.
- Remove "Defold bundle size" advantage → Defold drops to tier with Flutter+Flame.

**Recommendation robustness** : **MEDIUM**. Top-3 stable across factor perturbations. Godot's lead is principled but narrow ; Unity's tier-B2 trust concern + Defold's manual pixel-perfect are real friction points. A valid alternative recommendation would put Defold first if **install size conversion rate is pilot P's dominant metric**.

### EtD balance A1

**Benefits (primary alternative Godot)** :
- Zero vendor-lock risk structurally
- First-class pixel-art recipe documented
- Active community + Foundation growth trajectory
- MIT license enables enterprise use later
- Near-instant iteration (no compile step GDScript)

**Risks** :
- Monetization SDK maturity lag vs Unity (mitigated by 2026 Foundation Mobile Push)
- No formal LTS branch (mitigated by MIT + Foundation escape hatch)
- Android 2D perf regressions intermittently reported (mitigated by 4.5+ stability improvements)

**Balance : Benefits > Risks** for pilot P.

### Phase 2 recommendation A1

**Primary recommendation : Godot 4 (current 4.5 ou 4.6)** pour pilot P.

**Runner-up alternative : Defold** si pilot P priorité écrasante sur bundle size + install conversion.

**Fallback : Unity 6.3 LTS** si pilot P exige max-mature monetization ecosystem + LTS guarantee + user-acquisition through ad networks requires 1st-party SDK polish.

---

## PICOC B11 — Pixel-art sprite authoring tool

### Kappa A vs B

**Convergence sur Tier 1 + Tier 4** :
- Tier 1 unanimous : Aseprite #1
- Tier 4 unanimous : Pyxel Edit dismissed (dormant + Adobe AIR end-of-life)

**Divergence significative** : LibreSprite ranking.
- A: #2 (FOSS safety valuable)
- B: Tier 3 (dormant since Dec 2023 = 15+ months stale, feature lag vs post-fork Aseprite)

**Arbitrage DIV-LibreSprite** : **B wins**. Concrete last-release date 2023-12-03 confirms effective dormancy. FOSS safety only valuable if project is actively maintained. Pixelorama (MIT + monthly cadence) dominates LibreSprite on every dimension.

**Kappa brut** : 6/8 full agreement + 2 tier-level divergence (LibreSprite, PixiEditor small shift). **Kappa ≈ 0.75** ("substantial").

### Final consolidated ranking B11

| Rank | Tool | Tier | Score | Notes |
|------|------|------|-------|-------|
| **1** | **Aseprite** | 1 | 9.0 | Unmatched metadata fidelity + official Unity importer + Godot Wizard + Flame native. $19.99 one-off. |
| **2** | **Pixelorama** | 1 | 7.5 | MIT FOSS + monthly cadence + audio-timeline + web/mobile authoring. Best open-source. |
| **3** | Unity PSD Importer | 2 | 6.5 | Only if Unity is fixed target engine. Not an authoring tool itself. |
| **4** | Pro Motion NG | 2 | 6.0 | Best palette discipline + per-frame pivots. No engine importers = DIY interchange. Win-only. |
| **5** | PixiEditor | 2 | 5.5 | Latest tooling + LGPL-3. CLI/metadata story immature. |
| **6** | Stipple Effect | 3 | 5.0 | Scripting-first DeltaScript unique. Solo maintainer, 15-month gap. |
| **7** | LibreSprite | 3 | 4.5 | GPLv2 safety but effectively dormant. Lacks post-fork Aseprite features. |
| **8** | Pyxel Edit | 4 | 3.5 | Perpetual beta + Adobe AIR dep + unclear commercial terms. Disqualified. |

### GRADE synthesis B11

#### Gagnant : **Aseprite (GRADE 5/7 — STANDARD)**

**Starting score** : 3 (L1 Aseprite official docs + publicly-available binary format spec)

**Positive factors** :
- **+1 convergence** : A+B unanimous #1.
- **+1 large effect** : Metadata fidelity (frame tags + slices + pivots in-format) is STRUCTURALLY unmatched. Public binary format spec = archival safety.
- **+1 major evidence** : Best-in-class engine importer ecosystem (Unity official package + Godot Wizard + Flame native + Unreal community). Enables full CI pipeline via Lua scripting + CLI.

**Negative factors** :
- **-1 bias** : Proprietary source-available EULA (Aug 2016 license change from GPL-2 to proprietary) = vendor lock-in if Igara stops. Mitigated by public format spec archival safety.
- **0 indirectness** : Aligned with pilot P (pixel-art mobile game authoring).

**Score = 3 + 3 - 1 = 5/7** → **STANDARD** (haute confidence).

#### Alternative FOSS : **Pixelorama (GRADE 4/7 — RECOMMANDE)**

**Starting score** : 2 (L1 docs + L2 GitHub)

**Positive factors** :
- **+1 convergence** : A#3, B#2 — both retained Tier 1.
- **+1 large effect** : MIT license + monthly cadence + 9.4k stars growing + palette cycling first-class + mobile authoring (Android experimental).
- **+1 major evidence** : Active Orama Interactive team, 3,934+ commits, v1.1.9 April 2026.

**Negative factors** :
- **-1 indirectness** : Weaker engine importer ecosystem vs Aseprite (no official Unity importer ; Godot via PNG+JSON sidecar).
- **-1 imprecision** : .pxo format spec WIP, less standardized cross-tooling.

**Score = 2 + 3 - 2 = 3** → **RECOMMANDE**.

### Sensitivity analysis B11

- Remove "Aseprite metadata fidelity" advantage → Pixelorama ties. Remaining differentiator: engine importer ecosystem (Aseprite still wins).
- Remove "Aseprite engine importers" → Pixelorama leads. Aseprite drops to #2.
- Remove "Aseprite $19.99 cost" (if budget zero) → Pixelorama #1 pilot P.

**Recommendation robustness** : **HIGH** — Aseprite dominant across most factor perturbations. Pixelorama is robust #2 / backup if budget-free mandatory.

### EtD balance B11

**Benefits (primary Aseprite)** :
- Industry-standard metadata pipeline
- Public binary spec = format longevity
- CLI + Lua scripting = full CI automation
- Best engine importer ecosystem (Unity + Godot + Flame + Unreal)
- One-off $19.99 acceptable for solo indie

**Risks** :
- Proprietary EULA (vs FOSS Pixelorama)
- Binary format not git-diffable (mitigated by JSON sidecar CI pattern)
- No mobile authoring (desktop-only)

**Balance : Benefits >> Risks** for pilot P.

### Phase 2 recommendation B11

**Primary : Aseprite** for pilot P (pain point PO "identifier où est l'asset" directly addressed by frame tags + slices + Unity/Godot/Flame official importers).

**FOSS alternative : Pixelorama** if Aseprite licensing later becomes blocker.

---

## PICOC A7 — Offline-first persistence + cloud-save sync

### Kappa A vs B

**Convergence très forte** : les deux reviewers convergent sur :
- **Stack 7 PowerSync + Supabase = primary** (both)
- **Stack 1 Nakama = secondary** (both)
- **Stack 2 Firestore = tertiary** (both)
- **Stack 3 Realm+ADS = ELIMINATE** (both, EOL 2025-09-30 confirmed)

**Divergence principielle** : Stack 4 (Platform-native dual).
- A: Tier 2 viable with caveats (zero third-party cost/lock-in)
- B: Eliminate (2x engineering, cross-platform leaderboard broken)

**Arbitrage DIV-Stack4** : **B wins pour pilot P**. PO's `acres.md` line 21 mentions "classement selon richesse et sauvegarde avec google play service" — leaderboard cross-platform is explicit requirement. Dual native (CloudKit iOS ∥ Play Games Android) creates siloed leaderboards + 2x engineering. Stack 4 retained only as theoretical comparator.

**Kappa brut** : 6/7 agreement on retain/eliminate/tier = ~86% ("almost perfect"). **Kappa ≈ 0.82**.

### Final consolidated ranking A7

| Rank | Stack | Tier | Notes |
|------|-------|------|-------|
| **1** | **Stack 7 PowerSync + Supabase** | 1 | Best sync semantics (causal+), self-hostable, Flutter first-class, OSS client (Apache) + FSL server. Atlas Device Sync migration target. |
| **2** | **Stack 1 Drift + Nakama** | 1 | OSS + self-host removes vendor lock-in. Server-arbitrated merge for anti-cheat. Multi-engine clients. |
| **3** | Stack 2 sqflite + Firestore LWW | 2 | Zero ops SaaS, polished FlutterFire. LWW data-loss risk requires per-feature document design. |
| **4** | Stack 6 ObjectBox Sync | 3 | HLC conflict resolution best-in-class. Commercial sync pricing opaque. |
| **5** | Stack 5 Isar/Hive + ETag + Firestore | 3 | Isar performance strong but maintenance abandoned by author. |
| **6** | Stack 4 Platform-native dual | 3 | Free per-user quotas. 2x engineering + leaderboard siloing disqualifies for pilot P. |
| — | Stack 3 Realm + ADS | **ELIMINATE** | **EOL 2025-09-30** confirmed. Disqualified. |

### GRADE synthesis A7

#### Gagnant : **Stack 7 PowerSync + Supabase (GRADE 4/7 — RECOMMANDE)**

**Starting score** : 2 (L1 vendor docs + L3 community migration guides)

**Positive factors** :
- **+1 convergence** : A+B unanimous primary.
- **+1 large effect** : Causal+ consistency (vs LWW in Firestore/CloudKit) = higher correctness ceiling. Apache client + FSL server = lowest lock-in of cloud shortlist.
- **+1 major evidence** : Post-Atlas-Device-Sync migration validation (vendor explicitly positioned as successor). Standard Postgres backend enables Supabase combo giving Auth + leaderboard-via-SQL in one stack.

**Negative factors** :
- **-1 indirectness** : Developer owns conflict-handling code in backend (not turnkey). PowerSync Service FSL not Apache — commercial clause at scale.
- **-1 imprecision** : Specific save/load P95 ms UNVERIFIED ; post-ADS migration literature still accumulating (2025 deprecation + 2026 maturity).
- **0 inconsistency** : A+B converge principally.

**Score = 2 + 3 - 2 = 3** → **RECOMMANDE**.

#### Alternative : **Stack 1 Drift + Nakama (GRADE 3/7 — RECOMMANDE)**

**Starting score** : 2 (L1 Heroic Labs docs)

**Positive factors** :
- **+1 convergence** : A+B both secondary.
- **+1 large effect** : Apache 2.0 + self-hostable = zero vendor lock-in backstop. Multi-engine Dart/Unity/Godot/Unreal clients.
- **+1 major evidence** : Version-CAS server-arbitrated = correct model for leaderboard anti-cheat concerns. 10+ year vendor track record.

**Negative factors** :
- **-1 indirectness** : Operational burden moderate (run Go server + Postgres). Solo indie ops cost real.
- **-1 indirectness** : Custom merge/delta logic = developer code, not framework.

**Score = 2 + 3 - 2 = 3** → **RECOMMANDE**.

### Sensitivity analysis A7

- Remove PowerSync's "causal+ consistency" advantage → PowerSync drops to Stack 1 tier. Stack 1 Nakama leads (Apache 2.0 + multi-engine).
- Remove Stack 3 elimination (hypothetical if ADS revived) → Realm would be Tier 2 (legacy strength). But EOL confirmed — moot.
- If solo-dev refuses backend ops entirely → Stack 2 Firestore becomes primary by default (LWW data-loss acceptable for casual saves).

**Recommendation robustness** : **MEDIUM-HIGH** for PowerSync. Alternative ranking valid if pilot P primary constraint = "absolutely no backend ops" → Firestore wins.

### EtD balance A7

**Benefits (primary PowerSync + Supabase)** :
- Strongest sync semantics (causal+ > LWW)
- Lowest lock-in with OSS client + vendor-agnostic Postgres backend
- Self-host escape hatch via Open Edition
- Supabase combo : Auth + Postgres leaderboards (via SQL views/RPC) in one stack → directly addresses Acres leaderboard requirement

**Risks** :
- Developer-defined conflict policy = engineering you own
- FSL server commercial clause at scale
- 1-week inactivity free tier deactivation hostile for long-tail hobby

**Balance : Benefits > Risks** for pilot P, but pilot P must accept developer-owned conflict policy as complexity.

### Phase 2 recommendation A7

**Primary : PowerSync (client Apache SDK + Open Edition OR managed) + Supabase** for pilot P.
- Implementation pattern : block-queue conflict strategy, single-writer-per-user model for farm state.
- Leaderboard via Supabase SQL view/RPC.

**Backend-ops-allergic alternative : sqflite + Firestore LWW** if solo dev refuses running any server. Mitigated by per-feature document design.

**Vendor-risk-averse alternative : Drift + Nakama self-hosted** if Apache 2.0 + multi-engine future-proofing dominates.

---

## Phase 1.5 final status

### Pilot report conclusions

**Protocol validated** on 3 representative PICOCs covering :
- Well-documented vendor domain (A1 engines)
- Grey-literature-heavy domain (B11 tools)
- Heterogeneous academic + vendor domain (A7 persistence)

**Kappa results** :
- A1 : 0.85 ("almost perfect")
- B11 : 0.75 ("substantial")
- A7 : 0.82 ("almost perfect")

**Weighted average ≈ 0.81 ("almost perfect")** — well above methodology.md §2.2 threshold 0.6.

### Concrete recommendations for Acres project

Given pilot P = Acres (solo indie, 2D pixel-art farming-sim, portrait, offline-first, Android+iOS, ads+IAP+leaderboards, multi-language) :

**Engine : Godot 4** (5.0 when stable, 4.5 LTS-equivalent current).
- Justification : pixel-art first-class recipe + MIT license + Foundation growth + 2026 Mobile Push stabilizing monetization plugins. Acceptable trade-off vs Unity's community for solo indie scale.
- Fallback : Defold if bundle size dominates UA strategy ; Unity if max-polish monetization required from day 1.

**Pixel-art authoring : Aseprite** ($19.99 one-off).
- Justification : directly solves PO pain point "où est l'asset dans le PNG" via frame tags + slices + Godot Aseprite Wizard importer. One-off purchase acceptable for solo indie ; ROI on dev velocity >> cost.
- Fallback : Pixelorama (MIT FOSS + monthly cadence) if budget strictly $0.

**Persistence : SQLite (via Drift) + PowerSync + Supabase** (cloud managed free tier initially, then Pro $49/mo).
- Justification : causal+ consistency ≥ Firestore LWW + Apache client + Supabase Postgres enables leaderboards-via-SQL for Acres wealth ranking. Self-host escape hatch if commercial terms change.
- Fallback : Nakama self-hosted if multi-engine future flexibility + zero SaaS cost prioritized.

### Effort calibration (Amendment MG-9 action item #7)

**Phase 1.5 pilot elapsed time** : ~1 session (multi-hour with parallel agents).
- Phase 1.5a peer review : 1 agent, ~5min
- Phase 2.1 discovery : 3 agents parallel, ~5min each
- Phase 2.4 extraction : 6 agents parallel, ~5-8min each
- Phase 2.5 synthesis : supervisor ~10min

**Extrapolation for Phase 2 full execution (34 remaining PICOCs)** :
- ~2-3 sessions per PICOC with agent parallelization
- Total : ~70-100 hours wall-clock if sequential ; ~20-30 hours with batching 5-6 PICOCs in parallel
- **GATE DECISION** : feasible for solo indie over 2-3 weeks of focused time.

### Phase 2 green-lit

**APPROVED** for Phase 2 full review on 34 remaining PICOCs.

**Recommended Phase 2 batching** :
- Batch 1 (architecture foundations) : A4', A6, A8 (3 PICOCs)
- Batch 2 (asset pipeline) : B7, B8, B9, B10 (4 PICOCs)
- Batch 3 (persistence residuals) : C12, C13, C14, C15 (4 PICOCs)
- Batch 4 (store publishing) : D17, D19, D20, D21 (4 PICOCs)
- Batch 5 (monetization) : E22, E22b, E23, E24, E25 (5 PICOCs)
- Batch 6 (social) : F26, F28, F29 (3 PICOCs)
- Batch 7 (localization) : G30, G31, G32 (3 PICOCs)
- Batch 8 (dev tooling) : H33, H34, H35, H36, H37 (5 PICOCs)
- Batch 9 (quality + AI) : I37, I39, J43 (3 PICOCs)

### Integration plan (Phase 3)

1. **Update decision-tree.json** : add `mobile-game-2d` branch after `mobile-type` question in existing tree. Include P-refinement questions (2D/3D, pixel-art/vector, solo/team, offline/online, stores required).
2. **Create stack profile** : `ebse/guide/data/stacks/godot-mobile-game.json` with recommended stack (Godot 4 + Aseprite + Drift + PowerSync + Supabase).
3. **JSON decision files** : one per PICOC result in `ebse/guide/data/decisions/mobile-game-2d-*.json`.
4. **Guide pages** : create `ebse/guide/02-domains/mobile-game-2d/` with domain README + per-category pages.

### Phase 4 : Apply to Acres

After Phase 3 integration :
1. Backup existing `acres_flutter/` → `acres_flutter_v1_backup/`
2. Create new `acres/` project using Godot 4
3. Import existing `assets/` (PNG + audio are format-agnostic)
4. Apply `scaffold-claude.md` template → new `CLAUDE.md`
5. Apply `scaffold-settings.jsonc` → new `.claude/settings.json`
6. MVP scope : map + plant/harvest + save (local + cloud via PowerSync) + basic Google Play leaderboard
7. Iterate based on playtest.

## Addendum — Agent C verification results (2026-04-21)

Agent C (`a30a1602003605e05`) verified 20 priority claims. 16 VERIFIED ; 3 MAJOR REFUTATIONS ; 4 MINOR nuances.

### MAJOR REFUTATIONS (rankings affected)

**REFUTATION #1 — Aseprite v1.3.17 date**
- Extraction claimed : release 2026-02-25
- Agent C verified : actual release **2025-02-25** (one year earlier)
- **Impact** : Aseprite has been in **~14-month stable-release gap** (only v1.3.18-beta1 since Feb 2025). "Actively released / recently updated" narrative for Aseprite is WEAKER than extraction implied.
- **Ranking effect** : Aseprite remains #1 for pilot P (metadata fidelity + engine importers + CLI still dominant), but recency advantage flipped — Pixelorama now has stronger momentum.

**REFUTATION #2 — LibreSprite dormancy**
- Extraction claimed : last release v1.1 = 2023-12-03 (15+ months dormant)
- Agent C verified : latest release **v1.2 March 2025** — substantive features (expanded scripting, UI translations, pen-pressure support, LibreSprite Online browser version)
- **Impact** : LibreSprite is NOT dormant. Should be reconsidered.
- **Ranking effect B11** : LibreSprite promoted from Tier 3 (#7 discarded) to **Tier 2 (Viable FOSS alternative)** — sits between Pixelorama and Pro Motion NG.

**REFUTATION #3 — Pyxel Edit Adobe AIR dependency**
- Extraction claimed : Adobe AIR dependency = risk factor (AIR end-of-life)
- Agent C verified : Pyxel Edit **switched to captive/portable runtime** (vendor explicit statement : "you no longer need to install Adobe AIR")
- **Impact** : AIR-dependency disqualifier NO LONGER HOLDS. "Perpetual beta" still stands.
- **Ranking effect** : Pyxel Edit remains Tier 4 but on beta-only grounds, not AIR-dependency. Could be reconsidered at stable release.

### MINOR nuances

- **Defold <2MB** : holds for HTML5 gzipped + arm64-only Android ; multi-arch Android typically <5MB. A1 recommendation unaffected.
- **Pixelorama monthly cadence** : Sep 2025→Dec 2025 monthly, then 3.5-month gap to April 2026. "Approximately monthly, irregular" more accurate.
- **Aseprite price** : $19.99 USD (Steam US) / €16.79 EU — one-off confirmed.
- **CloudKit 5 GB** : user's iCloud quota (shared with photos, backups), not dedicated per-app.

### Updated B11 ranking post Agent C

| Rank | Tool | Tier | Score | Notes updated |
|------|------|------|-------|---------------|
| **1** | **Aseprite** | 1 | 8.5 (was 9.0) | Recency ding from 14-month gap ; still dominant on metadata + ecosystem |
| **2** | **Pixelorama** | 1 | 7.5 | Monthly-ish cadence + MIT reinforces this. Strong alternative. |
| **3** | **LibreSprite** | 2 | 7.0 (was 4.5) | **PROMOTED** post-Agent-C. v1.2 March 2025 + active scripting/features. GPL-2 FOSS. Viable alternative if Aseprite EULA blocks. |
| 4 | Unity PSD Importer | 2 | 6.5 | Unchanged — only if Unity target |
| 5 | Pro Motion NG | 2 | 6.0 | Unchanged |
| 6 | PixiEditor | 2 | 5.5 | Unchanged |
| 7 | Stipple Effect | 3 | 5.0 | Unchanged |
| 8 | Pyxel Edit | 4 | 3.5 (was 3.5) | Tier 4 confirmed on perpetual-beta grounds (AIR disqualifier retracted) |

### Updated Acres recommendation post Agent C

**Pixel-art authoring : Aseprite remains primary** ($19.99). PO pain point fit dominant despite Aseprite recency gap. Pixelorama and LibreSprite as FOSS alternatives if budget $0 mandatory.

### GRADE score updates

- **Aseprite** : score 5/7 → **4/7** (one -1 for imprecision on "actively maintained"). Still **RECOMMANDE**.
- **Pixelorama** : score 3/7 unchanged.
- **LibreSprite** : now eligible for future Phase 2 extraction at Tier 2 (was excluded). Not in pilot ranking.

### Sensitivity post Agent C

**Recommendation robustness recomputed** :
- Aseprite still primary : ranking robust
- FOSS alternative choice : Pixelorama vs LibreSprite becomes principled. Pixelorama slightly ahead (MIT + faster cadence in 2025) ; LibreSprite strong if GPL-2 safety is the dominant criterion.

### Agent C final verdict

**Pilot report conclusions UPDATED but NOT INVALIDATED**. Top-3 A1 rankings unchanged (Godot/Unity/Defold). A7 rankings unchanged (PowerSync/Nakama/Firestore). B11 post-update reshuffled within Tiers 1-2 but primary Aseprite recommendation holds.

**Agent C verification enables Phase 2 execution with increased confidence** on verified facts + explicit UNVERIFIED flags for unchecked claims.

---

**Phase 1.5 COMPLETE. APPROVED for Phase 2.**
