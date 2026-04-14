# Dependency Scanning

**[STANDARD]** Dependabot + npm audit + OWASP dependency-check | Score GRADE : 6/7

## Dependabot (GitHub)

```yaml
# .github/dependabot.yml
version: 2
updates:
  - package-ecosystem: "maven"
    directory: "/OLS-backend"
    schedule: { interval: "weekly" }
    open-pull-requests-limit: 10
  - package-ecosystem: "npm"
    directory: "/OLS-frontend"
    schedule: { interval: "weekly" }
    open-pull-requests-limit: 10
  - package-ecosystem: "docker"
    directory: "/"
    schedule: { interval: "weekly" }
```

## OWASP dependency-check (Maven)

```xml
<plugin>
    <groupId>org.owasp</groupId>
    <artifactId>dependency-check-maven</artifactId>
    <version>10.0.4</version>
    <configuration>
        <failBuildOnCVSS>7</failBuildOnCVSS>
    </configuration>
</plugin>
```

## npm audit (CI)

```yaml
- name: npm audit
  run: npm audit --audit-level=high
```

Processus : Dependabot PRs weekly → review + merge rapide. CI echoue sur CVE high/critical.

Sources : OWASP Top 10 A06 (niv. 2), OWASP ASVS V14.2 (niv. 2), NIST NVD (niv. 1), Dependabot docs (niv. 3)
