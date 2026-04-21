# Extraction Form — PICOC E22b : Ad Placement + Format-Mix + Frequency Capping UX Policy

**Domain** : mobile-game-2d
**PICOC #** : E22b
**Date extraction** : 2026-04-21
**Reviewers** : A + B (isolated) + Agent C verification
**Protocol** : Kitchenham & Charters 2007 §2.4 + Amendment G-1 + #3 + MG-9 (Safety / Operational-constraint tagging)
**Pilot profile** : solo indie, 2D pixel-art, Android+iOS, budget=open-source strict, ai_agent=yes, team_size=ebse-default, scale=mvp

Scope note: this PICOC covers the technical ad surface decisions with SE-measurable outcomes. Consent prompt UX (ATT copy, UMP timing) is D20 territory and is excluded here. Pure copy / timing optimization (UX-research discipline) is out of scope.

## 1. PICOC formal

| Element | Value |
|---------|-------|
| **P** (Population) | Solo indie developer shipping a 2D pixel-art portrait offline-first Android + iOS game with short-session gameplay (discrete run / level / wave) and ads monetization integrated per E22 (single-SDK AdMob direct via `godot-admob`). Pilot P includes interstitial-between-runs and rewarded-continue as idiomatic patterns. |
| **I** (Intervention) | Class of ad placement + format-mix + frequency-capping UX policies. Four axes: (a) format deployment (which formats used where: interstitial triggers between-runs or on-menu-return; rewarded-ad integration into the game economy for gems / continues; banner presence / absence on gameplay vs menu screens; app-open ads permitted or disabled); (b) frequency-capping rules (time-based, session-based, event-based; minimum gap between full-screen ads); (c) rewarded-ad opt-in flow (pre-prompt presence + value-exchange framing transparency); (d) portrait UI accessibility (close-button reachability with thumb in portrait mode; banner overlap with interactive game UI zones; ad-click-through-safe-zones). Explicitly NOT in scope: consent prompt UX / ATT prompt timing / UMP copy optimization (→ D20). |
| **C** (Comparator) | Discovered via systematic search per Amendment G-1. |
| **O** (Outcome) | Compliance pass rate under Apple ASRG §4 (advertising) + Google Play Ads Policy (disruptive-ads, full-screen interstitial rules, Families-policy restrictions); accidental-click rate (% ad interactions attributable to UI mis-tap); banner-overlay UI interference incidents (% sessions with banner occluding mandatory UI); rewarded-ad opt-in rate as UX conversion (proxy for perceived fairness, not revenue); short-term retention proxies (D1 session count, uninstall rate within first session) as ISO 25019 quality-in-use outcomes; accessibility close-button target-size compliance (WCAG 2.2 SC 2.5.8 + Apple HIG 44 pt + Material 48 dp); rage-tap incidence analytics; 1-star review rate attributable to ad placement. EXCLUDED: eCPM, ARPDAU, LTV, revenue conversion. |
| **Co** (Context) | Short-session casual / hyper-casual 2D pixel-art portrait game. Offline-first gracefully degrades when ads fail to load (no forced-ad-or-no-play gates). ATT / UMP obligations propagate from D20. Google Play Families policy sensitivity if app rated under-13 audiences. Portrait UI real estate limits banner placement options. **Budget=open-source strict**: policy is implemented entirely in-engine; no SaaS A/B testing platform is used. Remote-config for frequency caps, when added, uses the H37 recommended self-hosted solution rather than Firebase Remote Config SaaS. AI agent drafts policy tables + test cases. |
| **Anchor** | SWEBOK v4 KA3 Design (UI / UX design, advertising surface integration); ISO/IEC 25010:2023 Usability (Appropriateness Recognizability, Learnability, Operability, User error protection, Inclusivity / Accessibility); ISO/IEC 25019 Quality in Use (engagement, satisfaction, freedom from risk); W3C WCAG 2.2 SC 2.5.8 Target Size Minimum; Apple HIG 44 pt touch targets + Apple HIG Games; Apple App Store Review Guidelines §4 Design (advertising behaviour); Google Play Ads Policy (disruptive-ads classification, full-screen interstitial restrictions post-2022, Families Policy). |

## 2. Candidates (G-1 archetype classes)

Per Amendment G-1 with MG-9 clarification, candidates are architectural archetypes emerging from the axis taxonomy, not concrete vendor policies.

| # | Archetype | Format deployment | Frequency cap | Rewarded flow | Budget fit |
|---|-----------|-------------------|---------------|---------------|:---:|
| 1 | **Rewarded-opt-in primary + anchored adaptive banner (menus only) + capped interstitial** | rewarded-for-continue / gems + anchored adaptive banner on menu only + interstitial gated between runs | ≥ 60 s between full-screen + session-count-based | explicit pre-prompt + value-exchange transparency | **OSS-OK** |
| 2 | Anchored banner + interstitial mix (legacy) | banner persistent gameplay + interstitial every N runs | time-based only | inline trigger (no opt-in prompt) | OSS-OK but compliance-borderline post-2022 |
| 3 | Rewarded-only (no banner, no interstitial) | rewarded nodes only | rewarded is opt-in self-paced | explicit prompt | OSS-OK |
| 4 | Aggressive interstitial / app-open blanket | interstitial on launch + between runs + app-open | none / minimal | implicit | REJECTED — policy-failure risk |
| 5 | Banner-only persistent | anchored banner persistent gameplay + menus | n/a (no full-screen) | n/a | OSS-OK but banner occlusion risk |

All archetypes are implemented in-engine; no SaaS involvement. O1 budget veto does not discriminate between them. Ranking is driven by compliance + accessibility + retention proxies.

## 3. Exclusions E1-E5

- **E1 (scope)** — Consent UX copy / timing optimization (already D20 territory).
- **E2 (non-mobile)** — Web / desktop ad UX studies without mobile portrait applicability.
- **E3 (business-only)** — eCPM / LTV-optimization studies without extractable SE outcome (per pilot MG-9 §2).
- **E4 (genre-mismatch)** — Pre-2022 Google Play Ads Policy era interstitial guidance (superseded by the 2022 disruptive-ads classification).
- **E5 (policy failure)** — Aggressive interstitial / app-open blanket pattern; Apple ASRG §4 + Google Play disruptive-ads classification rejection risk.

## 4. O-matrix (1-5, higher = better; O1 budget-fit is hard constraint)

| Archetype | O1 Budget fit (hard) | O2 ASRG / Play compliance | O3 Accidental-click ↓ | O4 A11y (44 pt / WCAG) | O5 Offline-graceful | Σ |
|-----------|:---:|:---:|:---:|:---:|:---:|:---:|
| **Rewarded-opt-in primary + adaptive banner + capped interstitial** | 5 | 5 | 5 | 5 | 5 | **25** |
| Anchored banner + interstitial mix (legacy) | 5 | 3 | 3 | 3 | 4 | 18 |
| Rewarded-only | 5 | 5 | 5 | 5 | 5 | 25 |
| Aggressive interstitial / app-open blanket | 5 | 1 | 1 | 2 | 3 | 12 |
| Banner-only persistent | 5 | 4 | 3 | 3 | 4 | 19 |

Archetype #1 and archetype #3 tie at Σ=25. Because pilot P includes ads monetization in scope, #3 (rewarded-only) under-monetizes the casual-run pattern; #1 captures the rewarded benefits and adds a modest banner floor on menus only (gameplay stays banner-free).

## 5. Top-3 rationale

1. **Rewarded-opt-in primary + anchored adaptive banner (menus only) + capped interstitial with ≥ 60 s gap + no-interstitial-on-splash + WCAG 2.2 SC 2.5.8 + HIG 44 pt close target + explicit pre-prompt value-exchange transparency (Σ=25)** — canonical casual-mobile pattern. Interstitial shown between runs after a minimum 60 s session threshold + session-count gating. Rewarded ads integrate with the game economy (gems, continue-after-fail) with explicit pre-prompt so the user understands the exchange. Banner on menus only preserves portrait gameplay real estate.

2. **Rewarded-only (Σ=25)** — ties on SE outcomes but under-monetizes since pilot P has ads in scope. Acceptable if the developer deprioritizes ad revenue relative to retention.

3. **Banner-only persistent (Σ=19)** — compliant but thin on rewarded uplift and with banner occlusion risk on portrait gameplay.

Tie-break #1 vs #3: #1 captures the rewarded benefits plus a modest banner floor on menus while keeping gameplay banner-free; pilot P retains #1.

## 6. Kappa A vs B

**Tier agreement** : 5/5 archetypes identically tiered. **Kappa brut ≈ 1.0** ("perfect agreement").

Reviewer A and Reviewer B both identify #1 as canonical. Minor divergence: A ranks banner-only ahead of the legacy mix, B allows the mix higher if frequency cap is strict. Neither challenges #1.

**Principled divergence** : none.

**Supervisor arbitrage** : none required.

## 7. GRADE (no +convergence bonus)

**Starting score** : 2 (pyramid L1 — Apple ASRG §4 + Google Play Ads Policy + W3C WCAG 2.2 SC 2.5.8 + Apple HIG).

**Positive factors** :
- **+1 large effect** — Apple ASRG §4 + Play disruptive-ads policy + HIG 44 pt + WCAG 2.2 SC 2.5.8 + ISO 25010 User error protection all align on the canonical pattern; convergent regulatory + standards signal.
- **+1 major evidence** — Safety / Operational-constraint outcomes (MG-9 §2) tagged: dark-pattern avoidance + addiction-risk mitigation encoded in the "no forced-ad-or-no-play" rule, the ≥ 60 s frequency cap, and the rewarded opt-in transparency. Loot-box jurisdictional regulations (Belgium 2018, Netherlands 2018, China 2019) tangential (no paid-blind loot-boxes in pilot P).

**Negative factors** :
- **-1 indirectness** — Retention proxy (D1 session count) comes from general casual-game retention literature, not isolated-variable ad-policy A/B studies.
- **-1 imprecision** — Rage-tap incidence and 1-star review rate attributable to ads are rarely isolated in published studies; effect magnitudes are not robustly quantified per-archetype.

**Score final** : 2 + 2 - 2 = **2/7 → RECOMMANDE (borderline)**. Pyramid-authoritative policy alignment raises the recommendation tier; imprecision on magnitude keeps it from STANDARD.

## 8. Sources (Kitchenham Table 2)

| # | Source | Pyramid level | Year | Role |
|---|--------|:---:|:---:|------|
| 1 | Apple ASRG §4 (advertising behaviour) | L1 platform-primary | 2026 | Compliance gate for full-screen interstitial + close-target usability |
| 2 | Google Play Developer Program Policy — Ads (Disruptive Ads classification) | L1 platform-primary | 2026 | Full-screen interstitial rules post-2022 |
| 3 | W3C WCAG 2.2 Recommendation (SC 2.5.8 Target Size Minimum) | L1 W3C Rec | 2023 | Accessibility close-button minimum |
| 4 | Apple HIG (44 pt touch targets + HIG Games) | L1 | 2026 | Portrait touch target authority |
| 5 | Material Design 3 (48 dp touch target) | L1 vendor | 2026 | Android equivalent |
| 6 | ISO/IEC 25010:2023 Usability (User error protection) | L1 standard | 2023 | Accidental-click framing |
| 7 | ISO/IEC 25019:2023 Quality-in-Use | L1 standard | 2023 | Retention proxy + MG-9 Safety framing |
| 8 | Google Play Families Policy | L1 platform-primary | 2026 | Policy-eligibility gate |
| 9 | Indie casual game ad-UX postmortems (GDC Vault, dev blogs) | L5 (MG-2) | 2022-2025 | Retention + rage-tap observations |
| 10 | ACM CHI PLAY rewarded-ad integration studies (SE-outcome filtered per MG-9) | L3 | 2020-2025 | Rewarded opt-in rate as UX conversion |

## 9. Primary recommendation

**For the Acres pilot P under budget=open-source strict** : **Rewarded-opt-in primary (rewarded-for-continue + rewarded-for-gems) + anchored adaptive banner on menu screens only (gameplay banner-free) + capped interstitial between runs (≥ 60 s gap + session-count gating + no-interstitial-on-splash) + explicit pre-prompt with value-exchange transparency + WCAG 2.2 SC 2.5.8 + Apple HIG 44 pt / Material 48 dp close target + portrait-safe close-button placement**. Policy encoded as an in-engine table (Godot resource file) with frequency counters persisted locally per A7.

AI agent scope: draft the policy table (formats, gaps, prompts), generate test cases for frequency counters, validate 44 pt / 48 dp close-button target on-device, author the rewarded-ad integration points in the game economy, tag Safety/Operational-constraint outcomes per MG-9. Human gate mandatory for final frequency parameters per ai-collab #3 (monetization tuning is a human-only decision).

## 10. Decision

**ADOPT** : Rewarded-opt-in primary + anchored adaptive banner on menus only + capped interstitial with ≥ 60 s gap + WCAG 2.2 + HIG 44 pt close target.

**RUNNER-UP** : Rewarded-only (if ad monetization de-prioritized relative to retention).

**REJECTED** : Aggressive interstitial / app-open blanket (ASRG §4 + Play disruptive-ads policy rejection risk); anchored banner + interstitial mix legacy (compliance-borderline post-2022).

**Safety / Operational-constraint tagging (MG-9 §2)** : archetype #1 satisfies dark-pattern-avoidance + addiction-risk-mitigation outcomes via the "no forced-ad-or-no-play", frequency-cap ≥ 60 s, and rewarded opt-in with transparent value exchange properties. Loot-box jurisdictional regulations (BE / NL 2018, CN 2019) out-of-scope for pilot P (no paid-blind loot-boxes).

**Traceability** : `verification/picoc/mobile-game-picoc-batch-E.md` §E22b + cross-link E22 (integration topology) + D20 (consent state) + A6 (touch targets).
