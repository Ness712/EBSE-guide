# Extraction Form — PICOC C14 : Save Schema Migration Strategy Across Game Versions

**Domain** : mobile-game-2d
**PICOC #** : C14
**Year** : 2026
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + #3 + MG-2 + MG-6

## 1. PICOC formel

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie dev shipping iterative content updates through Google Play + Apple App Store to an installed user base whose local save files were produced by prior binaries, including users who skip versions (v1.0 → v1.5 jump after long dormancy, after 4+ intermediate releases unseen). Long-tail users on outdated OS and app versions (iOS users may skip updates for months ; Android auto-update but fragmented OS floor). |
| **I** (Intervention) | Save-schema migration strategy class. Sub-classes (G-1 archetypes) : (a) additive-only schema evolution (new optional fields, tolerated unknowns) ; (b) lazy on-load migration chain (versioned reader applied when old save opens, v1→v2→v3→v4) ; (c) eager batch migration (one-shot rewrite on first launch of new binary) ; (d) versioned parallel readers retained in shipped binary ; (e) event-sourcing / replayable command log ; (f) no-migration / reset-and-reward policy. Axes : temporal distribution (A7 cross-device sync is spatial ; C14 is temporal v1-vN) ; migration locus (on-load vs eager) ; legacy-reader retention policy. |
| **C** (Comparator) | Discovered via Phase 2.1 systematic search (G-1) — no pre-identification. |
| **O** (Outcome) | Progress-preservation rate across version jumps (% saves loading successfully post-update) ; first-launch latency post-update (migration cost, ms) ; migration-related crash rate (crashes / 1000 sessions) ; support-ticket volume attributable to migration ; storage overhead of legacy readers ; dev effort per schema change (hours) ; IAP entitlement + purchased-content integrity across migrations (%) ; absence of "lost progress after update" reviews ; release-cadence achievability. |
| **Context** | Solo indie no dedicated QA ; content-update cadence (monthly) ; multi-year title lifecycle ; heterogeneous user devices + OS versions ; budget=open-source strict ; ai_agent=yes ; scale=mvp ; leaderboard continuity (migration must not invalidate earned scores) ; IAP entitlement preservation critical (store policy + revenue). |
| **Anchor** | SWEBOK v4 KA7 Software Maintenance (software evolution, impact analysis, data migration) + KA8 Configuration Management (version control of data schemas) + KA9 SE Management (release process) ; ISO/IEC 25010:2023 Maintainability (Modifiability — schema evolvability) + Reliability (Recoverability under migration failure) + Compatibility ; ISO/IEC 29110-4-3 VSE change management practices. |

## 2. Candidates discovered (G-1 archetype classes)

| # | Candidate | Class | Dependency on C12 | Evidence |
|---|-----------|-------|:-----------------:|----------|
| 1 | Additive-only JSON + `save_version` field + stepwise manual readers | (a) + (b) hybrid | JSON | Fowler L2 + indie postmortems L5 |
| 2 | Lazy on-load migration chain (v1→v2→v3…) | (b) | any format | Fowler Evolutionary Database Design L2 |
| 3 | Eager batch migration on first launch post-update | (c) | any format | DBA migration practice L3 |
| 4 | Versioned parallel readers retained in binary | (d) | schema-driven | Protobuf / FlatBuffers pattern L1 |
| 5 | Event-sourcing + replayable command log | (e) | schemaless log + snapshot | Kleppmann DDIA Ch.11 L2 |
| 6 | No-migration / reset-and-reward | (f) | any | Common indie pattern for major rewrites |
| 7 | Schema-driven evolution (protobuf field tags, optional semantics) | (a) + schema-driven | protobuf | protobuf docs L1 |

## 3. Exclusions E1-E5

| Candidate | Criterion | Reason |
|-----------|-----------|--------|
| Eager batch migration | E1 outcome mismatch | Long first-launch latency + crash-during-migration risks entire install base at once ; unacceptable without rollback budget at MVP. |
| Versioned parallel readers (d) alone | E2 scope | Viable at scale, overkill at MVP ; binary bloat + dev-effort multiplier without matching payoff. |
| Event-sourcing / command log | E2 scope | Requires architectural commitment across A7+C12+C13 ; not justified at MVP for a farming-sim save. |
| No-migration / reset-and-reward | E1 outcome fail | Violates progress-preservation outcome O1 ; ships a known regression. |
| Managed migration SaaS | E5 budget | Strict-OSS forbids SaaS even free tier. |

## 4. O-matrix (ordinal 1-5, higher=better ; O1 gate)

| Candidate | O1 Budget=OSS (gate) | O2 Progress preservation | O3 First-launch latency | O4 Crash-risk post-update | O5 Dev effort per schema change | O6 IAP entitlement integrity | O7 Skip-version robustness | Sigma |
|-----------|:--------------------:|:------------------------:|:-----------------------:|:-------------------------:|:-------------------------------:|:----------------------------:|:--------------------------:|:-----:|
| Additive-only + `save_version` + stepwise readers | 5 PASS | 5 | 5 | 4 | 4 | 5 | 5 | 33 |
| Lazy on-load chain (no additive guarantee) | 5 PASS | 4 | 4 | 3 | 3 | 4 | 5 | 28 |
| Eager batch migration | 5 PASS | 4 | 2 | 2 | 3 | 4 | 4 | 24 |
| Versioned parallel readers | 5 PASS | 5 | 5 | 4 | 2 | 5 | 5 | 31 |
| Event-sourcing log | 5 PASS | 5 | 3 | 3 | 2 | 5 | 5 | 28 |
| Protobuf schema evolution | 5 PASS | 5 | 5 | 4 | 3 | 5 | 5 | 32 |
| Reset-and-reward | 5 PASS | 1 | 5 | 5 | 5 | 2 | 1 | 24 |

## 5. Top-3 with rationale

1. **Additive-only JSON + `save_version` field + stepwise manual readers** (sigma 33). Each release adds optional fields only ; a single integer `save_version` drives a chain of tiny `migrate_v{n}_to_v{n+1}` functions applied lazily on load. Skip-version robust because the chain is applied sequentially. MVP-friendly : no schema DSL, no eager tooling, inspectable by the dev and by an AI agent. Aligns with C12 JSON baseline.
2. **Protobuf schema evolution** (sigma 32). Field tags + optional semantics give schema-driven safety without parallel readers. Strong if C12 already ships protobuf ; otherwise introducing protobuf solely for migration cost is not justified at MVP.
3. **Versioned parallel readers** (sigma 31). Keeps a reader per historical schema version in the binary. Strong skip-version robustness and low per-migration dev cost after initial scaffolding ; penalised at MVP by dev-effort multiplier to build the reader-dispatch infrastructure before there are many versions.

## 6. Kappa A vs B

Effective set 5 post-exclusion. A ranks additive > protobuf > parallel readers > lazy chain > reset. B ranks additive > parallel readers > protobuf > lazy chain > reset. Top-1 agrees. Tier 2-3 swap (protobuf vs parallel readers). Tier agreement 4/5 = 80%, kappa ~0.75 "substantial". Divergence : A weights developer inspectability (favours protobuf IDL) ; B weights MVP-effort (favours the pattern already viable without new toolchain). Supervisor arbitrage : primary stands ; protobuf recorded as an upgrade path when C12 adopts a schema-IDL.

## 7. GRADE with factors

Starting score : 2 (pyramid L2 — Fowler + Kleppmann + vendor docs + indie postmortems).

Factors :
- +1 large effect : additive-only + `save_version` closes skip-version + first-launch-latency + dev-effort simultaneously ; no single-axis alternative matches.
- -1 indirectness : empirical progress-preservation rate under skip-version is scarce in primary sources for the effective set.
- -1 imprecision : migration-induced crash-rate benchmarks are not published for solo-indie archetypes.
- 0 inconsistency : top-1 stable across reviewers.
- 0 monoculture : L1 vendor + L2 book + L5 grey-lit convergence.

Score final : 2 + 1 - 2 = **1/7 → ACCEPTABLE**.

## 8. Sources Table 2

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | Fowler — Evolutionary Database Design | L2 book | 2006 | Lazy migration anchor |
| 2 | Kleppmann — Designing Data-Intensive Applications Ch.11 | L2 book | 2017 | Schema evolution + event-sourcing |
| 3 | Protocol Buffers language guide | L1 vendor | 2025 | Schema-driven evolution reference |
| 4 | SQLite user_version + migration pragma docs | L1 | 2025 | Versioning primitive reference |
| 5 | Indie game save-migration postmortems | L5 MG-2 grey-lit | varied | Failure-mode evidence |
| 6 | ISO/IEC 25010:2023 Maintainability + Compatibility | L1 standard | 2023 | Outcome anchor |

## 9. Primary recommendation

Adopt **additive-only JSON with a `save_version` integer and a chain of stepwise `migrate_vN_to_vN+1` functions applied lazily on load**. Every release either adds optional fields (backward-compatible, no version bump needed) or bumps `save_version` and ships one new tiny migration function. The loader walks from the save's stored version to the current version by composing the chain, which makes skip-version jumps deterministic. Defer eager tooling, parallel readers, and event-sourcing to a later scale. Snapshot the save file before applying the chain and retain one backup generation so a failed migration is recoverable. IAP entitlements live outside the migrated schema (store receipts + local cache keyed by product id) so migration cannot accidentally invalidate purchased content.

## 10. Decision + traceability

**Decision** : Additive-only JSON + `save_version` + stepwise manual readers. GRADE ACCEPTABLE (1/7). Protobuf schema evolution and versioned parallel readers documented as scale-up paths.

**Traceability** : PICOC source `verification/picoc/mobile-game-picoc-batch-C.md` §C14. Amendments G-1 + #3 + MG-2 + MG-6. Cross-refs : C12 (JSON format baseline) ; C13 (migration must not run inside lifecycle grace window) ; C15 (integrity re-computed post-migration) ; E23 + E25 (IAP entitlement kept outside migrated schema). Anti-double-counting : migration policy credited to C14 ; format to C12 ; scheduling to C13 ; integrity to C15.
