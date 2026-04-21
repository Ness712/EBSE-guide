# Phase 1.4 — Protocol Amendments : domaine `mobile-game-2d`

**Protocole de base** : `methodology.md` v3.0 (Kitchenham & Charters 2007, EBSE-2007-01) + global amendment G-1 (methodology-global-amendments.md)
**Date** : 2026-04-21
**Domaine couvert** : `mobile-game-2d`

## Heritage

Le protocole de base `methodology.md` v3.0 s'applique integralement au domaine `mobile-game-2d` sans modification substantielle. Les 13 etapes Kitchenham (3 phases Planning / Conducting / Reporting) sont executees telles quelles.

**Amendements globaux herites** :
- **G-1** (2026-04-21) : Correction du biais d'ancrage dans la table §1.2 "Scope et plateformes". S'applique integralement a tous les PICOCs du present domaine (C = à découvrir, zero pre-identification).

**Amendements `ai-collaboration` herites** :
- **#1** — Corpus fixe a l'avance pour reviewers (Phase 1.2+). S'applique au domaine : Phase 1.2 scope commissioning a utilise corpus fixe (ISO 25010/25019, SWEBOK v4, Apple ASRG, Google Play Policy, etc.).
- **#2** — Agent C verifie les fabrications tool/reference par defaut. S'applique : Phase 1.5 Agent C verification checklist inclut verification de tools/SDKs cites dans les PICOCs + ISO clause numbers + platform policy URLs.
- **#3** — Format PICOC avec anchor Phase 1.2. S'applique : 37 PICOCs du domaine ont tous un Anchor field explicite (SWEBOK KA + ISO standards + platform policies).
- **#4** — Citations academiques au-dela de la pyramide standard. S'applique : Game Accessibility Guidelines (community-maintained) acceptee comme grey-literature anchor pour I39 avec flag.

## Amendements specifiques `mobile-game-2d`

### Amendement MG-1 — Grey-literature anchor acceptation (Game Accessibility Guidelines)

- **Protocole original** (methodology.md §2.3) : pyramide de preuves prescrit niveau 1-5 (Standards → Consortia → Official docs → Surveys → Expert consensus). Niveau 6 (blog individuel, tutoriel) NON UTILISE.
- **Observation** : **Game Accessibility Guidelines** (gameaccessibilityguidelines.com) est une ressource **community-maintained** (pas formal standard ISO/W3C) mais **widely cited in practice** + **only comprehensive game-specific accessibility framework** existing. Ni community review ni formal peer-review mais operationally canonical dans l'industry (cited by Xbox Accessibility Team, IGDA Game Accessibility SIG, academic papers).
- **Amendement** : autoriser **Game Accessibility Guidelines comme anchor de niveau 5** (convergence d'experts reconnus) pour PICOC I39 (game-specific accessibility), avec flag explicite "grey-literature anchor" dans GRADE computation. Risque de biais (section 2.3) a evaluer normalement ; facteur -1 possible pour absence de formal peer review.
- **Scope** : s'applique uniquement a I39. Les autres PICOCs du domaine utilisent les anchors standard (ISO, W3C, SWEBOK, platform policies, ICU, CLDR, Unicode UAX, OWASP MASVS).
- **Validation** : applicable en Phase 2.1 extraction. Si Phase 2 discovery surface une formal standardization effort (ex: draft ISO accessibility for games), upgrader l'anchor niveau.

### Amendement MG-2 — Heterogeneous Phase 2.1 literature bases (indie scale vs AAA)

- **Protocole original** (methodology.md §2.1) : recherche Phase 2.1 dans bases academiques + surveys + docs officielles.
- **Observation** : literature mobile game dev est fortement skewed vers AAA/industrial-scale studies (Chueca et al. 2024 explicitly restricts to industry-scale + excludes indie). Solo-indie 2D pixel-art P is under-represented dans academic literature + over-represented dans grey-literature (postmortems, GDC Vault, itch.io community, IGDA blogs, indie developer interviews).
- **Amendement** : accepter **indie-scale grey-literature** (indie game postmortems published on canonical venues : GDC Vault talks + indie dev blogs cited by peers + itch.io community resources + IGDA resources) comme niveau 5 anchor, avec conditions :
  1. Source has named author + organizational attribution
  2. Source is cited by ≥ 2 independent sources (triangulation requirement)
  3. Source discloses conflict of interest (e.g., engine vendor affiliation)
  4. Risk of bias evaluation (section 2.3) applied : publication bias (positive outcomes only) + selection bias (successful titles only)
- **Scope** : s'applique aux Phase 2.1 extractions pour TOUS les PICOCs mobile-game-2d (explicit population is solo indie).
- **Impact GRADE** : grey-literature anchors cumulatif avec peer-reviewed + standards contribue au score ; convergence requirement unchanged (2+ independent sources pour +1 convergence factor).

### Amendement MG-3 — Game-specific KPIs not in ISO 25010

- **Protocole original** (methodology.md §1.2) : anchors principaux ISO 25010:2023 (9 characteristics + ~40 sub-characteristics).
- **Observation** : certains outcomes-KPI utilises dans PICOCs mobile-game-2d N'ONT PAS DE MAPPING DIRECT a ISO 25010 :
  - Retention cohorts (D1 / D7 / D30 retention rates) → game-specific engagement metric
  - Crash-free user rate Play Vitals threshold 1.09% → specific platform threshold
  - ANR rate Play Vitals 0.47% → specific platform threshold
  - Input-to-photon latency → game-specific perceptual metric
  - Leaderboard cheating incidence → game-specific security metric
  - Game Accessibility Guidelines conformance count → game-specific
- **Amendement** : ces game-specific KPIs sont acceptes comme **domain-specific outcomes justified by mobile-game-2d P**, NOT forced-fit into ISO 25010 categories. Cross-mapping ISO 25019 (Quality in Use — effectiveness, engagement, satisfaction) est prefere quand possible.
- **Scope** : tous PICOCs mobile-game-2d.
- **Validation** : applicable en Phase 2 extraction. Phase 2.1 scope a flagger quand outcome metric used is game-specific (pas ISO 25010/25019 direct).

### Amendement MG-4 — EAA 2025 regulatory inflection within review horizon

- **Protocole original** (methodology.md §2.3) : sources doivent etre datees de moins de 5 ans OU etre standards toujours en vigueur.
- **Observation** : **European Accessibility Act (EAA 2025)** Directive (EU) 2019/882, **enforcement 28 June 2025**, applies to mobile games distributed in EU market. Current date 2026-04-21 → EAA active for ~10 months. Literature post-EAA-2025 still accumulating.
- **Amendement** : pour PICOC I39 (game accessibility), Phase 2.1 extraction doit tagger chaque source par "pre-EAA-2025 / post-EAA-2025 / EAA-agnostic". Pre-EAA-2025 sources conservees pour historical context mais GRADE facteur temporel applique si la source ne reflete pas la regulation post-June-2025.
- **Scope** : I39 specifically. Other PICOCs not affected.

### Amendement MG-5 — Post-Firebase Dynamic Links deprecation unstable literature

- **Protocole original** (methodology.md §2.3) : sources obsoletes (>3 ans pour adoption/satisfaction data) exclues via E2.
- **Observation** : **Firebase Dynamic Links deprecated August 2025**. Literature on deep-link attribution 2019-2025 largely describes DDL-era practices. Replacement approaches (Universal Links + App Links + third-party SaaS + SKAdNetwork/AdAttributionKit) documentation accumulating but literature-base unstable.
- **Amendement** : pour PICOC F29 (deep linking + attribution), Phase 2.1 extraction tag EACH source "pre-DDL-deprecation / post-DDL-deprecation / DDL-agnostic". GRADE facteur temporel (-1 obsolescence) applied to pre-DDL sources when study claims rely on DDL availability. **Expected** : Phase 2.1 may return inconclusive for F29 if post-DDL literature insufficient. Documenter comme Phase 2.1 limit.
- **Scope** : F29 specifically.

### Amendement MG-6 — Cross-batch extraction tagging requirement

- **Protocole original** (methodology.md §2.4) : formulaire d'extraction standardise par PICOC.
- **Observation** : 37 PICOCs mobile-game-2d ont **dense cross-batch dependencies** documentees (cf. mobile-game-picoc.md dependency graph). Certaines primary studies address end-to-end concerns spanning multiple PICOCs (ex: "end-to-end indie mobile game shipping pipeline" touches H33 + D17 + D19 + D20 + D21 + H34).
- **Amendement** : formulaire d'extraction inclut **cross-PICOC tagging field obligatoire** : chaque source extractee doit etre tagged par primary PICOC + secondary PICOCs (avec scope split per PICOC). Anti-double-counting rule : le meme DATUM (concrete claim/metric) ne peut contribuer qu'a une seule PICOC ; seules les CITATIONS sont partagees cross-PICOC.
- **Scope** : tous PICOCs mobile-game-2d.

### Amendement MG-7 — A1 extraction form enrichment (post-I38 absorption)

- **Observation** : I38 "Performance budget" absorbed into A1 per Phase 1.3 Batch I reconciliation. Thin residuels (thermal throttling governance, CI perf regression gates, RUM post-launch perf monitoring) cannot sustain independent PICOC but must not be lost.
- **Amendement** : A1 extraction form enriched avec explicit sub-findings slots :
  - Sub-finding A1.thermal : thermal throttling onset + governance behavior per engine candidate
  - Sub-finding A1.perf-regression : CI perf regression gate effectiveness (cross-reference H33)
  - Sub-finding A1.RUM-monitoring : post-launch performance monitoring approach (cross-reference H36)
- **Scope** : A1 only.

### Amendement MG-8 — A1 extraction form enrichment (post-H38 absorption)

- **Observation** : H38 "Hot reload / live code" absorbed into A1 per Phase 1.3 Batch H reconciliation.
- **Amendement** : A1 extraction form enriched avec explicit sub-finding :
  - Sub-finding A1.hot-reload : hot-reload + live-code patching availability + state preservation semantics per engine candidate
- **Scope** : A1 only.

### Amendement MG-9 — Phase 1.5a peer review response (modifications appliquees)

- **Source** : Peer review independent Phase 1.5a (agent `a763601a65fc03363`) — APPROVE WITH MODIFICATIONS, 10 modifications requises.
- **Date** : 2026-04-21

**Modifications critiques appliquees** :

1. **J43 C-field class enumeration** : Peer reviewer a detecte edge-case G-1 dans J43 (C field pre-enumere 4 comparison classes C1-C4). **Resolution** : les comparison classes sont **archetypes architecturaux** qui emergent de l'intervention taxonomy (pas de pre-identification de tools concrets). Clarification G-1 : *G-1 prohibits concrete tool pre-identification (e.g., "Unity vs Godot vs Flutter") ; enumerating architectural classes or comparison archetypes that emerge from I's taxonomy is permitted when they serve to contextualize the comparison landscape without naming specific products*. Scope clarifie dans MG-9 (present amendement). J43 wording acceptable as-is sous clarifie scope.

2. **ISO 25010 Safety sub-characteristic coverage gap** : Peer reviewer note que Phase 1.2 scope listait "Sa Operational constraint | KA14 + KA12 | Dark patterns, addiction risk, loot box regulation" mais aucun PICOC ne l'operationnalise explicitement. **Resolution** : partially covered via E22b (ad UX disruption risk + intrusiveness) + E24 (monetization model SE driver includes freedom-from-risk considerations). **Action cross-reference** : E22b et E24 extraction forms enrichis pour tagger explicitement Safety/Operational-constraint outcomes (dark-pattern avoidance, addiction-risk mitigation, loot-box regulatory compliance — notably Belgium 2018 + Netherlands 2018 + China 2019 loot-box regulations applicable selon distribution). No new PICOC added.

3. **KA15 SE Economics gap** : Peer reviewer note l'absence d'anchor KA15 explicit. **Resolution** : anchor **E24 aussi sur KA15** (monetization model choice has economics implications — tool-stack TCO indirectly via SDK footprint, ongoing-ops burden). Pas de nouveau PICOC dev-side cost-governance (risk of scope explosion). Dev-side costs (CI minutes, crash-reporting seats, BaaS per-MAU) restent implicit outcomes dans H33 (ops cost) + H35/H36 (SaaS tier costs) + H37 (experimentation SaaS cost) + E24 (SDK stack cost). Cross-references documented.

4. **Index graph A4'/J43 overstated coupling** : J43 scope dit explicitly que A4' determinism verification est ABSORBED into A4' + ai-collab #4 composition, NOT J43 scope. **Resolution** : correction du dependency graph dans `mobile-game-picoc.md` — changer `A4' ← I37 replay tests + J43` en `A4' ← I37 replay tests` (J43 defers to A4', not consumes it).

5. **ISO/IEC 30113-12:2019 anchor** : Phase 1.2 liste ISO 30113-12 (gesture-based interface) dans SECONDARY anchors mais A6 ne la reference pas. **Resolution** : A6 enrichi avec cross-reference ISO 30113-12 dans anchor section (gesture primitive interoperability). Fait au niveau extraction form enrichment pas re-formulation PICOC.

**Modifications secondaires notees** (a traiter Phase 2.1) :

6. **Agent C DARE verification discharge** : 4 DARE scores encore UNVERIFIED (Aleem 2016, Chueca 2024, Zohud 2019, Toftedahl 2021). Action Phase 1.5 Agent C : verifier abstracts + DARE D1-D5 empiriques via fetch PDFs.

7. **Total-effort budget gate post-pilot** : explicit gate after Phase 1.5 pilot — if median time-per-PICOC extrapolates > X person-months, scope reduction ou depth reduction. Gate value a determiner apres pilot.

8. **Non-English source logging** : Phase 2.1 extraction template ajoute field "Non-English game dev community source per batch where applicable (jp/cn/kr/fr) OR declare limit". Applied Phase 2 onwards.

9. **Outcome-saturation flag** : Phase 2.1 extraction flag "outcome differentiated candidates YES/NO OR saturated near ceiling" per extracted source. Feeds outcome-set pruning for Phase 2.

10. **I41 accessibility candidate renumbering traceability** : Phase 1.3 Batch I journal clarifies that commissioning candidate "I41" numbering was loose (range I37-I42 covered 4 candidates I37/I38/I39/I40 per consolidated picoc file). I39 = game-specific accessibility residual, corresponds to commissioning I41 semantics. Documented en journal row 26.

**Scope de MG-9** : Modifications housekeeping + pilot-dependent gates. Protocole substantivement inchange. Pilot A1+B11+A7 peut proceder sans attendre toutes les modifications.

---

## Non-amendements (protocole applique tel quel)

- **Phases Kitchenham 2-3** : executees sans modification.
- **Double extraction A+B + Agent C** : mecanisme de base inchange. Applique rigoureusement a chaque PICOC batch A-J + Phase 1.5 pilot.
- **Scoring GRADE** : inchange, applique tel quel en Phase 2.5.
- **PRISMA flow** : inchange, applique tel quel en Phase 2.1.
- **Formulaires d'extraction** : inchange (ajouts G-1 [C=a decouvrir] + #3 [Anchor mandatory] + MG-6 [cross-PICOC tagging] + MG-7/MG-8 [A1 sub-findings]).

## Journal cumule des decisions Phase 1.1-1.3

| # | Phase | Date | Decision | Type | Source |
|---|-------|------|----------|:----:|--------|
| 1 | 1.1 | 2026-04-21 | DARE gate passed, no existing SLR >= 2.5 on DIRECT scope | Gate | Reviewer A + B convergence |
| 2 | 1.2 | 2026-04-21 | Amendment G-1 applied globally (anti-biais scope table §1.2) | Amendment | Superviseur (PO) |
| 3 | 1.2 | 2026-04-21 | Scope narrowed to 2D mobile game (3D out-of-scope for this SLR) | Scope | PO |
| 4 | 1.2 | 2026-04-21 | 43 decisions candidates identified in commissioning | Scope | PO |
| 5 | 1.3 Batch A | 2026-04-21 | A2 Language merged into A1 (deducible) | Merge | Reviewer A+B convergence |
| 6 | 1.3 Batch A | 2026-04-21 | A3 Rendering absorbed into A1 outcome (dependence VSE P) | Absorption | B wins arbitrage |
| 7 | 1.3 Batch A | 2026-04-21 | A4 split kept only timing (A4') ; paradigm absorbed A1 | Split/Absorb | B wins |
| 8 | 1.3 Batch A | 2026-04-21 | A5 Scene mgmt absorbed (scene graph ubiquitous) | Absorption | B wins |
| 9 | 1.3 Batch A | 2026-04-21 | A7 Offline-first + A8 Asset pipeline proposed (not in initial 6) | Addition | B proposal retained |
| 10 | 1.3 Batch B | 2026-04-21 | B11 Pixel-art authoring (PO pain point) added by both A+B independently | Addition | Independent convergence |
| 11 | 1.3 Batch B | 2026-04-21 | i18n redirected from Batch B to Batch G | Redirection | Commissioning Category G dedicated |
| 12 | 1.3 Batch C | 2026-04-21 | C14 save-on-interrupt retained (B wins — A7.I doesn't include scheduling policy) | Principled arbitrage | B wins |
| 13 | 1.3 Batch C | 2026-04-21 | C15 save integrity added (convergent gap identification) | Addition | Independent convergence |
| 14 | 1.3 Batch D | 2026-04-21 | D21 split (asset gen absorbed A8+B11, platform integration retained) | Split | B's split finer |
| 15 | 1.3 Batch E | 2026-04-21 | E22b scoped strictly to ad UX (excl consent UX = D20) | Scope narrowing | B critique accepted |
| 16 | 1.3 Batch E | 2026-04-21 | E24 reframed as SE architectural driver (not business model choice) | Reframing | B framing wins |
| 17 | 1.3 Batch F | 2026-04-21 | F27 achievements absorbed into F26 (shared backend) | Absorption | Convergence |
| 18 | 1.3 Batch F | 2026-04-21 | F28 narrowed to identity/auth (save-data → A7) | Narrowing | Convergence |
| 19 | 1.3 Batch F | 2026-04-21 | F29 narrowed to deep-link + attribution (share sheet excluded) | Scope narrowing | Compromise arbitrage |
| 20 | 1.3 Batch G | 2026-04-21 | G30 + G32 kept separate (intervention surfaces distinct) | Split retain | B wins |
| 21 | 1.3 Batch G | 2026-04-21 | G31 narrowed to RTL/BiDi layout (font absorbed B8) | Narrowing | A wins on layer distinction |
| 22 | 1.3 Batch H | 2026-04-21 | H35/H36 split (disjoint evidence bases) | Split retain | B wins |
| 23 | 1.3 Batch H | 2026-04-21 | H37 retained (A wins ; B mis-identified D19 scope) | Retention | A wins with correction |
| 24 | 1.3 Batch H | 2026-04-21 | H38 hot reload absorbed A1 (MG-8 enrichment) | Absorption | Convergence |
| 25 | 1.3 Batch I | 2026-04-21 | I38 perf budget absorbed A1+H33+H36 (MG-7 enrichment) | Absorption | B wins |
| 26 | 1.3 Batch I | 2026-04-21 | I40 crash-free target absorbed H35 | Absorption | Convergence |
| 27 | 1.3 Batch J | 2026-04-21 | J43 AI-asset render validation gate added (100% convergence) | Addition | Perfect convergence |
| 28 | 1.4 | 2026-04-21 | 8 domain-specific amendments (MG-1 to MG-8) | Amendments | Superviseur |

## Approbation du protocole amende

Le protocole `methodology.md` v3.0 + amendment G-1 global + amendments `ai-collaboration` #1-#4 + **amendments domain-specific MG-1 to MG-8** constitue le protocole complet pour la SLR `mobile-game-2d`.

**Approbation formelle** : requise en Phase 1.5 via peer review par un reviewer isole + pilotage sur 3 PICOCs representatives.

**Status** : Phase 1.3 terminee (37 PICOCs + 17 inherited = 54 total) + Phase 1.4 amendments documented. Ready for Phase 1.5 peer review + pilot.

**Pilot PICOCs candidates** (Phase 1.5) :
1. **A1** Mobile 2D game engine / framework selection (most structurant, drives downstream)
2. **B11** Pixel-art sprite authoring tool + source-format interchange (PO pain point, highest value)
3. **A7** Offline-first local persistence + cloud-save sync architecture (cross-cutting, largest cross-batch impact)

**Pilot rationale** : sample 3 PICOCs across different batches (A×2 + B×1) with different evidence-base characteristics :
- A1 : well-documented engines (academic + vendor docs + benchmarks) — stress-tests protocol under rich evidence
- B11 : grey-literature indie tools (community surveys + GDC Vault) — stress-tests protocol under MG-2 grey-lit acceptance
- A7 : academic CRDT/sync literature + vendor docs — stress-tests protocol under heterogeneous source types

Phase 1.5 pilot will validate :
- (a) time per PICOC (effort estimation for full Phase 2)
- (b) kappa inter-reviewers on extraction
- (c) applicability of inclusion/exclusion criteria to game-dev literature (MG-1 + MG-2 + MG-4)
- (d) Agent C verification coverage
