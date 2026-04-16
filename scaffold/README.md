# Scaffold — ebse-scaffold

## Qu'est-ce que c'est ?

Le **scaffold** configure Claude Code en agent autonome (HOTL) piloté par un **Product Owner (PO)**. Le PO définit l'objectif, l'agent gère tout le reste (décomposition, code, tests, review, PR, monitoring).

**Chaque regle est sourcee** — EBSE domain `ai-collaboration` (17 PICOCs, Kitchenham 2007), docs officielles Claude Code, ou feedback PO. Rien n'est invente.

## Fichiers templates

| Fichier | Destination | Commite ? | Role |
|---------|-------------|:---------:|------|
| `claude-md-autonomous-agent.md` | `<projet>/CLAUDE.md` | Oui (mono-repo) / Non (multi-repo racine) | Regles permanentes : role PO, plan=contrat, escalation, gates, qualite, quota, monitoring |
| `claude-local-example.md` | `<projet>/CLAUDE.local.md` | **Jamais** | Consignes temporaires : overrides de gates, contexte de sprint, contraintes temporaires |
| `settings-autonomous-agent.jsonc` | `<projet>/.claude/settings.json` | Oui (mono-repo) / Non (multi-repo racine) | Config agent : model opusplan, permissions allow/deny, hooks PostToolUse+Stop |
| `settings-local-example.jsonc` | `<projet>/.claude/settings.local.json` | **Jamais** | Overrides personnels : directories supplementaires, prefs locales |

## Installation (5 minutes)

### 1. Copier le CLAUDE.md template

```bash
cp scaffold/claude-md-autonomous-agent.md /chemin/vers/mon-projet/CLAUDE.md
```

### 2. Remplir les sections `[CONFIGURER]`

Ouvrir le CLAUDE.md copie et remplir :
- **Stack** : backend, frontend, BDD, CI/CD, monitoring
- **Commandes** : build, tests, lint, typecheck, e2e, dev
- **Chemins critiques** : auth, payment, migrations, security
- **Conventions** : branche, commit, langue
- **Guide EBSE** : chemin vers `data/decisions/`

### 3. Copier le settings.json template

```bash
# Retirer les commentaires JSONC avant copie
grep -v "^\s*//" scaffold/settings-autonomous-agent.jsonc > /chemin/vers/mon-projet/.claude/settings.json
```

Adapter :
- Les commandes `allow` selon votre stack
- La commande `PostToolUse` hook (ex: `pnpm lint && pnpm typecheck` ou `mvn checkstyle:check`)

### 4. Configurer le mode

Au lancement de Claude Code :
```bash
claude --model opusplan --permission-mode auto
```

Ou dans les settings du projet pour persistence.

### 5. C'est pret

Dire a Claude Code : "Je veux [feature X]" — il decompose, code, teste, review, et te presente un PR.

## Architecture des fichiers

Claude Code utilise plusieurs fichiers avec une **precedence precise** (source : code.claude.com/docs/en/memory) :

### Cas 1 : Mono-repo (un seul repo git = le projet)

```
<projet>/                        ← repo git
├── CLAUDE.md                    ← Regles PERMANENTES (COMMITE, partage avec l'equipe)
├── CLAUDE.local.md              ← Consignes TEMPORAIRES (PAS commite, dans .gitignore)
├── .claude/
│   ├── settings.json            ← Config agent (COMMITE)
│   └── settings.local.json      ← Overrides perso (PAS commite)
```

### Cas 2 : Multi-repo (dossier parent + sous-repos git)

```
<projet>/                        ← PAS un repo git (dossier parent)
├── CLAUDE.md                    ← Regles permanentes — PAS commite car hors repos
│                                  Distinction permanent/temporaire reste utile semantiquement
├── CLAUDE.local.md              ← Consignes temporaires — PAS commite non plus
├── .claude/
│   ├── settings.json            ← Config agent — PAS commite (hors repos)
│   └── settings.local.json      ← Overrides — PAS commite
│
├── <sous-repo-backend>/         ← repo git
│   └── CLAUDE.md                ← Regles specifiques backend (COMMITE dans ce repo)
├── <sous-repo-frontend>/        ← repo git
│   └── CLAUDE.md                ← Regles specifiques frontend (COMMITE dans ce repo)
└── <sous-repo-docs>/            ← repo git
    └── CLAUDE.md                ← Regles specifiques docs (COMMITE dans ce repo)
```

**En multi-repo** : les CLAUDE.md a la racine sont hors des repos git donc jamais commites. Seuls les CLAUDE.md **dans** chaque sous-repo sont commites. Les sous-repos heritent automatiquement du CLAUDE.md parent (Claude Code auto-discover les parents).

**Conseil multi-repo** : meme si le CLAUDE.md racine n'est pas commite, le **sauvegarder quelque part** (backup, repo documentation) car il contient la config agent + tokens monitoring + procedures. Si la machine est perdue, il faut pouvoir le reconstruire.

### Precedence (du plus fort au plus faible)

1. **Managed policy** (entreprise) — si applicable
2. **Project `.claude/settings.json`** — config agent du projet (commite)
3. **User `~/.claude/settings.json`** — config globale utilisateur
4. **Local `.claude/settings.local.json`** — overrides personnels (PAS commite)

**CLAUDE.md** : tous les CLAUDE.md (racine + sous-repos + parents) sont **concatenes** au demarrage. Le plus specifique complete le plus general.

### Quand utiliser quoi

| Situation | Ou mettre | Commite ? |
|-----------|-----------|:---------:|
| Regle permanente du projet (conventions, stack, monitoring) | `CLAUDE.md` | **Oui** |
| Override temporaire ("0 users donc reset DB OK") | `CLAUDE.local.md` | **Non** |
| Permissions agent, hooks, model par defaut | `.claude/settings.json` | **Oui** |
| Directories supplementaires perso, overrides locaux | `.claude/settings.local.json` | **Non** |
| Reperes specifiques a un sous-repo (backend, frontend) | `<sous-repo>/CLAUDE.md` | **Oui** |

### Consignes temporaires (CLAUDE.local.md)

Les consignes temporaires sont des **overrides contextuels** qui ne doivent PAS etre commitees car elles changent selon :
- Le stade du projet (0 users vs production avec vrais users)
- Le sprint en cours (acces SSH autorise pour ce sprint)
- L'environnement personnel (chemins locaux, tokens personnels)

**Exemples** :

```markdown
# CLAUDE.local.md (PAS commite)

## Override gate : DB schema
Contexte : zero users en prod. Tu peux consolider les migrations
et reset la DB au lieu d'empiler. Supprime cette consigne quand
les premiers vrais utilisateurs arrivent.

## Override gate : acces serveur
Tu peux SSH sur le serveur prod (debian@IP) pour diagnostics directs.
Toujours confirmer avant actions destructives.
```

Quand la consigne temporaire est supprimee → l'agent retombe sur les regles permanentes du `CLAUDE.md` (qui incluent les gates humaines obligatoires).

## Prerequis

- Claude Code installe avec un plan Max (20x recommande pour usage intensif)
- Le guide EBSE (`data/decisions/`) accessible depuis le projet
- CI/CD avec lint + tests + typecheck configure (pour les hooks)
- Optionnel : Playwright MCP pour tests navigateur, Context7 MCP pour docs

## Personnalisation par projet

Le template est **universel** — les parties projet-specifiques sont dans les sections `[CONFIGURER]`. Exemples :

### Projet TypeScript/React

```
Build : pnpm build
Tests : pnpm test
Lint : pnpm lint
Typecheck : pnpm typecheck
E2E : pnpm playwright test
```

### Projet Java/Spring Boot

```
Build : mvn clean package -DskipTests
Tests : mvn verify
Lint : mvn checkstyle:check
Typecheck : N/A (compile = typecheck)
E2E : mvn failsafe:integration-test
```

### Projet Python/Django

```
Build : N/A
Tests : pytest
Lint : ruff check .
Typecheck : mypy .
E2E : pytest tests/e2e/
```

## Tracabilite

Chaque regle du template CLAUDE.md a un tag `Source:` qui pointe vers :
- **PICOC #N** : decision du domaine `ai-collaboration` dans `data/decisions/ai-agent-*.json`
- **Claude Code docs** : documentation officielle fetchee et verifiee
- **Feedback PO** : directive du Product Owner memorisee et validee
- **EBSE source** : papier academique / standard (arXiv, ISO, NIST, EU AI Act)

Le tableau de tracabilite complet est en fin de template.

## Maintenance

- **Re-evaluation domaine** : tous les 6 mois (domaine `ai-collaboration` base sur sources 2024-2026, en evolution rapide)
- **Mise a jour template** : quand de nouvelles PICOCs sont ajoutees au domaine
- **Feedback PO** : les feedbacks du PO sont memorises par Claude Code et integres automatiquement dans les sessions futures
