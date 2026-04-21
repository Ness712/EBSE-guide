# Phase 2 Synthesis — domaine `mobile-game-2d`

**Protocole** : methodology.md §2 (Kitchenham & Charters 2007) + Amendements G-1 (anti-biais), #3 (anchor), MG-1 à MG-9 (domain-specific)
**Domaine** : `mobile-game-2d`
**PICOCs** : 37 (3 pilote Phase 1.5 + 34 Phase 2)
**Pilot P** : solo indie + 2D pixel-art + portrait + offline-first + Android+iOS + ads+IAP+leaderboards + cross-platform

---

## Méthodologie de synthèse

1. **Double extraction A+B isolés** : kappa calculé par batch
2. **Arbitrage supervisor** sur divergences principielles via P-fit (solo indie + pixel-art portrait + offline-first)
3. **GRADE /7** par recommandation primaire : `Starting_score + large_effect + major_evidence − indirectness − inconsistency − bias − imprecision` (bonus `convergence` omis — single-model reviewers)
4. **Filter transverses** : chaque candidat scoré sur O1 "budget compliance" selon le niveau budget du pilot
5. **Anchor completeness** : toute recommandation rattachée ≥ 1 standard (ISO/IEC, SWEBOK, W3C, platform policies, OWASP)

---

## Transverses du pilot P (appliqués comme hard constraints)

| Transverse | Valeur | Impact sur SLR |
|------------|--------|----------------|
| budget | open-source (self-host OSS, SaaS exclu incl free tier) | O1 hard filter sur candidats |
| ai_agent | yes | domaine ai-collaboration activé (17 PICOCs hérités) |
| team_size | ebse-default | guide dérive solo optimal |
| scale | mvp | O-matrix priorise ship-fast + minimum service surface |
| data_residency | ebse-default | guide dérive EU (Hetzner DE / OVH FR) |
| platform | mobile (Android + iOS) | domain-specific |
| domain | mobile-game-2d | — |

**Services platform-mandatory** (acceptés dans tous niveaux budget car unavoidable) : Apple Developer, Google Play Console, Play Billing, StoreKit, AdMob, Play Vitals, Xcode Organizer, Apple Game Center, Google Play Games Services.

---

## Recommandations consolidées par batch

### Batch A — Framework & Architecture

| # | PICOC | Primary recommendation | GRADE | Tier |
|---|-------|------------------------|:-----:|------|
| A1 | Engine selection | **Godot 4** (GDScript + C# hot paths) | 2/7 | BONNE PRATIQUE |
| A4' | Simulation update (determinism) | **`_physics_process` 60Hz + seeded `RandomNumberGenerator` (PCG32) per-subsystem + record-input replay harness** | 4/7 | STANDARD |
| A6 | Touch input + a11y | Godot `InputEvent` + state machines custom (swipe/long-press/double-tap) + Control min-size 44 CSS px (WCAG 2.2 SC 2.5.5 AAA) + `DisplayServer.tts_speak` | 3/7 | RECOMMANDE |
| A7 | Offline-first persistence | **Platform-native saves (Play Games Saved Games + Apple iCloud Key-Value Store)** — zero backend at MVP ; OSS self-host backend (PocketBase ou Nakama) seulement si features au-delà de platform-native | 2/7 | BONNE PRATIQUE |
| A8 | Asset pipeline + bundle | Godot Lossy 2D import + build-time TextureAtlas + plain AAB (Android) / App-Sliced IPA (iOS) ; ASTC VRAM uniquement HUD/fonts persistants | 3/7 | RECOMMANDE |

### Batch B — Asset Pipeline Tooling

| # | PICOC | Primary | GRADE | Tier |
|---|-------|---------|:-----:|------|
| B7 | Tile-based level authoring | Godot TileMap + LDtk interchange (JSON) | 3/7 | RECOMMANDE |
| B8 | Font rendering (multi-script) | SDF (MSDF-gen) for scalable UI + bitmap for retro HUD + HarfBuzz via Godot TextServer pour Arabic/CJK/Indic | 3/7 | RECOMMANDE |
| B9 | Audio runtime | Godot built-in AudioStreamPlayer + AudioBus + AudioEffect | 2/7 | BONNE PRATIQUE |
| B10 | 2D animation authoring | Aseprite frame-by-frame + AnimationPlayer state machine dans Godot | 3/7 | RECOMMANDE |
| B11 | Pixel-art sprite authoring | **Aseprite** (commercial one-time, palette-indexed, `.aseprite` source + PNG+JSON sidecar) ; LibreSprite v1.1 ou Pixelorama si strict FOSS | 4/7 | STANDARD |

### Batch C — Persistence Residuals

| # | PICOC | Primary | GRADE | Tier |
|---|-------|---------|:-----:|------|
| C12 | Save serialization | JSON baseline (Godot native, human-diffable) | 2/7 | BONNE PRATIQUE |
| C13 | Lifecycle persistence scheduling | Event-driven + SQLite WAL + Godot `NOTIFICATION_APPLICATION_PAUSED` hook | 2/7 | BONNE PRATIQUE |
| C14 | Schema migration | Additive-only JSON + `save_version` field + stepwise manual migrations | 1/7 | ACCEPTABLE |
| C15 | Save integrity | Platform-native cloud saves (MVP) ; Keystore-HMAC (clé TEE/Secure Enclave) + server sign on sync + Play Integrity/App Attest UNIQUEMENT leaderboard submit + IAP verification (jamais per-save, quota 10k/day + caching discouraged) | 3/7 | RECOMMANDE |

### Batch D — Store Publishing

| # | PICOC | Primary | GRADE | Tier |
|---|-------|---------|:-----:|------|
| D17 | Publishing workflow | Fastlane + Play Console Internal → Beta → Production staged rollout 5→20→50→100% + crash-rate halt triggers | 3/7 | RECOMMANDE |
| D19 | Dynamic content delivery | Plain AAB/IPA (pixel-art <200MB fit) ; PAD/ODR seulement si assets >200MB (unlikely for indie) | 2/7 | BONNE PRATIQUE |
| D20 | Privacy manifest + data-safety | **Apple Privacy Manifest + Play Data Safety + UMP (GDPR consent) + ATT (iOS 14.5+)** — mandatory réglementaire | 4/7 | STANDARD |
| D21 | Launch surface | Android 12+ SplashScreen API + adaptive icons + iOS multi-variant assets + monochrome/themed icon support | 3/7 | RECOMMANDE |

### Batch E — Monetization

| # | PICOC | Primary | GRADE | Tier |
|---|-------|---------|:-----:|------|
| E22 | Ads architecture | AdMob single-SDK direct via godot-admob (bidding mediation post-scale uniquement) | 2/7 | BONNE PRATIQUE |
| E22b | Ad UX policy | Rewarded-opt-in primary + anchored adaptive banner + frequency cap ≥60s + no-interstitial-on-splash + WCAG 2.2 SC 2.5.8 target size | 3/7 | RECOMMANDE |
| E23 | IAP abstraction | **OpenIAP** (hyodotdev monorepo) — unified GDScript API Play Billing 8.x + StoreKit 2 | 2/7 | BONNE PRATIQUE |
| E24 | Monetization model (SE driver) | F2P + IAP (acres.md spécifie gemmes via pub ou achat ; Premium serait SE-strict dominant mais acres.md product concept F2P) | 3/7 | RECOMMANDE |
| E25 | Receipt validation | Platform-native Play Billing sandbox + StoreKit 2 local verify au MVP ; server-authoritative via OSS self-host backend quand backend disponible | 2/7 | BONNE PRATIQUE |

### Batch F — Social / Platform Services

| # | PICOC | Primary | GRADE | Tier |
|---|-------|---------|:-----:|------|
| F26 | Leaderboards + achievements | **Platform-native** : Google Play Games Services v2 + Apple Game Center (zero backend) | 2/7 | BONNE PRATIQUE |
| F28 | Player identity | Anonymous-first UUID local + Sign in with Apple (iOS mandatory si autre auth) + GPGS Sign-In (Android optionnel) | 3/7 | RECOMMANDE |
| F29 | Deep linking + attribution | Universal Links (iOS) + App Links (Android) + SKAdNetwork 4 / AdAttributionKit (iOS) + Play Install Referrer (Android) | 2/7 | BONNE PRATIQUE |

### Batch G — Localization

| # | PICOC | Primary | GRADE | Tier |
|---|-------|---------|:-----:|------|
| G30 | Localization workflow | gettext PO (Godot native) + XLIFF interchange + **Weblate self-host** + pseudo-localization CI | 3/7 | RECOMMANDE |
| G31 | RTL/BiDi layout | UAX #9 isolates (FSI/PDI) + logical start/end anchors + engine-level Godot `layout_direction` + per-sprite `rtl_policy` (mirror/preserve/replace) + first-strong auto on user inputs | 3/7 | RECOMMANDE |
| G32 | Message format + plurals | ICU MessageFormat 1 + gettext PO + CLDR 6 categories (zero/one/two/few/many/other) | 3/7 | RECOMMANDE |

### Batch H — Dev Tooling + Ops

| # | PICOC | Primary | GRADE | Tier |
|---|-------|---------|:-----:|------|
| H33 | CI/CD pipeline | **GitHub Actions workflow YAML + self-hosted runner** sur VPS (décomposition G-3.6) + Godot CLI headless export + Fastlane overlay ; alternative full-OSS : Forgejo Actions self-host | 1/7 | ACCEPTABLE |
| H34 | Device testing | Local Android Studio AVD + Xcode Simulator + Waydroid (optionnel) + TestFlight (platform-mandatory) + Play Internal Testing (platform-mandatory) + devices physiques | 2/7 | BONNE PRATIQUE |
| H35 | Crash reporting + ANR | Play Console Vitals + Xcode Organizer + MetricKit (platform-native) au MVP ; GlitchTip self-host quand backend OSS déployé | 2/7 | BONNE PRATIQUE |
| H36 | Engagement + retention + progression analytics | Play Console + App Store Connect dashboards (MVP) ; Plausible self-host OU custom `/events` endpoint quand backend OSS déployé | 2/7 | BONNE PRATIQUE |
| H37 | Remote config + feature flags | Hardcode + redéploie au MVP ; Unleash self-host OU static JSON + ETag sur VPS quand graduated rollout utile | 2/7 | BONNE PRATIQUE |

### Batch I — Quality

| # | PICOC | Primary | GRADE | Tier |
|---|-------|---------|:-----:|------|
| I37 | Test methodology | gdUnit4 unit + scene_runner integration + replay-based regression (release-candidate branches) + periodic playtesting (post-MVP) | 2/7 | BONNE PRATIQUE |
| I39 | Game accessibility | Pixel-art palette-swap colorblind modes + GAG Basic all 5 categories + OS-bridged (prefers-reduced-motion) | 3/7 | RECOMMANDE |

### Batch J — AI Collaboration Inheritance

| # | PICOC | Primary | GRADE | Tier |
|---|-------|---------|:-----:|------|
| J43 | AI asset perceptual gate | Composed gate : palette-lock + atlas-UV schema + pHash golden-image + audio fingerprint + threshold human spot-check + provenance manifest (NIST AI 600-1 + ISO 42001) | 1/7 | INFORMATIONNEL |

---

## Stack consolidé — `godot-mobile-game-2d`

### Client

- **Engine** : Godot 4 (GDScript primary, C# for hot paths)
- **Game loop** : fixed-timestep `_physics_process` 60Hz + seeded RNG per-subsystem
- **Input** : `InputEvent` + state machines custom + 44 CSS px min-size
- **Renderer** : 2D CanvasItem + MSDF fonts + HarfBuzz TextServer
- **Asset authoring** : Aseprite (pixel-art) + LDtk (levels) + Audacity (audio)

### Platform-native services (MVP, zero backend)

- **Saves cross-device** : Google Play Games Saved Games + Apple iCloud Key-Value Store
- **Leaderboards** : Google Play Games Services v2 + Apple Game Center
- **Crashes** : Play Console Vitals + Xcode Organizer + MetricKit
- **IAP** : Play Billing 8.x + StoreKit 2 via OpenIAP plugin
- **Ads** : AdMob via godot-admob plugin
- **Auth** : Sign in with Apple (iOS mandatory) + GPGS Sign-In (Android)

### Build & ship

- **CI/CD** : GitHub Actions YAML + self-hosted runner + Godot CLI headless + Fastlane overlay
- **Device testing** : local emulators + TestFlight + Play Internal Testing
- **Publishing** : Fastlane staged rollout 5→20→50→100% + crash-rate halt

### Quality

- **Testing** : gdUnit4 unit + scene_runner integration + replay-based regression
- **Localization** : gettext PO + XLIFF + Weblate self-host
- **Accessibility** : palette-swap colorblind + GAG Basic + OS-bridged

### Compliance

- **Privacy** : Apple Privacy Manifest + Play Data Safety + UMP + ATT
- **Launch surface** : Android 12+ SplashScreen + adaptive/themed icons + iOS multi-variant

### Optional (deferred to when backend OSS déployé)

- **Crash reporting SDK** : GlitchTip self-host (Sentry SDK compat) via sentry-godot DSN
- **Analytics** : Plausible self-host OU custom `/events` endpoint
- **Feature flags** : Unleash self-host
- **Backend custom** (si features au-delà platform-native) : PocketBase OU Nakama OSS self-host

---

## Qualités architecturales (ISO 25010:2023)

- **Functional suitability** : 37 PICOCs couvertes, chaque primary traceable à ≥ 1 anchor
- **Performance efficiency** : Godot fixed-timestep + ASTC + AAB
- **Compatibility** : XLIFF + gettext PO + JSON portabilité
- **Interaction capability** : GAG Basic + WCAG 2.2 SC 2.5.5 + Apple HIG 44pt
- **Reliability** : offline-first platform-native + replay-based regression
- **Security** : Keystore-HMAC + server-authoritative IAP + MASVS-CRYPTO compliance
- **Maintainability** : MIT engine + Foundation governance + XLIFF + gettext PO
- **Portability** : Godot multi-export + ICU MessageFormat

## Contraintes VSE (ISO 29110-4-3) respectées

- Solo indie effort budget : Zero mandatory SaaS, zero recurring vendor lock-in
- V&V time budget : I37 budget-proportional mix + J43 minimal gate tiered
- Privacy Manifest footprint : E22 single-SDK + E23 OpenIAP = minimal
