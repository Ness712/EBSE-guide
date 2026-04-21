# Phase 1.3 Batch C — PICOCs : Persistence Residuals (domaine `mobile-game-2d`)

**Protocole** : methodology.md v3.0 §1.3 + Amendement G-1 + Amendement #3
**Date** : 2026-04-21
**Methode** : double extraction + reconciliation
**Tracability** :
- Reviewer A : agent `aebc0830ebff7a152`
- Reviewer B : agent `a79b75cc9bd59dd35`

## Cadre upstream

**A7** (Batch A) couvre l'**architecture de persistance** : storage engines (file/SQLite/KV/document) + sync strategies (LWW/version-vector/CRDT/server-arbitrated) + cloud backends (platform-native/third-party) + outcomes (latency, conflict correctness, footprint, IAP restoration, OS-kill integrity).

**Batch C** doit isoler les decisions **orthogonales a A7** : ce qui n'est pas dans A7.I (classes) ni A7.O (outcomes).

## Decisions candidates initiales (commissioning §1.2 Categorie C)

- C12. Save file format (JSON / binary / protobuf / custom)
- C13. Local storage engine (SQLite / KV / flat file / embedded DB)
- C14. Save-on-interrupt strategy
- C15. Cloud save backend
- C16. Save migration strategy

## Reconciliation A vs B

| # initial | Decision | Verdict A | Verdict B | Accord | Reconciliation |
|-----------|----------|-----------|-----------|:------:|----------------|
| C12 | Save format | RETAIN | RETAIN | V | RETAIN → PICOC C12 |
| C13 | Storage engine | ABSORB A7 | ABSORB A7 | V | ABSORBED |
| C14 | Save-on-interrupt | ABSORB A7 | RETAIN (orthogonal) | X | RETAIN → PICOC C13 (**B wins**) |
| C15 | Cloud backend | ABSORB A7 | ABSORB A7 | V | ABSORBED |
| C16 | Schema migration | RETAIN | RETAIN | V | RETAIN → PICOC C14 |
| (new) | Save integrity | RETAIN (proposed) | FLAG as gap | PARTIAL V | RETAIN → PICOC C15 (convergence implicite) |

**Kappa brut sur candidats initiaux : 4/5 = 80%** ("good/substantial", > 0.6 threshold).

**Arbitrage DIV-C14 (save-on-interrupt)** :
- Position A : "A7 outcome 'save integrity under OS kill' couvre — les strategies = mechanisms inside A7 comparator space"
- Position B : "A7.I enumere storage engines + sync strategies, mais PAS la scheduling policy (autosave cadence, event-driven flush, continuous journaling, lifecycle-hook-driven). Ces strategies sont orthogonales aux storage engines."

**Arbitrage** : **Position B retenue**. Relecture de A7.I confirme : ne mentionne PAS la scheduling/triggering policy. Le *quand* on ecrit (vs le *ou* on ecrit / *comment* on sync) est un axe distinct. La confusion A vient de ce que A7 a pour outcome "save integrity under OS kill" — mais cet outcome est la consequence de ce mechanism (policy de scheduling), pas son remplacement. Kitchenham §5.3 dit explicitement de ne PAS confondre outcome et mechanism dans un PICOC.

**Arbitrage save integrity (hors liste initiale)** :
- A propose explicitement comme PICOC C3 (leaderboard integrity + IAP entitlement tamper-resistance)
- B flag comme gap dans open questions ("should be commissioned") mais ne committe pas de PICOC

Les deux convergent sur l'importance + l'orthogonalite vs A7. **RETAIN comme PICOC C15**.

## PICOCs retenus - Batch C final

### PICOC #C12 — Serialization format of persisted game state

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo produisant un jeu mobile 2D pixel-art portrait offline-first (avec cloud save optionnel), Android+iOS stores, ads+IAP+leaderboards, persistant gameplay state (player progression, inventory, meta-currency, settings, IAP entitlement cache) dans le storage substrate choisi en A7. |
| **I** | Classe des **formats de serialisation** des structures d'etat de jeu vers un flux d'octets persistable : (a) formats texte lisibles auto-decrivants (JSON, XML, YAML) ; (b) formats binaires a schema partage compile (Protocol Buffers, FlatBuffers, Cap'n Proto) ; (c) formats binaires schemaless (BSON, CBOR, MessagePack schemaless) ; (d) custom packed binary (hand-rolled struct layouts, engine-native BinaryWriter). Axes : build-time schema vs runtime-tolerant ; self-describing vs schema-external ; human-debuggable vs compact. |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : serialization benchmark repos GitHub, mobile platform serialization benchmarks Android/iOS, schema-evolution literature ACM DL, indie dev postmortems save corruption). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables** : (a) cold-start save-load latency P95 sur low-end device (ms) ; (b) on-disk save size (bytes pour payload representatif 500 KB) ; (c) forward/backward schema compatibility defect rate per app version (count) ; (d) memory allocation pressure lors serialization (GC spikes Android / autorelease churn iOS) ; (e) cloud-save quota fit (Play Saved Games 3 MB / iCloud per-key limits) ; (f) human-readability for support/debug workflows (solo-indie relevant : time-to-diagnose user-submitted corrupted save, minutes). **User-facing** : (g) perceived app launch smoothness (cold start < 3 s target) ; (h) support turnaround apres corrupted save report (days). |
| **Co** | Solo indie, QA bandwidth minimale ; target device floor = 2 GB-RAM Android entry-level ; monthly content patches (cadence typique live indie 2D) ; users reporting corrupted saves via email — dev must debug from user-mailed file ; A7 storage engine choisi (influence format choices mais n'impose pas). |
| **Question** | "Pour un dev indie solo mobile 2D pixel-art avec persistance offline-first et content patches frequents, **quelle classe de format de serialisation** (texte self-describing / binaire schema-driven / binaire schemaless / custom packed) optimise le compromis cold-start load latency + forward/backward compat + storage footprint vs cloud quotas + debuggability support, dans les contraintes du storage engine A7 ?" |
| **Anchor** | **SWEBOK v4** : KA2 Design (data design, information representation), KA12 Software Quality (Maintainability via debuggability). **ISO/IEC 25010:2023** : Performance Efficiency (time behaviour load, resource utilization memory), Compatibility (co-existence cross app versions), Maintainability (Analysability — debuggability). **ISO/IEC 29110-4-3** : VSE profile (solo dev support constraints). |
| **Dependances** | **Strong dep A7** (storage engine). **Medium dep C14 schema migration** (format and migration strategy co-design). |

---

### PICOC #C13 — Lifecycle-triggered persistence scheduling

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo produisant un jeu mobile 2D Android+iOS ou l'OS peut suspendre/background/terminate l'app avec preavis borne (onPause/onStop, applicationWillResignActive/DidEnterBackground, low-memory kill, thermal kill, user task-switch, force-stop), et ou la session incarne du progres douloureux a perdre (farming-sim progression plusieurs heures). |
| **I** | Classe des **strategies de declenchement d'ecriture persistante** : (a) event-driven autosave (on checkpoint, on room transition, on shop close) ; (b) time-driven autosave (fixed interval ticks, e.g. every 60 s) ; (c) continuous journaling / write-ahead log (append-only delta stream flushed opportunistically) ; (d) lifecycle-hook-driven flush (on backgrounding callback within OS grace window) ; (e) hybrid policies. Axes : trigger type (event vs time vs lifecycle) ; durability guarantee (immediate fsync vs buffered) ; grace-window usage (Android/iOS background task budgets). |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : mobile platform lifecycle docs Android Doze / iOS background-task, game dev postmortems sur save-loss, indie forum discussions autosave cadence, ACM mobile computing papers sur persistence-under-interrupt, engine-specific autosave patterns). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables** : (a) progress loss en secondes de gameplay apres forced OS kill (low-memory, thermal, user swipe-away) ; (b) frame-time disruption jank introduit par save operations pendant gameplay actif (P99 frame-time delta ms) ; (c) battery drain attributable to persistence (mAh / heure de play) ; (d) write amplification / flash wear (bytes ecrits par minute de play) ; (e) save-corruption incidence quand interrupt arrive mid-write (% corrupted saves sur N=1000 forced kills at random timings) ; (f) background-task grace window usage (% utilise vs OS budget). **User-facing** : (g) perceived save reliability (no "progress lost" 1-star reviews) ; (h) perceived frame smoothness during save operations ; (i) perceived battery drain. |
| **Co** | Offline-first avec cloud sync optionnel ; portrait 2D pixel-art ; Android + iOS lifecycles differ : Android Doze + Background Execution Limits vs iOS backgroundTask budgets ; device population low-end → flagship ; A7 storage engine choisi (influence granularite du save). |
| **Question** | "Pour un jeu mobile 2D indie solo Android+iOS soumis au lifecycle hostile (OS kill possible a tout moment), **quelle classe de strategie de declenchement d'ecriture persistante** (event-driven / time-driven / continuous journaling / lifecycle-hook-driven / hybrid) minimise progress loss apres OS kill + jank during save + battery drain + flash wear + corruption mid-write ?" |
| **Anchor** | **SWEBOK v4** : KA2 Design (persistence mechanisms), KA3 Design (concurrency and interrupt handling), KA12 Software Quality (reliability). **ISO/IEC 25010:2023** : Reliability (Fault tolerance OS kill, Recoverability), Performance Efficiency (Time behaviour save-time, Resource utilization battery). **Apple App Store Review Guidelines** : background-task completion windows. **Google Play Policies** : background execution, battery. **Apple HIG** : Handling Interruptions. |
| **Dependances** | **Strong dep A7** (storage engine dictates save granularity — SQLite WAL vs full file rewrite). **Medium dep C12** (format speed affects max autosave frequency feasible). |

---

### PICOC #C14 — Schema migration strategy across game versions

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo shippant iterative content updates through Google Play + Apple App Store a une installed user base dont les local save files ont ete produits par des prior binaries, **y compris users qui skip des versions** (v1.0 → v1.5 jump apres long dormancy, apres 4+ intermediate releases non vues). Long-tail users sur outdated versions (iOS users may skip updates months ; Android auto-update mais fragmented OS versions). |
| **I** | Classe des **strategies de migration du schema save** : (a) additive-only schema evolution (new optional fields, tolerated unknowns) ; (b) lazy on-load migration (versioned reader chain applied when old save opens, e.g. v1→v2→v3→v4) ; (c) eager batch migration (one-shot rewrite on first launch of new version) ; (d) versioned parallel readers (retain readers for all historical versions in shipped binary) ; (e) event-sourcing / command log rejouable ; (f) no-migration / reset-and-reward policies. Axes : temporal distribution (sync A7 is spatial device-device ; migration is temporal v1-v5) ; migration locus (on-load vs eager) ; legacy-reader retention strategy. |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : schema evolution literature ACM DL + OOPSLA, database migration pattern books (Fowler, Ambler), GitHub topics `schema-migration`/`save-migration`, indie game postmortems save-loss incidents, Apple + Google platform guidance on data compatibility). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables** : (a) user-facing progress preservation rate cross version jumps (% users whose save loads successfully post-update) ; (b) first-launch latency post-update binary (migration cost visible to user, ms) ; (c) migration-related crash rate (Crashlytics / Play Vitals, crashes / 1000 sessions) ; (d) support-ticket volume attributable to migration (count / release) ; (e) storage overhead legacy readers in shipped binary (MB bloat) ; (f) dev effort per schema change (person-hours per migration) ; (g) IAP entitlement + purchased-content integrity cross migrations (% preserved). **User-facing** : (h) absence of "lost progress after update" reviews (count / 1000 downloads) ; (i) release cadence achievability (releases / month). |
| **Co** | Solo indie sans dedicated QA ; aggressive release cadence (monthly content updates) ; multi-year title lifecycle ; heterogeneous user devices + OS versions ; leaderboard continuity requirement (migration must NOT invalidate legitimately earned scores) ; IAP entitlement preservation cross migrations CRITICAL (store policy + revenue). |
| **Question** | "Pour un dev indie solo shippant iterative updates a un jeu mobile 2D avec offline-first persistence, **quelle classe de strategie de migration schema save** (additive-only / lazy on-load / eager batch / versioned parallel readers / event-sourcing / reset-and-reward) minimise post-update crash rate + user progress loss + support tickets cross arbitrary skipped-version upgrade paths, tout en gardant migration effort tractable pour single dev et binary bloat acceptable ?" |
| **Anchor** | **SWEBOK v4** : KA7 Software Maintenance (software evolution, impact analysis, data migration), KA8 Configuration Management (version control of data schemas), KA9 SE Management (release process solo dev). **ISO/IEC 25010:2023** : Maintainability (Modifiability — schema evolvability), Reliability (Recoverability under migration failure), Compatibility (co-existence across app versions through user data). **ISO/IEC 29110-4-3** : VSE change management practices. |
| **Dependances** | **Strong dep C12** (format determines migration options — protobuf has schema evolution built-in vs custom binary needs manual versioning). **Medium dep A7** (cloud sync interacts : migration in-progress across devices can cause temporary inconsistency). **Outcome cross-link** (g) with A7 outcome "IAP entitlement restoration". |

---

### PICOC #C15 — Save integrity protection (encryption & tamper detection)

| Element | Valeur |
|---------|--------|
| **P** | Dev indie solo mobile 2D pixel-art Android+iOS avec **leaderboards** (Google Play Games Services, Apple Game Center) et **IAP entitlement state cached localement** pour offline-first play, ou leaderboard submissions + IAP grants dependent de values read from local persistence sur **untrusted end-user devices** (rooted/jailbroken, USB debugging sandbox access, community-shared save-edit tools). Threat model dominated by casual hex-edit griefers + community save-editors, NOT nation-state adversaries. |
| **I** | Classe des **mecanismes protection integrite + confidentialite saves locales** : (a) absence de protection (plain, default baseline) ; (b) integrite par signature/HMAC avec cle embarquee (client-side key, obfuscation only) ; (c) integrite par signature serveur (server holds signing key) ; (d) chiffrement symetrique cle derivee localement (key from device identifiers or user PIN) ; (e) chiffrement cle gardee par plateforme (Android Keystore / iOS Keychain hardware-backed) ; (f) attestation d'integrite serveur avant acceptance scores/achievements (Play Integrity API / App Attest). Axes : trust boundary (client-only / server-arbitrated / hardware-attested) ; threat model severity coverage ; dev complexity. |
| **C** | À découvrir systématiquement en Phase 2.1 (recherche : OWASP MASVS mobile anti-tamper sections, Google Play Integrity API docs, Apple App Attest + DeviceCheck docs, ACM mobile security papers, game dev anti-cheat postmortems, leaderboard cheating research). **Pre-identification prohibée per Amendement G-1.** |
| **O** | **Mesurables** : (a) leaderboard cheating incidence (fraction top-N scores rejected or flagged as suspicious, % of submissions) ; (b) IAP entitlement fraud rate via save-edit (fraud cases detected / 1000 users) ; (c) performance overhead integrity checks au save/load (ms on low-end device) ; (d) implementation complexity solo indie (LOC + integration effort hours) ; (e) false-positive rate (legitimate users flagged as cheaters, % - CRITICAL pour ne pas pisser off honest users) ; (f) dev effort to respond a new save-edit tool community-shared (hours). **User-facing** : (g) perceived competitive fairness leaderboards (user sentiment score / reviews) ; (h) revenue integrity (honest-user LTV preservation) ; (i) IAP restoration success rate (integrite ne break pas restore flow). |
| **Co** | Solo indie NO dedicated security engineer ; Google Play Games Services anti-abuse policy + Apple Game Center guidelines ; Apple ASRG §3.1.1 Restore Purchases + §3.1 IAP integrity ; Google Play Billing + Data Safety declarations ; threat model = casual griefers NOT determined adversary ; MUST NOT break honest-user IAP restore flow. |
| **Question** | "Pour un jeu mobile 2D indie solo avec leaderboards + IAP-gated content Android+iOS, **quelle classe de save integrity protection mechanism** (plain / client-HMAC / server-signature / local-key encryption / platform-key encryption / server attestation) minimise leaderboard cheating + IAP entitlement fraud tout en gardant save/load overhead imperceptible sur low-end + implementation effort tractable pour solo dev + false-positive rate sur honest users acceptable ?" |
| **Anchor** | **SWEBOK v4** : KA13 Software Security (cryptographic mechanisms, threat modeling, secure storage), KA14 Professional Practice (compliance with platform policies), KA16 Computing Foundations (cryptography). **ISO/IEC 25010:2023** : Security (Confidentiality, Integrity of save data, Accountability, Authenticity, Resistance). **ISO/IEC 25019** : Quality-in-Use (Trust, Freedom from risk). **Apple App Store Review Guidelines** : §3.1.1 Restore Purchases, §3.1 IAP integrity, §5.2 (cheating). **Google Play Developer Program Policy** : Cheating/Anti-Abuse, Data Safety declarations. **OWASP MASVS** : V8 (Resilience) anti-tamper controls. |
| **Dependances** | **Orthogonal to A7** (sync strategies don't address tamper-resistance). **Strong cross-link Batch F** (leaderboard architecture) + **Batch E** (IAP validation server-side vs client). |

**Note open-question B (reconcilie)** : B a flag "B batch may have IAP-entitlement PICOC" — oui, Batch E traitera IAP validation server-side (focus = receipt validation + fraud). C15 narrows IAP framing a "cached entitlement for offline play between server validations" — **cross-reference** a etablir en Phase 1.3 consolidation.

---

## Decisions dropped / absorbed

| Decision | Action | Justification | Redirection |
|----------|--------|---------------|-------------|
| C13 Local storage engine | ABSORBED A7 | A7.I enumere explicitement "local file-based saves, embedded relational stores, embedded key-value stores, document-oriented local stores" | — |
| C15-original Cloud save backend | ABSORBED A7 | A7.I enumere "backends cloud platform-native ou third-party" | — |
| Server-side anti-cheat architectures (beyond save integrity) | OUT OF SCOPE | Pour real-time validation, shadow simulation, server-authoritative gameplay — appartient a PICOC networking/online-services (non-commissioned actuellement) | — |
| GDPR/CCPA data-subject handling saved data | OUT OF SCOPE | Privacy-by-design PII = legal compliance, distinct axis. Sera couvert si Privacy batch future. | — |
| Multi-profile / family sharing single device | OUT OF SCOPE | Niche pour indie 2D ; broaden P si needed | — |
| Server-side analytics/telemetry persistence | OUT OF SCOPE | Appartient a Batch H (dev tooling / observability) | Batch H |
| Asset caching / hot-patching content bundles | OUT OF SCOPE | Appartient a A8 (asset pipeline) ou future content-delivery batch | A8 |

## Open questions pour Phase 1.5 + cross-batch

### Cross-batch interactions

1. **C15 IAP framing** : clarifier avec Batch E que **C15 couvre uniquement cached entitlement offline-play integrity** ; la server-side receipt validation canonical sera dans PICOC Batch E dediee IAP.
2. **C15 leaderboard integrity** : la server-side score validation (anti-cheat architecture) sera dans **Batch F** PICOC leaderboard. C15 couvre uniquement **client-side tamper resistance** du save blob avant submission.
3. **C14 vs A7 LWW interaction** : si deux devices appliquent migrations a different times puis sync, schema-migration correctness et sync conflict resolution interagissent. Flag extraction-time : studies reporting cloud-sync avec schema evolution doivent etre tagges specifiquement.
4. **C12 vs A7 latency confound** : save/load latency est shared outcome A7 (storage engine axis) + C12 (format axis). Phase 2.1 extraction doit tagger studies par axis varied (storage fixed + format varied ; format fixed + storage varied ; both varied = confound note).

### Questions Agent C Phase 1.5

5. Verifier : **Google Play Saved Games 3 MB limit** toujours en vigueur 2026.
6. Verifier : **iCloud per-key limit** pour Game Center save data.
7. Verifier : **Apple App Attest API** existe + scope (C15 anchor).
8. Verifier : **Google Play Integrity API** replacement for deprecated SafetyNet Attestation.
9. Verifier : **OWASP MASVS V8 Resilience** section existence.
10. Verifier : **ISO/IEC 25010:2023 "Resistance"** sub-characteristic (nouveau 2023) — correct reference.

### Questions Phase 2.1 extraction

11. Phase 2.1 pour C12 : chercher **serialization benchmarks mobile-specific** (pas juste JVM/Node benchmarks).
12. Phase 2.1 pour C13 : chercher **autosave cadence empirical studies** (% progress loss par strategy).
13. Phase 2.1 pour C14 : chercher **additive schema tolerance** real-world failure modes (ex: user deleted mandatory field).
14. Phase 2.1 pour C15 : chercher **false-positive rate studies** anti-cheat mobile (honest-user rejection).

## Statut Batch C

- **4 PICOCs retenues** : C12, C13, C14, C15
- **Kappa brut** : 4/5 = 80% ("good") — au-dessus du seuil 0.6
- **1 ajout hors-liste** : C15 save integrity (convergence implicite A+B)
- **Absorption par A7 confirme pour 2 candidats** : C13, C15-original
- **Cross-batch dependencies** : Batch E (IAP), Batch F (leaderboard), Batch H (observability)

**APPROVED pour Phase 1.3 Batch D (store publishing).**
