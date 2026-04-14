# Gestion des dependances

**[RECOMMANDE]** Version pinning + Dependabot weekly + review avant upgrade majeure | Score GRADE : 4/7

Les dependances non epinglees et non mises a jour sont la premiere source de vulnerabilites. Dependabot automatise la detection ; la review humaine evite les breaking changes.

```yaml
# .github/dependabot.yml — scan hebdomadaire
version: 2
updates:
  - package-ecosystem: "npm"
    directory: "/"
    schedule:
      interval: "weekly"
    open-pull-requests-limit: 10
  - package-ecosystem: "maven"
    directory: "/"
    schedule:
      interval: "weekly"
```

| Regle | Implementation |
|-------|---------------|
| Epingler les versions | `package-lock.json` (npm), versions exactes dans `pom.xml` |
| `npm ci` en CI (jamais `npm install`) | Respecte le lockfile, build reproductible |
| Dependabot ou Renovate weekly | Detection automatique des mises a jour |
| Review changelog avant major upgrade | Eviter les breaking changes en prod |
| Audit securite en CI | `npm audit` + `mvn dependency-check` |

| Principe | Source |
|----------|--------|
| Dependances explicitement declarees | Twelve-Factor Factor II |
| Build reproductible via lockfile | Twelve-Factor Factor II |
| Scan automatique des CVE | OWASP A06:2021 Vulnerable Components |

Sources : Twelve-Factor Factor II — declare dependencies explicitly (niv. 5), OWASP A06:2021 — Vulnerable and Outdated Components (niv. 2), SWEBOK v4 — dependency management, supply chain (niv. 1), GitHub Dependabot docs (niv. 3)
