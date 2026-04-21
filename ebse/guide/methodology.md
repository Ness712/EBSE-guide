# Methodologie — EBSE Guide

**Version** : 3.0
**Date** : 2026-04-14
**Methode** : Systematic Literature Review adaptee au genie logiciel, structuree selon Kitchenham & Charters (2007), *Guidelines for performing Systematic Literature Reviews in Software Engineering*, EBSE Technical Report EBSE-2007-01.

Ce document est le **protocole pre-enregistre** de l'outil EBSE-Guide. Il suit exactement les 13 etapes de Kitchenham & Charters 2007 (sections 5, 6, 7), avec pour chaque etape une section "Adaptation EBSE-Guide" expliquant comment nous adaptons la procedure au cas d'usage specifique : **le choix d'outils et de pratiques en genie logiciel** (pas une revue de litterature academique classique).

**Format de sortie** : les recommandations sont stockees en JSON structure, servies via une application web (humains) et une API (IA/machines). L'outil ne GENERE pas de recommandations — il FILTRE et AFFICHE des donnees issues du processus EBSE. Pas de source = pas de recommandation affichee.

---

## Glossaire (definitions Kitchenham 2007)

| Terme | Definition (Kitchenham 2007) |
|-------|------------------------------|
| **Systematic Literature Review (SLR)** | A means of identifying, evaluating and interpreting all available research relevant to a particular research question, or topic area, or phenomenon of interest. |
| **Primary study** | An empirical study investigating a specific research question. |
| **Secondary study** | A study that reviews all the primary studies relating to a specific research question. A systematic literature review is a form of secondary study. |
| **Review protocol** | A plan that describes the conduct of a proposed systematic literature review. |
| **Search strategy** | The strategy used to find primary studies. Includes search terms, databases to search, and search processes. |
| **Inclusion criteria** | The criteria that a primary study must satisfy in order to be included in the systematic review. |
| **Exclusion criteria** | The criteria that, if satisfied, would exclude a primary study from the systematic review. |
| **Study quality** | The extent to which the study minimises bias and maximises internal and external validity. |
| **Data extraction** | The process by which the data needed to address the review questions are obtained from each primary study. |
| **Data synthesis** | The process of collating and summarising the results of the included primary studies. |
| **PICOC** | Population, Intervention, Comparison, Outcome, Context — framework for structuring research questions. |
| **Kappa statistic** | A statistical measure of inter-rater agreement for qualitative items, correcting for agreement by chance. |
| **Sensitivity analysis** | An analysis undertaken to determine how sensitive the results of a study or systematic review are to changes in how it was done. |
| **Publication bias** | The problem that positive results are more likely to be published than negative results. |
| **Effect size** | A quantitative measure of the magnitude of a phenomenon (e.g. mean difference, odds ratio). |
| **Meta-analysis** | A statistical technique for combining the results of n independent studies that address the same question. |
| **Narrative synthesis** | A textual approach to synthesis of results when statistical meta-analysis is not appropriate. |

---

## Table des matieres

### Phase 1 — Planning (Kitchenham sections 5.1-5.5)
1. [1.1 — Identification of the need for a review (5.1)](#11--identification-of-the-need-for-a-review)
2. [1.2 — Commissioning a review (5.2)](#12--commissioning-a-review)
3. [1.3 — Specifying the research question(s) (5.3)](#13--specifying-the-research-questions)
4. [1.4 — Developing a review protocol (5.4)](#14--developing-a-review-protocol)
5. [1.5 — Evaluating the review protocol (5.5)](#15--evaluating-the-review-protocol)

### Phase 2 — Conducting the review (Kitchenham sections 6.1-6.5)
6. [2.1 — Identification of research (6.1)](#21--identification-of-research)
7. [2.2 — Selection of primary studies (6.2)](#22--selection-of-primary-studies)
8. [2.3 — Study quality assessment (6.3)](#23--study-quality-assessment)
9. [2.4 — Data extraction and monitoring (6.4)](#24--data-extraction-and-monitoring)
10. [2.5 — Data synthesis (6.5)](#25--data-synthesis)

### Phase 3 — Reporting the review (Kitchenham sections 7.1-7.3)
11. [3.1 — Specifying dissemination mechanisms (7.1)](#31--specifying-dissemination-mechanisms)
12. [3.2 — Formatting the main report (7.2)](#32--formatting-the-main-report)
13. [3.3 — Evaluating the report (7.3)](#33--evaluating-the-report)

### Annexes
- [Limites documentees](#limites-documentees)
- [References](#references)

---

# Phase 1 — Planning

---

## 1.1 — Identification of the need for a review

*Kitchenham 2007, section 5.1*

### Procedure Kitchenham

The most important reason for undertaking a systematic review is that it is the first stage in the identification of the need for primary studies. A systematic review should be undertaken for one or more of the following reasons:

1. To summarise the existing evidence concerning a treatment, technology, method, tool, or technique.
2. To identify any gaps in current research in order to suggest areas for further investigation.
3. To provide a framework/background in order to appropriately position new research activities.

Before undertaking a systematic review, researchers should identify and review any existing systematic reviews of the phenomenon of interest, in particular to assess whether a new review is necessary or an existing review update would suffice.

### DARE criteria checklist (Database of Abstracts of Reviews of Effects)

Kitchenham 2007 recommends using the DARE criteria to assess the quality of existing reviews. Each existing review should be evaluated against:

| # | DARE Criterion | Question |
|---|----------------|----------|
| D1 | Inclusion/exclusion criteria | Were inclusion/exclusion criteria reported? |
| D2 | Search adequacy | Was the search adequate? |
| D3 | Included studies | Were the included studies synthesised? |
| D4 | Quality assessment | Was the quality of the included studies assessed? |
| D5 | Summary | Are sufficient details about the individual included studies presented? |

**Scoring**: Each criterion is scored 0 (not met), 0.5 (partially met), or 1 (fully met). A review scoring < 2.5/5 is considered low quality and justifies conducting a new SLR.

### Adaptation EBSE-Guide

**Contexte** : nous ne recherchons pas des etudes academiques existantes. Nous recherchons des **benchmarks, enquetes, guides de bonnes pratiques, et revues d'outils** existants dans le domaine du logiciel.

**Avant de creer une nouvelle page de guide, nous verifions :**
1. Existe-t-il deja une revue systematique academique (via IEEE Xplore, ACM DL, Google Scholar) ?
2. Existe-t-il un benchmark independant (TechEmpower, ThoughtWorks Radar, CNCF Landscape) ?
3. Existe-t-il une enquete grande echelle (SO Survey, State of JS, JetBrains Survey) ?

**Application DARE** : si une revue existante repond a nos questions, nous evaluons sa qualite avec les DARE criteria. Si score >= 2.5/5, nous l'utilisons comme source plutot que de refaire le travail. Si score < 2.5/5, nous justifions la nouvelle revue.

**Justification de notre revue** : les revues existantes en SE ne couvrent generalement pas le choix d'outils pratiques avec le niveau de granularite requis (quel ORM ? quel test runner ?). Cette lacune justifie notre SLR adaptee.

---

## 1.2 — Commissioning a review

*Kitchenham 2007, section 5.2*

### Procedure Kitchenham

A commissioned systematic review defines the scope and resources for the review. In medical research, reviews are typically commissioned by governmental or health care bodies. The commissioning includes:

1. **Scope definition** — which topic areas will be covered
2. **Research team** — who will perform the review
3. **Timeline** — expected delivery dates
4. **Resources** — budget and infrastructure available
5. **Stakeholder identification** — who will use the results

Kitchenham notes this step is optional in SE, as most reviews are self-initiated by researchers.

### Adaptation EBSE-Guide

Bien que Kitchenham considere cette etape optionnelle en SE, nous la documentons formellement pour la transparence.

**Scope du projet :**

Le scope repose sur des standards complementaires a 3 niveaux :

**Niveau 1 — SCOPE (quels sujets couvrir)**

| Standard | Role | Couverture |
|----------|------|------------|
| **ISO/IEC 25010:2023** | Qualite du PRODUIT | 9 caracteristiques, ~40 sous-caracteristiques |
| **ISO/IEC 25019:2023** | Qualite d'USAGE (perspective utilisateur) | Effectiveness, Efficiency, Satisfaction, Freedom from risk, Context coverage |
| **SWEBOK v4 (2024)** | Domaines de PRATIQUE | 18 knowledge areas |

Pourquoi 25010 + 25019 : ISO 25010 dit "le produit est fiable". ISO 25019 dit "l'utilisateur percoit le produit comme fiable". Les deux perspectives sont necessaires.

**Niveau 2 — MESURE (comment savoir si c'est atteint)**

| Standard | Role |
|----------|------|
| **ISO/IEC 25023** | Metriques concretes pour chaque caracteristique de 25010 (ex: temps de reponse en ms pour "time behaviour") |

**Niveau 3 — OPERATIONNALISATION (standards specialises par domaine)**

| Standard | Operationnalise quelle caracteristique ISO |
|----------|-------------------------------------------|
| **OWASP ASVS** | Security — regles testables (~300) |
| **WCAG 2.2** | Inclusivity — criteres mesurables (~86) |
| **ISO 9241-110:2020** | Interaction Capability — 7 principes d'interaction |
| **Twelve-Factor App** | Flexibility + Reliability — 12 pratiques cloud-native |
| **Nielsen 10 Heuristics** | Interaction Capability — 10 principes UX pratiques |
| **Material Design 3 + Apple HIG** | User engagement — tendances visuelles actuelles (date) |

Ces standards de niveau 3 sont decouverts par recherche systematique (etape 2.1), pas fixes d'avance. La liste ci-dessus est le resultat de la recherche initiale et peut s'etendre.

**Matrice de couverture :**

Croiser les sous-caracteristiques ISO/IEC 25010:2023 + 25019:2023 avec les **sous-topics** SWEBOK v4 (pas seulement les 18 knowledge areas).

**Pourquoi les sous-topics et non les knowledge areas** : appliquer la matrice au niveau "Software Construction" (knowledge area) est trop grossier pour identifier des decisions comme DRY, SOLID ou KISS/YAGNI — elles apparaissent seulement quand on descend dans les sous-topics (ex: "code reuse", "minimizing complexity", "coding practices"). Kitchenham 2007 recommande une "early search of the relevant literature" iterative — descendre au niveau sous-topic en est l'operationnalisation correcte pour notre contexte. `Source: SWEBOK v4 (sous-topics de chaque knowledge area) + Kitchenham 2007 section 5.1`

Pour chaque case `[sous-caracteristique ISO] x [sous-topic SWEBOK]` :

1. Lire la definition ISO de la sous-caracteristique
2. Lire la description SWEBOK du sous-topic (pas juste le knowledge area)
3. Determiner si l'intersection genere une decision technique :
   - **OUI** — la case entre dans le scope du guide, formuler une question PICOC
   - **NON** — marquer "N/A" avec justification (les deux ne se croisent pas)

**Controle** : cette determination est soumise a double extraction (2 reviewers independants).

**Taille maximale** : ~40 sous-caracteristiques x ~80 sous-topics SWEBOK = ~3200 cases theoriques. En pratique, la grande majorite sera N/A — estimer ~300-500 cases pertinentes.

**ISO/IEC 25010:2023 — 9 caracteristiques, ~40 sous-caracteristiques**

**1. Functional Suitability** : Functional completeness, Functional correctness, Functional appropriateness

**2. Performance Efficiency** : Time behaviour, Resource utilization, Capacity

**3. Compatibility** : Co-existence, Interoperability

**4. Interaction Capability** (renomme depuis "Usability" en 2011) : Appropriateness recognizability, Learnability, Operability, User error protection, User engagement (nouveau 2023), Inclusivity (nouveau 2023, remplace "Accessibility"), User assistance (nouveau 2023), Self-descriptiveness (nouveau 2023)

**5. Reliability** : Faultlessness (renomme depuis "Maturity"), Availability, Fault tolerance, Recoverability

**6. Security** : Confidentiality, Integrity, Non-repudiation, Accountability, Authenticity, Resistance (nouveau 2023)

**7. Maintainability** : Modularity, Reusability, Analysability, Modifiability, Testability

**8. Flexibility** (renomme depuis "Portability") : Adaptability, Installability, Replaceability, Scalability (nouveau 2023)

**9. Safety** (nouveau 2023) : Operational constraint, Risk identification, Fail safe, Hazard warning, Safe integration

**SWEBOK v4 — 18 knowledge areas** : (1) Software Requirements, (2) Software Architecture, (3) Software Design, (4) Software Construction, (5) Software Testing, (6) Software Engineering Operations, (7) Software Maintenance, (8) Software Configuration Management, (9) Software Engineering Management, (10) Software Engineering Process, (11) Software Engineering Models and Methods, (12) Software Quality, (13) Software Security, (14) Software Engineering Professional Practice, (15) Software Engineering Economics, (16) Computing Foundations, (17) Mathematical Foundations, (18) Engineering Foundations.

**Equipe de recherche** :
- Reviewer A : Agent IA 1 (contexte isole)
- Reviewer B : Agent IA 2 (contexte isole)
- Agent C : Verificateur de sources (contexte isole)
- Superviseur humain : resolution des divergences, approbation du protocole

**Scope et plateformes :**

Le guide couvre actuellement **le web** (navigateur). Les autres plateformes ne sont PAS couvertes tant que la recherche EBSE n'a pas ete faite :

| Plateforme | Statut | Prochaine etape |
|-----------|--------|-----------------|
| **Web (navigateur)** | Couvert | 106 decisions, 3 stacks backend, multi-frontend |
| **Web vers Mobile (PWA/Capacitor)** | Couvert | Page web-mobile-strategy.md, batch 16 |
| Mobile natif Android | Pas couvert | A couvrir par SLR dediee (scope + PICOC + alternatives a decouvrir systematiquement par §1.3) |
| Mobile natif iOS | Pas couvert | A couvrir par SLR dediee (scope + PICOC + alternatives a decouvrir systematiquement par §1.3) |
| Mobile cross-platform | Pas couvert | A couvrir par SLR dediee (scope + PICOC + alternatives a decouvrir systematiquement par §1.3) |
| Mobile game (2D/3D) | Pas couvert | A couvrir par SLR dediee (scope + PICOC + alternatives a decouvrir systematiquement par §1.3) |
| Desktop app | Pas couvert | A couvrir par SLR dediee (scope + PICOC + alternatives a decouvrir systematiquement par §1.3) |
| Desktop game (2D/3D) | Pas couvert | A couvrir par SLR dediee (scope + PICOC + alternatives a decouvrir systematiquement par §1.3) |

**Regle** : le guide NE RECOMMANDE PAS une plateforme qu'il n'a pas recherchee. L'arbre de decision affiche "pas encore couvert" pour les plateformes non recherchees.

**Regle anti-biais (correction 2026-04-21)** : la colonne "Prochaine etape" NE DOIT PAS pre-identifier de candidats (ex: "Flutter vs React Native vs KMP"). Cette pre-selection cree un biais d'ancrage (selection bias §2.3, performance bias) — les alternatives seront decouvertes systematiquement via §1.3 "Decouverte des alternatives" dans les bases appropriees au moment de la SLR dediee. Correction documentee comme amendement global au protocole : voir `verification/amendments/methodology-global-amendments.md`.

---

## 1.3 — Specifying the research question(s)

*Kitchenham 2007, section 5.3*

### Procedure Kitchenham

Research questions are the most important part of any systematic review. They drive the entire systematic review methodology:

- The search process must identify primary studies that address the research questions.
- The data extraction process must extract the data items needed to answer the questions.
- The data analysis process must synthesise the data in such a way that the questions can be answered.

Kitchenham recommends structuring questions using the **PICOC** framework:

| Lettre | Signification | Description |
|--------|---------------|-------------|
| **P** | Population | The specific software engineering group or application area being investigated |
| **I** | Intervention | The software methodology, tool, technology, or procedure that addresses a specific issue |
| **C** | Comparison | The software methodology, tool, technology, or procedure against which the intervention is being compared |
| **O** | Outcome | Factors of importance to practitioners such as improved reliability, reduced production cost, and reduced time to market |
| **C** | Context | The context in which the comparison takes place (e.g., academia or industry, practitioners or students) |

Kitchenham notes that not all question components will be applicable to all questions, but the framework ensures systematic consideration of each element.

Research questions should also be:
- **Meaningful** — answerable based on available research
- **Specific** — not too broad to be addressable
- **Structured** — decomposable into sub-questions if needed

### Adaptation EBSE-Guide

**Format PICOC adapte au logiciel :**

| Lettre | Signification | Description |
|--------|---------------|-------------|
| **P** | Projet/Population | Type de projet (web app, API, mobile, CLI, etc.), taille d'equipe, contraintes |
| **I** | Intervention | Outil, framework, pratique ou configuration evaluee |
| **C** | Comparison | Alternative(s) a l'intervention |
| **O** | Outcome | Resultat mesurable : performance, securite, maintenabilite, satisfaction dev, fiabilite |
| **Co** | Context | Contexte de deploiement : production/side-project, equipe junior/senior, open-source/entreprise, budget |

**Exemple :**

```
P  = Web app avec API REST, equipe 1-10 devs
I  = PostgreSQL
C  = MySQL, MongoDB, SQLite
O  = Fiabilite, satisfaction developpeur, ecosysteme, scalabilite
Co = Production, equipe mixte junior/senior, budget limite
```

Question formulee : "Pour une web app avec API REST (equipe 1-10 devs) en production avec equipe mixte et budget limite, PostgreSQL offre-t-il une meilleure fiabilite et satisfaction developpeur que MySQL, MongoDB ou SQLite ?"

**Regles :**
- Chaque case active de la matrice (etape 1.2) genere au moins une question PICOC
- Si le P (type de projet) varie, formuler plusieurs questions PICOC avec des P differents
- Le C (comparaison) doit inclure TOUTES les alternatives trouvees par decouverte systematique
- Le Co (contexte) doit inclure le contexte de deploiement (production vs prototype, equipe senior vs junior, etc.)

**Decouverte des alternatives (sous-procedure de 1.3) :**

Avant de formuler le PICOC, identifier exhaustivement tous les outils/pratiques existants.

Recherche systematique dans des bases exhaustives :

| Base | Couvre quoi | Type de recherche |
|------|-------------|-------------------|
| **npm registry** | Tous les packages JavaScript | Recherche par mots-cles derives du PICOC |
| **Maven Central** | Tous les packages Java | Idem |
| **PyPI** | Tous les packages Python | Idem |
| **GitHub** | Tous les projets open source | Idem |
| **Stack Overflow Survey** | Outils utilises par ~70k devs, par categorie | Lecture des categories correspondantes |
| **State of JS / State of CSS** | Outils frontend par categorie | Idem |
| **CNCF Landscape** | Outils cloud native par categorie | Idem |

Regles de decouverte :
- Chercher dans TOUTES les bases applicables au domaine (JS : npm + SO + State of JS, Java : Maven + SO, etc.)
- Les mots-cles de recherche sont derives du PICOC (I et C)
- Documenter : base cherchee, mots-cles utilises, nombre de resultats, outils retenus
- Un outil non present dans aucune base n'est pas evalue (limite documentee)

---

## 1.4 — Developing a review protocol

*Kitchenham 2007, section 5.4*

### Procedure Kitchenham

A pre-defined protocol is necessary to reduce the possibility of researcher bias. The protocol specifies the methods that will be used to undertake a specific systematic review. A protocol should include ALL the following components:

1. **Background** — the rationale for the survey
2. **Research questions** — the questions the review is intended to answer
3. **Search strategy** — the strategy that will be used to search for primary studies including search terms and resources to be searched (both electronic databases and specific journals or conference proceedings)
4. **Study selection criteria and procedures** — the criteria and procedures used to determine which studies are included in, or excluded from, the systematic review
5. **Study quality assessment checklists and procedures** — the checklists and procedures used to assess the quality of each included primary study
6. **Data extraction strategy** — how the information required from each primary study will be obtained
7. **Synthesis of the extracted data** — the strategy for synthesising the extracted data (meta-analysis if appropriate, or narrative synthesis)
8. **Project timetable** — the expected schedule for the review
9. **Dissemination strategy** — how the results will be reported (optional at protocol stage)

Kitchenham emphasises that the protocol should be treated as a living document: changes are permitted but must be documented as protocol amendments.

### Adaptation EBSE-Guide

**Ce document (methodology.md) EST le protocole.** Il contient tous les composants requis par Kitchenham :

| Composant Kitchenham | Ou dans ce document |
|----------------------|---------------------|
| Background | Section 1.1 (Need for review) + 1.2 (Commissioning) |
| Research questions | Section 1.3 (PICOC) |
| Search strategy | Section 2.1 (Identification of research) |
| Study selection criteria and procedures | Section 2.2 (Selection of primary studies) |
| Study quality assessment checklists and procedures | Section 2.3 (Study quality assessment) |
| Data extraction strategy | Section 2.4 (Data extraction and monitoring) |
| Synthesis of extracted data | Section 2.5 (Data synthesis) |
| Project timetable | Fichier PLAN.md (externe a ce document) |
| Dissemination strategy | Section 3.1 (Dissemination) |

**Regles de gestion du protocole :**
- Le protocole ne peut PAS etre modifie apres approbation sans documentation de la deviation
- Toute modification est un "protocol amendment" documente dans le journal de decisions (section 3.2)
- Le protocole est versionne (version actuelle : 3.0)

---

## 1.5 — Evaluating the review protocol

*Kitchenham 2007, section 5.5*

### Procedure Kitchenham

The review protocol should be reviewed and agreed upon by all the review team members. The protocol may also be reviewed by external experts. Kitchenham identifies two sub-procedures:

**1. Peer review of the protocol:**
- The protocol should be reviewed by an independent researcher or methodologist
- The reviewer checks the protocol for completeness, consistency, and feasibility
- Disagreements should be resolved by discussion or by involving additional reviewers

**2. Piloting the protocol:**
- Before undertaking the full review, the protocol should be piloted on a small sample of primary studies
- Piloting verifies that: (a) the inclusion/exclusion criteria are workable, (b) the quality assessment instruments are appropriate, (c) the data extraction forms capture all the required information
- Results of piloting should be used to refine the protocol before it is finalised

### Adaptation EBSE-Guide

**Revue par les pairs du protocole :**

Avant d'executer la recherche, le protocole complet (scope, PICOC, criteres, strategie) est soumis a revue :

1. **Reviewer independant** (humain ou agent IA dans un contexte separe) lit le protocole
2. Le reviewer verifie :
   - Les PICOC sont complets et sans ambiguite
   - Les criteres d'inclusion/exclusion sont clairs et applicables
   - La strategie de recherche couvre les bases pertinentes
   - Le scope n'a pas d'oublis evidents
3. Les retours sont documentes et integres
4. Le protocole revise est marque comme **approuve** avec date et identifiant du reviewer

**Pilotage (test sur un echantillon) :**

Avant l'execution complete, le protocole est teste sur un petit echantillon :

1. Selectionner **3 a 5 questions PICOC** representatives (couvrant differents domaines)
2. Executer le protocole complet sur cet echantillon (recherche, selection, extraction, GRADE)
3. Evaluer :
   - Le temps par question PICOC (pour estimer l'effort total)
   - Le kappa inter-reviewers sur l'echantillon
   - Les ambiguites dans les criteres ou le formulaire d'extraction
4. Ajuster le protocole si necessaire (documenter les ajustements comme deviations, section 3.2)
5. Le pilotage est documente avec les resultats et les ajustements

**Regles :**
- Le protocole ne peut PAS etre modifie apres approbation sans documentation de la deviation
- Les donnees du pilotage PEUVENT etre integrees dans les resultats finaux si le protocole n'a pas change entre le pilotage et l'execution

---

# Phase 2 — Conducting the review

---

## 2.1 — Identification of research

*Kitchenham 2007, section 6.1*

### Procedure Kitchenham

The objective of a systematic review is to find as many primary studies relating to the research question as possible using an unbiased search strategy. Key sub-procedures:

**6.1.1 — Search strategy:**
- Derive search terms from the research questions (PICOC)
- Identify alternative spellings, synonyms, and related terms
- Use Boolean operators (AND, OR, NOT) to construct search strings
- Consider the use of wild cards and truncation
- Pilot the search string to verify coverage

Kitchenham recommends supplementing electronic database searches with:
- Reference list checking (backward snowballing)
- Citation searching (forward snowballing)
- Manual searching of key journals/conferences
- Contact with known experts in the field
- Grey literature searches

**6.1.2 — Publication bias:**
Positive research results are more likely to be published than negative results. Strategies to mitigate:
- Include grey literature (technical reports, work in progress, unpublished studies)
- Search multiple databases, not just one
- Do not restrict to English-language publications only
- Consider contacting researchers for unpublished work

**6.1.3 — Documenting search strategy (Table 2):**

Kitchenham's Table 2 — Search documentation for each database:

| Element | Description |
|---------|-------------|
| Database name | The name of the electronic database or resource searched |
| Search strategy | The exact search string used |
| Years covered | The range of publication years searched |
| Date of search | When the search was conducted |
| Years of publication searched | Specific year range |
| Complete list of included data sources | All journals, conferences, etc. within the database that were searched |

**6.1.4 — Lessons learned (Kitchenham):**
- Structured questions help identify appropriate search terms
- Search strings can be very complex and may need iteration
- Determining appropriate search strategies is currently one of the weakest areas of SLR practice in SE
- Researchers should be prepared to iterate search terms
- The completeness of a search can never be guaranteed

### Adaptation EBSE-Guide

**Flux PRISMA :**

A chaque execution de recherche, documenter le flux suivant (adapte de PRISMA 2020) :

```
IDENTIFICATION
  Sources identifiees par base :
    - npm registry : N resultats
    - Maven Central : N resultats
    - GitHub : N resultats
    - SO Survey : N categories consultees
    - State of JS : N categories consultees
    - CNCF Landscape : N categories consultees
    - Snowballing : N sources additionnelles
    - Autres bases : N resultats
  Total identifie : N
  Doublons retires : N
  Total apres deduplication : N

SCREENING (titre + resume)
  Sources screenees : N
  Sources exclues au screening : N
    - E1 (niveau 6) : N
    - E2 (obsolete) : N
    - E3 (langue) : N
    - E4 (marketing) : N
    - E5 (sans auteur) : N
    - E6 (hors contexte) : N

ELIGIBILITE (lecture complete)
  Sources evaluees en detail : N
  Sources exclues apres lecture complete : N (avec raison pour chaque)

INCLUSION
  Sources incluses dans la synthese : N
    - Niveau 1 : N
    - Niveau 2 : N
    - Niveau 3 : N
    - Niveau 4 : N
    - Niveau 5 : N
```

**Documentation de la recherche (Table 2 Kitchenham) :**

Pour chaque base interrogee, documenter :

| Element | Valeur |
|---------|--------|
| Nom de la base | (ex: npm registry) |
| Strategie de recherche | Mots-cles exacts utilises |
| Annees couvertes | (ex: 2021-2026) |
| Date de la recherche | YYYY-MM-DD |
| Nombre de resultats | N |
| Sources retenues | Liste |

**Documentation PRISMA :**

Le flux PRISMA est enregistre pour chaque question PICOC (ou batch de questions PICOC) dans `verification/prisma/`.

Format du fichier :

```markdown
# PRISMA Flow — [Question PICOC ou Batch]

**Date de recherche** : YYYY-MM-DD
**Bases interrogees** : [liste]
**Mots-cles** : [liste]

## Flux
[Tableau PRISMA ci-dessus rempli]

## Documentation recherche (Table 2 Kitchenham)
[Un tableau par base]

## Sources exclues avec raisons
| # | Source | Critere d'exclusion | Raison |
|---|--------|---------------------|--------|
| 1 | Titre / URL | E1-E6 | Justification |
```

**Biais de publication :**
- Rechercher activement des sources negatives (critiques, post-mortems, issues GitHub, articles "pourquoi on a quitte X")
- Ne pas se limiter aux sources en anglais si des sources francophones de qualite existent
- Inclure les grey literature : technical reports, RFC drafts, blog posts d'entreprises majeures (si niveau >= 5)

**Snowballing :**

Procedure identique a Kitchenham (backward + forward snowballing) :

*Backward snowballing (references citees)* : pour chaque source incluse de niveau 1 a 3, examiner la bibliographie / les liens references, identifier les references pertinentes pour le PICOC, appliquer les criteres d'inclusion/exclusion.

*Forward snowballing (qui cite cette source)* : pour chaque source cle (niveau 1-2 ou source fondatrice), rechercher les documents/articles qui citent cette source (via Google Scholar, GitHub, etc.), appliquer les criteres d'inclusion/exclusion.

*Critere d'arret* : le snowballing s'arrete quand aucune nouvelle source pertinente n'est trouvee sur 2 iterations consecutives OU le nombre de sources trouvees par snowballing represente < 5% du total des sources identifiees.

**Regles :**
- Le flux PRISMA est OBLIGATOIRE pour chaque batch de recherche
- Chaque source exclue apres lecture complete a une raison individuelle documentee
- Le total inclus doit correspondre au nombre de sources dans les formulaires d'extraction

---

## 2.2 — Selection of primary studies

*Kitchenham 2007, section 6.2*

### Procedure Kitchenham

**6.2.1 — Study selection criteria:**
Once a set of potentially relevant primary studies has been obtained, they need to be assessed for their actual relevance. Study selection criteria are intended to identify those primary studies that provide direct evidence about the research question. Selection criteria are based on the research question and should be piloted (section 1.5).

Inclusion criteria specify the characteristics a study must have to be included. Exclusion criteria specify the characteristics that would lead to excluding a study.

**6.2.2 — Study selection process:**
Kitchenham recommends a multi-stage selection process:
1. **Initial selection** — based on title and abstract (screening)
2. **Full-text assessment** — reading the complete study to confirm relevance
3. **Final inclusion** — based on full assessment against all criteria

Practical guidelines:
- The final inclusion/exclusion decision should be based on the full text
- In case of doubt, include the study at the screening stage and make the final decision at full-text stage
- Maintain a list of excluded studies with reasons for exclusion

**6.2.3 — Reliability of inclusion decisions (kappa statistic):**
To reduce the possibility of bias, the selection process should be independently verified:
- Each study is independently assessed by at least two reviewers
- Inter-rater agreement is measured using Cohen's kappa statistic
- Disagreements are resolved by discussion or by a third reviewer

Kappa interpretation:
| Kappa | Agreement |
|-------|-----------|
| < 0.20 | Poor |
| 0.21-0.40 | Fair |
| 0.41-0.60 | Moderate |
| 0.61-0.80 | Good/Substantial |
| 0.81-1.00 | Very good/Almost perfect |

Kitchenham notes that if the kappa is low (< 0.6), the selection criteria may be too ambiguous and should be refined.

### Adaptation EBSE-Guide

**Criteres d'inclusion :**

Une source est INCLUSE si elle remplit TOUS les criteres suivants :

| # | Critere | Justification |
|---|---------|---------------|
| I1 | La source traite directement de l'intervention (I) ou de la comparaison (C) du PICOC | Pertinence |
| I2 | La source fournit des donnees factuelles (chiffres, specifications, recommandations normatives) | Objectivite |
| I3 | La source est de niveau 1 a 5 dans la pyramide des preuves (voir section 2.4) | Fiabilite minimale |
| I4 | La source est datee de moins de 5 ans OU est un standard toujours en vigueur | Actualite |
| I5 | La source est accessible (URL valide, document telecharger, texte lisible) | Verifiabilite |

**Criteres d'exclusion :**

Une source est EXCLUE si elle remplit AU MOINS UN des criteres suivants :

| # | Critere | Justification |
|---|---------|---------------|
| E1 | Source de niveau 6 (blog individuel, tutoriel, video YouTube sans donnees) | Fiabilite insuffisante |
| E2 | Source datee de plus de 5 ans ET n'est pas un standard toujours en vigueur | Obsolescence |
| E3 | Source dans une langue non verifiable par les reviewers | Impossibilite de verification |
| E4 | Source exclusivement marketing (white paper vendeur sans donnees independantes) | Conflit d'interet majeur |
| E5 | Source sans auteur identifiable ni organisation reconnue | Tracabilite impossible |
| E6 | Source traitant d'un contexte (P) radicalement different de celui du PICOC | Indirectness trop forte |

**Documentation des exclusions :**
Chaque source exclue est documentee avec :
- L'identifiant de la source (titre, URL)
- Le critere d'exclusion applique (E1 a E6)
- Une phrase de justification

**Processus multi-etapes :**
1. **Screening (titre + resume)** : appliquer les criteres d'exclusion E1 a E6 sur le titre et le resume/description de la source
2. **Lecture complete** : pour les sources restantes, lire le texte complet et verifier les criteres d'inclusion I1 a I5
3. **Decision** : chaque source recoit un statut INCLUSE ou EXCLUE (avec raison)
4. **Double screening** : la selection est faite independamment par 2 reviewers ; les divergences sont resolues par discussion

**Regles :**
- Le screening est base sur les criteres definis ci-dessus, pas sur le jugement subjectif
- En cas de doute, la source est INCLUSE (pour etre evaluee en detail)
- Si kappa < 0.6, les criteres sont affines avec des exemples de calibration supplementaires
- Les sources inaccessibles sont traitees par la procedure de verification (section 2.4)

---

## 2.3 — Study quality assessment

*Kitchenham 2007, section 6.3*

### Procedure Kitchenham

Over and above general inclusion/exclusion criteria, it is considered important to assess the "quality" of primary studies. Quality assessment is needed to:
- Provide more detailed inclusion/exclusion criteria
- Investigate whether quality differences provide an explanation for differences in study results
- Provide a means of weighting the importance of individual studies when results are being synthesised
- Guide interpretation of findings and determine the strength of inferences
- Guide recommendations for further research

**6.3.1 — Hierarchy of evidence:**
Kitchenham proposes a hierarchy of evidence for SE (adapted from medical research):

| Level | Type of evidence |
|-------|------------------|
| 1 | Systematic reviews / meta-analyses of randomized controlled trials |
| 2 | Randomized controlled trials (RCTs) |
| 3 | Non-randomized controlled studies (quasi-experiments) |
| 4 | Case studies, cross-sectional surveys |
| 5 | Expert opinion, formal consensus |
| 6 | Anecdotal evidence |

**6.3.2 — Quality instruments:**

**Table 4 — Types of bias relevant to quality assessment:**

| Bias type | Description |
|-----------|-------------|
| **Selection bias** | Systematic differences between baseline characteristics of the groups that are compared |
| **Performance bias** | Systematic differences in the care provided apart from the intervention being evaluated |
| **Detection/measurement bias** | Systematic differences between groups in how outcomes are determined |
| **Attrition bias** | Systematic differences between groups in withdrawals from a study |
| **Reporting bias** | Systematic differences between reported and unreported findings |

Kitchenham notes that for SE studies, additional quality issues are important:
- How were the subjects selected? Were they representative?
- How were confounding factors managed?
- Was blinding used?
- Was the study design adequate for the research question?

**Table 5 — Generic quality checklist for primary studies:**

| # | Question | Yes / No / Partial / N/A |
|---|----------|--------------------------|
| Q1 | Is the study based on research (rather than expert opinion)? | |
| Q2 | Is there a clear statement of the aims of the research? | |
| Q3 | Is there an adequate description of the context in which the research was carried out? | |
| Q4 | Was the research design appropriate to address the aims of the research? | |
| Q5 | Was the recruitment strategy appropriate to the aims of the research? | |
| Q6 | Was there a control group with which to compare treatments? | |
| Q7 | Was the data collected in a way that addressed the research issue? | |
| Q8 | Was the data analysis sufficiently rigorous? | |
| Q9 | Has the relationship between researcher and participants been adequately considered? | |
| Q10 | Is there a clear statement of findings? | |
| Q11 | Is the study of value for research or practice? | |

Each question is scored: Yes = 1, Partial = 0.5, No = 0.

**6.3.3 — Using quality data:**
Quality assessment data can be used in several ways:
- As a threshold for inclusion/exclusion (e.g. only include studies scoring >= 6/11)
- As a weighting factor in the synthesis (higher quality studies receive more weight)
- As a basis for sensitivity analysis (check whether excluding low-quality studies changes the results)
- As an explanatory factor (do lower quality studies report systematically different results?)

### Adaptation EBSE-Guide

**Pourquoi nous adaptons la hierarchie de Kitchenham :**
La hierarchie de Kitchenham est concue pour des etudes empiriques academiques (RCT, quasi-experiments). Nos "etudes primaires" sont des sources heterogenes (standards internationaux, docs officielles, enquetes, benchmarks). Nous utilisons donc une pyramide des preuves adaptee au logiciel.

**Pyramide des preuves (adaptee au logiciel) :**

| Niveau | Type de source | Exemple | Fiabilite |
|--------|---------------|---------|-----------|
| **1** | Standards internationaux (consensus, peer-review) | ISO/IEC, W3C WCAG, IEEE, IETF RFC, lois (RGPD) | Tres haute |
| **2** | Consortiums industrie ouverts | OWASP ASVS, CNCF, OpenAPI | Haute |
| **3** | Documentation officielle du framework/outil | react.dev, spring.io, postgresql.org/docs | Haute (pour leur propre outil) |
| **4** | Donnees empiriques grande echelle | SO Survey (70k), State of JS (20k), npm downloads | Moyenne |
| **5** | Convergence d'experts reconnus | Fowler, Google SRE Book, Apple HIG, Material Design 3 | Moyenne (si convergent) |
| **6** | Expert individuel, blog, tutoriel | Article Medium, video YouTube | Faible — NON UTILISE |

**Correspondance avec la hierarchie Kitchenham :**

| Kitchenham level | Notre niveau | Justification |
|------------------|-------------|---------------|
| 1 (SLR/meta-analyse) | 1 (standards internationaux) | Les standards internationaux representent le plus haut niveau de consensus en SE pratique |
| 2 (RCT) | Rarement applicable | Les RCT sont quasi inexistants pour les choix d'outils SE |
| 3 (quasi-experiment) | 4 (enquetes grande echelle) | Les enquetes sont l'equivalent le plus proche |
| 4 (case study, survey) | 4 (enquetes grande echelle) | Idem |
| 5 (expert opinion) | 5 (experts convergents) | Direct mapping |
| 6 (anecdote) | 6 (blog individuel) | Direct mapping — exclu |

**Grille de risque de biais (adaptation Table 4 Kitchenham) :**

Pour CHAQUE source incluse, evaluer les dimensions suivantes. Les types de biais sont adaptes de la Table 4 de Kitchenham au contexte du choix d'outils SE :

| Dimension | Biais Kitchenham correspondant | Question | Risque |
|-----------|-------------------------------|----------|--------|
| **Conflit d'interet** | Performance bias | La source evalue-t-elle son propre produit ? | HAUT / BAS |
| **Self-published benchmark** | Detection/measurement bias | La source publie-t-elle ses propres benchmarks sans methodologie transparente ? | HAUT / BAS |
| **Vendor marketing** | Reporting bias | La source est-elle un white paper vendeur ou un article sponsorise ? | HAUT / BAS |
| **Echantillon** | Selection bias | L'echantillon est-il < 1000 repondants pour une enquete ? | HAUT / BAS |
| **Obsolescence** | Attrition bias (temporal) | La source a-t-elle plus de 3 ans (pour les donnees d'adoption/satisfaction) ? | HAUT / BAS |
| **Selection bias** | Selection bias | L'echantillon est-il biaise (ex: enquete sur un site specifique = que les utilisateurs de ce site) ? | HAUT / BAS |
| **Methodologie** | Detection/measurement bias | La methodologie de collecte des donnees est-elle decrite et reproductible ? | HAUT / BAS |

**Risque global :**

| Nombre de dimensions a HAUT risque | Risque global |
|-------------------------------------|---------------|
| 0 | Faible |
| 1-2 | Modere |
| 3+ | Eleve |

**Impact sur GRADE :**
- Risque **faible** : pas d'ajustement GRADE
- Risque **modere** : -1 au score GRADE (cumule avec les autres facteurs negatifs)
- Risque **eleve** : la source est retrogradee d'un niveau dans la pyramide OU exclue si le risque est majeur (documenter la decision)

**Checklist de qualite (adaptation Table 5 Kitchenham) :**

| # | Question originale Kitchenham | Question adaptee SE | Applicable ? |
|---|------------------------------|---------------------|:------------:|
| Q1 | Is the study based on research? | La source est-elle basee sur des donnees (pas juste une opinion) ? | OUI |
| Q2 | Clear statement of aims? | La source a-t-elle un objectif clair ? | OUI |
| Q3 | Adequate description of context? | Le contexte (technologie, version, environment) est-il decrit ? | OUI |
| Q4 | Appropriate research design? | La methodologie est-elle appropriee (enquete, benchmark, analyse) ? | OUI |
| Q5 | Appropriate recruitment strategy? | L'echantillon est-il representatif (pas juste utilisateurs d'un seul outil) ? | OUI |
| Q6 | Was there a control group? | Y a-t-il une comparaison avec des alternatives ? | OUI (adapte : "comparaison" au lieu de "control group") |
| Q7 | Data collected appropriately? | Les donnees sont-elles collectees de maniere transparente ? | OUI |
| Q8 | Sufficiently rigorous analysis? | L'analyse est-elle rigoureuse (pas de cherry-picking) ? | OUI |
| Q9 | Researcher/participant relationship considered? | Le conflit d'interet est-il declare ? | OUI (adapte : "conflit d'interet" au lieu de "relationship") |
| Q10 | Clear statement of findings? | Les resultats sont-ils clairement presentes ? | OUI |
| Q11 | Value for research or practice? | La source est-elle utile pour le choix pratique ? | OUI |

Scoring : Yes = 1, Partial = 0.5, No = 0. Score total sur 11.

**Utilisation des donnees de qualite (6.3.3) :**
- Seuil d'inclusion : score qualite >= 5/11 pour etre retenue
- Ponderation : les sources de qualite superieure (>= 8/11) recoivent un poids accru dans la synthese
- Analyse de sensibilite : verifier si l'exclusion des sources < 7/11 change les conclusions
- Explication : les divergences entre sources sont-elles correles a leur qualite ?

**Formulaire de risque de biais :**

```
SOURCE : ___
RISQUE DE BIAIS :
  Conflit d'interet :    [ ] HAUT  [ ] BAS  — Detail : ___
  Self-published bench : [ ] HAUT  [ ] BAS  — Detail : ___
  Vendor marketing :     [ ] HAUT  [ ] BAS  — Detail : ___
  Echantillon :          [ ] HAUT  [ ] BAS  — Detail : ___
  Obsolescence :         [ ] HAUT  [ ] BAS  — Detail : ___
  Selection bias :       [ ] HAUT  [ ] BAS  — Detail : ___
  Methodologie :         [ ] HAUT  [ ] BAS  — Detail : ___
  RISQUE GLOBAL :        [ ] Faible  [ ] Modere  [ ] Eleve
  IMPACT GRADE :         ___

CHECKLIST QUALITE (Table 5 adaptee) :
  Q1  (donnees, pas opinion) :  [ ] Yes  [ ] Partial  [ ] No  [ ] N/A
  Q2  (objectif clair) :        [ ] Yes  [ ] Partial  [ ] No  [ ] N/A
  Q3  (contexte decrit) :       [ ] Yes  [ ] Partial  [ ] No  [ ] N/A
  Q4  (methodologie adaptee) :  [ ] Yes  [ ] Partial  [ ] No  [ ] N/A
  Q5  (echantillon representatif) : [ ] Yes  [ ] Partial  [ ] No  [ ] N/A
  Q6  (comparaison) :           [ ] Yes  [ ] Partial  [ ] No  [ ] N/A
  Q7  (collecte transparente) : [ ] Yes  [ ] Partial  [ ] No  [ ] N/A
  Q8  (analyse rigoureuse) :    [ ] Yes  [ ] Partial  [ ] No  [ ] N/A
  Q9  (conflit interet declare) : [ ] Yes  [ ] Partial  [ ] No  [ ] N/A
  Q10 (resultats clairs) :      [ ] Yes  [ ] Partial  [ ] No  [ ] N/A
  Q11 (utilite pratique) :      [ ] Yes  [ ] Partial  [ ] No  [ ] N/A
  SCORE QUALITE :               ___/11
```

**Clarifications pour le classement des sources (amelioration kappa) :**

Ces clarifications resolvent les divergences observees entre reviewers (kappa batch 1 = 0.456).

**Niveau 3 — "doc officielle RECOMMANDE" vs "doc officielle MENTIONNE" :**
- Si la doc dit "nous recommandons X" ou X est le defaut auto-configure : score de depart = 2 (niveau 3 prescriptif)
- Si la doc dit "X est supporte" sans recommandation explicite : traiter comme niveau 4 (mention, pas prescription)
- Exemple : Spring Boot docs "Logback is used for logging" (defaut) = niveau 3 prescriptif
- Exemple : Spring Boot docs "Log4j2 is supported" (alternative) = niveau 4 (mention)

**Design systems (Material Design, Apple HIG) = niveau 5, PAS niveau 3 :**
- Material Design est le design system de Google (une entreprise), pas un standard industriel
- Apple HIG est le design system d'Apple (une entreprise), pas un standard industriel
- Ils sont au niveau 5 (expert reconnu), pas au niveau 3 (doc officielle du framework utilise)
- Exception : si le projet UTILISE Material Design comme design system (ex: Angular Material), alors c'est niveau 3

**Enquetes — quel seuil pour "grande echelle" :**
- SO Survey (~70k), JetBrains (~25k), State of JS (~20k) = niveau 4 (grande echelle)
- Grafana Survey (~1250), Sparkbox (~1500) = niveau 4 (echelle moderee, mais donnees specifiques)
- npm downloads = niveau 4 (donnees factuelles, pas d'enquete)
- Enquete < 500 repondants = niveau 5 (trop petit pour etre representative)

**Exemples de calibration concrets (15 exemples pour aligner les reviewers) :**

| Source | Niveau | Justification |
|--------|--------|---------------|
| NIST SP 800-63B "passwords SHALL be at least 8 characters" | **1** | Standard gouvernemental, langage normatif (SHALL) |
| WCAG 2.2 SC 1.4.3 "contrast ratio at least 4.5:1" | **1** | W3C Recommendation, critere mesurable |
| RGPD Article 17 "droit a l'effacement" | **1** | Loi europeenne |
| OWASP ASVS V2.1.1 "passwords at least 12 characters" | **2** | Consortium ouvert, exigence numerotee |
| OWASP Top 10 A03 "use parameterized queries" | **2** | Consortium ouvert, recommandation prescriptive |
| Spring Boot docs "Logback is used for logging" (defaut) | **3** | Doc officielle, c'est le defaut auto-configure |
| Spring Boot docs "Log4j2 is supported" (alternative) | **4** | Mention sans recommandation |
| React docs "ESLint essential, eslint-plugin-react-hooks" | **3** | Doc officielle, mot "essential" = prescriptif |
| Vite docs "Vitest shares vite.config" (Vite utilise Vitest) | **3** | Le framework utilise cet outil lui-meme |
| SO Survey 2025 "PostgreSQL 55.6% adoption" | **4** | Enquete 70k repondants, donnee quantitative |
| npm trends "Vitest 82M/mois" | **4** | Donnee factuelle d'adoption |
| Google SRE Book "four golden signals" | **5** | Expert reconnu (une entreprise, pas un standard) |
| Material Design 3 "8dp grid" | **5** | Design system d'une entreprise, pas un standard |
| Martin Fowler "test pyramid" | **5** | Expert individuel reconnu |
| Kent Beck "tests should minimize programmer waiting" | **5** | Expert individuel reconnu |

**Regle de frontiere 4/5 vers 3/4 (la plus critique pour le GRADE) :**
Le score GRADE passe de [RECOMMANDE] (3-4) a [STANDARD] (5-7). La frontiere est entre 4 et 5.
- Score de depart 2 (niveau 3-4) + convergence (+1) + grande echelle (+1) = 4 vers [RECOMMANDE]
- Score de depart 3 (niveau 2) + convergence (+1) + grande echelle (+1) = 5 vers [STANDARD]
La distinction depend du niveau de la source la PLUS HAUTE. Avec les exemples ci-dessus, cette source est clairement classable.

---

## 2.4 — Data extraction and monitoring

*Kitchenham 2007, section 6.4*

### Procedure Kitchenham

The objective of this stage is to design data extraction forms to accurately record the information researchers obtain from primary studies. Key sub-procedures:

**6.4.1 — Design of data extraction forms:**
Data extraction forms should be designed to collect all the information needed to address the review questions and the study quality criteria. Each form should include:
- Name of the reviewer
- Date of data extraction
- Study identifier (title, authors, journal, publication details)
- Space for additional notes

The form should be piloted on a sample of studies and refined as necessary.

**6.4.2 — Data extraction form contents:**
The form should record:
- **Study identification data** — bibliographic details
- **Study features** — population, sample size, methodology, context
- **Study quality** — quality assessment results (from section 2.3)
- **Study outcomes** — results relevant to the review question(s)
- **Additional notes** — any other relevant information

**6.4.3 — Data extraction procedures:**
- Each included primary study should be independently data-extracted by at least two reviewers
- Disagreements should be resolved by discussion or by a third reviewer
- A common process to reduce effort is to have one reviewer extract data and a second reviewer check the extraction
- Data extraction forms should be stored and available for audit

**6.4.4 — Multiple publications of the same data:**
Researchers should be careful to identify when separate publications report the same study (and thus the same data). Including multiple publications of the same data would bias the synthesis. Strategies:
- Check for common authors, institutions, samples, and date ranges
- If multiple publications of the same study are identified, use only the most complete/recent version

**6.4.5 — Unpublished and missing data:**
When important information is missing from a primary study:
- Contact the original researchers to request the missing data
- Document any missing data in the extraction form
- Perform sensitivity analysis to assess the impact of missing data on the review conclusions

### Adaptation EBSE-Guide

**Formulaire d'extraction standardise :**

Pour CHAQUE source consultee, remplir :

```
SOURCE :
  Nom : ___
  URL / reference : ___
  Niveau pyramide : ___
  Date de publication : ___
  Reviewer : ___
  Date d'extraction : ___

RISQUE DE BIAIS : (reference au formulaire section 2.3)
  Risque global : Faible / Modere / Eleve
  Score qualite : ___/11

EXTRACTION :
  Citation exacte (copier-coller) : ___
  Donnee chiffree (si applicable) : ___
  Ce que la source dit de l'outil evalue : ___
  Conflit d'interet identifie (oui/non + detail) : ___

NOTES ADDITIONNELLES : ___
```

**Regles d'extraction :**
- Copier-coller les citations, ne jamais paraphraser
- Si une source ne dit rien sur l'outil evalue : noter "aucune mention"
- Si une source n'existe pas pour un niveau : noter "aucune source a ce niveau"
- Ne JAMAIS utiliser de source niveau 6

**Publications multiples (6.4.4) :**
En SE pratique, une meme donnee peut apparaitre dans plusieurs publications (ex: un meme benchmark cite par le vendeur ET par un article independant). Regles :
- Identifier les duplications (meme donnee, meme source primaire)
- Ne compter qu'une seule fois dans la synthese
- Utiliser la publication la plus complete/recente

**Donnees manquantes (6.4.5) :**
Quand une donnee importante est absente d'une source :
- Rechercher la donnee dans d'autres publications du meme auteur/organisation
- Si la donnee reste introuvable, documenter l'absence dans le formulaire
- Evaluer l'impact sur la synthese (la recommandation tient-elle sans cette donnee ?)

**Verification des sources (Agent C) :**

Pour CHAQUE source incluse, un agent verificateur independant (Agent C) effectue :

1. **Acces URL** : acceder a l'URL citee et confirmer :
   - L'URL est valide et accessible
   - Le contenu correspond a ce qui est cite dans le formulaire d'extraction
   - La citation exacte est presente dans la source
   - La date de publication est correcte
2. **Resultat** : chaque source recoit un statut :
   - **VERIFIE** : URL accessible, contenu confirme
   - **PARTIEL** : URL accessible mais contenu a change (documenter les differences)
   - **INACCESSIBLE** : URL non accessible (declencher la procedure ci-dessous)

**Procedure pour sources inaccessibles :**

Quand une source est inaccessible, appliquer dans l'ordre :
1. **WebSearch** : rechercher le titre exact + auteur
2. **Archive.org (Wayback Machine)** : chercher une version archivee de l'URL
3. **GitHub raw data** : si la source est un repo/doc GitHub, chercher le raw content ou un fork
4. **Citations tierces** : chercher des sources tierces qui citent et reprennent les donnees
5. **Contact auteur** : si possible, contacter l'auteur/organisation pour obtenir le document

Si la source reste inaccessible apres les 5 tentatives :
- La source est marquee **INACCESSIBLE** dans le formulaire d'extraction
- Elle ne peut PAS etre utilisee pour le calcul GRADE
- Une note est ajoutee dans le rapport final

**Regles :**
- La verification est faite par un agent DIFFERENT de celui qui a fait l'extraction (separation des roles)
- Les resultats de verification sont documentes dans `verification/access/`
- Une source non verifiee ne peut pas recevoir un niveau de confiance GRADE superieur a [BONNE PRATIQUE]

**Double extraction (identique a Cochrane, procedure Kitchenham 6.4.3) :**

1. **Reviewer A** remplit le formulaire d'extraction pour chaque source
2. **Reviewer B** remplit le meme formulaire independamment, sans voir le travail de A
3. **Comparaison** :
   - Les deux extractions sont identiques : valide
   - Divergence : relecture conjointe, identification de l'erreur, correction
4. **Mesure** : calculer le taux d'accord (kappa de Cohen)
   - kappa > 0.8 : accord excellent, methode fiable
   - kappa 0.6-0.8 : accord bon, verifier les divergences
   - kappa < 0.6 : formulaire a ameliorer, trop d'ambiguite

**Application avec IA :**
- Agent IA 1 et Agent IA 2 extraient independamment (contextes separes)
- Comparaison automatique des extractions
- Divergences flaggees pour verification humaine

**Tracabilite (OBLIGATOIRE) :**

Chaque page du guide DOIT avoir un fichier de tracabilite dans `verification/extractions/`.
Ce fichier prouve que la double extraction a ete faite et documente les resultats.

Format du fichier de tracabilite :

```markdown
# Double Extraction — [Batch/Page name]

**Date** : YYYY-MM-DD
**Agent A** : [identifiant agent]
**Agent B** : [identifiant agent]

## Comparaison

| # | Page | Agent A reco | Agent B reco | Accord reco | GRADE A | GRADE B | Accord GRADE |
|---|------|-------------|-------------|:-----------:|---------|---------|:------------:|
| 1 | nom-page | reco A | reco B | V ou X | X/7 | X/7 | V ou +/-N |

## Resultats
- Accord recommandations : X/Y (Z%)
- Accord GRADE : X/Y (Z%)
- Pages modifiees suite a la double extraction : [liste ou "aucune"]

## Divergences et resolution
[Pour chaque divergence : quelle divergence, comment resolue, quelle valeur retenue]
```

**Regles :**
- Un fichier de tracabilite manquant = la page n'est PAS consideree comme validee
- Les identifiants des agents doivent etre traces pour prouver que 2 contextes separes ont ete utilises
- Les divergences et leur resolution doivent etre documentees, pas juste "convergence totale"

---

## 2.5 — Data synthesis

*Kitchenham 2007, section 6.5*

### Procedure Kitchenham

Data synthesis involves collating and summarising the results of the included primary studies. Key sub-procedures:

**6.5.1 — Descriptive (narrative) synthesis:**
A narrative synthesis is always needed, even when statistical methods are used. It involves:
- Tabulating the results of individual studies
- Grouping studies by type, by quality, or by other relevant characteristics
- Providing a textual summary of the overall pattern of results
- Identifying areas of agreement and disagreement between studies

**6.5.2 — Quantitative synthesis (meta-analysis):**
Where studies are sufficiently similar, a quantitative meta-analysis may be appropriate. This involves:
- Calculating a weighted average effect size across studies
- Assessing heterogeneity (are the study results consistent?)
- Using forest plots to display results
- Using random effects or fixed effects models as appropriate

Kitchenham notes that quantitative meta-analysis is rarely appropriate in SE due to heterogeneity of study designs, contexts, and measures. When heterogeneity is high, narrative synthesis is preferred.

**6.5.3 — Qualitative synthesis:**
For qualitative studies, synthesis may involve:
- Identifying themes and patterns
- Cross-case analysis
- Building explanatory frameworks

**6.5.4 — Sensitivity analysis:**
Sensitivity analysis investigates the robustness of the review conclusions by:
- Repeating the analysis with different assumptions or criteria
- Excluding certain studies (e.g., low quality, high risk of bias) and checking whether conclusions change
- Varying the statistical methods used (if applicable)

**6.5.5 — Publication bias (funnel plots):**
Publication bias can be assessed by:
- Using funnel plots (for quantitative synthesis): plot effect size against sample size. Asymmetry suggests publication bias.
- Using statistical tests for asymmetry (Egger's test, Begg's test)
- Performing a "trim and fill" analysis to estimate missing studies

### Adaptation EBSE-Guide

**Synthese narrative (6.5.1) :**
Toujours presente. Chaque recommandation est accompagnee d'un resume narratif des sources, de leurs convergences et divergences.

**Synthese quantitative (6.5.2) — Score GRADE :**

La meta-analyse statistique classique (forest plots, effect sizes) n'est PAS applicable a notre contexte car nos "etudes" ne mesurent pas le meme outcome avec la meme methodologie. **Justification Kitchenham** : section 6.5.2 note que "quantitative meta-analysis is rarely appropriate in SE due to heterogeneity".

A la place, nous utilisons un scoring GRADE adapte, qui est une forme de synthese quantitative structuree :

**Score de depart :**

| Source la plus haute | Score de depart |
|---------------------|-----------------|
| Niveau 1 (standard international) | 4 |
| Niveau 2 (consortium ouvert) | 3 |
| Niveau 3 (doc officielle) | 2 |
| Niveau 4 (enquete grande echelle) | 2 |
| Niveau 5 (experts convergents) | 1 |

**Facteurs d'ajustement :**

La confiance MONTE (+1 chacun, max +3) :

| Facteur | Condition | Verification |
|---------|-----------|--------------|
| Convergence | 2+ sources independantes arrivent a la meme conclusion | Les sources sont-elles independantes ? Disent-elles la meme chose ? |
| Grande echelle | Donnees basees sur >10 000 repondants/observations | Verifier le N de l'echantillon |
| Effet important | La difference entre I et C est majeure et evidente | Le chiffre parle de lui-meme (ex: 78% vs 32%) |

La confiance DESCEND (-1 chacun, max -3) :

| Facteur | Condition | Verification |
|---------|-----------|--------------|
| Conflit d'interet | La source evalue son propre produit | Qui a produit la source ? |
| Incoherence | Les sources se contredisent | Comparer les conclusions des sources |
| Indirectness | La source parle d'un contexte different du P | Le contexte de la source correspond-il au P du PICOC ? |
| Imprecision | Petit echantillon ou intervalle de confiance large | N < 1000, ou resultats serres |
| Biais de publication | Seuls les succes sont publies | Y a-t-il des retours negatifs disponibles ? |
| Risque de biais eleve | La source a un risque global eleve (section 2.3) | Resultat de l'evaluation de biais |

**Calcul :**

```
Score final = Score de depart + facteurs positifs + facteurs negatifs
Minimum = 0, Maximum = 7
```

**Correspondance score vers niveau de confiance :**

| Score | Niveau | Label |
|-------|--------|-------|
| 5-7 | HAUTE | [STANDARD] |
| 3-4 | MOYENNE-HAUTE | [RECOMMANDE] |
| 2 | MOYENNE | [BONNE PRATIQUE] |
| 0-1 | BASSE | [CHOIX D'EQUIPE] |

**Evaluation formelle du biais de publication (6.5.5) :**

Les funnel plots ne sont pas applicables (pas de meta-analyse quantitative). **Justification Kitchenham** : les funnel plots necessitent des effect sizes numeriques comparables, ce que nous n'avons pas.

A la place, nous evaluons le biais de publication par verification systematique :

| Verification | Comment |
|-------------|---------|
| Retours negatifs existent-ils ? | Rechercher activement des critiques, post-mortems, issues GitHub, articles "pourquoi on a quitte X" |
| Les sources negatives ont-elles ete exclues ? | Verifier si des sources critiques ont ete exclues par les criteres |
| Les enquetes mesurent-elles l'insatisfaction ? | Verifier si les enquetes donnent aussi les % de "would NOT use again" |
| Asymetrie | Les sources sont-elles majoritairement positives ? Si oui, le biais de publication est suspect |

**Resultat :**
- **Biais de publication non detecte** : aucun ajustement
- **Biais de publication suspecte** : -1 au score GRADE (deja dans les facteurs negatifs)
- **Biais de publication confirme** : -2 au score GRADE + note dans le rapport

**Analyse de sensibilite (6.5.4) :**

Apres le calcul GRADE, verifier la robustesse de la recommandation :

1. **Retrait un-par-un** : retirer chaque source (une a la fois) et recalculer le score GRADE
   - Si la recommandation change de niveau (ex: [STANDARD] vers [RECOMMANDE]), la recommandation est **fragile**
   - Si la recommandation reste stable, elle est **robuste**

2. **Documentation :**
```
ANALYSE DE SENSIBILITE — [Question PICOC]
  Recommandation : ___
  Score GRADE de base : ___ / 7
  Niveau : ___

  | Source retiree | Score sans cette source | Niveau sans cette source | Changement ? |
  |---------------|------------------------|--------------------------|:------------:|
  | Source 1 | X/7 | [NIVEAU] | OUI / NON |
  | Source 2 | X/7 | [NIVEAU] | OUI / NON |
  | ... | ... | ... | ... |

  Conclusion : ROBUSTE / FRAGILE
  Si fragile : quelles sources sont critiques ? ___
```

3. **Impact sur le rapport :**
   - Recommandation **robuste** : presentee normalement
   - Recommandation **fragile** : un avertissement est ajoute, identifiant les sources critiques dont depend la recommandation

**Balance benefices vs risques (GRADE EtD) :**

Pour chaque recommandation, documenter explicitement :

| Dimension | Evaluation |
|-----------|-----------|
| **Benefices** | Quels sont les avantages concrets de l'intervention (I) vs la comparaison (C) ? Quantifier si possible. |
| **Risques / inconvenients** | Quels sont les risques, couts, complexites, vendor lock-in, courbe d'apprentissage ? |
| **Balance** | Les benefices l'emportent-ils clairement sur les risques ? |
| **Faisabilite** | L'intervention est-elle realisable dans le contexte P ? (ressources, competences, infrastructure requises) |

Format :
```
BALANCE BENEFICES/RISQUES — [Intervention]
  Benefices :
    - ___
    - ___
  Risques :
    - ___
    - ___
  Balance : Benefices > Risques / Equilibre / Risques > Benefices
  Faisabilite : Haute / Moyenne / Basse — Detail : ___
```

Impact :
- Si la balance est "Risques > Benefices" : la recommandation est degradee d'un niveau, meme si le GRADE est haut
- Si la faisabilite est "Basse" : la recommandation mentionne les prerequis necessaires

---

# Phase 3 — Reporting the review

---

## 3.1 — Specifying dissemination mechanisms

*Kitchenham 2007, section 7.1*

### Procedure Kitchenham

Dissemination mechanisms should be defined in the review protocol or at the latest during the conduct of the review. Potential dissemination mechanisms include:

- Journal papers or conference papers
- Technical reports
- Summarised results on the web
- Flyers/posters summarising the main results
- Direct communication to relevant practitioner bodies
- Press/media releases

Kitchenham notes that results should be disseminated to practitioners as well as researchers, as the primary goal of SLRs is to inform practice.

### Adaptation EBSE-Guide

**Mecanismes de dissemination :**

| Canal | Format | Audience |
|-------|--------|----------|
| **Application web** (app/) | Pages interactives avec arbre de decision, recommandations, sources | Developpeurs, equipes, CTOs |
| **API JSON** | Donnees structurees (recommandations, GRADE, sources) | Agents IA, outils automatises |
| **Fichiers Markdown** (guide/) | Pages detaillees par domaine (testing, auth, etc.) | Contributeurs, reviewers |
| **Fichiers de verification** (verification/) | PRISMA flows, double extractions, kappa reports | Auditeurs, reproductibilite |

**Regles :**
- Le format web est le canal primaire (audience : praticiens)
- L'API est le canal secondaire (audience : machines/IA)
- Les fichiers Markdown sont le canal de contribution/audit
- Les trois canaux doivent etre synchronises

### 3.1.1 — Arbre de decision : regles de design

L'arbre de decision (`data/decision-tree.json`) est le mecanisme primaire de personnalisation du guide.

**Regle 1 — Questions metier uniquement, jamais techniques**

L'utilisateur repond a des questions sur son contexte, pas sur sa stack. Le guide DEDUIT la tech depuis les reponses.

| Question valide | Question invalide |
|---|---|
| "Ou tes utilisateurs vont-ils utiliser ton app ?" | "Tu veux du React ou du Vue ?" |
| "Est-ce un jeu ou une app ?" | "Tu veux Godot ou Unity ?" |
| "Quel est ton budget infrastructure ?" | "Tu utilises Sentry ou GlitchTip ?" |
| "Un agent IA ecrira du code ?" | "Tu utilises Claude Code ou Cursor ?" |

**Regle 2 — Questions transverses AVANT divergence domain-specific**

Classification des questions :

| Type | Exemples | Placement |
|---|---|---|
| Transverses (applicables a tout projet) | budget, ai-agent-usage, scale, team-size, data-residency | Stage 1, avant divergence, sur un tronc commun unique |
| Domain-specific (applicables a une branche) | mobile=iOS/Android, game=pixel-art/3D, web=PWA/store | Stage 2, dans la branche correspondante |

Architecture :

```
Stage 1 — Transverses (tronc commun)
  budget → ai-agent-usage → team-size → scale

Stage 2 — Platform & domain (divergence)
  platform-question
  ├─ web → mobile-need → store-need → result
  ├─ mobile → mobile-type → mobile-kind
  │         └─ game-genre (si game) OU app-type (si app) → result
  └─ desktop → not-covered-yet

Stage 3 — Result
  result : accumule sets (budget, ai_agent, team_size, scale, platform, domain...)
         → selectionne stack profile via combinatoire (domain, budget)
```

Rationale : les SLR domain-specific filtrent leurs candidats selon les transverses. Si les transverses sont poses apres les SLRs, les recommendations sont figees sur des candidats qui peuvent ne plus correspondre aux contraintes.

Anti-pattern : dupliquer la question `budget` dans chaque branche. Les questions transverses doivent etre posees une seule fois sur le tronc commun.

**Regle 3 — Option "Laisse le guide decider (EBSE default)" obligatoire**

Chaque question DOIT offrir l'option "Laisse le guide decider" avec set `"ebse-default"` et un `default_recommendation` expliquant le defaut choisi.

Rationale : trois cas d'usage convergent vers le meme comportement :
1. L'utilisateur ne sait pas → veut un defaut sensible
2. L'utilisateur veut "le mieux" → veut l'optimal evidence-based
3. L'utilisateur considere la question comme non-contrainte → veut que le guide derive la valeur

Le guide applique les sources EBSE pour determiner la valeur evidence-based optimale pour le contexte. Le defaut EBSE EST l'optimal selon les sources, par definition.

Operationnellement : `sets: { question: "ebse-default" }`. Le synthesis downstream resout la valeur en appliquant le ranking O-matrix des PICOCs du domaine.

**Regle 4 — Budget a trois niveaux distincts**

Le tree DOIT offrir trois niveaux de budget :

| Niveau | Definition | Exclut |
|--------|------------|--------|
| `budget=open-source` | Self-host sur ton infra + OSS-licensed | Tout SaaS meme gratuit (free tier inclus) |
| `budget=free-ok` | Free tier SaaS + OSS self-host | Paid SaaS |
| `budget=saas-ok` | Tous candidats evalues sur merite | Rien |

Rationale : "open source" refere a la licence et au code source, pas au prix. Free tier SaaS est du SaaS proprietaire gratuit, pas open source. Les trois concepts — prix, licence, modele de deploiement — sont distincts et doivent etre represent es par des niveaux separes pour eviter l'ambiguite.

Les SLR domain-specific DOIVENT filtrer les candidats selon le niveau budget :
- `budget=open-source` : candidats SaaS (meme free tier) scored 1/5 sur O1, rejetes sauf platform-mandatory
- `budget=free-ok` : paid SaaS scored 1/5, rejetes ; free tier + OSS self-host acceptes
- `budget=saas-ok` : tous candidats evalues sur autres criteres

**Regle 5 — Services platform-mandatory acceptes dans tous niveaux budget**

Certains services sont requis pour distribution et ne sont pas des "choix" : Apple Developer, Google Play Console, Play Billing, StoreKit, AdMob (mobile ads), Play Vitals, Xcode Organizer. Ils sont acceptes dans tous les niveaux budget.

**Regle 6 — Decomposition des services hybrides par facette**

Certains services ont plusieurs facettes avec des classifications differentes. Ils doivent etre evalues par facette, pas comme un monolithe.

Cas canonique : GitHub / GitLab.com / Forgejo.org (git hosting + CI/CD platforms) :

| Facette | Classification | `budget=open-source` compliant ? |
|---------|----------------|:---------------------------------:|
| Git hosting (code repo) | OSS-adjacent (git distribue, pas de vendor lock-in) | Oui |
| Workflow YAML syntax | Texte standard dans ton repo, portable | Oui |
| Hosted runner / shared compute | SaaS compute | Non |
| Self-hosted runner | Ton infra | Oui |

Quand un SLR evalue un service hybride, le PICOC doit decomposer en facettes et scorer chacune. Exemple pour H33 CI/CD : "GitHub Actions" seul est ambigu, decomposer en "GitHub Actions + hosted runner" vs "GitHub Actions + self-hosted runner".

**Regle 7 — `sets` authoritative, `deduced_tech` commentaire**

`sets` persiste les choix utilisateur (inputs de la fonction synthesis). `deduced_tech` est un commentaire pour transparence au PO mais ne doit pas etre utilise dans la logique downstream — seul `sets` est authoritative.

**Checklist pour ajouter un nouveau domaine au guide :**

1. SLR complete pour le domaine (Phases 1-3) — genere PICOCs + synthesis + stack profile
2. Identifier les questions domain-specific (celles qui ne s'appliquent qu'a ce domaine)
3. Ajouter ces questions comme noeuds dans la branche domain, avec choix metier + option "Laisse le guide decider"
4. Faire converger la branche vers `next: "result"` (le tronc commun transverses est deja parcouru au Stage 1)
5. Inscrire `domain` dans les `sets` du dernier noeud domain-specific
6. Verifier que le noeud `result` combine `domain` + transverses pour selectionner le stack profile
7. Tester le flow complet avec les trois profils typiques : (a) budget=open-source + solo, (b) budget=free-ok + startup, (c) laisse-le-guide-decider partout

---

## 3.2 — Formatting the main report

*Kitchenham 2007, section 7.2*

### Procedure Kitchenham

**Table 8 — Recommended structure for a systematic review report:**

| Section | Content |
|---------|---------|
| **Title** | Identify the report as a systematic review |
| **Authorship** | Names and affiliations |
| **Executive summary** | Brief summary of the review, for a wider audience |
| **Background** | Rationale for the review, existing reviews/gaps |
| **Review questions** | Clearly stated research questions |
| **Review method** | Complete description of the method: search strategy, study selection criteria, quality assessment, data extraction, synthesis methods |
| **Included and excluded studies** | Lists of included studies (with key characteristics) and excluded studies (with reasons) |
| **Results** | Results for each research question, tabulated summaries, quality assessment results |
| **Discussion** | Interpretation of results, limitations, applicability |
| **Conclusions** | Summary of main findings, implications for practice, implications for research |
| **Acknowledgements** | Funding, assistance received |
| **Conflicts of interest** | Any conflicts declared |
| **References** | All references cited |
| **Appendices** | Data extraction forms, quality assessment forms, lists of excluded studies |

Kitchenham emphasises that the report should be sufficiently detailed to allow replication of the review.

### Adaptation EBSE-Guide

**Format de recommandation (equivalent des "Results" Table 8) :**

Chaque recommandation du guide suit ce format :

```
[NIVEAU] Recommandation en une phrase

  Contexte (P) : ___
  Score GRADE : ___ / 7
  Robustesse : ROBUSTE / FRAGILE (sources critiques : ___)
  Sources :
    - [niveau X] Source 1 : "citation exacte" [risque de biais : Faible/Modere/Eleve]
    - [niveau X] Source 2 : "citation exacte" [risque de biais : Faible/Modere/Eleve]
  Facteurs GRADE appliques :
    + convergence / grande echelle / effet important
    - conflit d'interet / incoherence / biais de publication / ...
  Balance benefices/risques :
    Benefices : ___
    Risques : ___
    Balance : ___
    Faisabilite : ___
  Alternatives evaluees : ___
  PRISMA : [reference au fichier PRISMA]
  Date : ___
```

**Arbre de decision (equivalent de "Executive summary" / outil pour praticiens) :**

L'outil pose des questions sur les **besoins metier** de l'utilisateur (qu'il connait). Le guide **deduit** les choix techniques (que l'utilisateur ne connait pas forcement). L'utilisateur ne voit JAMAIS de jargon technique dans les questions.

Structure :

```
PLATEFORME (ou tes utilisateurs utilisent l'app ?)
  -> BESOIN MOBILE (aussi sur telephone ? app store ?)
  -> NOMBRE D'UTILISATEURS (echelle)
  -> EXPERIENCE EQUIPE (quel langage ?)
  -> BUT DE L'APP (interactif, contenu, API, temps-reel)
  -> TYPE DE DONNEES (relationnelles ou documents)
  -> BUDGET (gratuit ou SaaS autorise)
  -> RESULTAT (le guide deduit toute la stack)
```

Questions metier uniquement (pas de jargon technique) :

| Question metier | Ce que le guide deduit | Source |
|----------------|----------------------|--------|
| "Ou tes utilisateurs utilisent l'app ?" | Plateforme (web/mobile/desktop) | Contrainte runtime W3C/Apple/Google |
| "Aussi sur telephone ?" | PWA si oui (batch 16, GRADE 6/7) | StatCounter 59% trafic mobile 2025 |
| "App Store obligatoire ?" | Capacitor si oui (batch 16, GRADE 5/7) | Batch 16 double extraction |
| "Combien d'utilisateurs ?" | Infrastructure (Docker Compose vs K8s) | Twelve-Factor, Google SRE |
| "Experience de l'equipe ?" | Langage vers backend framework | SWEBOK v4 SE Economics |
| "A quoi sert l'app ?" | Type projet (SPA/content/realtime/API) | SWEBOK v4 Software Architecture |
| "Comment sont tes donnees ?" | BDD (PostgreSQL/MongoDB) | SO Survey 2025 PostgreSQL #1 |
| "Budget outils ?" | Open source vs SaaS | Factuel |

"Je ne sais pas" obligatoire : chaque question DOIT avoir une option "je ne sais pas" avec une recommandation par defaut basee sur le GRADE EBSE le plus haut, une explication de pourquoi c'est le defaut, et l'utilisateur n'est jamais bloque.

Deduction technique (`deduced_tech`) :

```json
{
  "label": "Oui, souvent sur telephone",
  "sets": { "mobile_need": "pwa" },
  "deduced_tech": "PWA recommande (GRADE 6/7) — installable, offline, push. Meme codebase."
}
```

**Profils de stack et multi-stack (equivalent des "Results" groupes) :**

Regrouper les recommandations interdependantes en combinaisons coherentes et validees.

Methode :
1. Identifier les dependances : le choix de l'outil A influence-t-il le choix de l'outil B ?
   - Source : doc officielle de A (recommande-t-elle un outil B specifique ?)
   - Source : doc officielle de B (est-elle compatible avec A ?)
2. Regrouper les outils interdependants en "profils"
3. Chaque profil est une combinaison complete et coherente

Exemple de profil :

```
PROFIL : Web App — Java/React
  Backend     : Spring Boot     [RECOMMANDE] (SO Survey #1 satisfaction Java web)
  Frontend    : React           [RECOMMANDE] (SO Survey + State of JS)
  BDD         : PostgreSQL      [RECOMMANDE] (SO Survey #1 satisfaction SGBD)
  Tests back  : JUnit 5         [STANDARD] (doc Spring recommande JUnit)
  Tests front : Vitest          [RECOMMANDE] (doc Vite recommande Vitest)
  Test UI     : Testing Library [RECOMMANDE] (doc React recommande Testing Library)
  CI/CD       : GitHub Actions  [RECOMMANDE] (#1 adoption CI pour projets GitHub)
  Linter JS   : ESLint          [STANDARD] (doc React recommande ESLint)
  Formatter   : Prettier        [RECOMMANDE] (State of JS #1 formatter)
  
  Interdependances validees :
    - Spring docs -> JUnit (niveau 3)
    - Vite docs -> Vitest (niveau 3)
    - React docs -> Testing Library + ESLint (niveau 3)
```

Recommandations conditionnelles et multi-stack :

Chaque recommandation est stockee en JSON avec :
- `universal` : principes valables pour TOUTE stack (ex: "pyramide 70/20/10")
- `variants` : outils specifiques par stack (ex: { "java-spring-boot": "JUnit 5", "typescript-nestjs": "Vitest" })
- `depends_on` : liste des choix prealables qui affectent cette recommandation

Classification des pages :
- **UNIVERSEL** : la recommandation est valable quelle que soit la stack
- **MIXTE** : principes universels + outils stack-specific (la majorite des pages)
- **STACK-SPECIFIC** : uniquement pour une stack donnee

Obligation multi-stack : pour chaque page MIXTE ou STACK-SPECIFIC, les variantes pour **au moins 3 stacks backend** (Java/Spring Boot, TypeScript/NestJS, Python/Django) doivent exister. Chaque variante est sourcee via EBSE (PICOC, GRADE, double extraction). Les agents recherchant les variantes NE DOIVENT PAS voir le contenu des autres stacks pour eviter le biais.

**Correspondance Table 8 Kitchenham vers notre structure :**

| Section Table 8 | Equivalent EBSE-Guide | Emplacement |
|-----------------|----------------------|-------------|
| Title | Titre de la page guide | guide/01-stack-profiles/ ou guide/02-domains/ |
| Authorship | Agent A + Agent B + superviseur humain | verification/extractions/ |
| Executive summary | Arbre de decision + profils de stack | Application web |
| Background | Section 1.1 + 1.2 de cette methodologie | methodology.md |
| Review questions | PICOC de chaque page | Formulaire d'extraction |
| Review method | Ce document complet | methodology.md |
| Included and excluded studies | Flux PRISMA | verification/prisma/ |
| Results | Recommandation + GRADE + sources | guide/ |
| Discussion | Balance benefices/risques + analyse de sensibilite | guide/ (dans chaque page) |
| Conclusions | Niveau GRADE final + robustesse | guide/ (dans chaque page) |
| Conflicts of interest | Risque de biais par source | Formulaire d'extraction |
| References | Sources citees | guide/ (dans chaque page) |
| Appendices | Formulaires d'extraction, kappa reports | verification/ |

**Journal de decisions et deviations (equivalent de "Discussion" / "Appendices") :**

Un journal continu est maintenu tout au long du processus. Pour chaque decision significative :

```
JOURNAL DE DECISIONS — [Projet/Batch]

| # | Date | Decision | Justification | Impact | Decideur |
|---|------|----------|---------------|--------|----------|
| 1 | YYYY-MM-DD | Description de la decision | Pourquoi cette decision a ete prise | Quelles etapes/resultats sont affectes | Qui a decide |
```

Exemples de decisions a documenter :
- Ajout/retrait d'une base de recherche
- Modification d'un critere d'inclusion/exclusion
- Decision sur une source ambigue (incluse ou exclue)
- Resolution d'une divergence entre reviewers
- Choix methodologique non prevu par le protocole

Documentation des deviations de protocole :

```
DEVIATION DE PROTOCOLE — #[numero]

  Date : YYYY-MM-DD
  Etape du protocole concernee : ___
  Protocole original : ___
  Ce qui a ete fait a la place : ___
  Justification : ___
  Impact sur les resultats : ___
  Approuve par : ___
```

**Regles :**
- Le lecteur doit pouvoir verifier chaque recommandation en ouvrant les sources citees
- Si le score est <= 1, le guide ne recommande PAS — il dit "[CHOIX D'EQUIPE]" et liste les options
- Chaque recommandation porte une date et sera revalidee a la prochaine revision
- Les sources non verifiees (section 2.4) sont signalees
- Le journal est mis a jour EN TEMPS REEL, pas retrospectivement
- Les deviations sont numerotees et referencees dans le rapport final
- Un fichier de journal est maintenu dans `verification/decisions/`
- L'absence de journal pour un batch rend les resultats non auditables

---

## 3.3 — Evaluating the report

*Kitchenham 2007, section 7.3*

### Procedure Kitchenham

The systematic review report should be reviewed and evaluated before dissemination. Kitchenham identifies several mechanisms:

1. **Internal review** — by all members of the review team
2. **External peer review** — by independent experts not involved in the review
3. **Publication review** — through the normal peer review process of journals or conferences
4. **Stakeholder review** — by the commissioners of the review (if applicable)

The evaluation should check:
- Completeness of the review (all protocol elements covered)
- Accuracy of data extraction (spot-checking)
- Validity of the synthesis and conclusions
- Clarity of the report
- Identification of any remaining threats to validity

### Adaptation EBSE-Guide

**Mecanismes d'evaluation :**

| Mecanisme Kitchenham | Adaptation EBSE-Guide |
|---------------------|----------------------|
| Internal review | Double extraction + kappa (section 2.4) — deja integre dans le processus |
| External peer review | Revue du protocole par reviewer independant (section 1.5) |
| Publication review | Non applicable (pas de publication academique) |
| Stakeholder review | Test utilisateurs de l'application web + feedback |

**Verification finale :**

Avant publication d'une nouvelle page ou mise a jour, verifier :
- [ ] Le flux PRISMA est complet et documente
- [ ] La double extraction est faite et le fichier de tracabilite existe
- [ ] Le kappa est >= 0.6 (sinon, les criteres sont affines)
- [ ] L'analyse de sensibilite est documentee
- [ ] La balance benefices/risques est evaluee
- [ ] Le biais de publication est evalue
- [ ] Les sources sont verifiees par l'Agent C
- [ ] Le journal de decisions est a jour
- [ ] Les variantes multi-stack existent (si page MIXTE/STACK-SPECIFIC)

**Maintenance :**

| Frequence | Action |
|-----------|--------|
| **Revue annuelle** | Toutes les recommandations sont revalidees avec les sources mises a jour |
| **Revue ponctuelle** | Quand une source majeure change (nouvelle version ISO, nouvelle enquete SO Survey, etc.) |

Processus de mise a jour :
1. Pour chaque recommandation existante, verifier si les sources ont change
2. Si oui, reprendre les etapes 2.1-2.5 (recherche vers synthese)
3. Mettre a jour la date de la recommandation
4. Archiver l'ancienne version (historique des changements)
5. Re-executer l'analyse de sensibilite pour les recommandations modifiees

Versioning : le guide suit le versioning semantique `ANNEE.MOIS` (ex: `2026.04`). Chaque recommandation modifiee est marquee `[MAJ 2026.04]`.

**Watchlist — technologies emergentes :**

Ces technologies sont a reevaluer lors de chaque revue annuelle. Si leur adoption/satisfaction atteint un seuil significatif dans les enquetes, elles sont evaluees via EBSE et ajoutees au guide.

| Technologie | Categorie | Signal actuel (2026) | Seuil pour evaluation |
|------------|-----------|---------------------|----------------------|
| Bun | Runtime JS | ~2M dl/sem, satisfaction haute | Si >10% adoption SO Survey |
| Deno | Runtime JS | Croissance moderee | Si >5% adoption SO Survey |
| HTMX | Frontend alternatif | Niche, satisfaction tres haute | Si >5% adoption State of JS |
| Rust web (Actix, Axum) | Backend | Haute satisfaction, faible adoption | Si >3% adoption SO Survey |
| Go web (Gin, Fiber) | Backend | Bonne perf, ecosysteme croissant | Si >5% adoption backend SO |
| Drizzle ORM | ORM TypeScript | Croissance rapide, menace Prisma | Si downloads > Prisma |
| Biome | Linter+formatter | 35x plus rapide, 97% Prettier-compat | Si React docs le recommandent |
| SolidJS | Frontend | 90% satisfaction, 10% adoption | Si >15% adoption State of JS |
| Svelte 5 | Frontend | Haute satisfaction, runes | Si >15% adoption State of JS |

Processus watchlist : a chaque revue annuelle, verifier les metriques. Si un seuil est atteint : PICOC + double extraction + page guide.

---

# Annexes

---

## Limites documentees

| Limite | Explication |
|--------|-------------|
| **Couverture** | Le scope est base sur ISO/IEC 25010:2023, ISO/IEC 25019:2023 et SWEBOK v4 (2024). Si un domaine n'apparait dans aucun des trois, il n'est pas couvert. |
| **Decouverte** | Un outil absent de toutes les bases de recherche definies (npm, Maven, GitHub, enquetes) ne sera pas evalue. |
| **Qualite des preuves** | La plupart des preuves en genie logiciel sont de niveau 3-5 (docs, enquetes, experts). Les niveaux 1-2 (standards, consortiums) sont rares pour les choix d'outils. |
| **Contexte** | Les recommandations sont formulees pour des contextes definis (P du PICOC). Un contexte tres different peut invalider une recommandation. |
| **Biais des enquetes** | Les enquetes (SO Survey, State of JS) mesurent la popularite et la satisfaction parmi les repondants, avec un biais de selection (qui repond ?). |
| **Temporalite** | Les tendances (design, outils) evoluent. Les recommandations sont datees et doivent etre revalidees annuellement. |
| **Verification** | La verification d'acces (section 2.4) depend de la disponibilite des URLs au moment de la verification. Les sources peuvent devenir inaccessibles apres la verification. |
| **Sensibilite** | Certaines recommandations peuvent etre fragiles (dependantes d'une seule source). L'analyse de sensibilite identifie ces cas mais ne les resout pas. |
| **Absence de meta-analyse** | Les funnel plots et meta-analyses statistiques ne sont pas applicables (heterogeneite des sources). Le scoring GRADE est une alternative structuree mais moins puissante statistiquement. Justification : Kitchenham 2007, section 6.5.2. |

---

## References

### Methode
- Kitchenham, B.A. et al. (2004). *Evidence-Based Software Engineering*. ICSE 2004.
- Kitchenham, B.A. & Charters, S. (2007). *Guidelines for performing Systematic Literature Reviews in Software Engineering*. EBSE Technical Report EBSE-2007-01. — **Document fondateur de cette methodologie.**
- Kitchenham, B.A., Budgen, D. & Brereton, P. (2015). *Evidence-Based Software Engineering and Systematic Reviews*. CRC Press.
- GRADE Working Group. *GRADE Handbook*. https://gradepro.org/handbook/
- GRADE Working Group. *Evidence to Decision (EtD) Framework*. https://www.gradeworkinggroup.org/
- Moher, D. et al. (2009). *PRISMA Statement*. BMJ.
- Page, M.J. et al. (2021). *PRISMA 2020 Statement: an updated guideline for reporting systematic reviews*. BMJ.
- Cochrane Handbook for Systematic Reviews of Interventions. https://training.cochrane.org/handbook
- Wohlin, C. (2014). *Guidelines for snowballing in systematic literature studies*. EASE 2014.
- Centre for Reviews and Dissemination (CRD). *DARE — Database of Abstracts of Reviews of Effects*. University of York.

### Standards de scope (niveau 1)
- ISO/IEC 25010:2023. *Systems and software engineering — Product quality model*.
- ISO/IEC 25019:2023. *Systems and software engineering — Quality-in-use model*.
- IEEE Computer Society (2024). *SWEBOK v4 — Guide to the Software Engineering Body of Knowledge*.

### Standards de mesure (niveau 2)
- ISO/IEC 25023. *Measurement of system and software product quality*.

### Standards d'operationnalisation (niveau 3)
- OWASP ASVS. *Application Security Verification Standard*. https://owasp.org/www-project-application-security-verification-standard/
- OWASP Top 10. https://owasp.org/www-project-top-ten/
- W3C WCAG 2.2. *Web Content Accessibility Guidelines*. https://www.w3.org/TR/WCAG22/
- ISO 9241-110:2020. *Ergonomics of human-system interaction — Interaction principles*.
- Nielsen Norman Group. *10 Usability Heuristics*. https://www.nngroup.com/articles/ten-usability-heuristics/
- Wiggins, A. *The Twelve-Factor App*. https://12factor.net/
- Google. *Material Design 3*. https://m3.material.io/
- Apple. *Human Interface Guidelines*. https://developer.apple.com/design/human-interface-guidelines/

### Standards evalues mais non retenus
Les standards suivants ont ete evalues et ne sont pas retenus comme fondations car leur scope est couvert par les standards ci-dessus ou n'est pas pertinent pour le guide :
- PMBOK, BABOK, DSDM, SEBoK (gestion de projet / analyse metier / systemes — hors scope)
- CMMI, TOGAF, ITIL, COBIT, SAFe (gouvernance / maturite organisationnelle — hors scope pour petites equipes)
- NIST CSF, NIST 800-53, CIS Controls (securite infrastructure — couvert par OWASP au niveau applicatif)
- ISO/IEC 27001 (management securite — utile en reference mais OWASP ASVS est plus concret pour le code)
- ISO/IEC 12207 (processus lifecycle — couvert par SWEBOK)
- DAMA-DMBOK (gestion de donnees — pertinent uniquement si le guide couvre la qualite des donnees)

### Sources de donnees
- Stack Overflow Developer Survey. https://survey.stackoverflow.co/
- State of JavaScript. https://stateofjs.com/
- State of CSS. https://stateofcss.com/
- JetBrains Developer Survey. https://www.jetbrains.com/lp/devecosystem/
- npm registry. https://www.npmjs.com/
- Maven Central. https://mvnrepository.com/
- CNCF Landscape. https://landscape.cncf.io/
