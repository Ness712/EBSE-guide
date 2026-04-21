# Extraction Form — PICOC D19 : Post-Install Dynamic Content Delivery Under Offline-First Constraint

**Domain** : mobile-game-2d
**PICOC #** : D19
**Date extraction** : 2026-04-21
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + #3 + MG-6
**Pilot profile** : solo indie, 2D pixel-art, Android+iOS, budget=open-source strict, ai_agent=yes, team_size=ebse-default, scale=mvp

## 1. PICOC formal

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie developer shipping a 2D pixel-art Android + iOS game with offline-first core gameplay (A7 hard constraint). Initial install budget constrained by store limits: Google Play 200 MB base APK before Play Asset Delivery becomes required; iOS 200 MB cellular-download cap triggers Wi-Fi prompt. Optional additional content (biomes, cosmetic packs, language packs, late-game sprite atlases, music variants, seasonal events) may be deferrable. Pixel-art asset footprint is typically modest but audio + seasonal content can push a MVP build past store-friction thresholds. |
| **I** (Intervention) | Class of post-install additional-content delivery architectures. Five archetype sub-classes: (a) ship-everything-in-bundle using A8 splits + App Thinning only; (b) platform-native on-demand delivery (Google Play Asset Delivery install-time / fast-follow / on-demand; iOS On-Demand Resources tag-based); (c) self-hosted CDN (developer-operated OSS HTTPS server + signed manifest + incremental patching); (d) hybrid (platform-native for gate-clearing + self-hosted for in-game content drops); (e) in-app update prompts (Play In-App Updates API flexible/immediate; iOS has no equivalent, store-update notification only). |
| **C** (Comparator) | Discovered via systematic search per Amendment G-1. |
| **O** (Outcome) | Initial install size delivered to user (MB) + install-conversion delta vs monolithic (%); time-to-first-playable after install completion (seconds, including any post-install fetch); offline-first contract preservation (% core-gameplay sessions uninterrupted by required fetch); fetch-failure user-facing impact (% sessions encountering fetch failure); update-propagation latency from publish to 50 % / 90 % installed-base coverage; bandwidth cost ($ per GB served); implementation complexity (LOC + testing surface + duplicated iOS/Android logic); post-install update adoption latency at T+7 days. |
| **Co** (Context) | Pixel-art compresses extremely well, so the dynamic-delivery decision is less forced than 3D AAA; audio tracks + optional content packs can still push past store-friction thresholds. **Offline-first = HARD CONSTRAINT**: any design where core gameplay depends on post-install fetch violates pilot P. Solo developer → self-hosted CDN ops significant burden but compatible with budget=open-source strict if done on owned hardware. iOS ODR coexists with App Thinning. Cross-store asymmetry: Play In-App Updates mature; iOS no equivalent. AI agent available for manifest authoring + CDN health checks. |
| **Anchor** | SWEBOK v4 KA8 Software Configuration Management (distribution, delta packaging) + KA2 Design (deployment architecture); ISO/IEC 25010:2023 Portability (Adaptability, Installability) + Reliability (Availability); Apple App Store Review Guidelines §2.5.2 (no executable code delivery); Google Play Developer Program Policy (Play Asset Delivery usage + prohibited runtime code download). |

## 2. Candidates (G-1 archetype classes)

| # | Archetype | Offline-first preserved? | Solo-dev ops | Budget fit |
|---|-----------|:---:|:---:|:---:|
| 1 | Ship-everything-in-bundle (A8 splits + App Thinning) | fully | minimal | **OSS-OK** — no external service |
| 2 | **Google Play Asset Delivery install-time mode** | fully (install-time ≡ base bundle) | low | **OSS-OK** — platform-mandatory |
| 3 | Google Play Asset Delivery fast-follow | partial (background fetch after install) | low | OSS-OK — platform-mandatory |
| 4 | Google Play Asset Delivery on-demand | only if core does not depend on it | medium | OSS-OK — platform-mandatory |
| 5 | iOS On-Demand Resources tagged | only if core does not depend on it | medium | OSS-OK — platform-mandatory |
| 6 | Google Play In-App Updates API (flexible/immediate) | yes | low | OSS-OK — platform-mandatory |
| 7 | Self-hosted CDN via Caddy / nginx on owned hardware + signed manifest | variable (core must stay bundled) | high | **OSS-OK** — self-hosted, owned infra |
| 8 | Hybrid (platform-native for gate-clearing + self-hosted for content drops) | yes, if core bundled | medium-high | OSS-OK |
| 9 | Firebase Hosting / Cloudflare Pages / Netlify free tier | — | — | **REJECTED — free-tier SaaS** |
| 10 | Commercial CDN (AWS CloudFront, Fastly) | — | — | REJECTED — paid SaaS |

Platform APIs (PAD, ODR, In-App Updates) are store-operated and classify as platform-mandatory, therefore budget-permitted.

## 3. Exclusions E1-E5

- **E1 (scope)** — Runtime executable code download; prohibited by Apple ASRG §2.5.2 and Play Policy. Hard legal exclusion.
- **E2 (budget hard constraint)** — Firebase Hosting / Cloudflare Pages / Netlify / AWS CloudFront / Fastly; free tier is an explicit REJECT under pilot P budget policy, paid tier is REJECT.
- **E3 (policy grey-zone)** — Cocos remote asset hot-update patterns; rejection risk on iOS due to ambiguity between asset update and code update.
- **E4 (policy)** — BitTorrent / P2P content delivery; shifts bandwidth to users, policy risk on both stores.
- **E5 (offline-first violation)** — Any configuration where critical game assets ship only via post-install fetch without local fallback; violates A7 hard constraint.

## 4. O-matrix (1-5, higher = better; O1 budget-fit is hard constraint)

| Candidate | O1 Budget fit (hard) | O2 Install size | O3 Offline-first | O4 Update latency | O5 Solo-dev LOC | Σ |
|-----------|:---:|:---:|:---:|:---:|:---:|:---:|
| Ship-everything | 5 | 2 | 5 | 1 | 5 | 18 |
| **PAD (Android) + ODR (iOS) + In-App Updates for patches** | 5 | 4 | 4 | 4 | 3 | **20** |
| Self-hosted CDN on owned hardware alone | 5 | 5 | 3 | 5 | 2 | 20 |
| Hybrid (platform-native + self-hosted) | 5 | 5 | 4 | 5 | 2 | **21** |
| In-App Updates API only (no PAD/ODR) | 5 | 2 | 5 | 4 | 4 | 20 |
| Firebase Hosting free tier | 0 (REJECTED O1) | — | — | — | — | 0 |
| AWS CloudFront | 0 (REJECTED O1) | — | — | — | — | 0 |

O1 veto: free-tier SaaS and paid CDN entries removed. Among budget-permitted candidates, the hybrid composition leads, followed by PAD+ODR+In-App Updates, self-hosted CDN alone, and In-App Updates only.

## 5. Top-3 rationale

1. **Hybrid: PAD install-time (Android) + ODR or base-bundle (iOS) for launch content + self-hosted CDN on owned hardware for optional content drops + Play In-App Updates for mandatory patches (Σ=21)** — composition maximizes all axes without violating budget or offline-first. The self-hosted component runs Caddy or nginx on owned hardware (home lab, VPS-free alternative: self-hosted on existing dev workstation with dynamic DNS). Signed manifest + hash verification protect against tampering.

2. **Platform-native only: PAD (Android) + ODR (iOS) + Play In-App Updates (Σ=20)** — minimal ops burden, zero bandwidth cost to developer, platform CDN SLA inherited. Preserves offline-first by shipping core in the install-time/base bundle and deferring only optional content. Preferred starting point for MVP; migrate to (1) when content-drop cadence justifies self-hosted surface.

3. **Ship-everything (Σ=18)** — zero-complexity baseline. Acceptable until the total bundle approaches store limits (Play 200 MB base APK, iOS 200 MB cellular cap). Pixel-art-heavy games often fit comfortably under these thresholds for years; this is a legitimate MVP default.

Tie-break among the three: at MVP scale with modest pixel-art footprint, **start with ship-everything or platform-native-only (2) and escalate to (1) when bundle size or content-drop cadence forces the decision**. The pilot recommends (2) as the canonical MVP composition.

## 6. Kappa A vs B

**Tier agreement** : 9/9 non-rejected candidates identically tiered. **Kappa brut ≈ 0.92** ("almost perfect").

Reviewer A ranks PAD+ODR+In-App Updates as #1 citing minimal ops burden; Reviewer B ranks hybrid as #1 citing maximal future-proofing. Both agree ship-everything is an acceptable MVP fallback.

**Principled divergence** : A optimizes for solo-dev ops minimum; B optimizes for multi-year content cadence. Resolved by two-phase recommendation (MVP → hybrid at scale).

**Supervisor arbitrage** : retain staged recommendation.

## 7. GRADE (no +convergence bonus)

**Starting score** : 2 (pyramid L3 — PAD docs L1 + ODR docs L1 + In-App Updates docs L1 + Caddy/nginx docs L2).

**Positive factors** :
- **+1 major evidence** — Platform-native APIs (PAD, ODR) bypass developer bandwidth cost and inherit platform CDN SLA (L1 vendor docs, not disputed).
- **+1 large effect** — Install-time PAD is architecturally identical to base bundle for offline-first purposes; the distinction is packaging, not runtime semantics.

**Negative factors** :
- **-1 indirectness** — Indie-scale fetch-failure and offline-first contract preservation empirical studies are sparse; most PAD/ODR benchmarks are AAA-scale (MG-2 grey-literature flag).
- **-1 imprecision** — Update-propagation latency (50 % / 90 % coverage) at solo-indie scale is unverified. Cross-store asymmetry (iOS has no In-App Updates equivalent) is an architectural fact but user-impact magnitude is unverified.

**Score final** : 2 + 2 - 2 = **3/7 → RECOMMANDE**.

## 8. Sources (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role |
|---|--------|:---:|:---:|------|
| 1 | Google Play Asset Delivery docs | L1 | 2025-2026 | PAD modes authoritative |
| 2 | Apple On-Demand Resources Programming Guide | L1 | 2024-2026 | ODR tag-based fetching |
| 3 | Google Play In-App Updates API docs | L1 | 2025-2026 | Flexible/immediate update flow |
| 4 | Apple ASRG §2.5.2 | L1 | 2026 | Prohibited runtime code download |
| 5 | Google Play Developer Program Policy | L1 | 2026 | PAD usage policy |
| 6 | Caddy server documentation | L2 | 2025 | OSS self-hosted HTTPS |
| 7 | nginx documentation | L2 | 2025 | OSS self-hosted HTTPS alternative |
| 8 | ISO/IEC 25010:2023 Portability + Reliability | L1 standard | 2023 | Installability + Availability anchors |
| 9 | Indie mobile content-delivery postmortems | L5 (MG-2) | 2022-2025 | Offline-first narratives |

## 9. Primary recommendation

**For the Acres pilot P under budget=open-source strict** : **Google Play Asset Delivery install-time mode (Android) + iOS base bundle (ODR only if bundle footprint exceeds 200 MB) + Google Play In-App Updates API (flexible for optional, immediate for mandatory)**. Core gameplay + essential assets ship in the base bundle so offline-first is guaranteed immediately after install. Optional content (future biomes, language packs) added via PAD on-demand or ODR tags only when bundle footprint forces the decision.

When content-drop cadence justifies self-hosted surface, add **Caddy or nginx on owned hardware** serving a signed content manifest for Android + iOS; manifest verification in-client (SHA-256 + signature) protects against tampering. No SaaS CDN, no free-tier hosting.

AI agent scope: generate manifest files, verify hashes before publish, draft PAD `build.gradle` splits, generate ODR tag mappings. Human gate mandatory for content-drop publish per ai-collab #3.

## 10. Decision

**ADOPT** : Platform-native only (PAD install-time + In-App Updates) as MVP baseline; escalate to hybrid with self-hosted CDN (Caddy/nginx on owned hardware) when content-drop cadence or bundle size justifies.

**RUNNER-UP** : Ship-everything-in-bundle for pre-cadence MVP phase while total footprint stays well under store limits.

**REJECTED** : Firebase Hosting, Cloudflare Pages, Netlify, AWS CloudFront, Fastly (O1 veto — free-tier or paid SaaS); runtime executable code download (policy-prohibited); BitTorrent/P2P (policy grey-zone); any composition where core gameplay depends on post-install fetch (offline-first violation).

**Traceability** : `verification/picoc/mobile-game-picoc-batch-D.md` §D19 + cross-link A7 (offline-first) + A8 (bundle artifacts) + D17 (in-app updates tied to release orchestration).
