# Framework backend

**[CHOIX D'EQUIPE]** Le choix depend du contexte — pas de reponse universelle | Score GRADE : 2/7

## Pourquoi pas de reponse unique

2 agents independants arrivent a 2 recommandations differentes :
- Agent A : NestJS (meme langage que le frontend, TypeScript partout)
- Agent B : Django (MVP le plus rapide, Python #1 TIOBE)

Les 2 sont d'accord sur un point : **Spring Boot n'est PAS le premier choix pour une equipe de 1-10 devs** qui part de zero (trop de boilerplate, courbe d'apprentissage Java).

## Arbre de decision

```
Quel langage ton equipe maitrise ?
├── Java → Spring Boot [RECOMMANDE pour ce contexte]
│   SO Survey 2025 : 14.7% adoption backend, top satisfaction Java
│   Forces : JVM performante, ecosysteme enterprise mature, virtual threads Java 21
│   Faiblesse : verbeux, courbe d'apprentissage raide pour les juniors
│
├── TypeScript/JavaScript → NestJS [RECOMMANDE pour ce contexte]
│   State of JS 2025 : croissance la plus rapide
│   Forces : meme langage front+back, structure Angular-like, Swagger auto
│   Faiblesse : moins mature que Spring (7 ans vs 20 ans)
│
├── Python → Django + DRF [RECOMMANDE pour ce contexte]
│   Python #1 TIOBE (26%), SO Survey 2025 : 12.6%
│   Forces : MVP ultra-rapide, admin inclus, ORM inclus, hiring pool enorme
│   Faiblesse : performance sync par defaut, scaling plus complexe
│
└── C# → ASP.NET Core [RECOMMANDE pour ce contexte]
    Excellent performance (Kestrel, AOT), ecosysteme Microsoft
    Forces : typage fort, top benchmarks perf
    Faiblesse : ecosysteme OSS plus petit hors Microsoft
```

## Comparaison (donnees enquetes)

| Critere | Spring Boot | NestJS | Django | ASP.NET Core |
|---------|------------|--------|--------|-------------|
| SO 2025 usage | 14.7% | 6.7% | 12.6% | 14.2% |
| Ecosysteme | Maven (enterprise, massif) | npm (le plus grand) | PyPI (data+web) | NuGet (Microsoft) |
| Performance | Excellente (JVM) | Bonne (V8) | Moderee (sync) | Excellente (Kestrel) |
| Courbe apprentissage | Raide | Moderee | Douce | Moderee |
| Fit equipe 1-10 | Moyen | Excellent | Excellent | Bon |
| Hiring pool | Grand (senior/enterprise) | Tres grand (JS devs) | Tres grand (Python #1) | Moyen |

## Resolution de la divergence

Le GRADE est 2/7 [CHOIX D'EQUIPE] car **aucune source ne recommande UN framework pour TOUS les contextes**. Le choix depend de :
1. Le langage que l'equipe maitrise (facteur #1 selon SWEBOK — productivite depend de la maitrise)
2. Le type d'application (enterprise → Spring Boot, MVP rapide → Django, full-stack JS → NestJS)
3. Le hiring pool cible

Sources : SO Survey 2025 49k devs (niv. 4), JetBrains 2024 23k devs (niv. 4), State of JS 2025 (niv. 4), TIOBE 2026 (niv. 4), SWEBOK v4 "SE Economics — productivity depends on language mastery" (niv. 1)
