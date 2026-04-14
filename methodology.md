# Methodologie — EBSE Guide

**Version** : 2.0
**Date** : 2026-04-14
**Methode** : Adaptation de l'Evidence-Based Medicine (EBM) au genie logiciel, via Evidence-Based Software Engineering (EBSE, Kitchenham et al. 2004), structuree selon Kitchenham & Charters 2007.

Ce document est le **protocole pre-enregistre** de l'outil EBSE. Chaque etape est mecanique et reproductible. Deux personnes suivant ce protocole doivent arriver aux memes conclusions.

**Format de sortie** : les recommandations sont stockees en JSON structure, servies via une application web (humains) et une API (IA/machines). L'outil ne GENERE pas de recommandations — il FILTRE et AFFICHE des donnees issues du processus EBSE. Pas de source = pas de recommandation affichee.

---

## Table des matieres

### Phase 1 — Planning
1. [Etape 1.1 — Scope (quels sujets couvrir)](#phase-1--planning)
2. [Etape 1.2 — Questions (PICO)](#etape-12--questions-pico)
3. [Etape 1.3 — Decouverte des alternatives](#etape-13--decouverte-des-alternatives)
4. [Etape 1.4 — Criteres d'inclusion/exclusion des sources](#etape-14--criteres-dinclusion-exclusion-des-sources)
5. [Etape 1.5 — Strategie de recherche](#etape-15--strategie-de-recherche)
6. [Etape 1.6 — Protocole : revue par les pairs et pilotage](#etape-16--protocole--revue-par-les-pairs-et-pilotage)

### Phase 2 — Conducting
7. [Etape 2.1 — Recherche et flux PRISMA](#etape-21--recherche-et-flux-prisma)
8. [Etape 2.2 — Selection des sources](#etape-22--selection-des-sources)
9. [Etape 2.3 — Evaluation de la qualite (risque de biais)](#etape-23--evaluation-de-la-qualite-risque-de-biais)
10. [Etape 2.4 — Extraction des donnees](#etape-24--extraction-des-donnees)
11. [Etape 2.5 — Verification des sources](#etape-25--verification-des-sources)
12. [Etape 2.6 — Snowballing](#etape-26--snowballing)
13. [Etape 2.7 — Synthese, GRADE et analyse de sensibilite](#etape-27--synthese-grade-et-analyse-de-sensibilite)
14. [Etape 2.8 — Double extraction (verification inter-reviewers)](#etape-28--double-extraction-verification-inter-reviewers)

### Phase 3 — Reporting
15. [Etape 3.1 — Format de recommandation](#etape-31--format-de-recommandation)
16. [Etape 3.2 — Arbre de decision](#etape-32--arbre-de-decision)
17. [Etape 3.3 — Profils de stack et multi-stack](#etape-33--profils-de-stack-et-multi-stack)
18. [Etape 3.4 — Journal de decisions et deviations](#etape-34--journal-de-decisions-et-deviations)
19. [Etape 3.5 — Maintenance](#etape-35--maintenance)

### Annexes
20. [Limites documentees](#limites-documentees)
21. [References](#references)

---

# Phase 1 — Planning

---

## Etape 1.1 — Scope

### Objectif
Identifier de maniere exhaustive tous les sujets que le guide doit couvrir.

### Fondations — 3 niveaux

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
| **OWASP ASVS** | Security → regles testables (~300) |
| **WCAG 2.2** | Inclusivity → criteres mesurables (~86) |
| **ISO 9241-110:2020** | Interaction Capability → 7 principes d'interaction |
| **Twelve-Factor App** | Flexibility + Reliability → 12 pratiques cloud-native |
| **Nielsen 10 Heuristics** | Interaction Capability → 10 principes UX pratiques |
| **Material Design 3 + Apple HIG** | User engagement → tendances visuelles actuelles (date) |

Ces standards de niveau 3 sont decouverts par recherche systematique (etape 2.1), pas fixes d'avance. La liste ci-dessus est le resultat de la recherche initiale et peut s'etendre.

### Methode de croisement
Croiser les sous-caracteristiques ISO/IEC 25010:2023 + 25019:2023 avec les knowledge areas SWEBOK v4.

### ISO/IEC 25010:2023 — 9 caracteristiques, ~40 sous-caracteristiques

**1. Functional Suitability**
- Functional completeness
- Functional correctness
- Functional appropriateness

**2. Performance Efficiency**
- Time behaviour
- Resource utilization
- Capacity

**3. Compatibility**
- Co-existence
- Interoperability

**4. Interaction Capability** (renomme depuis "Usability" en 2011)
- Appropriateness recognizability
- Learnability
- Operability
- User error protection
- User engagement (nouveau 2023)
- Inclusivity (nouveau 2023, remplace "Accessibility")
- User assistance (nouveau 2023)
- Self-descriptiveness (nouveau 2023)

**5. Reliability**
- Faultlessness (renomme depuis "Maturity")
- Availability
- Fault tolerance
- Recoverability

**6. Security**
- Confidentiality
- Integrity
- Non-repudiation
- Accountability
- Authenticity
- Resistance (nouveau 2023)

**7. Maintainability**
- Modularity
- Reusability
- Analysability
- Modifiability
- Testability

**8. Flexibility** (renomme depuis "Portability")
- Adaptability
- Installability
- Replaceability
- Scalability (nouveau 2023)

**9. Safety** (nouveau 2023)
- Operational constraint
- Risk identification
- Fail safe
- Hazard warning
- Safe integration

### SWEBOK v4 — 18 knowledge areas

1. Software Requirements
2. Software Architecture
3. Software Design
4. Software Construction
5. Software Testing
6. Software Engineering Operations
7. Software Maintenance
8. Software Configuration Management
9. Software Engineering Management
10. Software Engineering Process
11. Software Engineering Models and Methods
12. Software Quality
13. Software Security
14. Software Engineering Professional Practice
15. Software Engineering Economics
16. Computing Foundations
17. Mathematical Foundations
18. Engineering Foundations

### Matrice de couverture

Pour chaque case `[sous-caracteristique ISO] x [knowledge area SWEBOK]` :

1. Lire la definition ISO de la sous-caracteristique
2. Lire la description SWEBOK du knowledge area
3. Determiner si l'intersection genere une decision technique :
   - **OUI** → la case entre dans le scope du guide, formuler une question PICO
   - **NON** → marquer "N/A" avec justification (les deux ne se croisent pas)

**Controle** : cette determination est soumise a double extraction (2 reviewers independants).

**Taille maximale** : ~40 sous-caracteristiques x 18 knowledge areas = 720 cases. En pratique, beaucoup seront N/A.

---

## Etape 1.2 — Questions (PICO)

### Objectif
Formuler chaque decision technique comme une question structuree, sans ambiguite.

### Format PICO adapte au logiciel

| Lettre | Signification | Description |
|--------|---------------|-------------|
| **P** | Projet/Population | Type de projet (web app, API, mobile, CLI, etc.), taille d'equipe, contraintes |
| **I** | Intervention | Outil, framework, pratique ou configuration evaluee |
| **C** | Comparaison | Alternative(s) a l'intervention |
| **O** | Outcome | Resultat mesurable : performance, securite, maintenabilite, satisfaction dev, fiabilite |

### Exemple

```
P = Web app avec API REST, equipe 1-10 devs
I = PostgreSQL
C = MySQL, MongoDB, SQLite
O = Fiabilite, satisfaction developpeur, ecosysteme, scalabilite
```

Question formulee : "Pour une web app avec API REST (equipe 1-10 devs), PostgreSQL offre-t-il une meilleure fiabilite et satisfaction developpeur que MySQL, MongoDB ou SQLite ?"

### Regles
- Chaque case active de la matrice (etape 1.1) genere au moins une question PICO
- Si le P (type de projet) varie, formuler plusieurs questions PICO avec des P differents
- Le C (comparaison) doit inclure TOUTES les alternatives trouvees a l'etape 1.3

---

## Etape 1.3 — Decouverte des alternatives

### Objectif
Trouver TOUS les outils/pratiques qui existent pour repondre a la question PICO, sans en oublier.

### Methode
Recherche systematique dans des bases exhaustives, comme en medecine (PubMed, MEDLINE → npm, Maven, etc.).

### Bases de recherche (liste fixe)

| Base | Couvre quoi | Type de recherche |
|------|-------------|-------------------|
| **npm registry** | Tous les packages JavaScript | Recherche par mots-cles derives du PICO |
| **Maven Central** | Tous les packages Java | Idem |
| **PyPI** | Tous les packages Python | Idem |
| **GitHub** | Tous les projets open source | Idem |
| **Stack Overflow Survey** | Outils utilises par ~70k devs, par categorie | Lecture des categories correspondantes |
| **State of JS / State of CSS** | Outils frontend par categorie | Idem |
| **CNCF Landscape** | Outils cloud native par categorie | Idem |

### Regles
- Chercher dans TOUTES les bases applicables au domaine (JS → npm + SO + State of JS, Java → Maven + SO, etc.)
- Les mots-cles de recherche sont derives du PICO (I et C)
- Documenter : base cherchee, mots-cles utilises, nombre de resultats, outils retenus
- Un outil non present dans aucune base n'est pas evalue (limite documentee)

---

## Etape 1.4 — Criteres d'inclusion/exclusion des sources

### Objectif
Definir formellement, AVANT la recherche, quelles sources seront retenues et lesquelles seront exclues. Ceci empeche le cherry-picking post-hoc.

### Criteres d'inclusion

Une source est INCLUSE si elle remplit TOUS les criteres suivants :

| # | Critere | Justification |
|---|---------|---------------|
| I1 | La source traite directement de l'intervention (I) ou de la comparaison (C) du PICO | Pertinence |
| I2 | La source fournit des donnees factuelles (chiffres, specifications, recommandations normatives) | Objectivite |
| I3 | La source est de niveau 1 a 5 dans la pyramide des preuves (voir etape 2.4) | Fiabilite minimale |
| I4 | La source est datee de moins de 5 ans OU est un standard toujours en vigueur | Actualite |
| I5 | La source est accessible (URL valide, document telecharger, texte lisible) | Verifiabilite |

### Criteres d'exclusion

Une source est EXCLUE si elle remplit AU MOINS UN des criteres suivants :

| # | Critere | Justification |
|---|---------|---------------|
| E1 | Source de niveau 6 (blog individuel, tutoriel, video YouTube sans donnees) | Fiabilite insuffisante |
| E2 | Source datee de plus de 5 ans ET n'est pas un standard toujours en vigueur | Obsolescence |
| E3 | Source dans une langue non verifiable par les reviewers | Impossibilite de verification |
| E4 | Source exclusivement marketing (white paper vendeur sans donnees independantes) | Conflit d'interet majeur |
| E5 | Source sans auteur identifiable ni organisation reconnue | Tracabilite impossible |
| E6 | Source traitant d'un contexte (P) radicalement different de celui du PICO | Indirectness trop forte |

### Documentation des exclusions
Chaque source exclue est documentee avec :
- L'identifiant de la source (titre, URL)
- Le critere d'exclusion applique (E1 a E6)
- Une phrase de justification

---

## Etape 1.5 — Strategie de recherche

### Objectif
Definir la strategie de recherche AVANT l'execution, pour garantir la reproductibilite.

### Elements de la strategie

Pour chaque question PICO, documenter :

1. **Bases a interroger** : lesquelles parmi la liste fixe (etape 1.3) + bases additionnelles justifiees
2. **Mots-cles** : derives systematiquement du PICO (synonymes, variantes)
3. **Criteres d'inclusion/exclusion** : reference a l'etape 1.4
4. **Ordre de recherche** : par niveau de la pyramide (niveau 1 d'abord, puis 2, etc.)
5. **Date de la recherche** : a documenter pour chaque base
6. **Procedure de snowballing** : verifier les references citees dans les sources trouvees (voir etape 2.6)

### Regles
- La strategie est fixee AVANT l'execution de la recherche
- Toute modification en cours de route est une deviation de protocole (voir etape 3.4)
- La strategie inclut une procedure pour les sources inaccessibles (voir etape 2.5)

---

## Etape 1.6 — Protocole : revue par les pairs et pilotage

### Objectif
Valider le protocole (etapes 1.1 a 1.5) avant de l'appliquer a grande echelle.

### Revue par les pairs du protocole

Avant d'executer la recherche, le protocole complet (scope, PICO, criteres, strategie) est soumis a revue :

1. **Reviewer independant** (humain ou agent IA dans un contexte separe) lit le protocole
2. Le reviewer verifie :
   - Les PICO sont complets et sans ambiguite
   - Les criteres d'inclusion/exclusion sont clairs et applicables
   - La strategie de recherche couvre les bases pertinentes
   - Le scope n'a pas d'oublis evidents
3. Les retours sont documentes et integres
4. Le protocole revise est marque comme **approuve** avec date et identifiant du reviewer

### Pilotage (test sur un echantillon)

Avant l'execution complete, le protocole est teste sur un petit echantillon :

1. Selectionner **3 a 5 questions PICO** representatives (couvrant differents domaines)
2. Executer le protocole complet sur cet echantillon (recherche, selection, extraction, GRADE)
3. Evaluer :
   - Le temps par question PICO (pour estimer l'effort total)
   - Le kappa inter-reviewers sur l'echantillon
   - Les ambiguites dans les criteres ou le formulaire d'extraction
4. Ajuster le protocole si necessaire (documenter les ajustements comme deviations, etape 3.4)
5. Le pilotage est documente avec les resultats et les ajustements

### Regles
- Le protocole ne peut PAS etre modifie apres approbation sans documentation de la deviation
- Les donnees du pilotage PEUVENT etre integrees dans les resultats finaux si le protocole n'a pas change entre le pilotage et l'execution

---

# Phase 2 — Conducting

---

## Etape 2.1 — Recherche et flux PRISMA

### Objectif
Executer la strategie de recherche et documenter le flux de selection selon PRISMA (Preferred Reporting Items for Systematic reviews and Meta-Analyses).

### Flux PRISMA

A chaque execution de recherche, documenter le flux suivant :

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

### Documentation PRISMA

Le flux PRISMA est enregistre pour chaque question PICO (ou batch de questions PICO) dans `verification/prisma/`.

**Format du fichier :**

```markdown
# PRISMA Flow — [Question PICO ou Batch]

**Date de recherche** : YYYY-MM-DD
**Bases interrogees** : [liste]
**Mots-cles** : [liste]

## Flux

[Tableau PRISMA ci-dessus rempli]

## Sources exclues avec raisons

| # | Source | Critere d'exclusion | Raison |
|---|--------|---------------------|--------|
| 1 | Titre / URL | E1-E6 | Justification |
```

### Regles
- Le flux PRISMA est OBLIGATOIRE pour chaque batch de recherche
- Chaque source exclue apres lecture complete a une raison individuelle documentee
- Le total inclus doit correspondre au nombre de sources dans les formulaires d'extraction

---

## Etape 2.2 — Selection des sources

### Objectif
Appliquer les criteres d'inclusion/exclusion (etape 1.4) de maniere systematique.

### Procedure

1. **Screening (titre + resume)** : appliquer les criteres d'exclusion E1 a E6 sur le titre et le resume/description de la source
2. **Lecture complete** : pour les sources restantes, lire le texte complet et verifier les criteres d'inclusion I1 a I5
3. **Decision** : chaque source recoit un statut INCLUSE ou EXCLUE (avec raison)
4. **Double screening** : la selection est faite independamment par 2 reviewers ; les divergences sont resolues par discussion

### Regles
- Le screening est base sur les criteres definis a l'etape 1.4, pas sur le jugement subjectif
- En cas de doute, la source est INCLUSE (pour etre evaluee en detail)
- Les sources inaccessibles sont traitees a l'etape 2.5

---

## Etape 2.3 — Evaluation de la qualite (risque de biais)

### Objectif
Evaluer formellement le risque de biais de chaque source incluse, au-dela du simple conflit d'interet.

### Grille de risque de biais

Pour CHAQUE source incluse, evaluer les dimensions suivantes :

| Dimension | Question | Risque |
|-----------|----------|--------|
| **Conflit d'interet** | La source evalue-t-elle son propre produit ? | HAUT / BAS |
| **Self-published benchmark** | La source publie-t-elle ses propres benchmarks sans methodologie transparente ? | HAUT / BAS |
| **Vendor marketing** | La source est-elle un white paper vendeur ou un article sponsorise ? | HAUT / BAS |
| **Echantillon** | L'echantillon est-il < 1000 repondants pour une enquete ? | HAUT / BAS |
| **Obsolescence** | La source a-t-elle plus de 3 ans (pour les donnees d'adoption/satisfaction) ? | HAUT / BAS |
| **Selection bias** | L'echantillon est-il biaise (ex: enquete sur un site specifique = que les utilisateurs de ce site) ? | HAUT / BAS |
| **Methodologie** | La methodologie de collecte des donnees est-elle decrite et reproductible ? | HAUT / BAS |

### Risque global

| Nombre de dimensions a HAUT risque | Risque global |
|-------------------------------------|---------------|
| 0 | Faible |
| 1-2 | Modere |
| 3+ | Eleve |

### Impact sur GRADE

- Risque **faible** : pas d'ajustement GRADE
- Risque **modere** : -1 au score GRADE (cumule avec les autres facteurs negatifs)
- Risque **eleve** : la source est retrogradee d'un niveau dans la pyramide OU exclue si le risque est majeur (documenter la decision)

### Formulaire de risque de biais

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
```

---

## Etape 2.4 — Extraction des donnees

### Objectif
Pour chaque source incluse, extraire les donnees factuelles de maniere standardisee.

### Pyramide des preuves (adaptee au logiciel)

| Niveau | Type de source | Exemple | Fiabilite |
|--------|---------------|---------|-----------|
| **1** | Standards internationaux (consensus, peer-review) | ISO/IEC, W3C WCAG, IEEE, IETF RFC, lois (RGPD) | Tres haute |
| **2** | Consortiums industrie ouverts | OWASP ASVS, CNCF, OpenAPI | Haute |
| **3** | Documentation officielle du framework/outil | react.dev, spring.io, postgresql.org/docs | Haute (pour leur propre outil) |
| **4** | Donnees empiriques grande echelle | SO Survey (70k), State of JS (20k), npm downloads | Moyenne |
| **5** | Convergence d'experts reconnus | Fowler, Google SRE Book, Apple HIG, Material Design 3 | Moyenne (si convergent) |
| **6** | Expert individuel, blog, tutoriel | Article Medium, video YouTube | Faible — NON UTILISE |

### Clarifications pour le classement des sources (amelioration kappa)

Ces clarifications resolvent les divergences observees entre reviewers (kappa batch 1 = 0.456).

**Niveau 3 — "doc officielle RECOMMANDE" vs "doc officielle MENTIONNE" :**
- Si la doc dit "nous recommandons X" ou X est le defaut auto-configure → score de depart = 2 (niveau 3 prescriptif)
- Si la doc dit "X est supporte" sans recommandation explicite → traiter comme niveau 4 (mention, pas prescription)
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

**Exemples de calibration concrets (pour aligner les reviewers) :**

Ces exemples fixent le classement de sources courantes pour eviter les divergences entre reviewers.

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

**Regle de frontiere 4/5 → 3/4 (la plus critique pour le GRADE) :**
Le score GRADE passe de [RECOMMANDE] (3-4) a [STANDARD] (5-7). La frontiere est entre 4 et 5.
- Score de depart 2 (niveau 3-4) + convergence (+1) + grande echelle (+1) = 4 → [RECOMMANDE]
- Score de depart 3 (niveau 2) + convergence (+1) + grande echelle (+1) = 5 → [STANDARD]
La distinction depend du niveau de la source la PLUS HAUTE. Avec les exemples ci-dessus, cette source est clairement classable.

### Formulaire d'extraction standardise

Pour CHAQUE source consultee, remplir :

```
SOURCE :
  Nom : ___
  URL / reference : ___
  Niveau pyramide : ___
  Date de publication : ___

RISQUE DE BIAIS : (reference au formulaire etape 2.3)
  Risque global : Faible / Modere / Eleve

EXTRACTION :
  Citation exacte (copier-coller) : ___
  Donnee chiffree (si applicable) : ___
  Ce que la source dit de l'outil evalue : ___
  Conflit d'interet identifie (oui/non + detail) : ___
```

### Regles
- Copier-coller les citations, ne jamais paraphraser
- Si une source ne dit rien sur l'outil evalue → noter "aucune mention"
- Si une source n'existe pas pour un niveau → noter "aucune source a ce niveau"
- Ne JAMAIS utiliser de source niveau 6

---

## Etape 2.5 — Verification des sources

### Objectif
S'assurer que chaque source citee est accessible, que les donnees citees correspondent au contenu reel, et gerer les sources inaccessibles.

### Verification d'acces

Pour CHAQUE source incluse :

1. **Acces URL** : l'agent verificateur (Agent C) accede a l'URL citee et confirme :
   - L'URL est valide et accessible
   - Le contenu correspond a ce qui est cite dans le formulaire d'extraction
   - La citation exacte est presente dans la source
   - La date de publication est correcte
2. **Resultat** : chaque source recoit un statut :
   - **VERIFIE** : URL accessible, contenu confirme
   - **PARTIEL** : URL accessible mais contenu a change (documenter les differences)
   - **INACCESSIBLE** : URL non accessible (declencher la procedure ci-dessous)

### Procedure pour sources inaccessibles

Quand une source est inaccessible, appliquer dans l'ordre :

1. **WebSearch** : rechercher le titre exact + auteur
2. **Archive.org (Wayback Machine)** : chercher une version archivee de l'URL
3. **GitHub raw data** : si la source est un repo/doc GitHub, chercher le raw content ou un fork
4. **Citations tierces** : chercher des sources tierces qui citent et reprennent les donnees
5. **Contact auteur** : si possible, contacter l'auteur/organisation pour obtenir le document

**Si la source reste inaccessible apres les 5 tentatives** :
- La source est marquee **INACCESSIBLE** dans le formulaire d'extraction
- Elle ne peut PAS etre utilisee pour le calcul GRADE
- Une note est ajoutee dans le rapport final

### Regles
- La verification est faite par un agent DIFFERENT de celui qui a fait l'extraction (separation des roles)
- Les resultats de verification sont documentes dans `verification/access/`
- Une source non verifiee ne peut pas recevoir un niveau de confiance GRADE superieur a [BONNE PRATIQUE]

---

## Etape 2.6 — Snowballing

### Objectif
Trouver des sources additionnelles en examinant les references citees dans les sources deja trouvees (backward snowballing) et les sources qui citent les sources trouvees (forward snowballing).

### Procedure

#### Backward snowballing (references citees)
Pour chaque source incluse de niveau 1 a 3 :
1. Examiner la bibliographie / les liens references dans la source
2. Identifier les references qui pourraient etre pertinentes pour le PICO
3. Appliquer les criteres d'inclusion/exclusion (etape 1.4)
4. Si incluse, ajouter au flux PRISMA dans la categorie "Snowballing"

#### Forward snowballing (qui cite cette source)
Pour chaque source cle (niveau 1-2 ou source fondatrice) :
1. Rechercher les documents/articles qui citent cette source (via Google Scholar, GitHub, etc.)
2. Appliquer les criteres d'inclusion/exclusion
3. Si incluse, ajouter au flux PRISMA dans la categorie "Snowballing"

### Critere d'arret
Le snowballing s'arrete quand :
- Aucune nouvelle source pertinente n'est trouvee sur 2 iterations consecutives
- OU le nombre de sources trouvees par snowballing represente < 5% du total des sources identifiees

### Regles
- Le snowballing est documente dans le flux PRISMA (nombre de sources trouvees par cette methode)
- Les sources trouvees par snowballing sont soumises aux memes criteres et evaluations que les sources trouvees par recherche directe

---

## Etape 2.7 — Synthese, GRADE et analyse de sensibilite

### Objectif
Calculer mecaniquement le niveau de confiance pour chaque recommandation, puis verifier la robustesse par analyse de sensibilite et evaluation du biais de publication.

### Score de depart

Le score de depart depend du niveau le plus haut de source disponible :

| Source la plus haute | Score de depart |
|---------------------|-----------------|
| Niveau 1 (standard international) | 4 |
| Niveau 2 (consortium ouvert) | 3 |
| Niveau 3 (doc officielle) | 2 |
| Niveau 4 (enquete grande echelle) | 2 |
| Niveau 5 (experts convergents) | 1 |

### Facteurs d'ajustement

**La confiance MONTE (+1 chacun, max +3) :**

| Facteur | Condition | Verification |
|---------|-----------|--------------|
| Convergence | 2+ sources independantes arrivent a la meme conclusion | Les sources sont-elles independantes ? Disent-elles la meme chose ? |
| Grande echelle | Donnees basees sur >10 000 repondants/observations | Verifier le N de l'echantillon |
| Effet important | La difference entre I et C est majeure et evidente | Le chiffre parle de lui-meme (ex: 78% vs 32%) |

**La confiance DESCEND (-1 chacun, max -3) :**

| Facteur | Condition | Verification |
|---------|-----------|--------------|
| Conflit d'interet | La source evalue son propre produit | Qui a produit la source ? |
| Incoherence | Les sources se contredisent | Comparer les conclusions des sources |
| Indirectness | La source parle d'un contexte different du P | Le contexte de la source correspond-il au P du PICO ? |
| Imprecision | Petit echantillon ou intervalle de confiance large | N < 1000, ou resultats serres |
| Biais de publication | Seuls les succes sont publies | Y a-t-il des retours negatifs disponibles ? |
| Risque de biais eleve | La source a un risque global eleve (etape 2.3) | Resultat de l'evaluation de biais |

### Calcul

```
Score final = Score de depart + facteurs positifs + facteurs negatifs
Minimum = 0, Maximum = 7
```

### Correspondance score → niveau de confiance

| Score | Niveau | Label |
|-------|--------|-------|
| 5-7 | HAUTE | [STANDARD] |
| 3-4 | MOYENNE-HAUTE | [RECOMMANDE] |
| 2 | MOYENNE | [BONNE PRATIQUE] |
| 0-1 | BASSE | [CHOIX D'EQUIPE] |

### Evaluation formelle du biais de publication

Pour chaque recommandation, verifier explicitement :

| Verification | Comment |
|-------------|---------|
| Retours negatifs existent-ils ? | Rechercher activement des critiques, post-mortems, issues GitHub, articles "pourquoi on a quitte X" |
| Les sources negatives ont-elles ete exclues ? | Verifier si des sources critiques ont ete exclues par les criteres |
| Les enquetes mesurent-elles l'insatisfaction ? | Verifier si les enquetes donnent aussi les % de "would NOT use again" |
| Asymetrie | Les sources sont-elles majoritairement positives ? Si oui, le biais de publication est suspect |

**Resultat** :
- **Biais de publication non detecte** : aucun ajustement
- **Biais de publication suspecte** : -1 au score GRADE (deja dans les facteurs negatifs)
- **Biais de publication confirme** : -2 au score GRADE + note dans le rapport

### Analyse de sensibilite

Apres le calcul GRADE, verifier la robustesse de la recommandation :

1. **Retrait un-par-un** : retirer chaque source (une a la fois) et recalculer le score GRADE
   - Si la recommandation change de niveau (ex: [STANDARD] → [RECOMMANDE]), la recommandation est **fragile**
   - Si la recommandation reste stable, elle est **robuste**

2. **Documentation** :
```
ANALYSE DE SENSIBILITE — [Question PICO]
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

3. **Impact sur le rapport** :
   - Recommandation **robuste** : presentee normalement
   - Recommandation **fragile** : un avertissement est ajoute, identifiant les sources critiques dont depend la recommandation

### Balance benefices vs risques (GRADE EtD)

Pour chaque recommandation, documenter explicitement :

| Dimension | Evaluation |
|-----------|-----------|
| **Benefices** | Quels sont les avantages concrets de l'intervention (I) vs la comparaison (C) ? Quantifier si possible. |
| **Risques / inconvenients** | Quels sont les risques, couts, complexites, vendor lock-in, courbe d'apprentissage ? |
| **Balance** | Les benefices l'emportent-ils clairement sur les risques ? |
| **Faisabilite** | L'intervention est-elle realisable dans le contexte P ? (ressources, competences, infrastructure requises) |

**Format :**
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

**Impact** :
- Si la balance est "Risques > Benefices" → la recommandation est degradee d'un niveau, meme si le GRADE est haut
- Si la faisabilite est "Basse" → la recommandation mentionne les prerequis necessaires

---

## Etape 2.8 — Double extraction (verification inter-reviewers)

### Objectif
Controler que la lecture des sources n'a pas introduit d'erreurs.

### Methode : double extraction (identique a Cochrane)

1. **Reviewer A** remplit le formulaire d'extraction pour chaque source
2. **Reviewer B** remplit le meme formulaire independamment, sans voir le travail de A
3. **Comparaison** :
   - Les deux extractions sont identiques → valide
   - Divergence → relecture conjointe, identification de l'erreur, correction
4. **Mesure** : calculer le taux d'accord (kappa de Cohen)
   - kappa > 0.8 → accord excellent, methode fiable
   - kappa 0.6-0.8 → accord bon, verifier les divergences
   - kappa < 0.6 → formulaire a ameliorer, trop d'ambiguite

### Application avec IA
- Agent IA 1 et Agent IA 2 extraient independamment (contextes separes)
- Comparaison automatique des extractions
- Divergences flaggees pour verification humaine

### Tracabilite (OBLIGATOIRE)

Chaque page du guide DOIT avoir un fichier de tracabilite dans `verification/extractions/`.
Ce fichier prouve que la double extraction a ete faite et documente les resultats.

**Format du fichier de tracabilite :**

```markdown
# Double Extraction — [Batch/Page name]

**Date** : YYYY-MM-DD
**Agent A** : [identifiant agent]
**Agent B** : [identifiant agent]

## Comparaison

| # | Page | Agent A reco | Agent B reco | Accord reco | GRADE A | GRADE B | Accord GRADE |
|---|------|-------------|-------------|:-----------:|---------|---------|:------------:|
| 1 | nom-page | reco A | reco B | ✓ ou ❌ | X/7 | X/7 | ✓ ou ±N |

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

# Phase 3 — Reporting

---

## Etape 3.1 — Format de recommandation

### Format de sortie

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

### Regles
- Le lecteur doit pouvoir verifier chaque recommandation en ouvrant les sources citees
- Si le score est <= 1, le guide ne recommande PAS — il dit "[CHOIX D'EQUIPE]" et liste les options
- Chaque recommandation porte une date et sera revalidee a la prochaine revision
- Les sources non verifiees (etape 2.5) sont signalees

---

## Etape 3.2 — Arbre de decision

### Principe

L'outil pose des questions sur les **besoins metier** de l'utilisateur (qu'il connait). Le guide **deduit** les choix techniques (que l'utilisateur ne connait pas forcement). L'utilisateur ne voit JAMAIS de jargon technique dans les questions — il voit "tes utilisateurs telecharment depuis l'App Store ?" et le guide decide "Capacitor".

### Structure

```
PLATEFORME (ou tes utilisateurs utilisent l'app ?)
  → BESOIN MOBILE (aussi sur telephone ? app store ?)
  → NOMBRE D'UTILISATEURS (echelle)
  → EXPERIENCE EQUIPE (quel langage ?)
  → BUT DE L'APP (interactif, contenu, API, temps-reel)
  → TYPE DE DONNEES (relationnelles ou documents)
  → BUDGET (gratuit ou SaaS autorise)
  → RESULTAT (le guide deduit toute la stack)
```

### Questions metier uniquement (pas de jargon technique)

L'arbre pose des questions que l'utilisateur peut TOUJOURS repondre :

| Question metier | Ce que le guide deduit | Source |
|----------------|----------------------|--------|
| "Ou tes utilisateurs utilisent l'app ?" | Plateforme (web/mobile/desktop) | Contrainte runtime W3C/Apple/Google |
| "Aussi sur telephone ?" | PWA si oui (batch 16, GRADE 6/7) | StatCounter 59% trafic mobile 2025 |
| "App Store obligatoire ?" | Capacitor si oui (batch 16, GRADE 5/7) | Batch 16 double extraction |
| "Combien d'utilisateurs ?" | Infrastructure (Docker Compose vs K8s) | Twelve-Factor, Google SRE |
| "Experience de l'equipe ?" | Langage → backend framework | SWEBOK v4 SE Economics |
| "A quoi sert l'app ?" | Type projet (SPA/content/realtime/API) | SWEBOK v4 Software Architecture |
| "Comment sont tes donnees ?" | BDD (PostgreSQL/MongoDB) | SO Survey 2025 PostgreSQL #1 |
| "Budget outils ?" | Open source vs SaaS | Factuel |

### "Je ne sais pas" obligatoire

Chaque question DOIT avoir une option "je ne sais pas" avec :
- Une **recommandation par defaut** basee sur le GRADE EBSE le plus haut
- Une **explication** de pourquoi c'est le defaut
- L'utilisateur n'est **jamais bloque**

### Deduction technique (`deduced_tech`)

Chaque option de reponse a un champ `deduced_tech` qui explique CE QUE LE GUIDE CHOISIT et POURQUOI :
```json
{
  "label": "Oui, souvent sur telephone",
  "sets": { "mobile_need": "pwa" },
  "deduced_tech": "PWA recommande (GRADE 6/7) — installable, offline, push. Meme codebase."
}
```

L'utilisateur voit la question metier. Le guide montre la deduction technique en dessous, avec le GRADE.

### Regles

- Chaque question porte sur un **besoin metier**, JAMAIS sur un choix technique
- Chaque deduction technique cite sa **source EBSE** (batch, GRADE)
- Chaque question a un **"je ne sais pas"** avec reco par defaut
- L'arbre ne contient PAS d'opinions — chaque branche est derivee de la methode EBSE
- La stack optimale (batch 12) est le defaut quand l'utilisateur n'a pas de contrainte

---

## Etape 3.3 — Profils de stack et multi-stack

### Objectif
Regrouper les recommandations interdependantes en combinaisons coherentes et validees.

### Methode
1. Identifier les dependances : le choix de l'outil A influence-t-il le choix de l'outil B ?
   - Source : doc officielle de A (recommande-t-elle un outil B specifique ?)
   - Source : doc officielle de B (est-elle compatible avec A ?)
2. Regrouper les outils interdependants en "profils"
3. Chaque profil est une combinaison complete et coherente

### Exemple de profil

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
    - Spring docs → JUnit (niveau 3)
    - Vite docs → Vitest (niveau 3)
    - React docs → Testing Library + ESLint (niveau 3)
```

### Recommandations conditionnelles et multi-stack

#### Principe

Une recommandation peut dependre d'un choix precedent. Par exemple :
- "Quel framework de test ?" depend de "Quel framework backend ?"
- Si backend = Spring Boot → JUnit 5. Si backend = NestJS → Jest/Vitest. Si backend = Django → pytest.

#### Format JSON conditionnel

Chaque recommandation est stockee en JSON avec :
- `universal` : principes valables pour TOUTE stack (ex: "pyramide 70/20/10")
- `variants` : outils specifiques par stack (ex: { "java-spring-boot": "JUnit 5", "typescript-nestjs": "Vitest" })
- `depends_on` : liste des choix prealables qui affectent cette recommandation

#### Classification des pages

Chaque page est classee comme :
- **UNIVERSEL** : la recommandation est valable quelle que soit la stack
- **MIXTE** : principes universels + outils stack-specific (la majorite des pages)
- **STACK-SPECIFIC** : uniquement pour une stack donnee

#### Obligation multi-stack

Pour chaque page MIXTE ou STACK-SPECIFIC :
- Les variantes pour **au moins 3 stacks backend** (Java/Spring Boot, TypeScript/NestJS, Python/Django) doivent exister
- Chaque variante est sourcee via EBSE (PICO, GRADE, double extraction)
- Les agents recherchant les variantes NE DOIVENT PAS voir le contenu des autres stacks pour eviter le biais

---

## Etape 3.4 — Journal de decisions et deviations

### Objectif
Documenter toutes les decisions methodologiques et les deviations par rapport au protocole, pour garantir la transparence et la reproductibilite.

### Journal de decisions (review diary)

Un journal continu est maintenu tout au long du processus. Pour chaque decision significative :

```
JOURNAL DE DECISIONS — [Projet/Batch]

| # | Date | Decision | Justification | Impact | Decideur |
|---|------|----------|---------------|--------|----------|
| 1 | YYYY-MM-DD | Description de la decision | Pourquoi cette decision a ete prise | Quelles etapes/resultats sont affectes | Qui a decide |
```

**Exemples de decisions a documenter :**
- Ajout/retrait d'une base de recherche
- Modification d'un critere d'inclusion/exclusion
- Decision sur une source ambigue (incluse ou exclue)
- Resolution d'une divergence entre reviewers
- Choix methodologique non prevu par le protocole

### Documentation des deviations de protocole

Toute deviation par rapport au protocole approuve (etape 1.6) est documentee :

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

### Regles
- Le journal est mis a jour EN TEMPS REEL, pas retrospectivement
- Les deviations sont numerotees et referencees dans le rapport final
- Un fichier de journal est maintenu dans `verification/decisions/`
- L'absence de journal pour un batch rend les resultats non auditables

---

## Etape 3.5 — Maintenance

### Frequence
- **Revue annuelle** : toutes les recommandations sont revalidees avec les sources mises a jour
- **Revue ponctuelle** : quand une source majeure change (nouvelle version ISO, nouvelle enquete SO Survey, etc.)

### Processus
1. Pour chaque recommandation existante, verifier si les sources ont change
2. Si oui, reprendre les etapes 2.1-2.7 (recherche → synthese)
3. Mettre a jour la date de la recommandation
4. Archiver l'ancienne version (historique des changements)
5. Re-executer l'analyse de sensibilite pour les recommandations modifiees

### Versioning
- Le guide suit le versioning semantique : `ANNEE.MOIS` (ex: `2026.04`)
- Chaque recommandation modifiee est marquee `[MAJ 2026.04]`

### Scope et plateformes

Le guide couvre actuellement **le web** (navigateur). Les autres plateformes ne sont PAS couvertes tant que la recherche EBSE n'a pas ete faite :

| Plateforme | Statut | Prochaine etape |
|-----------|--------|-----------------|
| **Web (navigateur)** | Couvert | 106 decisions, 3 stacks backend, multi-frontend |
| **Web → Mobile (PWA/Capacitor)** | Couvert | Page web-mobile-strategy.md, batch 16 |
| Mobile natif Android | Pas couvert | Necessite EBSE : Kotlin, Jetpack Compose, etc. |
| Mobile natif iOS | Pas couvert | Necessite EBSE : Swift, SwiftUI, etc. |
| Mobile cross-platform | Pas couvert | Necessite EBSE : Flutter vs React Native vs KMP |
| Desktop | Pas couvert | Necessite EBSE : Electron vs Tauri |

**Regle** : le guide NE RECOMMANDE PAS une plateforme qu'il n'a pas recherchee. L'arbre de decision affiche "pas encore couvert" pour les plateformes non recherchees.

### Watchlist — technologies emergentes

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

**Processus watchlist** : a chaque revue annuelle, verifier les metriques. Si un seuil est atteint → PICO + double extraction + page guide.

---

# Annexes

---

## Limites documentees

| Limite | Explication |
|--------|-------------|
| **Couverture** | Le scope est base sur ISO/IEC 25010:2023, ISO/IEC 25019:2023 et SWEBOK v4 (2024). Si un domaine n'apparait dans aucun des trois, il n'est pas couvert. |
| **Decouverte** | Un outil absent de toutes les bases de recherche definies (npm, Maven, GitHub, enquetes) ne sera pas evalue. |
| **Qualite des preuves** | La plupart des preuves en genie logiciel sont de niveau 3-5 (docs, enquetes, experts). Les niveaux 1-2 (standards, consortiums) sont rares pour les choix d'outils. |
| **Contexte** | Les recommandations sont formulees pour des contextes definis (P du PICO). Un contexte tres different peut invalider une recommandation. |
| **Biais des enquetes** | Les enquetes (SO Survey, State of JS) mesurent la popularite et la satisfaction parmi les repondants, avec un biais de selection (qui repond ?). |
| **Temporalite** | Les tendances (design, outils) evoluent. Les recommandations sont datees et doivent etre revalidees annuellement. |
| **Verification** | La verification d'acces (etape 2.5) depend de la disponibilite des URLs au moment de la verification. Les sources peuvent devenir inaccessibles apres la verification. |
| **Sensibilite** | Certaines recommandations peuvent etre fragiles (dependantes d'une seule source). L'analyse de sensibilite identifie ces cas mais ne les resout pas. |

---

## References

### Methode
- Kitchenham, B.A. et al. (2004). *Evidence-Based Software Engineering*. ICSE 2004.
- Kitchenham, B.A. & Charters, S. (2007). *Guidelines for performing Systematic Literature Reviews in Software Engineering*. EBSE Technical Report EBSE-2007-01.
- Kitchenham, B.A., Budgen, D. & Brereton, P. (2015). *Evidence-Based Software Engineering and Systematic Reviews*. CRC Press.
- GRADE Working Group. *GRADE Handbook*. https://gradepro.org/handbook/
- GRADE Working Group. *Evidence to Decision (EtD) Framework*. https://www.gradeworkinggroup.org/
- Moher, D. et al. (2009). *PRISMA Statement*. BMJ.
- Page, M.J. et al. (2021). *PRISMA 2020 Statement: an updated guideline for reporting systematic reviews*. BMJ.
- Cochrane Handbook for Systematic Reviews of Interventions. https://training.cochrane.org/handbook
- Wohlin, C. (2014). *Guidelines for snowballing in systematic literature studies*. EASE 2014.

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
