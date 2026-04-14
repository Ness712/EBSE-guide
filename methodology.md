# Methodologie — EBSE Guide

**Version** : 1.0
**Date** : 2026-04-14
**Methode** : Adaptation de l'Evidence-Based Medicine (EBM) au genie logiciel, via Evidence-Based Software Engineering (EBSE, Kitchenham et al. 2004).

Ce document est le **protocole pre-enregistre** de l'outil EBSE. Chaque etape est mecanique et reproductible. Deux personnes suivant ce protocole doivent arriver aux memes conclusions.

**Format de sortie** : les recommandations sont stockees en JSON structure, servies via une application web (humains) et une API (IA/machines). L'outil ne GENERE pas de recommandations — il FILTRE et AFFICHE des donnees issues du processus EBSE. Pas de source = pas de recommandation affichee.

---

## Table des matieres

1. [Vue d'ensemble](#1-vue-densemble)
2. [Etape 0 — Scope (quels sujets couvrir)](#2-etape-0--scope)
3. [Etape 1 — Question (PICO)](#3-etape-1--question-pico)
4. [Etape 2 — Decouverte des alternatives](#4-etape-2--decouverte-des-alternatives)
5. [Etape 3 — Collecte des preuves](#5-etape-3--collecte-des-preuves)
6. [Etape 4 — Evaluation (GRADE)](#6-etape-4--evaluation-grade)
7. [Etape 5 — Recommandation](#7-etape-5--recommandation)
8. [Etape 6 — Profils de stack](#8-etape-6--profils-de-stack)
9. [Etape 7 — Verification (double extraction)](#9-etape-7--verification)
10. [Etape 8 — Recommandations conditionnelles et multi-stack](#10-etape-8--recommandations-conditionnelles)
11. [Etape 9 — Arbre de decision](#11-etape-9--arbre-de-decision)
12. [Etape 10 — Maintenance](#12-etape-10--maintenance)
13. [Limites documentees](#13-limites-documentees)
14. [References](#14-references)

---

## 1. Vue d'ensemble

```
SCOPE (ISO 25010 + 25019 x SWEBOK) → QUESTION (PICO) → DECOUVERTE (bases exhaustives)
→ COLLECTE (pyramide des preuves) → EVALUATION (GRADE) → RECOMMANDATION (4 niveaux)
→ PROFILS DE STACK (interdependances) → VERIFICATION (double extraction) → MAINTENANCE (annuelle)
```

**Principe fondamental** : aucune etape ne repose sur un jugement humain. Le seul acte humain est la lecture des sources, controlee par double extraction et formulaire standardise.

---

## 2. Etape 0 — Scope

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

Ces standards de niveau 3 sont decouverts par recherche systematique (etape 3), pas fixes d'avance. La liste ci-dessus est le resultat de la recherche initiale et peut s'etendre.

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

## 3. Etape 1 — Question (PICO)

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
- Chaque case active de la matrice (etape 0) genere au moins une question PICO
- Si le P (type de projet) varie, formuler plusieurs questions PICO avec des P differents
- Le C (comparaison) doit inclure TOUTES les alternatives trouvees a l'etape 2

---

## 4. Etape 2 — Decouverte des alternatives

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

## 5. Etape 3 — Collecte des preuves

### Objectif
Pour chaque alternative trouvee, collecter les donnees factuelles depuis des sources classees par niveau de fiabilite.

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

## 6. Etape 4 — Evaluation (GRADE adapte)

### Objectif
Calculer mecaniquement le niveau de confiance pour chaque recommandation.

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

---

## 7. Etape 5 — Recommandation

### Format de sortie

Chaque recommandation du guide suit ce format :

```
[NIVEAU] Recommandation en une phrase

  Contexte (P) : ___
  Score GRADE : ___ / 7
  Sources :
    - [niveau X] Source 1 : "citation exacte"
    - [niveau X] Source 2 : "citation exacte"
  Facteurs GRADE appliques :
    + convergence / grande echelle / effet important
    - conflit d'interet / incoherence / ...
  Alternatives evaluees : ___
  Date : ___
```

### Regles
- Le lecteur doit pouvoir verifier chaque recommandation en ouvrant les sources citees
- Si le score est <= 1, le guide ne recommande PAS — il dit "[CHOIX D'EQUIPE]" et liste les options
- Chaque recommandation porte une date et sera revalidee a la prochaine revision

---

## 8. Etape 6 — Profils de stack

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

---

## 9. Etape 7 — Verification

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

## 10. Etape 8 — Recommandations conditionnelles et multi-stack

### Principe

Une recommandation peut dependre d'un choix precedent. Par exemple :
- "Quel framework de test ?" depend de "Quel framework backend ?"
- Si backend = Spring Boot → JUnit 5. Si backend = NestJS → Jest/Vitest. Si backend = Django → pytest.

### Format JSON conditionnel

Chaque recommandation est stockee en JSON avec :
- `universal` : principes valables pour TOUTE stack (ex: "pyramide 70/20/10")
- `variants` : outils specifiques par stack (ex: { "java-spring-boot": "JUnit 5", "typescript-nestjs": "Vitest" })
- `depends_on` : liste des choix prealables qui affectent cette recommandation

### Classification des pages

Chaque page est classee comme :
- **UNIVERSEL** : la recommandation est valable quelle que soit la stack
- **MIXTE** : principes universels + outils stack-specific (la majorite des pages)
- **STACK-SPECIFIC** : uniquement pour une stack donnee

### Obligation multi-stack

Pour chaque page MIXTE ou STACK-SPECIFIC :
- Les variantes pour **au moins 3 stacks backend** (Java/Spring Boot, TypeScript/NestJS, Python/Django) doivent exister
- Chaque variante est sourcee via EBSE (PICO, GRADE, double extraction)
- Les agents recherchant les variantes NE DOIVENT PAS voir le contenu des autres stacks pour eviter le biais

---

## 11. Etape 9 — Arbre de decision

### Principe

L'outil pose des questions a l'utilisateur. Chaque reponse affecte les recommandations suivantes.

### Structure

```
ENTREE → Question 1 (approche) → Question 2 (langage) → Question 3 (frontend)
→ ... → RESULTAT (ensemble de choix qui filtre les recommandations)
```

### Chemin "optimal"

Un chemin special ou l'utilisateur dit "je veux LE MIEUX, sans contrainte."
Ce chemin est determine par EBSE :
- PICO : P=web app, aucune contrainte. I=meilleure stack. C=toutes. O=qualite maximale.
- Double extraction 2 agents separes (aucune mention de stack existante dans le prompt)
- Le resultat est LA stack optimale selon les sources pures

### Chemin "contextuel"

L'utilisateur repond a des questions sur son contexte. Les questions sont organisees en 2 categories :

**Questions sur le PROJET (affectent l'architecture) :**

| Question | Options | Affecte quoi | Source |
|----------|---------|-------------|--------|
| Type de projet | SPA, site contenu, API only, temps-reel | Rendu (CSR/SSR/SSG), WebSocket, framework | SWEBOK v4 "Software Architecture" |
| Echelle visee | Local (<100 users), startup (100-10k), scale (10k-1M), mondial (1M+) | HA, CDN, caching, i18n, multi-region | Twelve-Factor, Google SRE |
| Besoins specifiques | Temps-reel, offline, mobile, i18n | WebSocket, PWA, service workers | ISO 25010 Functional Suitability |

**Questions sur les CONTRAINTES (affectent les outils) :**

| Question | Options | Affecte quoi | Source |
|----------|---------|-------------|--------|
| Langage maitrise | Java, TypeScript, Python, C#, aucun | Framework backend | SWEBOK v4 "SE Economics — productivity depends on mastery" |
| Taille equipe | 1-5, 5-20, 20+ | Complexite acceptable, boilerplate | DORA/Accelerate "team size affects practices" |
| Budget | Gratuit/open-source only, SaaS autorise | Outils (GlitchTip vs Sentry, Unleash vs LaunchDarkly) | — |
| Delai | MVP rapide, projet long terme | Stack speed-to-market vs robustesse | — |

Chaque branche mene a un ensemble de choix qui filtre les recommandations.
Les questions elles-memes sont justifiees par des sources (colonne "Source").

### Regles

- Chaque question de l'arbre doit avoir une justification (pourquoi cette question est pertinente)
- Chaque branche doit etre sourcee (pourquoi ce choix mene a cette recommandation)
- L'arbre ne contient PAS d'opinions — chaque branche est derivee de la methode EBSE

---

## 12. Etape 10 — Maintenance

### Frequence
- **Revue annuelle** : toutes les recommandations sont revalidees avec les sources mises a jour
- **Revue ponctuelle** : quand une source majeure change (nouvelle version ISO, nouvelle enquete SO Survey, etc.)

### Processus
1. Pour chaque recommandation existante, verifier si les sources ont change
2. Si oui, reprendre les etapes 3-5 (collecte → evaluation → recommandation)
3. Mettre a jour la date de la recommandation
4. Archiver l'ancienne version (historique des changements)

### Versioning
- Le guide suit le versioning semantique : `ANNEE.MOIS` (ex: `2026.04`)
- Chaque recommandation modifiee est marquee `[MAJ 2026.04]`

---

## 13. Limites documentees

| Limite | Explication |
|--------|-------------|
| **Couverture** | Le scope est base sur ISO/IEC 25010:2023, ISO/IEC 25019:2023 et SWEBOK v4 (2024). Si un domaine n'apparait dans aucun des trois, il n'est pas couvert. |
| **Decouverte** | Un outil absent de toutes les bases de recherche definies (npm, Maven, GitHub, enquetes) ne sera pas evalue. |
| **Qualite des preuves** | La plupart des preuves en genie logiciel sont de niveau 3-5 (docs, enquetes, experts). Les niveaux 1-2 (standards, consortiums) sont rares pour les choix d'outils. |
| **Contexte** | Les recommandations sont formulees pour des contextes definis (P du PICO). Un contexte tres different peut invalider une recommandation. |
| **Biais des enquetes** | Les enquetes (SO Survey, State of JS) mesurent la popularite et la satisfaction parmi les repondants, avec un biais de selection (qui repond ?). |
| **Temporalite** | Les tendances (design, outils) evoluent. Les recommandations sont datees et doivent etre revalidees annuellement. |

---

## 14. References

### Methode
- Kitchenham, B.A. et al. (2004). *Evidence-Based Software Engineering*. ICSE 2004.
- Kitchenham, B.A. & Charters, S. (2007). *Guidelines for performing Systematic Literature Reviews in Software Engineering*. EBSE Technical Report EBSE-2007-01.
- Kitchenham, B.A., Budgen, D. & Brereton, P. (2015). *Evidence-Based Software Engineering and Systematic Reviews*. CRC Press.
- GRADE Working Group. *GRADE Handbook*. https://gradepro.org/handbook/
- Moher, D. et al. (2009). *PRISMA Statement*. BMJ.
- Cochrane Handbook for Systematic Reviews of Interventions. https://training.cochrane.org/handbook

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
