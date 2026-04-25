# ebse-scaffold

Outil interactif de decisions techniques pour le developpement logiciel, base sur l'Evidence-Based Software Engineering (EBSE).

## Qu'est-ce que c'est ?

Un configurateur qui :
1. Te pose des questions sur ton projet (langage, equipe, budget, type d'app)
2. Determine la stack optimale selon des sources verifiables (pas d'opinion, pas d'invention)
3. Genere un guide personnalise avec TOUTES les recommandations adaptees a ta stack
4. Chaque recommandation a un score de confiance (GRADE) et des sources verifiables

## Methode

Adaptation de l'Evidence-Based Medicine au genie logiciel (EBSE, Kitchenham et al. 2004).

- **PICO** : chaque decision formulee comme une question structuree
- **Pyramide des preuves** : chaque source classee par fiabilite (ISO > OWASP > docs > enquetes > experts)
- **GRADE** : score de confiance mecanique (pas de jugement humain)
- **Double extraction** : 2 agents IA independants pour chaque recommandation
- **Kappa de Cohen** : taux d'accord mesure et documente
- **Tracabilite** : chaque recommandation a un fichier de preuve

Voir [ebse/guide/methodology.md](ebse/guide/methodology.md) pour le protocole complet.

## Utilisation

### Humain (web UI)
```bash
cd ebse/app
pnpm install
pnpm dev
# Ouvrir http://localhost:5173
```

### Machine / IA (API JSON)
```bash
# Envoyer le contexte, recevoir les recommandations
curl -X POST http://localhost:5173/api/guide \
  -H "Content-Type: application/json" \
  -d '{"backend": "java-spring-boot", "frontend": "react", "database": "postgresql"}'
```

### Donnees brutes
Les recommandations sont dans `ebse/guide/data/decisions/*.json` (lisibles par humain et machine).

## Structure du projet

```
ebse-scaffold/
├── ebse/                   ← Guide EBSE (decisions + app web)
│   ├── guide/              ← Decisions techniques basees sur preuves
│   │   ├── methodology.md  ← Methode EBSE (PICOC, GRADE, double extraction)
│   │   ├── data/           ← Base de donnees de recommandations (JSON)
│   │   │   ├── decisions/  ← 1 fichier par decision (PICOC)
│   │   │   ├── decision-tree.json
│   │   │   └── stacks/     ← Profils pre-calcules par stack
│   │   ├── verification/   ← Traces de double extraction + PRISMA
│   │   └── scripts/        ← Outils de maintenance du guide
│   └── app/                ← Application web (React + Vite + TypeScript)
└── scaffold/               ← Scaffold agent (templates operationnels)
    ├── scaffold-claude.md      ← Template CLAUDE.md universel (toutes les regles agent)
    ├── scaffold-settings.jsonc ← Template settings.json (permissions + hooks)
    ├── agents/                 ← Templates sous-agents custom (.claude/agents/)
    │   ├── reviewer/agent.md   ← Reviewer independant (sonnet, plan-mode, PICOC #5)
    │   └── explorer/agent.md   ← Explorateur lecture seule (haiku, plan-mode)
    ├── rules/                  ← Template regle path-scopee (.claude/rules/)
    │   └── template.md         ← Regle avec frontmatter paths: (chargement on-demand)
    ├── hooks/                  ← Scripts hooks Claude Code (.claude/hooks/)
    │   ├── session-start.sh    ← SessionStart : env + health-check
    │   ├── pre-commit-quality.sh ← PreToolUse : gates qualite avant commit
    │   ├── pre-push-quality.sh ← PreToolUse : pipeline complet avant push
    │   ├── pre-pr-create.sh    ← PreToolUse : verifie structure PR template
    │   ├── post-edit-lint.sh   ← PostToolUse : lint rapide apres Edit
    │   ├── post-merge-worktree.sh ← PostToolUse : cleanup worktree apres merge
    │   ├── audit-tool-use.sh   ← PostToolUse : audit trail MANDATORY (PICOC #20)
    │   ├── pre-compact.sh      ← PreCompact : re-injecte regles MANDATORY
    │   ├── subagent-start.sh   ← SubagentStart : contexte + log sous-agents
    │   ├── user-prompt-filter.sh ← UserPromptSubmit : detection injection
    │   ├── stop-notify.sh      ← Stop : notification OS tache terminee
    │   └── prompt-injection-filter.sh ← filtre injection generique
    └── commands/               ← Slash commands templates (/audit, /api-test, etc.)
```

## Stacks couvertes

- Java / Spring Boot + React
- TypeScript / NestJS + React
- Python / Django + React
- (C# / ASP.NET — prevu)
