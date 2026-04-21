# Phase 1.1 — DARE : domaine `mobile-game-2d`

**Protocole** : `methodology.md` v3.0, section 1.1 (Kitchenham & Charters 2007, EBSE-2007-01)
**Date** : 2026-04-21
**Methode** : double extraction (Reviewer A + Reviewer B, contextes isoles) + verification sources (Agent C — a executer Phase 1.5) + reconciliation superviseur
**Fichier de tracabilite** : ce document + outputs bruts des reviewers (`verification/extractions/phase-1-1-mobile-game-dare.md` a produire)

## Sujet de la SLR

Choix techniques pour le **developpement d'un jeu mobile 2D** destine a la distribution grand public (Apple App Store + Google Play) par un dev indie / petite equipe. P specifique initial : solo-dev + 2D + pixel art + portrait + offline-first avec cloud save optionnel + stores + monetisation gems via ads+IAP (correspondant au projet Acres).

Scope complet : voir `verification/commissioning/mobile-game-scope.md`.

## Strategie de recherche

| Element | Valeur |
|---------|--------|
| Bases interrogees (Reviewer A) | Google Scholar/Google via WebSearch, ScienceDirect, Wiley Online Library, MDPI, researchgate, GDC reports |
| Bases interrogees (Reviewer B) | Google (general), SpringerLink, ScienceDirect/Elsevier, thescipub, IJSG, arXiv, Wiley Online Library |
| Fenetre de publication | 2016-2026 (accepte antecedent si seminal) |
| Type accepte | SLR, Systematic Mapping Study (SMS), Tertiary Study avec protocole declare (Kitchenham/PRISMA) |
| Type rejete | Etudes primaires, narrative surveys sans protocole, opinion, vendor whitepapers, blogs (niveau 6) |
| Reviewers | A (contexte principal, searches manuelles + WebFetch) ; B (ae3f94eca2b5c17de, contexte isole) ; C verificateur a executer Phase 1.5 |

## Criteres DARE appliques

Conformement au Centre for Reviews and Dissemination (University of York), Kitchenham & Charters 2007 §5.1 :

- **D1** — Inclusion/exclusion criteria reported
- **D2** — Search adequate (multiple databases, explicit strings)
- **D3** — Included studies synthesised
- **D4** — Quality of included studies assessed
- **D5** — Per-study details presented

**Scoring** : 0 / 0.5 / 1 par critere, total /5. Seuil `>= 2.5/5 sur scope DIRECT` = SLR existante suffit. Sinon nouvelle SLR justifiee.

## Corpus identifie — union A ∪ B

**11 sources uniques** identifiees apres dedoublonnage :

| # | Source | Trouve par | Coverage | DARE | Verdict |
|---|--------|:---------:|---------|-----:|---------|
| 1 | Aleem, Capretz, Ahmed 2016 — Game dev SE lifecycle SLR | B | ADJACENT | 3.0/5 | Cite, pas substitut |
| 2 | Chueca et al. 2024 — GSE consolidation SLR | B | ADJACENT | 3.5/5 | Cite, pas substitut |
| 3 | Mizutani, Daros, Kon 2021 — Game mechanics architecture SLR | A+B | ADJACENT | 4.0/5 | Cite, pas substitut |
| 4 | Zohud, Zein 2019 — Cross-platform mobile apps SMS | B | ADJACENT | 2.5/5 | Cite, pas substitut |
| 5 | Zein, Salleh, Grundy 2023 — Tertiary study mobile app SE | B | ADJACENT | 4.5/5 | Cite comme **landscape map**, pas substitut |
| 6 | Toftedahl, Engstrom 2021 — Localization in game engines SMS | A+B | ADJACENT | 2.5/5 (non-verifie) | Cite, pas substitut |
| 7 | Christopoulou, Xinogalos 2017 — Engine comparison narrative | B | Serait DIRECT thematiquement | N/A (pas de protocole — exclu DARE) | Cite comme etude primaire |
| 8 | Nour Elmawas et al. 2022 — SLR game design tools (302 studies, 5 DBs) | A | ADJACENT (design tools, pas engine selection) | ~3.0/5 (non-verifie) | Cite, pas substitut |
| 9 | MDPI 2025 — State-of-the-Art Cross-Platform Mobile App Frameworks | A | ADJACENT (apps, pas jeux) | ~3.0/5 (non-verifie) | Cite, pas substitut |
| 10 | Kasurinen, Laine 2013 — ISO/IEC 29110 applicability in game dev | A | OUT-OF-SCOPE (applicability d'un standard) | N/A (etude primaire) | Cite pour limite du standard VSE |
| 11 | Sensor Tower, GDC, Slashdata, Unity Gaming Report | A | Market/adoption data | N/A (pas SLR) | Sources niveau 4 pour Phase 2 |

Details complets des 7 sources trouvees par B : voir section "Details Reviewer B" plus bas.

## Reconciliation A vs B

### Convergence

**Les deux reviewers convergent** sur la conclusion : aucune SLR existante ne couvre le scope DIRECT (choix de framework de jeu mobile 2D pour indie solo avec contraintes stores + monetisation).

- A : 0 source DIRECT, toutes ADJACENT ou non-SLR → **nouvelle SLR justifiee**
- B : 0 source DIRECT, toutes ADJACENT ou protocol-ineligible → **nouvelle SLR justifiee**

### Divergence (sources complementaires)

A et B ont utilise des strategies de recherche partiellement differentes :
- A a fait davantage de recherches tools/surveys/market (Sensor Tower, GDC, Slashdata, Hracek benchmark, Nour Elmawas)
- B a fait davantage de recherches academiques SLR (Aleem 2016, Chueca 2024, Zohud 2019, Zein 2023, Christopoulou 2017)

Resultat : **corpus complementaire**, pas contradictoire. Les 2 sources communes (Mizutani 2021, Toftedahl 2021) ont le meme verdict (ADJACENT) chez les deux reviewers.

**Accord brut inclusion (Phase 1.1)** : 2 communes / 11 unique = ~18% (BAS — mais attendu pour une recherche DARE qui est une decouverte, pas une decision). Conformement a Amendement #1 (ai-collaboration-amendments.md), Phase 1.1 est explicitement NON concernee par le "fixed corpus" amendment car la decouverte de SLR existantes est par nature divergente.

**Accord sur le verdict final** : 100% (les deux concluent "nouvelle SLR justifiee"). C'est le verdict final qui compte pour le gate DARE, pas l'accord brut sur les sources individuelles.

### Gate DARE — verdict final

**NO-GO pour reutilisation d'une SLR existante.**
**GO pour nouvelle SLR mobile-game-2d.**

### Source la plus proche — Zein, Salleh, Grundy 2023 (4.5/5)

Cette **tertiary study** (revue de revues) est la plus haute DARE du corpus. Elle cartographie 24 secondary studies (13 SMS + 11 SLR) sur le mobile app SE. **Elle confirme indirectement notre conclusion** : aucune SLR de son corpus ne traite le mobile **game** framework choice. Son exclusion explicite des jeux dans son P renforce la justification de notre nouvelle SLR.

## Details Reviewer B (output complet isole)

Reviewer B (agent `ae3f94eca2b5c17de`) a retourne 7 sources avec scoring DARE complet. Extrait des verdicts :

- **Aleem 2016** : "Cite as background reference for game SE process, NOT a substitute — scope mismatch on P (mobile, indie, 2D)."
- **Chueca 2024** : "NOT a substitute — out of P scope (explicitly non-indie)."
- **Mizutani 2021** : "NOT a substitute — adjacent scope."
- **Zohud 2019** : "NOT a substitute — games excluded."
- **Zein 2023** : "Cite as authoritative map of the mobile-app SLR landscape — confirms absence of a mobile-game-framework SLR in that neighborhood. NOT a substitute."
- **Toftedahl 2021** : "NOT a substitute" (WebFetch 403, scoring conservatif).
- **Christopoulou 2017** : "NOT eligible as DARE substitute (no protocol)."

Conclusion Reviewer B verbatim :
> *"No existing SLR scores >= 2.5/5 on DIRECT scope for our P. [...] A new SLR is justified. The intersection of (a) mobile, (b) 2D pixel-art, (c) solo indie developer workflow, (d) store monetization (ads + IAP + leaderboards), and (e) cross-platform Android+iOS is not systematically covered by any existing protocol-compliant secondary study within the 2019-2026 window."*

## Details Reviewer A (output)

Reviewer A a identifie les sources suivantes lors de WebSearch iterative :

- **Mizutani 2021** (ADJACENT) — confirme par B
- **Toftedahl 2021** (ADJACENT) — confirme par B
- **Nour Elmawas et al. 2022** "SLR of game design tools" (302 studies, 5 databases IEEE, ScienceDirect, Scopus, Springer, WoS — 18 papers discussed, 12 tools identified) — ADJACENT : game **design** tools, pas engine selection.
- **MDPI 2025** "State-of-the-Art Cross-Platform Mobile Application Development Frameworks" (Nkurunziza et al., MDPI Informatics vol 12 no 2) — ADJACENT : apps pas jeux, couvre Flutter/RN/MAUI.
- **Kasurinen, Laine 2013** "How Applicable Is ISO/IEC 29110 in Game Software Development?" — etude primaire, pas SLR. Cite pour documenter que le profil VSE ISO 29110 est juge trop waterfall pour le dev de jeu.
- **Sensor Tower State of Mobile Gaming 2025** — market report, niveau 4, pas SLR. Useable comme donnees de marche en Phase 2.
- **GDC State of the Game Industry 2025** — survey 3000+ dev, niveau 4. Biais **PC-focus** (80%). Utilisable avec extraction de la sous-section mobile.
- **Slashdata Developer Economics** (Q1 2025, reports "60% of game developers use game engines") — niveau 4, pas SLR.
- **Unity 2026 Gaming Report** — vendor, conflit d'interet declare — niveau 5 avec flag bias.
- **Sensor Tower Big Game Engines Report 2025** — market report, niveau 4, mobile-focused.
- **Filip Hracek 2024** "Benchmarking Flutter, Flame, Unity and Godot" — single-dev benchmark, conflit d'interet declare (ex-Flutter team), niveau 5. Source primaire utile mais biais majeur.

## Justification de la nouvelle SLR

### Critere Kitchenham 1 — Pas de SLR existante

Aucune des 11 sources identifiees n'atteint DARE >= 2.5/5 sur le scope DIRECT du P defini. Les sources adjacentes ayant le plus haut DARE (Mizutani 4.0/5, Chueca 3.5/5, Zein 4.5/5) sont explicitement hors-P :
- Mizutani : software architecture patterns, pas engine selection
- Chueca : explicitement restreint aux jeux industrie (AAA), indie exclu
- Zein 2023 : explicitement exclu les jeux de son tertiary

### Critere Kitchenham 2 — Lacune dans la recherche

L'intersection du P (solo indie + mobile + 2D + pixel art + stores + monetisation ads+IAP) n'est couverte par aucune revue systematique existante. La litterature couvre :
- Games en general (sans specificite mobile indie)
- Cross-platform mobile en general (sans jeux)
- Architecture patterns (sans decision operationnelle d'outil)
- Localization (sous-domaine etroit)
- Game design tools (different de tech stack)

### Critere Kitchenham 3 — Framework for future research

Cette SLR produira un framework de decisions techniques reutilisable pour :
- D'autres profils de dev mobile game (equipe plus grande, autres genres 2D)
- Extension future au 3D mobile (P different mais meta-structure reutilisable)
- Extension future au web game, desktop game

## Biais de publication — verification initiale

Conformement a methodology.md §2.1.2 :
- **Retours negatifs mobile game dev** activement recherches : Unity Runtime Fee controversy 2023-2024 (Sensor Tower data), Apple IAP fee disputes (Epic v Apple), critiques du modele F2P (addiction, dark patterns). A integrer en Phase 2 sources pour chaque PICOC applicable.
- **Pas de restriction langue** : sources anglophones principalement trouvees. Francophone verifiable : peu de production SLR francophone sur ce P specifique.
- **Grey literature** : IGDA resources, GDC talks, dev blogs (Hracek, postmortems) — classes niveau 5-6 selon source, integrer avec flag bias.

## Limites documentees (Phase 1.1)

1. **Recherche limitee en profondeur** : A et B n'ont pas interroge IEEE Xplore directement (accessibility limitee sans auth), DBLP directement, Semantic Scholar API. Un Reviewer B+ (retrofit Phase 1.5) pourrait elargir.
2. **Plusieurs abstracts lus via WebFetch, corps non-verifies** pour Aleem 2016, Chueca 2024, Zein 2023, Zohud 2019, Toftedahl 2021. Les DARE scores de B sont conservatifs (0.5 par defaut si non-verifiable). Agent C devra tenter l'acces aux PDFs complets en Phase 1.5.
3. **Wiley Online Library 403** a bloque la verification de Toftedahl 2021 — score 2.5/5 unverified.
4. **Corpus B mainly academic SLR**, **corpus A mainly tools/market/surveys** — complementaires mais non-overlapping outside 2 sources. Le faible kappa (~18% brut) est attendu en Phase 1.1 (Amendement #1 ai-collaboration).
5. **Toute decision de GRADE ulterieure** (Phase 2) ne peut pas s'appuyer sur ces SLR adjacentes comme source DIRECTE — elles seront seulement citees en background.

## Prochaine etape

Phase 1.2 — Commissioning (scope) : voir `verification/commissioning/mobile-game-scope.md`.

## Statut

**APPROVED pour Phase 1.2** (scope) : gate DARE passe (new SLR justifiee par convergence A+B + absence de DIRECT >= 2.5/5).
**Agent C verification** des DARE scores et URLs : a executer en Phase 1.5 (peer review + pilot).
