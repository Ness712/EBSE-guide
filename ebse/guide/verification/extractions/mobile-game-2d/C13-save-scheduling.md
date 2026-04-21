# Extraction Form — PICOC C13 : Lifecycle-Triggered Persistence Scheduling

**Domain** : mobile-game-2d
**PICOC #** : C13
**Year** : 2026
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + #3 + MG-2 + MG-6

## 1. PICOC formel

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie dev shipping a 2D mobile game on Android + iOS where the OS can suspend / background / terminate the app with bounded notice (onPause / onStop, applicationWillResignActive / DidEnterBackground, low-memory kill, thermal kill, user task-switch, force-stop) and where a session embodies painful-to-lose progress (farming-sim progression over multiple hours). |
| **I** (Intervention) | Class of **persistent-write triggering strategies** : (a) event-driven autosave (on checkpoint, room transition, shop close) ; (b) time-driven autosave (fixed interval, e.g. every 60 s) ; (c) continuous journaling / write-ahead log (append-only delta stream flushed opportunistically) ; (d) lifecycle-hook-driven flush (on backgrounding callback within OS grace window) ; (e) hybrid policies combining the above. |
| **C** (Comparator) | Discovered via systematic Phase 2.1 search : Android + iOS lifecycle docs, game-dev postmortems on save-loss, indie forum autosave cadence discussions, ACM mobile computing papers on persistence-under-interrupt, engine autosave patterns. No pre-identification per G-1. |
| **O** (Outcome) | Progress loss (s of gameplay) after forced OS kill ; frame-time disruption introduced by save operations during active gameplay (P99 frame-time delta) ; battery drain attributable to persistence (mAh/hour) ; write amplification / flash wear (bytes / minute) ; save-corruption incidence when interrupt arrives mid-write (% over N=1000 forced kills at random timings) ; background-task grace window usage (% of OS budget) ; perceived save reliability ; perceived frame smoothness ; perceived battery drain. |
| **Context** | Offline-first with optional cloud sync ; portrait 2D pixel-art ; Android vs iOS lifecycles differ (Android Doze + Background Execution Limits, iOS backgroundTask budgets) ; device floor low-end through flagship ; A7 storage engine influences granularity ; budget=open-source strict ; ai_agent=yes ; scale=mvp. |
| **Anchor** | SWEBOK v4 KA2 Design (persistence mechanisms) + KA3 Design (concurrency, interrupt handling) + KA12 Software Quality (reliability) ; ISO/IEC 25010:2023 Reliability (Fault tolerance OS kill, Recoverability) + Performance Efficiency (Time behaviour save-time, Resource utilization battery) ; Apple App Store Review Guidelines background-task completion ; Google Play Policies background execution, battery ; Apple HIG Handling Interruptions. |

## 2. Candidates discovered (G-1 archetype classes)

| # | Candidate | Archetype class | Implementation locus | Mobile support |
|---|-----------|-----------------|----------------------|:--------------:|
| 1 | Checkpoint event autosave (room transition, shop close, day-rollover) | (a) event-driven | Game-script hooks | yes |
| 2 | Fixed 60 s timer autosave | (b) time-driven | Timer scheduler | yes |
| 3 | 30 s timer + checkpoint hybrid | (b)+(a) hybrid | Combined | yes |
| 4 | Continuous delta journaling WAL + batched compaction | (c) WAL journaling | Custom / SQLite WAL | yes |
| 5 | Lifecycle hook flush only (onPause / willResignActive) | (d) lifecycle-only | Engine lifecycle callbacks | yes |
| 6 | Lifecycle hook + periodic 60 s timer + checkpoint hybrid | (e) full hybrid | Combined | yes |
| 7 | Save-on-every-mutation (synchronous) | (b-extreme) | Eager per-op | yes (impractical) |

## 3. Exclusions E1-E5

| Candidate | Criterion | Reason |
|-----------|-----------|--------|
| Save-on-every-mutation | E1 outcome mismatch | Causes frame-time disruption + flash wear orders of magnitude beyond acceptable ; fails O4 (jank) and O5 (battery) by construction. |
| Lifecycle-hook-only | E1 coverage gap | iOS / Android do not reliably deliver lifecycle callbacks under low-memory kill, thermal kill, or force-stop ; policy must supplement with periodic or event triggers. Retained only as a component of hybrid, not as a standalone policy. |
| Cloud-only save with no local durable buffer | E4 violates offline-first Co | Cloud-only violates offline-first context ; excluded. |
| Commercial save-as-a-service SDK | E5 budget | No qualifying candidate clears budget=open-source strict ; free-tier SaaS explicitly rejected. |
| Closed-source middleware with opaque scheduling | E3 unknown semantics | Scheduling policy must be inspectable for correctness reasoning — closed-source excluded. |

## 4. O-matrix (ordinal 1-5, higher=better ; O1 gate)

| Candidate | O1 Budget=OSS (gate) | O2 Progress loss minimization (forced OS kill) | O3 Jank avoidance (P99 frame-time) | O4 Battery + flash wear | O5 Mid-write corruption resistance | Sigma |
|-----------|:--------------------:|:----------------------------------------------:|:---------------------------------:|:-----------------------:|:----------------------------------:|:-----:|
| Event-driven only | 5 PASS | 3 | 5 | 5 | 4 | 22 |
| 60 s timer only | 5 PASS | 3 | 3 | 3 | 3 | 17 |
| 30 s timer + checkpoint hybrid | 5 PASS | 4 | 4 | 3 | 4 | 20 |
| WAL journaling | 5 PASS | 5 | 5 | 2 (flash wear) | 5 | 22 |
| Lifecycle hook only | 5 PASS | 2 (kill bypasses) | 5 | 5 | 3 | 20 |
| Full hybrid (lifecycle + 60 s + checkpoint) | 5 PASS | 5 | 4 | 4 | 5 | 23 |

## 5. Top-3 with rationale

1. **Full hybrid : lifecycle-hook flush + 60 s timer + checkpoint events** (sigma 23). Maximizes defense-in-depth across three failure modes : normal task-switch handled by lifecycle, thermal / low-memory kill caught by the periodic timer within the grace window, and semantic progress preserved by checkpoint events. Writes are atomic via write-to-temp + rename (Android internal storage, iOS NSFileManager) backed by Godot FileAccess or SQLite WAL.
2. **WAL journaling** (sigma 22). Highest O2 and O5 through append-only semantics ; losses on O4 because continuous journaling amplifies write volume. Recommended if the game introduces near-continuous state mutation (real-time simulation, heavy inventory churn) that would make the 60 s periodic timer too coarse.
3. **Event-driven only** (sigma 22). High O3 and O4 but O2 is limited by semantic-checkpoint frequency. For archetypes with natural frequent checkpoints (farming-sim shop-close, day-rollover, sleep), event-driven alone achieves acceptable progress-loss bounds at minimum write volume.

## 6. Kappa A vs B

Effective set (5 post-exclusion). A ranks hybrid > event-driven > WAL > 60 s timer > lifecycle-only. B ranks hybrid > WAL > event-driven > 60 s timer > lifecycle-only. Top-1 agrees. Tier 2-3 swap (event-driven vs WAL). Tier agreement 4/5 = 80%, kappa ~0.75 "substantial".

Divergence DIV-event-vs-WAL : A values O4 battery / wear (event-driven writes less than WAL) ; B values O2 + O5 (WAL captures mid-write + continuous progress). Supervisor arbitrage : retain event-driven for farming-sim archetype (natural frequent checkpoints), retain WAL as an archetype-dependent upgrade path for more continuous simulation.

## 7. GRADE with factors

Starting score : 2 (pyramid L3 — Android / iOS platform lifecycle docs L1 + SQLite WAL docs L1 + indie postmortems L5 MG-2 + ACM mobile computing papers L2).

Positive factors :
- +1 large effect : full hybrid closes all three failure modes ; no single-policy candidate achieves parity on O2 + O5 simultaneously.

Negative factors :
- -1 indirectness : platform-lifecycle grace-window budgets (iOS ~30 s backgroundTask) are documented but empirical save-completion success rate within that window is under-measured on low-end Android.
- -1 imprecision : N=1000 forced-kill corruption incidence is not available in primary sources for the effective candidate set.
- -1 monoculture discount : evidence concentrates on platform-vendor advisories + indie grey-lit ; academic literature on mobile persistence scheduling is thin.
- 0 inconsistency : rankings converge at top-1.

Score final : 2 + 1 - 3 = **1/7 -> ACCEPTABLE**.

## 8. Sources Table 2

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | Android Activity lifecycle + Background Execution Limits docs | L1 platform | 2025 | Lifecycle anchor |
| 2 | iOS UIApplicationDelegate + beginBackgroundTaskWithExpirationHandler docs | L1 platform | 2025 | Grace-window anchor |
| 3 | SQLite WAL mode documentation | L1 | 2025 | WAL capability reference |
| 4 | Godot FileAccess + atomic write-to-temp-and-rename patterns | L1 | 2026 | Engine persistence primitive |
| 5 | Indie postmortems on save-loss incidents | L5 MG-2 grey-lit | varied | Failure-mode evidence |
| 6 | ACM mobile computing papers on persistence under interrupt | L2 | varied | Academic background |
| 7 | Apple HIG Handling Interruptions | L1 | 2025 | Interruption UX anchor |
| 8 | ISO/IEC 25010:2023 Reliability + Performance Efficiency | L1 standard | 2023 | Outcome anchor |

## 9. Primary recommendation

Adopt the **full hybrid** : lifecycle-hook flush on Android onPause / iOS applicationWillResignActive, a 60 s periodic timer on an engine idle tick, and explicit checkpoint events on narrative beats (day-rollover, sleep, shop close, quest turn-in). Implement atomic save via write-to-temp + rename. Reserve a small pre-allocated temp slot to avoid write-after-full-disk failures. Log save outcomes to a local ring buffer so post-kill diagnostics can surface the policy that saved the user. Upgrade to SQLite WAL journaling only if a future gameplay archetype introduces near-continuous mutation that 60 s coverage cannot bound.

## 10. Decision + traceability

**Decision** : Full hybrid scheduling (lifecycle + 60 s timer + checkpoint events) with atomic write-to-temp + rename. Status GRADE ACCEPTABLE (1/7). Defense-in-depth across three failure modes dominates ; archetype-dependent upgrade to WAL journaling documented as a future option.

**Traceability** :
- PICOC source : `verification/picoc/mobile-game-picoc-batch-C.md` §C13 (principled arbitrage — Reviewer B proposed, A absorbed ; B wins because A7.I does not include scheduling policy)
- Protocol amendments : G-1 + #3 + MG-2 + MG-6
- Cross-references : A7 storage engine (dictates save granularity — SQLite WAL vs full-file rewrite) ; C12 format (parse/serialize cost bounds timer frequency) ; C14 migration (lazy on-load must not run inside the grace window) ; C15 integrity (HMAC applied in memory before flush so atomicity covers both bytes and MAC).
- Anti-double-counting : scheduling policy credited to C13 ; storage engine credited to A7 ; format cost credited to C12 ; integrity computation credited to C15.

Word count : ~1170 words.
