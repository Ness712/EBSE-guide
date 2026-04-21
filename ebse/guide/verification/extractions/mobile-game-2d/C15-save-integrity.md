# Extraction Form — PICOC C15 : Save-File Integrity and Tamper Resistance

**Domain** : mobile-game-2d
**PICOC #** : C15
**Year** : 2026
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + #3 + MG-2 + MG-6

## 1. PICOC formel

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie dev shipping a 2D mobile game on Android + iOS where local save files live in app-private storage but remain vulnerable to (a) bit-level corruption from interrupted writes or filesystem faults ; (b) deliberate tampering by users editing the save to unlock content, inflate currencies, or forge leaderboard inputs ; (c) cross-device sync conflicts. Ads+IAP present so entitlement state is economically significant. |
| **I** (Intervention) | Save-integrity mechanism class. Sub-classes (G-1) : (a) CRC32 / checksum for corruption only ; (b) HMAC with a keystore-held secret for tamper detection ; (c) digital signature with an asymmetric key-pair (private on server) ; (d) platform-native cloud save (Play Games Saved Games + Apple iCloud Key-Value Store / Game Center) delegating integrity to the vendor ; (e) server-side authoritative state ; (f) obfuscation only (XOR, custom format). Axes : integrity scope (corruption vs tampering vs replay) ; secret-management locus (device keystore vs server) ; platform-managed vs app-managed. |
| **C** (Comparator) | Discovered via Phase 2.1 systematic search (G-1) — no pre-identification. |
| **O** (Outcome) | Corruption-detection rate (% of corrupted saves flagged before load) ; tamper-detection rate against casual edit (hex editor, save-editor app) ; tamper-detection rate against skilled attacker (keystore extraction, memory patching) ; false-positive rate (legitimate save rejected) ; leaderboard-forgery resistance ; IAP-entitlement forgery resistance ; cross-device sync correctness ; user-facing recovery path on detected corruption ; dev effort ; battery / CPU overhead of integrity computation per save. |
| **Context** | budget=open-source strict (Play Games Saved Games + iCloud KVS = platform-mandatory, accepted) ; ai_agent=yes ; scale=mvp ; offline-first with optional cloud sync ; leaderboards present (F26) ; IAP present (E23) ; no backend server deployed at MVP (server-authoritative ruled out until scale). |
| **Anchor** | SWEBOK v4 KA2 Design (security mechanisms) + KA11 Security Engineering ; ISO/IEC 25010:2023 Security (Integrity, Non-repudiation) + Reliability (Recoverability) ; ISO/IEC 27002 A.8.24 (Use of cryptography) ; Apple CryptoKit + iOS Keychain docs ; Android Keystore docs ; Play Games Services Saved Games integrity model ; iCloud KVS semantics. |

## 2. Candidates discovered (G-1 archetype classes)

| # | Candidate | Class | Secret locus | Platform-mandatory |
|---|-----------|-------|:------------:|:------------------:|
| 1 | CRC32 checksum only | (a) | none | no |
| 2 | SHA-256 over payload only | (a) | none | no |
| 3 | HMAC-SHA256 with Android Keystore / iOS Keychain-held key | (b) | device secure enclave | no (OSS primitive) |
| 4 | Asymmetric signature (Ed25519) with private key server-side | (c) | server | no |
| 5 | Play Games Saved Games + Apple iCloud KVS / Game Center (platform-native) | (d) | platform-managed | yes (accepted under budget rule) |
| 6 | Server-authoritative state | (e) | server | no (requires backend) |
| 7 | XOR / custom obfuscation only | (f) | embedded constant | no |

## 3. Exclusions E1-E5

| Candidate | Criterion | Reason |
|-----------|-----------|--------|
| CRC32 / SHA-256 only | E1 outcome mismatch | Covers corruption but not tampering ; fails tamper-detection outcomes by construction. |
| Ed25519 server-signed | E2 context | No backend deployed at MVP ; revisited when a backend appears. |
| Server-authoritative | E2 context | Same — requires backend infrastructure outside MVP scope. |
| XOR / custom obfuscation | E3 anti-pattern | Security-through-obscurity ; fails all skilled-attacker outcomes ; SWEBOK KA11 anti-pattern. |
| Managed integrity SaaS | E5 budget | Strict-OSS forbids SaaS even free tier. |

## 4. O-matrix (ordinal 1-5, higher=better ; O1 gate)

| Candidate | O1 Budget gate | O2 Corruption detection | O3 Casual-tamper detection | O4 Skilled-tamper detection | O5 False-positive rate (low=high) | O6 Leaderboard forgery resistance | O7 IAP forgery resistance | O8 Dev effort | Sigma |
|-----------|:--------------:|:-----------------------:|:--------------------------:|:---------------------------:|:---------------------------------:|:---------------------------------:|:-------------------------:|:-------------:|:-----:|
| CRC32 only | 5 PASS | 5 | 1 | 1 | 5 | 1 | 1 | 5 | 19 |
| SHA-256 only | 5 PASS | 5 | 2 | 1 | 5 | 2 | 1 | 5 | 21 |
| HMAC-keystore | 5 PASS | 5 | 5 | 3 | 5 | 4 | 4 | 4 | 30 |
| Platform-native saves (Play Games + iCloud) | 5 PASS | 5 | 5 | 4 | 5 | 5 | 5 | 5 | 34 |
| Ed25519 server-sign | 5 PASS (requires backend) | 5 | 5 | 5 | 5 | 5 | 5 | 2 | 32 |
| Server-authoritative | 5 PASS (requires backend) | 5 | 5 | 5 | 5 | 5 | 5 | 1 | 31 |
| XOR obfuscation | 5 PASS | 2 | 2 | 1 | 4 | 1 | 1 | 5 | 16 |

## 5. Top-3 with rationale

1. **Platform-native saves (Play Games Saved Games + Apple iCloud KVS / Game Center)** (sigma 34). Integrity, replay protection, and cross-device sync are delegated to the platform. Accepted under the budget rule as platform-mandatory. Minimum dev effort, maximum coverage at MVP. IAP entitlements sit on the existing receipt-validation path (E25), so forgery resistance is inherited from the store receipt, not from the save bytes.
2. **Ed25519 server-sign** (sigma 32). Strongest skilled-attacker resistance but requires backend infrastructure outside MVP scope ; recorded as the scale-up path when a backend is deployed.
3. **HMAC-SHA256 with device keystore-held key** (sigma 30). The best app-managed option without a backend : corruption + casual tamper covered, skilled attacker only partially covered because the key lives on the same device (extraction under root / jailbreak). Retained as the fallback when platform-native saves are unavailable on a given flow.

## 6. Kappa A vs B

Effective set 4 post-exclusion. A ranks platform-native > HMAC-keystore > Ed25519-server > SHA-256-only. B ranks platform-native > Ed25519-server > HMAC-keystore > SHA-256-only. Top-1 agrees. Tier 2-3 swap (HMAC vs server-sign). Tier agreement 3/4 = 75%, kappa ~0.67 "substantial". Divergence : A discounts server-sign at MVP (no backend) ; B ranks it on intrinsic security. Supervisor arbitrage : primary stands ; server-sign is a context-gated upgrade, HMAC is the no-backend fallback.

## 7. GRADE with factors

Starting score : 2 (pyramid L1 platform docs + L1 crypto primitives + L2 SWEBOK KA11 + L5 indie postmortems).

Factors :
- +1 large effect : platform-native saves close integrity + sync + replay-protection in one primitive.
- -1 indirectness : Play Games + iCloud KVS integrity guarantees are documented at API level but not benchmarked against skilled-attacker tamper rates in public literature.
- -1 imprecision : keystore-extraction rate on rooted Android / jailbroken iOS under attacker effort is not published for solo-indie archetypes.
- 0 inconsistency : top-1 stable.
- 0 monoculture : L1 vendor + L1 OSS primitives + L2 SWEBOK convergence.

Score final : 2 + 1 - 2 = **1/7 → ACCEPTABLE**.

## 8. Sources Table 2

| # | Source | Pyramid level | Year | Role |
|---|--------|:-------------:|:----:|------|
| 1 | Play Games Services Saved Games docs | L1 vendor | 2025 | Platform-native integrity anchor |
| 2 | Apple Game Center + iCloud Key-Value Store docs | L1 vendor | 2025 | Platform-native integrity anchor |
| 3 | Android Keystore + iOS Keychain docs | L1 vendor | 2025 | Device secret-locus reference |
| 4 | RFC 2104 HMAC + NIST SP 800-107 | L1 standard | 2008 / 2012 | Primitive anchor |
| 5 | SWEBOK v4 KA11 Security Engineering | L2 | 2024 | Anti-pattern anchor |
| 6 | ISO/IEC 25010:2023 Security (Integrity) + 27002 A.8.24 | L1 standard | 2023 | Outcome anchor |

## 9. Primary recommendation

Use **platform-native saves as the primary integrity mechanism** : Play Games Saved Games on Android and iCloud Key-Value Store (or Game Center) on iOS. Integrity, replay protection, and cross-device continuity are delegated to the platform. IAP entitlements remain anchored in store-receipt validation (E25) independently of save bytes. For save content that cannot or should not round-trip through the platform save surface (e.g. very large saves above KVS quotas, or user-opt-out of cloud sync), fall back to a local **HMAC-SHA256 tag computed over the save payload with a secret kept in the Android Keystore / iOS Keychain**, written atomically alongside the save (write-to-temp + rename). On detected tamper or corruption, offer the user a recovery path : roll back to the last good snapshot (C14 retains one backup generation) rather than silently overwriting. Promote to Ed25519 server-sign once a backend exists.

## 10. Decision + traceability

**Decision** : Platform-native saves primary ; HMAC-keystore fallback for non-cloud paths. GRADE ACCEPTABLE (1/7). Server-sign recorded as post-backend upgrade.

**Traceability** : PICOC source `verification/picoc/mobile-game-picoc-batch-C.md` §C15. Amendments G-1 + #3. Cross-refs : C12 (payload defines HMAC input) ; C13 (HMAC computed before atomic flush) ; C14 (integrity re-computed post-migration) ; E25 (IAP receipt validation handles entitlement forgery independently) ; F26 (leaderboard anti-cheat relies on platform Game Services, not save HMAC). Anti-double-counting : integrity primitive credited to C15 ; receipt validation to E25 ; leaderboard anti-cheat to F26.
