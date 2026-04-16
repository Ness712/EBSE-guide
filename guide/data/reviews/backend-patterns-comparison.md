# Double Extraction v3.0 — Backend Patterns (5 decisions)

**Date** : 2026-04-15
**Agent A** : af3e1106d39eab9c2
**Agent B** : a55da6db19812b8fb

## Resultats

- **Accord outil : 5/5 (100%)**
- **0 divergence sur les recommandations**
- **GRADE : ±1 entre agents sur 2 decisions (entity-dto, doc org), identique sur 3**

| # | Decision | Reco | GRADE conservatif | Robustesse |
|---|----------|------|-------------------|------------|
| 1 | Entity-DTO mapping | MapStruct (simple) + manual @Component (complexe), jamais ModelMapper | 5/7 [STANDARD] | ROBUSTE |
| 2 | Error boundary strategy | 3 layers (global + per-route + per-feature), react-error-boundary | 5/7 [STANDARD] | ROBUSTE |
| 3 | Changelog display | Page persistante + notification subtile, PAS modal bloquante | 3/7 [BONNE_PRATIQUE] | FRAGILE |
| 4 | Documentation organization | Split par type/audience (Diataxis), single source of truth | 5/7 [RECOMMANDE] | ROBUSTE |
| 5 | Lombok usage | Lombok pour JPA entities + services, Records pour DTOs simples | 4/7 [RECOMMANDE] | ROBUSTE |

## Notes
- Entity-DTO mapping est la decision la plus solide du batch (JMH benchmarks, 152x difference)
- Changelog est FRAGILE — sources principalement de vendors SaaS (Appcues, UserPilot)
- Documentation organization confirme que la structure OLS actuelle (split README/CONVENTIONS/guides/references) est deja alignee avec Diataxis + Google SWE Book
- Lombok : Agent A a identifie un risque @Data sur JPA entities (lazy loading, hashCode) que Agent B n'a pas mentionne explicitement — le GRADE reste identique car B arrive a la meme reco
