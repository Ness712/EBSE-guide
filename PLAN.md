# Plan detaille — EBSE Guide Tool

**Date** : 2026-04-14
**Statut** : Plan a valider AVANT toute action

---

## 1. VISION

Un outil web + API ou :
- L'utilisateur repond a des questions sur son projet
- L'outil determine la stack optimale selon les sources EBSE
- L'outil genere un guide personnalise avec TOUTES les recos adaptees
- Chaque reco est sourcee (GRADE, pyramide, double extraction)
- Utilisable par humain (web UI) ET par IA/machine (API JSON)

---

## 2. STACK DE L'OUTIL (choisie via EBSE, rien d'invente)

| Outil | Recommande par | GRADE |
|-------|---------------|-------|
| React 19 | frontend-framework.md (double extraction, 2 agents) | 6/7 |
| TypeScript strict:true | typescript-strict.md | 6/7 |
| Vite 7 | rendering-strategy.md (CSR pour SPA) | 4/7 |
| Tailwind CSS 4 | profil stack | 4/7 |
| shadcn/ui | component-library.md | 3/7 |
| pnpm | PICO double extraction (2 agents convergent) | 5/7 |
| Vitest | unit-tests.md | 4/7 |
| ESLint + Prettier | linting.md | 5/7 |
| GitHub Actions | ci-pipeline.md | 4/7 |
| Conventional Commits | commit-conventions.md | 4/7 |

Pas de backend : donnees statiques JSON, logique client-side.
Deploiement : Vercel (gratuit pour static) ou GitHub Pages.

---

## 3. ARCHITECTURE DU PROJET

```
EBSE-guide/
├── methodology.md                 ← Methode EBSE (existe, ne change pas)
├── matrix.md                      ← Matrice ISO x SWEBOK (existe)
├── verification/                  ← Traces + formulaires (existe)
│
├── data/                          ← NOUVEAU : base de donnees structuree
│   ├── schema.json                ← Schema JSON des recommandations
│   ├── decision-tree.json         ← Arbre de decision (questions → branches)
│   ├── decisions/                 ← 1 fichier JSON par decision
│   │   ├── backend-framework.json
│   │   ├── frontend-framework.json
│   │   ├── database.json
│   │   ├── unit-testing.json
│   │   ├── logging.json
│   │   └── ... (~94 fichiers)
│   └── stacks/                    ← Profils pre-calcules
│       ├── optimal.json
│       ├── java-react.json
│       ├── nestjs-react.json
│       └── django-react.json
│
├── app/                           ← NOUVEAU : application web
│   ├── package.json
│   ├── pnpm-lock.yaml
│   ├── vite.config.ts
│   ├── tsconfig.json
│   ├── eslint.config.js
│   ├── .prettierrc
│   ├── src/
│   │   ├── main.tsx
│   │   ├── App.tsx
│   │   ├── features/
│   │   │   ├── configurator/     ← Questionnaire step-by-step
│   │   │   ├── guide/            ← Affichage du guide personnalise
│   │   │   └── api-export/       ← Export JSON pour machines
│   │   ├── shared/
│   │   │   ├── components/
│   │   │   ├── hooks/
│   │   │   └── types/
│   │   └── data/                  ← Import des JSON de data/
│   └── e2e/
│       └── configurator.spec.ts
│
└── guide/                         ← EXISTANT : pages markdown (reference)
    └── 02-domains/ (94 pages)
```

---

## 4. FORMAT DES DONNEES

### 4.1 Schema d'une decision (decisions/*.json)

```json
{
  "id": "unit-testing",
  "domain": "testing",
  "question": "Quel framework de test unitaire ?",
  "depends_on": ["backend-framework", "frontend-framework"],
  "tags": ["testing", "quality", "ci"],
  
  "universal": {
    "principles": [
      {
        "text": "Suivre la pyramide de tests 70/20/10",
        "grade": 5,
        "level": "STANDARD",
        "sources": [
          {
            "name": "SWEBOK v4 Ch.5",
            "pyramid": 1,
            "year": 2024,
            "quote": "Unit testing verifies the functioning of software modules in isolation"
          },
          {
            "name": "Google Testing Blog",
            "pyramid": 5,
            "year": 2015,
            "quote": "70% unit tests, 20% integration tests, 10% end-to-end tests"
          }
        ]
      }
    ]
  },
  
  "variants": {
    "java-spring-boot": {
      "recommendation": "JUnit 5 + AssertJ + Mockito",
      "grade": 5,
      "level": "RECOMMANDE",
      "implementation": "Inclus dans spring-boot-starter-test. Zero config.",
      "code": "@Test void should_work() { assertThat(result).isEqualTo(expected); }",
      "sources": [
        {
          "name": "Spring Boot Testing docs",
          "pyramid": 3,
          "year": 2025,
          "quote": "spring-boot-starter-test imports JUnit Jupiter, AssertJ, Hamcrest"
        }
      ]
    },
    "typescript-nestjs": {
      "recommendation": "Jest ou Vitest + supertest",
      "grade": 4,
      "level": "RECOMMANDE",
      "implementation": "NestJS CLI genere la config Jest par defaut.",
      "sources": [...]
    },
    "python-django": {
      "recommendation": "pytest + pytest-django + factory-boy",
      "grade": 4,
      "level": "RECOMMANDE",
      "implementation": "pip install pytest pytest-django factory-boy",
      "sources": [...]
    }
  }
}
```

### 4.2 Schema de l'arbre de decision (decision-tree.json)

```json
{
  "nodes": {
    "start": {
      "type": "choice",
      "question": "Quelle approche ?",
      "options": [
        {
          "label": "Je veux le MIEUX possible, je m'adapte",
          "description": "Le guide determine LA stack optimale selon les sources",
          "sets": { "approach": "optimal" },
          "next": "optimal-result"
        },
        {
          "label": "J'ai des contraintes (equipe, langage, budget...)",
          "next": "team-language"
        }
      ]
    },
    "team-language": {
      "type": "choice",
      "question": "Quel langage maitrise ton equipe ?",
      "options": [
        { "label": "Java", "sets": { "backend": "java-spring-boot" }, "next": "frontend-choice" },
        { "label": "TypeScript / JavaScript", "sets": { "backend": "typescript-nestjs" }, "next": "frontend-choice" },
        { "label": "Python", "sets": { "backend": "python-django" }, "next": "frontend-choice" },
        { "label": "C#", "sets": { "backend": "csharp-aspnet" }, "next": "frontend-choice" },
        { "label": "Aucun / je veux le mieux", "sets": { "approach": "optimal" }, "next": "optimal-result" }
      ]
    },
    "frontend-choice": {
      "type": "choice",
      "question": "Framework frontend ?",
      "options": [
        { "label": "React (recommande)", "sets": { "frontend": "react" }, "next": "database-choice" },
        { "label": "Vue.js", "sets": { "frontend": "vue" }, "next": "database-choice" },
        { "label": "Angular", "sets": { "frontend": "angular" }, "next": "database-choice" },
        { "label": "Svelte", "sets": { "frontend": "svelte" }, "next": "database-choice" }
      ]
    },
    "database-choice": {
      "type": "choice",
      "question": "Base de donnees ?",
      "options": [
        { "label": "Relationnelle (recommande: PostgreSQL)", "sets": { "database": "postgresql" }, "next": "result" },
        { "label": "Document (MongoDB)", "sets": { "database": "mongodb" }, "next": "result" }
      ]
    },
    "optimal-result": {
      "type": "result",
      "description": "Stack optimale determinee par EBSE sans contrainte",
      "sets": {
        "backend": "TO_BE_DETERMINED_BY_PHASE_B",
        "frontend": "react",
        "database": "postgresql"
      }
    },
    "result": {
      "type": "result",
      "description": "Generer le guide personnalise avec ces choix"
    }
  }
}
```

### 4.3 Sortie API (ce que l'IA/machine recoit)

```json
POST /api/guide
Body: { "backend": "java-spring-boot", "frontend": "react", "database": "postgresql" }

Response: {
  "stack": {
    "backend": "Spring Boot 4 (Java 21)",
    "frontend": "React 19 + TypeScript",
    "database": "PostgreSQL"
  },
  "recommendations": [
    {
      "id": "unit-testing",
      "domain": "testing",
      "recommendation": "JUnit 5 + AssertJ + Mockito",
      "grade": 5,
      "level": "RECOMMANDE",
      "universal_principles": ["Pyramide 70/20/10", ...],
      "implementation": "Inclus dans spring-boot-starter-test",
      "sources": [...]
    },
    ...
  ],
  "total": 94,
  "methodology": "EBSE (Kitchenham 2004), adapted from Evidence-Based Medicine"
}
```

---

## 5. PHASES DE TRAVAIL (dans l'ordre)

### Phase A — Trier les 94 pages (universel vs stack-specific)

**Action** : lire chaque page, classifier
**Methode** : 2 agents separes classifient independamment, puis reconciliation
**Livrable** : liste classee (universel / stack-specific / mixte)
**Critere de completion** : chaque page classee, 0 page oubliee

### Phase B — Recherche multi-stack (EBSE)

**Action** : pour chaque page stack-specific, rechercher les equivalents NestJS + Django
**Methode** : PICO par variante, double extraction 2 agents separes, GRADE
**Livrable** : variantes NestJS et Django pour chaque decision stack-specific
**Critere de completion** : chaque variante a ses sources, GRADE, double extraction

### Phase C — Chemin optimal (EBSE)

**Action** : determiner LA meilleure stack sans aucune contrainte
**Methode** : PICO (P=web app, aucune contrainte, I=meilleure stack, C=toutes), double extraction
**Livrable** : profil optimal source et verifie
**Critere de completion** : 2 agents independants convergent sur la stack optimale

### Phase B2 — Pratiques d'ingenierie manquantes (EBSE)

**Action** : ajouter les decisions de pratiques/process que le guide ne couvre pas encore
**Methode** : PICO par decision, double extraction 2 agents separes, GRADE
**Decisions a couvrir** :

| Categorie | Decision |
|-----------|----------|
| **Organisation projet** | Structure de dossiers (archi fichiers) |
| **Organisation projet** | Monorepo vs polyrepo |
| **Gestion des issues** | Workflow issues (GitHub Issues, Linear, Jira) |
| **Gestion du feedback** | Collecte feedback utilisateur/testeur |
| **Documentation** | Quoi documenter, ou, comment (README, ADR, Storybook) |
| **Onboarding** | Guide d'onboarding nouveau dev |
| **Definition of done** | Criteres pour considerer une tache finie |
| **Release management** | Process de release (semantic-release, changelog) |
| **Code ownership** | CODEOWNERS file, qui review quoi |
| **Gestion des environnements** | Workflow dev/staging/prod |
| **Analytics** | Mesure comportement utilisateur (PostHog, Plausible) |
| **Error monitoring UX** | Session replay, heatmaps |

**Critere de completion** : chaque pratique sourcee via EBSE, double extraction

### Phase B3 — Librairies UI granulaires (EBSE)

**Action** : pour chaque besoin UI courant, trouver la meilleure librairie
**Methode** : PICO par besoin, double extraction, GRADE
**Decisions a couvrir** :

| Besoin UI | PICO I (intervention evaluee) |
|-----------|-------------------------------|
| Panels redimensionnables | react-resizable-panels vs alternatives |
| Drag and drop | dnd-kit vs react-beautiful-dnd vs alternatives |
| Tables tri/filtre/pagination | @tanstack/react-table vs AG Grid vs alternatives |
| Listes virtualisees (perf) | @tanstack/react-virtual vs react-window |
| Data fetching + cache | @tanstack/react-query vs SWR vs alternatives |
| Toast / notifications | sonner vs react-hot-toast vs alternatives |
| Editeur rich text | TipTap vs Lexical vs Plate vs alternatives |
| Command palette | cmdk vs alternatives |
| Date picker | react-day-picker vs alternatives |
| File upload | react-dropzone vs alternatives |
| Icones | lucide-react vs heroicons vs alternatives |
| Keyboard shortcuts | react-hotkeys-hook vs alternatives |
| PDF viewer | react-pdf vs alternatives |
| Markdown editor | MDXEditor vs alternatives |
| URL state management | nuqs vs alternatives |
| Image cropping | react-image-crop vs alternatives |

**Note** : ces librairies sont FRONTEND-SPECIFIC (React). Si le guide couvre Vue/Angular/Svelte, des variantes sont necessaires.

**Critere de completion** : chaque besoin UI a une reco sourcee, GRADE, double extraction

### Phase D — Convertir en JSON structure

**Action** : transformer les 94 pages markdown + variantes en fichiers JSON
**Methode** : script de conversion + verification manuelle
**Livrable** : data/decisions/*.json + data/decision-tree.json
**Critere de completion** : chaque JSON valide le schema, chaque source presente

### Phase E — Developper l'application

**Action** : creer l'app React+Vite+TypeScript
**Methode** : suivre notre propre guide (ESLint, Prettier, Vitest, etc.)
**Sous-taches** :
  1. Setup projet (pnpm create vite, eslint, prettier, tailwind, shadcn)
  2. Feature configurator (questionnaire step-by-step, lecture decision-tree.json)
  3. Feature guide (affichage recommandations filtrees par choix)
  4. Feature export (JSON pour machines, markdown pour humains)
  5. Tests (Vitest unit, Playwright E2E)
**Critere de completion** : app fonctionnelle, tests verts, lint propre

### Phase F — API

**Action** : endpoint qui accepte les choix et retourne le guide personnalise
**Methode** : serverless function (Vercel) ou static JSON pre-genere
**Livrable** : POST /api/guide fonctionnel
**Critere de completion** : IA peut envoyer un contexte et recevoir des recos

### Phase G — Verification finale

**Action** : audit complet
**Methode** : relire ce plan point par point, verifier chaque critere de completion
**Checklist** :
  □ Chaque decision dans data/ a ses sources
  □ Chaque variante multi-stack a sa double extraction
  □ L'arbre de decision couvre tous les chemins
  □ L'app affiche correctement les recos pour chaque combinaison
  □ L'API retourne le bon JSON
  □ Les tests passent
  □ Le deploiement fonctionne
  □ Un humain peut utiliser le configurateur de A a Z
  □ Une IA peut consommer l'API et obtenir des recos exploitables

### ~~Phase H — Deploiement~~ (REPORTE — hors scope pour le moment)

L'app tourne en local via `pnpm dev`. Le deploiement web sera fait plus tard si besoin.

---

## 6. CE QUI EST DEJA FAIT (on reutilise)

| Element | Statut | Reutilisable |
|---------|--------|-------------|
| Methodologie EBSE (methodology.md) | ✓ Complet | Oui, tel quel |
| Matrice ISO 25010 x SWEBOK (matrix.md) | ✓ Complet | Oui |
| 94 pages markdown Java/React | ✓ Complet | Oui (base pour conversion JSON) |
| Verification (traces, formulaires, kappa) | ✓ Complet | Oui (modele pour nouvelles verifs) |
| 15 exemples calibration GRADE | ✓ Complet | Oui |
| Choix frontend (React 6/7) | ✓ Double extraction | Oui |
| Choix backend (decision tree) | ✓ Double extraction | Oui |
| Choix package manager (pnpm 5/7) | ✓ Double extraction | Oui |

## 7. CE QUI RESTE A FAIRE (nouveau contenu)

| Element | Travail | Methode | Statut |
|---------|---------|---------|--------|
| Variantes NestJS pour ~26 pages | Recherche EBSE | Double extraction | ✓ FAIT (batches 9-11) |
| Variantes Django pour ~26 pages | Recherche EBSE | Double extraction | ✓ FAIT (batches 9-11) |
| Chemin optimal (stack sans contrainte) | Recherche EBSE | Double extraction | ✓ FAIT (batch 12) |
| Pratiques d'ingenierie (~12 decisions) | Recherche EBSE | Double extraction | A FAIRE (Phase B2) |
| Librairies UI granulaires (~16 decisions) | Recherche EBSE | Double extraction | A FAIRE (Phase B3) |
| Conversion en JSON | Technique | Script + verif | A FAIRE (Phase D) |
| Application web | Developpement | Suivre notre guide | A FAIRE (Phase E) |
| API | Developpement | Serverless/static | A FAIRE (Phase F) |
| Tests | Developpement | Vitest + Playwright | A FAIRE (Phase E) |

---

## 8. RISQUES ET MITIGATIONS

| Risque | Mitigation |
|--------|-----------|
| Biais vers Java/React dans les variantes | Les agents NE DOIVENT PAS voir le contenu Java — recherche from scratch |
| Variantes multi-stack de mauvaise qualite | Double extraction 2 agents separes, meme methode que v0.1 |
| Arbre de decision incomplet | Tester chaque chemin possible (combinatoire) |
| JSON mal structure | Schema JSON + validation automatique |
| Oubli de page dans la conversion | Audit automatique (compter pages markdown vs fichiers JSON) |
| L'outil recommande un truc invente | Chaque reco dans le JSON DOIT avoir des sources EBSE |

---

## 9. DEFINITION OF DONE

Le projet est termine quand :
1. ✅ Un humain peut ouvrir l'outil, repondre aux questions, et obtenir un guide complet personnalise
2. ✅ Une IA peut envoyer une requete API et recevoir des recos JSON exploitables
3. ✅ Chaque recommandation affichee a un GRADE + sources verifiables
4. ✅ Les 3 stacks principales sont couvertes (Java/React, NestJS/React, Django/React)
5. ✅ Le chemin "optimal" donne LA meilleure stack selon les sources
6. ✅ Rien n'est invente — tout est source EBSE avec double extraction
7. ~~L'outil est deploye et accessible publiquement~~ (reporte)
