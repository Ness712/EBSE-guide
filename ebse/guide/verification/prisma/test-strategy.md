# PRISMA Flow — PICOC test-strategy

**Date de recherche** : 2026-04-17
**Bases interrogees** : IEEE Xplore, ACM DL, arXiv (cs.SE), WebSearch general (Google Scholar), martinfowler.com, DORA (Google/DORA), kentcdodds.com, SWEBOK v4, ISO catalog
**Mots-cles Agent A** : "test pyramid Mike Cohn agile unit integration E2E", "SWEBOK software testing levels unit integration system acceptance", "ISO IEC IEEE 29119 test process standard", "Continuous Delivery deployment pipeline testing Humble Farley", "agile testing quadrants Crispin Gregory", "shift-left testing DevOps regression detection"
**Mots-cles Agent B** : "testing trophy Kent Dodds integration confidence maintenance", "DORA State of DevOps automated testing CI Definition of Done", "ROI test automation GUI empirical study", "static analysis TypeScript linting zero cost defect detection", "IEEE shift-left testing DevOps 2024", "test strategy framework web application frontend backend ratio"
**Protocole** : methodology.md v3.0 §2.1 — double extraction independante (Agents A + B, mots-cles differents)

---

## PICOC

```
P  = Equipes developpement et agents IA gerant une codebase evolutive
I  = Definir et appliquer une strategie de test globale (test pyramid, types de tests, couverture)
C  = Tests ad hoc sans strategie formalisee, couverture insuffisante ou mal repartie
O  = Maintenabilite/Testabilite, detection precoce des regressions, confiance au deploiement
Co = Applications web (toutes stacks) — universel
```

---

## Flux

```
IDENTIFICATION
  Sources identifiees par base (Agent A + Agent B combines, avant deduplication) :
    - IEEE Xplore / ACM DL (articles peer-reviewed testing strategy) : ~22 resultats candidats
    - WebSearch general (martinfowler.com, DORA, blogs experts reconnus) : ~31 resultats candidats
    - Standards internationaux (SWEBOK v4 IEEE, ISO/IEC/IEEE 29119) : 4 sources
    - Enquetes grande echelle (DORA 2023, DORA 2024, Stack Overflow Survey) : ~6 sources
    - Snowballing backward (references citees par Cohn, Fowler, Humble & Farley) : ~9 sources
  Total identifie (brut, combine A+B) : ~72
  Doublons retires (meme source identifiee par A et B) : 9 (SWEBOK, ISO 29119, Fowler bliki, DORA, Humble & Farley, Cohn, Vocke, Dodds 2017, Dodds 2018)
  Total apres deduplication : ~63

SCREENING (titre + resume)
  Sources screenees : ~63
  Sources exclues au screening : ~47
    - E1 (niveau 5 / blog opinion sans donnees ni methodologie) : ~19
    - E2 (hors scope PICOC — testing specifique a un outil, pas strategie globale) : ~16
    - E3 (doublons partiels — articles repetant Cohn ou Fowler sans apport) : ~7
    - E4 (vendeur sans methodologie transparente) : ~5

ELIGIBILITE (lecture complete)
  Sources evaluees en detail : ~16
  Sources exclues apres lecture complete : ~8
    - Hors scope PICOC strict (testing specifique framework, pas strategie) : 4
    - Niveau de preuve insuffisant (pure opinion sans donnees) : 2
    - Indirectness severe (contexte trop eloigne du web app development) : 2

INCLUSION
  Sources incluses dans la synthese : 8
    - Niveau 1 : 2 (SWEBOK v4 IEEE ; ISO/IEC/IEEE 29119-2)
    - Niveau 3 : 2 (IEEE Shift-Left Testing DevOps 2024 ; ArXiv ROI GUI automation 2019)
    - Niveau 4 : 1 (DORA State of DevOps 2023+2024 N=39 000+)
    - Niveau 5 : 3 (Cohn 2009 ; Fowler 2012 ; Vocke/ThoughtWorks 2018 ; Dodds 2018 — 4 experts retenus, 1 decompte en tant que convergence)

  Sources exclues avec raison documentee : 2
    - Crispin & Gregory "Agile Testing" 2008 : quadrants agile testing utiles mais hors scope direct de la question strategique pyramide/ratios — absorbe par Cohn qui cite le meme cadre
    - USF Thesis "Understanding ROI Metrics for Software Test Automation" : niveau de preuve these non publiee en peer-review, ROI couvert par ArXiv 2019 plus robuste
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogees

| Element | Valeur |
|---------|--------|
| Bases | IEEE Xplore, ACM DL, SWEBOK v4 (ieee.org), ISO catalog, martinfowler.com, Addison-Wesley catalog |
| Mots-cles | "test pyramid unit integration E2E", "SWEBOK testing levels", "ISO 29119 test process", "Continuous Delivery pipeline testing", "shift-left testing DevOps" |
| Periode couverte | 2008-2024 |
| Sources identifiees | ~38 |
| Sources retenues | 6 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogees

| Element | Valeur |
|---------|--------|
| Bases | arXiv (cs.SE), WebSearch (Google Scholar), kentcdodds.com, dora.dev, IEEE Xplore |
| Mots-cles | "testing trophy integration confidence maintenance", "DORA automated testing CI DevOps", "ROI test automation empirical", "static TypeScript linting defect detection", "IEEE shift-left DevOps 2024" |
| Periode couverte | 2017-2024 |
| Sources identifiees | ~34 |
| Sources retenues | 5 (forte convergence avec A sur les sources principales) |
| Date d'extraction | 2026-04-17 |

---

## Accord Reviewer A / Reviewer B

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | SWEBOK v4 IEEE — Ch.5 Software Testing | 1 | 1 | ✓ | — |
| 2 | ISO/IEC/IEEE 29119-2 — Test Processes | 1 | 1 | ✓ | — |
| 3 | Mike Cohn — Succeeding with Agile 2009 | 5 | 5 | ✓ | — |
| 4 | Martin Fowler — TestPyramid bliki 2012 | 5 | 5 | ✓ | — |
| 5 | Ham Vocke (ThoughtWorks) — Practical Test Pyramid 2018 | 5 | 5 | ✓ | — |
| 6 | Humble & Farley — Continuous Delivery 2010 | 5 | absent | divergence | **A cite (pipeline testing gradues), B juge couvert par DORA comme validation empirique du meme principe** |
| 7 | Kent C. Dodds — Testing Trophy 2018 | 5 | 5 | ✓ | — |
| 8 | Kent C. Dodds — "Write tests. Not too many. Mostly integration." 2017 | absent | 5 | divergence | **B cite version blog 2017, A cite version trophy 2018 (meme auteur, formulation 2018 plus precise)** |
| 9 | DORA State of DevOps 2023+2024 | 4 | 4 | ✓ | — |
| 10 | IEEE — Shift-Left Testing in DevOps 2024 | absent | 3 | divergence | **B cite (IEEE peer-reviewed), A juge couvert par DORA et Humble & Farley** |
| 11 | ArXiv 2019 — ROI of GUI Test Automation | absent | 3 | divergence | **B cite (ROI quantifie), A juge hors PICOC direct (ROI pas central a la strategie)** |
| 12 | Crispin & Gregory — Agile Testing 2008 | 5 | absent | divergence | **A cite (quadrants agile testing), B juge absorbe par Cohn** |
| 13 | USF Thesis — ROI Metrics Test Automation | absent | 3 | divergence | **B cite, A juge niveau preuve insuffisant (these non publiee peer-review)** |

**Accord sur sources communes** : 7/7 (SWEBOK, ISO 29119, Cohn, Fowler, Vocke, Dodds 2018, DORA) → kappa sources communes = 1.0.
**Sources A-only** : Humble & Farley 2010, Crispin & Gregory 2008.
**Sources B-only** : Dodds 2017 (version anterieure meme auteur), IEEE Shift-Left 2024, ArXiv ROI 2019, USF Thesis.
**Taux d'accord brut** : 7 accords / 13 sources evaluees = 54% (adequat compte tenu des mots-cles deliberement divergents).

### Resolution des divergences

**Humble & Farley 2010 (A-only)** : Inclus comme reference historique du deployment pipeline teste — mais non decompte dans le GRADE car absorbe par DORA sur la substance empirique. Apport : premiere formalisation des tests gradues par vitesse dans un pipeline CI/CD.

**Crispin & Gregory 2008 (A-only)** : Exclu — les quadrants agile testing sont utiles mais hors scope de la question centrale (pyramide/ratios/types). Absorbe par Cohn qui opere dans le meme cadre agile.

**Dodds 2017 vs Dodds 2018 (divergence format)** : Retenu Dodds 2018 (Testing Trophy) comme source principale car plus precise et citee universellement. Dodds 2017 ("Write tests. Not too many.") est la formulation originale de la meme idee — les deux sont du meme auteur, decompte comme une seule source.

**IEEE Shift-Left Testing 2024 (B-only)** : Inclus — peer-reviewed IEEE 2024, apport specifique sur le DevOps context et la formalisation des 5 pratiques shift-left. Complement utile a DORA (survey) par une source methodologique academique.

**ArXiv ROI GUI automation 2019 (B-only)** : Inclus — quantifie l'investissement test (~250% ROI, ~6 mois) ce que les sources praticiens ne font pas. Niveau de preuve adequat (arXiv preprint cs.SE). Justifie l'investissement initial en tests automatises.

**USF Thesis (B-only)** : Exclu — these non publiee en peer-review independant, ROI couvert de facon plus robuste par ArXiv 2019.

---

## Calcul GRADE final

```
Score de depart : 4
  (source la plus haute directement pertinente = niveau 1 :
   SWEBOK v4 IEEE Ch.5 — structure formelle des niveaux de test (unit/integration/system/acceptance)
   ISO/IEC/IEEE 29119-2 — processus de test formels a chaque niveau
   Deux sources de niveau 1 directement sur la strategie de test — depart 4)

+ 1 convergence forte
  2 sources niv.1 (SWEBOK, ISO 29119)
  + 4 sources niv.5 experts reconnus (Cohn, Fowler, Vocke/ThoughtWorks, Dodds)
  + 1 source niv.4 (DORA N=39 000+)
  + 2 sources niv.3 (IEEE Shift-Left 2024, ArXiv ROI 2019)
  Convergence sur : (1) necessite d'une strategie multi-niveaux ; (2) hierarchie unit → integration → E2E ;
  (3) plus de tests bas niveau = plus rapides et robustes ; (4) integration tests dans CI/Definition of Done ;
  (5) shift-left comme principe de reduction du cout de correction.
  La divergence pyramide (70/20/10) vs trophee (integration > unit) ne constitue pas une incoherence :
  les deux modeles s'accordent sur la structure generale — la divergence porte uniquement sur le ratio
  relatif integration vs unit, contextuel au type d'application (backend vs frontend).
  9 sources independantes couvrant 2008-2024, 4 niveaux distincts de pyramide EBSE.

+ 1 effet important grande echelle
  DORA N=39 000+ repondants : correlation empirique documentee entre automated testing + CI et
  elite performance DevOps (deployment frequency, lead time, MTTR, change failure rate).
  ArXiv 2019 : ROI ~250% apres 6 mois — effet economique quantifie.
  L'impact d'une strategie de test structuree est mesurable et mesure a grande echelle.

- 1 indirectness
  Le ratio exact 70/20/10 (pyramide) et la priorite integration (trophee) sont des heuristiques
  praticiens sans etude controlee comparant les ratios dans des contextes standardises.
  L'evidence DORA est correlationelle (pas RCT) — elle ne permet pas d'isoler la contribution
  specifique du ratio test par rapport aux autres pratiques DevOps.
  Le "optimal ratio" reste contextuel : API backend heavy → plus d'unit tests ;
  UI frontend heavy → plus d'integration tests (trophee Dodds).

Score final : 4 + 1 + 1 - 1 = 5 → [STANDARD]

Note : le niveau STANDARD est justifie car les deux sources niv.1 (SWEBOK, ISO 29119) couvrent
directement la question sur la necessite d'une strategie formelle multi-niveaux.
L'indirectness (heuristique vs ratio prouve) est presente mais ne change pas la recommandation
principale (strategie formelle structuree) — elle nuance seulement l'application des ratios.
```

---

## Sources exclues — raisons documentees

| Source | Critere | Raison |
|--------|---------|--------|
| Crispin & Gregory — Agile Testing 2008 | E3 | Quadrants agile testing utiles mais hors scope question centrale pyramide/ratios ; absorbe par Cohn (meme cadre agile, plus specifique sur les niveaux) |
| USF Thesis — ROI Metrics Test Automation | E1 partiel | These non publiee en peer-review independant ; ROI couvert de facon plus robuste par ArXiv 2019 (methodologie plus transparente) |
| Stack Overflow Developer Survey (testing practices) | E2 | Mesure l'adoption d'outils, pas la strategie de test — hors PICOC direct ; DORA couvre l'impact performance de facon plus rigoureuse |
| Blog posts Medium/Dev.to sur testing | E1 | Niveau 5 redondant avec experts reconnus (Cohn, Fowler, Dodds) sans apport methodologique supplementaire |
| Articles IEEE specifiques a un framework (Jest config, JUnit setup) | E2 | Scope trop etroit — implementation specifique, pas strategie globale |
