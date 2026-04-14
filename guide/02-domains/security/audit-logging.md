# Audit Logging

**[STANDARD]** Piste d'audit structuree pour la non-repudiation | Score GRADE : 6/7

Chaque action sensible doit generer un enregistrement d'audit immutable contenant : **qui**, **quoi**, **quand**, **ou**.

## Champs obligatoires

| Champ | Description | Exemple |
|-------|-------------|---------|
| actor | Utilisateur ou systeme | `userId:42` |
| action | Operation effectuee | `DELETE_USER` |
| timestamp | ISO 8601 UTC | `2026-04-14T10:30:00Z` |
| resource | Entite ciblee | `User#42` |
| outcome | Resultat | `SUCCESS` / `FAILURE` |
| ip / origin | Source de la requete | `192.168.1.1` |

## Implementation Spring Boot (AOP + MDC)

```java
@Aspect
@Component
public class AuditAspect {
    @Around("@annotation(Audited)")
    public Object audit(ProceedingJoinPoint jp) throws Throwable {
        MDC.put("actor", SecurityContextHolder.getContext().getAuthentication().getName());
        MDC.put("action", jp.getSignature().getName());
        MDC.put("timestamp", Instant.now().toString());
        try {
            Object result = jp.proceed();
            log.info("AUDIT action={} outcome=SUCCESS", jp.getSignature().getName());
            return result;
        } catch (Exception e) {
            log.warn("AUDIT action={} outcome=FAILURE", jp.getSignature().getName());
            throw e;
        } finally { MDC.clear(); }
    }
}
```

## Sources

- [niv. 1] ISO/IEC 27002:2022 Control 8.15 — audit logs obligatoires, retention >= 1 an
- [niv. 2] OWASP ASVS V7 — structured audit logging, non-repudiation
- [niv. 2] OWASP Logging Cheat Sheet — qui/quoi/quand/ou, protection contre falsification
- [niv. 3] Spring AOP + SLF4J MDC — implementation recommandee pour Spring Boot
