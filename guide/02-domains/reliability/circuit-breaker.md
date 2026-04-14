# Circuit Breaker

**[RECOMMANDE]** **Resilience4j** | Score GRADE : 4/7

Successeur de Netflix Hystrix (deprecie 2018). Critical pour les appels services externes (email, stockage, APIs tiers).

```yaml
# application.yml
resilience4j:
  circuitbreaker:
    instances:
      emailService:
        sliding-window-size: 10
        failure-rate-threshold: 50
        wait-duration-in-open-state: 30s
        permitted-number-of-calls-in-half-open-state: 3
  retry:
    instances:
      emailService:
        max-attempts: 3
        wait-duration: 1s
        exponential-backoff-multiplier: 2
```

```java
@CircuitBreaker(name = "emailService", fallbackMethod = "emailFallback")
@Retry(name = "emailService")
public void envoyerNotification(String dest, String sujet, String corps) {
    mailSender.send(buildMessage(dest, sujet, corps));
}

private void emailFallback(String dest, String sujet, String corps, Throwable t) {
    log.warn("Circuit ouvert pour email: {}", t.getMessage());
    emailQueueRepository.save(new EmailEnAttente(dest, sujet, corps));
}
```

Sources : Resilience4j docs (niv. 3), Spring Cloud Circuit Breaker (niv. 3), Nygard "Release It!" — #1 stability pattern (niv. 5), Netflix Hystrix deprecation → Resilience4j (niv. 3)
