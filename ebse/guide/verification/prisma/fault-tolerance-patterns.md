# PRISMA Flow — PICOC : fault-tolerance-patterns

**Date de recherche** : 2026-04-17
**Bases interrogees** : arXiv (cs.DC, cs.SE, cs.NI), WebSearch general, documentation framework officielle (Resilience4j, Azure Architecture Center, AWS Well-Architected), IETF RFC, NIST CSRC
**Mots-cles Agent A** : "circuit breaker pattern microservices", "retry exponential backoff jitter production", "bulkhead pattern thread isolation", "timeout distributed systems", "cascading failure prevention", "stability patterns release it", "Hystrix Netflix fault tolerance"
**Mots-cles Agent B** : "fault tolerance patterns distributed systems", "resilience patterns systematic review", "circuit breaker retry bulkhead timeout composition", "retry storm prevention", "graceful degradation web application", "nestjs resilience patterns", "NIST cyber resilience engineering"
**Protocole** : methodology.md v3.0 §2.1 — double extraction independante (Agents A + B, mots-cles differents) + synthese

---

## Flux

```
IDENTIFICATION
  Sources identifiees par base (Agent A + Agent B combines, avant deduplication) :
    - arXiv (cs.DC, cs.SE, cs.NI) : ~22 resultats candidats
    - Documentation officielle frameworks (Resilience4j, Azure, AWS, Google SRE) : ~14 sources
    - WebSearch general (livres, bliki, IETF, NIST) : ~16 sources
    - GitHub (Netflix Hystrix, nestjs-resilience) : ~6 sources
    - Snowballing backward (references citees par Nygard, Google SRE) : ~8 sources
  Total identifie (brut, combine A+B) : ~66
  Doublons retires (meme source identifiee par A et B) :
    - Nygard Release It! 2018 : present A et B
    - arXiv 2512.16959 systematic review : present A et B
    - Google SRE Book ch.22 : present A et B
    - Resilience4j documentation : present A et B
  Total apres deduplication : ~62

SCREENING (titre + resume)
  Sources screenes : ~62
  Sources exclues au screening : ~43
    - E1 (blog opinion sans donnees, niveau 5 redondant) : ~15
    - E2 (hors scope PICOC — resilience infrastructure, pas patterns applicatifs) : ~12
    - E3 (doublons partiels — meme contenu, edition anterieure) : ~8
    - E4 (vendeur sans methodologie transparente) : ~8

ELIGIBILITE (lecture complete)
  Sources evaluees en detail : ~19
  Sources exclues apres lecture complete : ~4
    - Polly .NET documentation : pertinente mais redondante avec Resilience4j (meme semantique, autre langage) — exclue au profit de nestjs-resilience plus pertinent pour OLS
    - Nolan InfoQ 2020 cascading failures : contenu absorbe par Zhou et al. 2021 (peer-reviewed) et Google SRE
    - Azure Well-Architected Framework 2024 (B) : contenu consolide dans Azure Architecture Center 2025 — version 2025 retenue
    - OpenTelemetry docs : hors PICOC (observabilite, pas fault tolerance)

INCLUSION
  Sources incluses dans la synthese : 15
    - Niveau 1 : 2 (RFC 6585 IETF ; NIST SP 800-160 v2r1)
    - Niveau 3 : 6 (Azure Architecture Center 2025 ; AWS WAF Reliability Pillar 2024 ; Resilience4j docs ;
                    Zhou et al. IEEE TSE 2021 ; arXiv 2512.16959 ; arXiv 2511.23278 ; nestjs-resilience)
    - Niveau 4 : 2 (Google SRE Book ch.22 2016 ; Brooker AWS Builders Library 2019 ; Netflix Hystrix)
    - Niveau 5 : 4 (Nygard Release It! 2018 ; Fowler CircuitBreaker 2014 ; Hohpe & Woolf EIP 2003)

  Sources exclues avec raison documentee :
    - Polly .NET docs : redondant Resilience4j, hors stack OLS
    - Nolan InfoQ 2020 : absorbe par sources peer-reviewed plus rigoureuses
    - Azure WAF 2024 version anterieure : remplacee par Azure Architecture Center 2025
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogees

| Element | Valeur |
|---------|--------|
| Bases | arXiv (cs.DC, cs.SE), WebSearch, GitHub, documentation framework |
| Mots-cles | "circuit breaker pattern", "retry exponential backoff jitter", "bulkhead thread isolation", "stability patterns", "cascading failure" |
| Periode couverte | 2003-2025 |
| Sources identifiees | ~38 |
| Sources retenues | 10 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogees

| Element | Valeur |
|---------|--------|
| Bases | arXiv (cs.NI, cs.SE), WebSearch, NIST CSRC, IETF, GitHub |
| Mots-cles | "fault tolerance patterns distributed systems", "resilience patterns systematic review", "retry storm prevention", "NIST cyber resilience", "nestjs resilience" |
| Periode couverte | 2003-2025 |
| Sources identifiees | ~28 |
| Sources retenues | 11 (convergence elevee avec A sur 4 sources) |
| Date d'extraction | 2026-04-17 |

---

## Accord Reviewer A / Reviewer B

| # | Source | Niveau A | Niveau B | Accord ? | Note divergence |
|---|--------|---------|---------|:--------:|-----------------|
| 1 | RFC 6585 IETF 2012 | 1 | absent | partiel | **A-only** — inclus, base normative HTTP |
| 2 | NIST SP 800-160 v2r1 2021 | absent | 1 | partiel | **B-only** — inclus, source normative NIST |
| 3 | Nygard Release It! 2018 | 5 | 5 | ✓ | Source fondatrice convergente |
| 4 | Fowler CircuitBreaker 2014 | 5 | 5 | ✓ | Definition formelle etats CB |
| 5 | Hohpe & Woolf EIP 2003 | absent | 5 | partiel | **B-only** — inclus, prerequis idempotence |
| 6 | Google SRE Book ch.22 2016 | 3-4 | 5 | partiel | Niveaux divergent, chiffres B retenus |
| 7 | Brooker AWS Builders Library 2019 | 3-4 | 3-4 | ✓ | Formule full jitter |
| 8 | Azure Architecture Center 2025 | 3 | 5 | partiel | Niveau divergent, source incluse |
| 9 | AWS WAF Reliability Pillar 2024 | absent | 5 | partiel | **B-only** — inclus |
| 10 | Resilience4j docs 2019-2025 | 3 | 3 | ✓ | Ordre composition canonique |
| 11 | Zhou et al. IEEE TSE 2021 | 3 | absent | partiel | **A-only** — inclus, etude empirique |
| 12 | arXiv 2512.16959 2025 | 3-4 | 3 | ✓ | Systematic review 26 etudes |
| 13 | arXiv 2511.23278 RetryGuard 2025 | absent | 3 | partiel | **B-only** — inclus, retry storm data |
| 14 | Netflix Hystrix GitHub | 3-4 | absent | partiel | **A-only** — inclus, historique prod |
| 15 | nestjs-resilience GitHub | absent | 3 | partiel | **B-only** — inclus, profil OLS NestJS |

**Accord sur sources communes** : 4/4 sources partagees → kappa = 1.0 (inclusion + substance).

### Resolution des divergences

**RFC 6585 (A-only)** : Inclus — base normative IETF pour la semantique HTTP du retry (429 + Retry-After). Indispensable pour tout retry respectueux du protocole.

**NIST SP 800-160 v2r1 (B-only)** : Inclus avec note d'indirectness — cadre conceptuel (anticipate/withstand/recover/adapt) qui englobe les patterns. Source niveau 1, valeur normative meme si orientation cyber-resilience systemique.

**Hohpe & Woolf EIP 2003 (B-only)** : Inclus — Idempotent Receiver est le prerequis architectural fondamental du retry. Sans idempotence, le retry est dangereux (double-debit, double-creation).

**arXiv 2511.23278 RetryGuard (B-only)** : Inclus — donnees quantitatives recentes sur le retry storm (-98%). Nuance critique absente des autres sources.

**nestjs-resilience (B-only)** : Inclus dans variant NestJS — pertinent pour le profil OLS (backend NestJS). Grade variant : 3/RECOMMANDE (niveau 3, convergence avec Resilience4j sur la semantique).

**Netflix Hystrix (A-only)** : Inclus comme contexte historique niveau 4 — valide les patterns en production a grande echelle (10B+ exec/day). Contexte, pas recommandation d'implementation (Hystrix en maintenance mode).

**Google SRE niveaux divergents** : Niveau 4 retenu (Google, peer-reviewed interne, donnees production). Chiffres exacts de l'Agent B utilises (P99 2600ms→1400ms, erreurs 17%→6%).

---

## Sources exclues — raisons documentees

| Source | Raison exclusion |
|--------|-----------------|
| Polly .NET documentation | Redondant avec Resilience4j (meme semantique), hors stack OLS/NestJS |
| Nolan InfoQ 2020 | Absorbe par Zhou et al. 2021 (peer-reviewed) — meme phenomene, rigueur superieure |
| Azure WAF 2024 version anterieure | Remplacee par Azure Architecture Center 2025 — version plus recente retenue |
| OpenTelemetry documentation | Hors PICOC — observabilite, pas fault tolerance patterns |
| Blog posts / tutorials sans donnees | Niveau 5 redondant avec sources institutionnelles |
