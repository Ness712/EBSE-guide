# Double Extraction — Batch 15 : Ordre de l'arbre de decision

**Date** : 2026-04-14
**Agent A** : ace9509f2732cfe21 (contexte independant)
**Agent B** : abed764038bad61b3 (contexte independant)

## PICO

P = Arbre de decision pour choix de stack web
I = Langage comme question racine (cascade sur back+front)
C = Backend et frontend comme questions separees independantes
O = Coherence stack, type safety, productivite

## Resultats

- **Accord recommandation : 100%** — les 2 agents recommandent language-first
- **Accord GRADE : MODERATE pour les deux**
- **0 divergence**

## Arguments convergents

1. **Le langage est la contrainte racine** — chaque decision downstream (framework, ORM, tooling) est contrainte par le langage
2. **Seul TypeScript permet le full-stack single-language** — Java/Python/C# = backend seulement, frontend toujours en TypeScript/JS (contrainte navigateur W3C/WHATWG)
3. **SWEBOK v4 SE Economics** — "productivity depends on language mastery"
4. **Batch 12 (stack optimale)** — TypeScript full-stack gagne PARCE QUE le langage est unique (type safety DB→UI)
5. **L'approche component-first est logiquement incoherente** — elle presente comme independantes deux decisions qui ont une relation de dependance

## Fait technique

Les navigateurs web n'executent que JavaScript (W3C/WHATWG HTML spec). TypeScript compile vers JS. Aucune alternative n'approche JS/TS en adoption frontend :
- SO Survey 2025 : Blazor ~3%, Flutter Web ~2% — negligeable vs React/Vue/Angular
- W3C HTML spec ne supporte que JavaScript comme langage de script

Le frontend est donc TOUJOURS TypeScript/JavaScript, quel que soit le backend.

## Modifications appliquees

- decision-tree.json : question "quel langage" = racine, chaque option indique explicitement "stack polyglotte" ou "single-language"
- Frontend toujours marque comme TypeScript
