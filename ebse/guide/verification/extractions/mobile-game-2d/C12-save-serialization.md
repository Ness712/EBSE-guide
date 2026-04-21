# Extraction Form — PICOC C12 : Serialization Format of Persisted Game State

**Domain** : mobile-game-2d
**PICOC #** : C12
**Year** : 2026
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + #3 + MG-2 + MG-6

## 1. PICOC formel

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie dev shipping a 2D pixel-art mobile game (Android + iOS portrait, offline-first with optional cloud save), ads + IAP + leaderboards. Persists gameplay state (player progression, inventory, meta-currency, settings, IAP entitlement cache) into the storage substrate chosen in A7. |
| **I** (Intervention) | Class of **serialization format** for game-state structures into persistable byte streams : (a) human-readable self-describing text (JSON, XML, YAML) ; (b) schema-driven binary with shared compiled schema (Protocol Buffers, FlatBuffers, Cap'n Proto) ; (c) schemaless binary (BSON, CBOR, MessagePack schemaless) ; (d) custom packed binary (hand-rolled struct layouts, engine-native BinaryWriter). |
| **C** (Comparator) | Discovered via systematic Phase 2.1 search : serialization benchmark repos on GitHub, mobile-platform serialization benchmarks (Android + iOS), ACM DL schema-evolution literature, indie postmortems on save corruption. No pre-identification per G-1. |
| **O** (Outcome) | Cold-start save-load latency P95 on low-end device ; on-disk save size for representative payload ; forward / backward schema-compatibility defect rate per app version ; memory allocation pressure during serialization ; cloud-save quota fit (Play Saved Games 3 MB, iCloud per-key) ; human-readability for support/debug ; perceived app launch smoothness ; support turnaround after corrupted save. |
| **Context** | Solo indie with minimal QA bandwidth ; budget=open-source strict (self-host OSS only) ; target device floor 2 GB-RAM Android entry-level ; monthly content patch cadence ; users email corrupted save files — dev must debug from mailed file ; A7 storage engine influences but does not impose format ; ai_agent=yes ; scale=mvp. |
| **Anchor** | SWEBOK v4 KA2 Design (data design, information representation) + KA12 Software Quality (maintainability via debuggability) ; ISO/IEC 25010:2023 Performance Efficiency + Compatibility (co-existence cross app versions) + Maintainability (Analysability — debuggability) ; ISO/IEC 29110-4-3 VSE. |

## 2. Candidates discovered (G-1 archetype classes)

| # | Candidate | Archetype class | License | Schema evolution | Mobile support |
|---|-----------|-----------------|---------|:----------------:|:--------------:|
| 1 | JSON (built-in Godot + stdlib) | (a) text self-describing | public | additive-tolerant | yes |
| 2 | Godot ConfigFile INI-like | (a) text | MIT (engine) | partial | yes |
| 3 | YAML via OSS library | (a) text | MIT / Apache | additive | yes |
| 4 | Protocol Buffers (protobuf) | (b) schema binary | BSD | built-in (optional fields, reserved tags) | yes |
| 5 | FlatBuffers | (b) schema binary zero-copy | Apache 2.0 | built-in | yes |
| 6 | Cap'n Proto | (b) schema binary zero-copy | MIT | built-in | yes |
| 7 | CBOR (RFC 8949) | (c) schemaless binary | public (RFC) | tolerant | yes |
| 8 | MessagePack schemaless | (c) schemaless binary | Apache 2.0 | tolerant | yes |
| 9 | Godot binary resource (.tres/.res) | (d) engine-native | MIT (engine) | engine-versioned | yes |
| 10 | Hand-rolled packed struct | (d) custom | project | manual | yes |

## 3. Exclusions E1-E5

| Candidate | Criterion | Reason |
|-----------|-----------|--------|
| XML | E4 ecosystem-mismatch | Verbose, limited Godot stdlib support for game-save patterns ; outperformed by JSON and binary on every outcome axis. |
| YAML | E3 security concern + E4 dep weight | YAML parsers on mobile add a non-trivial OSS dependency and have historically brought deserialization CVEs unless carefully configured. |
| Commercial SaaS save backends (Firebase Realtime DB, PlayFab) | E5 budget incompatible | Free tier SaaS explicitly rejected by budget=open-source strict. |
| Godot binary .res for gameplay saves | E4 coupling risk | Engine-format save binds save compatibility to engine version — magnifies C14 migration risk. Retained for editor resources, excluded as gameplay save format. |
| Hand-rolled packed struct | E1 scope vs outcome fit | High dev effort + zero schema-evolution tooling vs protobuf / CBOR which provide the same compactness with migration safety. Excluded on cost-benefit for solo VSE. |

## 4. O-matrix (ordinal 1-5, higher=better ; O1 gate)

| Candidate | O1 Budget=OSS (gate) | O2 Debuggability (text readable from user-emailed save) | O3 Schema-evolution safety | O4 Load latency + footprint | O5 Cloud quota fit (3 MB Play Saved Games) | Sigma |
|-----------|:--------------------:|:------------------------------------------------------:|:-------------------------:|:---------------------------:|:------------------------------------------:|:-----:|
| JSON | 5 PASS | 5 | 3 (additive only) | 3 | 3 | 19 |
| Godot ConfigFile | 5 PASS | 5 | 2 | 3 | 3 | 18 |
| Protocol Buffers | 5 PASS | 2 (binary — needs protoc decode) | 5 | 5 | 5 | 22 |
| FlatBuffers | 5 PASS | 2 | 5 | 5 | 5 | 22 |
| Cap'n Proto | 5 PASS | 2 | 5 | 5 | 5 | 22 |
| CBOR | 5 PASS | 3 (diagnostic notation) | 3 | 4 | 5 | 20 |
| MessagePack | 5 PASS | 2 | 3 | 4 | 5 | 19 |

## 5. Top-3 with rationale

1. **JSON (Godot stdlib JSON.stringify / JSON.parse)** (sigma 19). Wins on O2 (dev debugs user-emailed save by opening it in a text editor — decisive for solo indie with no QA). Pairs naturally with additive-only schema evolution (C14). Loses to schema-binary formats on O4 size/latency but payload sizes (hundreds of KB typical for farming-sim save) keep JSON comfortably inside Play Saved Games 3 MB quota.
2. **Protocol Buffers** (sigma 22 by raw ordinals). Best-in-class schema-evolution + compactness. Drops to tier-2 for pilot P because O2 debuggability requires `protoc --decode` tooling that the user (who emails a save file for support) cannot run — the solo dev must decode every support case. Recommended for entitlement-cache subset (E23/E25 cross-link) where schema stability and compactness dominate, but not whole-save.
3. **CBOR** (sigma 20). Intermediate : schemaless-binary with standardized diagnostic notation that can be rendered back to text for debug. Reasonable compromise when JSON payload sizes begin to strain quotas.

Tier-2 raw sigma ordering places the three schema-binaries (protobuf, FlatBuffers, Cap'n Proto) at the top numerically, but O2 debuggability under the solo support workflow is undercounted in the matrix for those candidates. The qualitative supervisor tie-break promotes JSON for whole-save and reserves binary formats for sub-blocks where evolution + compactness outweigh human-readability.

## 6. Kappa A vs B

Effective set (7 post-exclusion). A ranks JSON > protobuf > CBOR > FlatBuffers > MessagePack > ConfigFile > Cap'n Proto. B ranks protobuf > JSON > FlatBuffers > CBOR > Cap'n Proto > MessagePack > ConfigFile. Top-2 differ (JSON vs protobuf at #1) — principled divergence on O2-vs-O3 weighting. Tier agreement 4/7 = 57%, kappa ~0.48 "moderate".

Divergence DIV-JSON-vs-protobuf : A weights O2 debuggability first (solo indie support workflow) ; B weights O3 schema-evolution first (long-tail update cadence + C14 coupling). Supervisor arbitrage : hybrid accepted — JSON for whole-save, protobuf for the entitlement-cache sub-block where C14 evolution matters more than debuggability.

## 7. GRADE with factors

Starting score : 2 (pyramid L3 — standards RFC 8949 / RFC 8259 L1 + vendor protobuf docs L1 + benchmark repos L3 + indie postmortems L5 MG-2).

Positive factors :
- +1 large effect : for payloads in the hundreds-of-KB range, JSON parse/serialize on low-end Android is well within frame budget across all mainstream stdlib implementations ; size impact on the 3 MB Play Saved Games quota is negligible for a typical farming-sim save.

Negative factors :
- -1 indirectness : most serialization benchmarks target server workloads (JSON vs protobuf throughput in microservices) rather than cold-start load on 2 GB-RAM Android.
- -1 imprecision : P95 cold-start load latency on representative device floor is not quantified per format in the available primary sources.
- -1 monoculture discount : within budget=open-source strict, the effective set is dominated by Google-ecosystem formats (protobuf + FlatBuffers) — limited diversity.
- 0 inconsistency : principled divergence arbitrated to a hybrid, not methodologically inconsistent.

Score final : 2 + 1 - 3 = **1/7 -> ACCEPTABLE**.

## 8. Sources Table 2

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | RFC 8259 JSON + RFC 8949 CBOR | L1 standard | 2017 / 2020 | Format specs |
| 2 | Protocol Buffers docs (protobuf.dev) | L1 | 2025 | Schema evolution reference |
| 3 | FlatBuffers docs (flatbuffers.dev) | L1 | 2025 | Zero-copy capability |
| 4 | Cap'n Proto docs | L1 | 2025 | Zero-copy capability |
| 5 | Godot JSON + ConfigFile docs | L1 | 2026 | Engine stdlib support |
| 6 | Serialization benchmark repos (GitHub) | L3 | 2024-2025 | Throughput evidence |
| 7 | Indie postmortems on save corruption | L5 MG-2 grey-lit | varied | Debuggability workflow evidence |
| 8 | ISO/IEC 25010:2023 Performance + Compatibility + Maintainability | L1 standard | 2023 | Outcome anchor |

## 9. Primary recommendation

Adopt **JSON (Godot stdlib)** as the whole-save format and apply **additive-only schema evolution** (C14 interaction). For the entitlement-cache sub-block (IAP restoration, C15 cross-link), use **Protocol Buffers** as a nested opaque field for schema-tight compactness. Include a format-version integer at the root of every save document so C14 lazy on-load migration has an unambiguous dispatch point. Commit one representative save under test fixtures so schema drift is detectable in CI.

## 10. Decision + traceability

**Decision** : JSON whole-save + Protocol Buffers entitlement sub-block. Status GRADE ACCEPTABLE (1/7). Debuggability under the solo support workflow and schema evolvability for monthly patch cadence jointly dominate.

**Traceability** :
- PICOC source : `verification/picoc/mobile-game-picoc-batch-C.md` §C12
- Protocol amendments : G-1 + #3 + MG-2 + MG-6
- Cross-references : A7 storage substrate (influences save granularity but not format) ; C13 scheduling (parse/serialize cost affects autosave frequency feasibility) ; C14 schema migration (format determines migration options) ; C15 integrity (HMAC covers the serialized byte stream regardless of format) ; E23/E25 IAP entitlement (sub-block protobuf).
- Anti-double-counting : format choice credited to C12 ; migration strategy credited to C14 ; integrity mechanism credited to C15.

Word count : ~1230 words.
