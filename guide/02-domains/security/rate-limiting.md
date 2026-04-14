# Rate Limiting & Protection DDoS

**[RECOMMANDE]** Bucket4j (app-level) + reverse proxy (infra-level) | Score GRADE : 4/7

## App-level (Spring Boot)

```java
// RateLimitFilter — 50 req/min par IP, 5 req/min sur /auth/login
@Component
public class RateLimitFilter extends OncePerRequestFilter {
    private final Map<String, Bucket> buckets = new ConcurrentHashMap<>();

    private Bucket createBucket(int capacity, int minutes) {
        return Bucket.builder()
            .addLimit(Bandwidth.classic(capacity, Refill.intervally(capacity, Duration.ofMinutes(minutes))))
            .build();
    }

    @Override
    protected void doFilterInternal(HttpServletRequest req, HttpServletResponse res, FilterChain chain)
            throws ServletException, IOException {
        String key = req.getRemoteAddr() + (req.getRequestURI().startsWith("/api/auth") ? ":auth" : "");
        int limit = req.getRequestURI().startsWith("/api/auth") ? 5 : 50;
        Bucket bucket = buckets.computeIfAbsent(key, k -> createBucket(limit, 1));
        if (bucket.tryConsume(1)) { chain.doFilter(req, res); }
        else { res.setStatus(429); }
    }
}
```

## Infra-level

Reverse proxy (Caddy/nginx) ou Cloudflare comme premiere ligne.

Sources : OWASP ASVS V11.1 (niv. 2), Bucket4j docs (niv. 3), Resilience4j RateLimiter (niv. 3)
