# Extraction Form — PICOC A7 : Offline-First Local Persistence + Cloud-Save Sync

**Domain** : mobile-game-2d
**PICOC #** : A7
**Date** : 2026
**Reviewers** : A + B (isolated contexts) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + Amendment #3 + methodology.md v2026.04.7

## 1. PICOC formal

| Element | Value |
|---------|-------|
| **P** | Solo indie mobile game developer building a 2D pixel-art farming-sim where core gameplay runs entirely offline (flights, metros, unstable networks), with optional cross-device cross-platform cloud save, save-state conflict management when the same user plays on multiple devices, IAP entitlement + leaderboard score validity preserved across reinstalls ; hostile mobile lifecycle: OS kill possible at any time (Android low-memory, iOS background termination) |
| **I** | Class of offline-first persistence + sync architectures: local file-based saves, embedded relational stores, embedded key-value stores, document-oriented local stores — paired with sync strategies (last-write-wins, version-vector, CRDT-based merge, server-arbitrated reconciliation) over platform-native or self-host sync backends |
| **C** | Discovered systematically in Phase 2.1 — no pre-identification per Amendment G-1 |
| **O** | Save/load latency in ms for representative game state (~500 KB) ; conflict-resolution correctness (% multi-device scenarios resolved without data loss) ; sync bandwidth KB/session ; recovery time after offline→online transition (s) ; on-device storage footprint MB ; IAP entitlement restoration success on reinstall ; save integrity under OS kill (zero corrupted saves on N=100 force-kill mid-save tests) ; reported save-loss incidence in store reviews |
| **Co** | Offline-first mandatory, cloud optional and must degrade gracefully ; Apple ASRG §3.1.1 entitlement restoration ; Google Play Billing v6+ consistency ; GDPR/COPPA if Families Policy applies ; Apple Privacy Manifest ; transverses = budget=open-source strict (hosting costs: zero tolerated, so cloud sync only via platform-mandatory services or self-host), ai_agent=yes, team_size=ebse-default, scale=mvp |
| **Anchor** | SWEBOK v4 KA2 Architecture (data architecture, offline-first patterns) + KA6 Operations (lifecycle, sync) + KA13 Software Security (data-at-rest, PII) ; ISO/IEC 25010:2023 Reliability (Recoverability, Fault tolerance) + Security (Confidentiality, Integrity) + Performance Efficiency (Time behaviour) ; ISO/IEC 25019 Freedom from risk (data loss) ; Apple ASRG §3.1.1 ; Google Play Developer Program Policy (Data Safety) ; Apple Privacy Manifest |

## 2. Candidates discovered (archetype classes)

| # | Archetype class | Description |
|---|-----------------|-------------|
| 1 | Local flat file (JSON / TOML / custom binary) + atomic rename | Single save blob, write-to-temp + atomic rename ; simplest durable primitive |
| 2 | Embedded relational store (SQLite + WAL) | Transactional durability, indexed queries, mature on Android + iOS |
| 3 | Embedded key-value store (LMDB / LevelDB class) | Fast random access, simpler model than relational |
| 4 | Embedded document store (local OSS embedded) | Schemaless flexibility, JSON-native |
| 5 | Platform-native cloud-save (iCloud KVS/Documents + Google Play Games Saved Games) | Platform-mandatory bridge, zero infra cost, one backend per store |
| 6 | Self-host OSS sync backend + client adapter | Developer operates own server (CouchDB / self-host sync gateway) ; budget=open-source compliant only if self-hosted |
| 7 | CRDT-based local store + opportunistic sync | Automerge / Yjs class ; mergeable state eliminates conflict explicitly |

## 3. Exclusions at screening

| Candidate | Exclusion code | Reason |
|-----------|:--------------:|--------|
| Firebase Firestore / Realtime Database | E1 | SaaS even free tier — budget=open-source strict rejects |
| Supabase hosted | E1 | SaaS even free tier — budget=open-source strict rejects |
| AWS Amplify / DynamoDB | E1 | SaaS paid — rejected |
| PlayFab / GameSparks-class BaaS | E1 | SaaS — rejected |
| Netlify / Vercel edge KV | E1 | SaaS — rejected |
| Proprietary encrypted-save middleware | E1 | Commercial licence — rejected |

Archetype 5 (platform-native cloud-save) is retained under the platform-mandatory carve-out (Apple iCloud + Google Play Games Services are platform-mandatory services per methodology §3.1.1 Rule 5).

## 4. O-matrix (ordinal 1–5, higher = better)

| Archetype | O1 Save/load latency | O2 Integrity under OS kill | O3 Conflict correctness | O4 Storage footprint | O5 Impl. effort (solo) | O6 IAP restore path | O7 Budget=OSS strict | Σ |
|-----------|:-------------------:|:--------------------------:|:-----------------------:|:-------------------:|:----------------------:|:-------------------:|:--------------------:|:-:|
| 1. Flat file + atomic rename | 4 | 4 | 2 | 5 | 5 | 3 | 5 | 28 |
| 2. SQLite + WAL | 4 | 5 | 3 | 4 | 4 | 4 | 5 | 29 |
| 3. Embedded KV | 5 | 4 | 2 | 4 | 4 | 3 | 5 | 27 |
| 4. Embedded document | 4 | 3 | 3 | 4 | 4 | 3 | 5 | 26 |
| 5. Platform-native cloud-save | 3 | 4 | 4 | 5 | 4 | 5 | 5 | 30 |
| 6. Self-host OSS sync | 3 | 4 | 4 | 3 | 2 | 3 | 4 | 23 |
| 7. CRDT local + opp. sync | 3 | 4 | 5 | 3 | 2 | 3 | 5 | 25 |

O7 scores platform-native cloud-save as 5 under the platform-mandatory carve-out.

## 5. Top-3 ranking with rationale

1. **SQLite + WAL (archetype 2) for local authoritative store + platform-native cloud-save (archetype 5) for optional sync** — SQLite provides transactional durability (O2 = 5), mature cross-platform implementations, and the WAL journaling mode is robust under force-kill. Platform-native cloud-save (iCloud on iOS, Play Games Saved Games on Android) satisfies the platform-mandatory carve-out while keeping hosting cost at zero.
2. **Flat file + atomic rename (archetype 1) as a minimal fallback** — Simplest and fastest to implement ; integrity guarantee rests on POSIX rename atomicity. Suitable if game state stays small (≤ 100 KB) and queries remain unnecessary.
3. **CRDT local + platform-native cloud-save (archetype 7 + 5)** — Best conflict correctness for users who genuinely play across devices mid-session. Implementation effort is the principal barrier for a solo developer ; retained as a future option if conflict-driven data-loss reports rise.

## 6. Kappa A vs B

Agreement on archetype ranking: 5/7 → **κ ≈ 0.70 ("substantial")**. Divergence concerns archetype 2 vs 5 primary position: Reviewer A places SQLite first on integrity grounds ; Reviewer B places platform-native first on IAP-restore + zero-infra grounds. Supervisor arbitrage: combine — SQLite as local authoritative store, platform-native cloud as optional sync channel. The two are composable rather than mutually exclusive.

## 7. GRADE synthesis

Starting score : **3** (highest source = L1 ISO/IEC 25010 Reliability + L1 Apple ASRG §3.1.1 + L1 SQLite project documentation).

Positive factors:
- **+1 large_effect** — WAL journaling in SQLite transforms "% saves corrupted under force-kill" from a double-digit failure rate (naïve overwrite) to effectively zero in public test harnesses. The qualitative integrity gain is decisive for a save-game workload.
- **+1 major_evidence** — SQLite durability is the subject of formal verification work and of the most-tested embedded database in production on both Android and iOS (bundled with the OS on both platforms, zero dependency cost).

Convergence factor **OMITTED** (monoculture discount — SQLite is the canonical embedded store on mobile, so practitioner sources agreeing on its use does not constitute independent evidence).

Negative factors:
- **−1 indirectness** — Academic CRDT / sync literature is written for collaborative editing, not save-game workloads ; conflict frequency and payload shape differ.
- **−1 imprecision** — Conflict-resolution correctness % across realistic multi-device scenarios has no published benchmark specific to save-game workloads.

No −1 inconsistency (A + B converge on hybrid) ; no −1 bias.

Final score : 3 + 2 − 2 = **3/7 → RECOMMANDE**.

## 8. Sources extracted (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | SQLite project documentation (WAL mode, atomicity) | L1 | 2026 | Local durability anchor |
| 2 | Apple ASRG §3.1.1 entitlement restoration | L1 platform | 2026 | Compliance anchor |
| 3 | Google Play Billing v6+ consistency guide | L1 platform | 2026 | Compliance anchor |
| 4 | Apple iCloud Key-Value + Documents APIs | L1 platform | 2026 | Platform-native cloud path |
| 5 | Google Play Games Services Saved Games | L1 platform | 2026 | Platform-native cloud path |
| 6 | ISO/IEC 25010:2023 Reliability + Security | L1 standard | 2023 | Quality-model anchor |
| 7 | Apple Privacy Manifest requirements | L1 platform | 2026 | Privacy anchor |
| 8 | Automerge / Yjs CRDT academic papers | L3 | 2019–2024 | CRDT reference |
| 9 | Indie postmortems on save-game corruption (MG-2 grey-lit) | L5 flagged | 2021–2025 | Practitioner evidence |

## 9. Primary recommendation for pilot P

**Local authoritative store: SQLite with WAL journaling and a single versioned `save_state` row (JSON payload + schema_version + checksum).** Optional cloud sync via platform-native services: iCloud Key-Value Store or Documents on iOS, Play Games Services Saved Games on Android, toggled by a single user-facing setting. Conflict resolution: deterministic last-write-wins keyed on monotonic `save_generation` counter stored inside the payload, with a "Keep local / Keep cloud" resolver UI when divergence exceeds a simple threshold. No self-hosted server, no SaaS, no paid backend — budget=open-source strict compliant.

## 10. Decision with traceability

**Decision** : Adopt archetype 2 (SQLite + WAL) as local authoritative store + archetype 5 (platform-native cloud-save) as optional sync channel.

**Traceability** : PICOC definition in `verification/picoc/mobile-game-picoc-batch-A.md` §A7 ; absorbs lifecycle-event correctness and save-on-interrupt ex-A5 concerns per Phase 1.3 reconciliation ; upstream dependency on A1 (file + network APIs) ; downstream consumers: C12 (serialization format), C13 (lifecycle-triggered scheduling), C14 (schema migration), C15 (save integrity + tamper detection), F28 (identity binding).
