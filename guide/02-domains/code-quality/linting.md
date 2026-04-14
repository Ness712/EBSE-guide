# Linting, formatting et analyse statique

## Pourquoi c'est obligatoire

**[STANDARD]** Le linting et l'analyse statique sont des **techniques primaires** de qualite | Score GRADE : 6/7

```
"Numerous techniques exist to ensure the quality of code as it is constructed.
 The primary techniques used to ensure construction quality are: [...] Static analysis"
 — SWEBOK v4, Section 3.6
```

```
"An estimated 82% of vulnerabilities are caused by clashes between programming styles."
 — SWEBOK v4, Computing Foundations (citant ptsecurity.com)
```

```
"Use tools and periodic reviews to ensure adopted standards and guidelines are followed."
 — SWEBOK v4, Section 1.5
```

L'analyse statique seule detecte **55-65% des defauts** (Capers Jones, 13 000+ projets). Combinee avec tests + reviews : **>97%**.

Sources : SWEBOK v4 (niv. 1), OWASP SAST (niv. 2), Capers Jones (niv. 5)

---

## JavaScript / TypeScript

### Linter

**[RECOMMANDE]** **ESLint** | Score GRADE : 5/7

React le recommande officiellement et qualifie `eslint-plugin-react-hooks` d'**"essentiel"**.

```bash
npm install -D eslint @eslint/js typescript-eslint eslint-plugin-react-hooks
```

```javascript
// eslint.config.js (flat config)
import js from '@eslint/js';
import tseslint from 'typescript-eslint';
import reactHooks from 'eslint-plugin-react-hooks';

export default tseslint.config(
  js.configs.recommended,
  ...tseslint.configs.recommended,
  reactHooks.configs['recommended-latest'],
);
```

| Alternative | Verdict |
|-------------|---------|
| Biome | 35x plus rapide, 479 regles, mais React ne le recommande pas (encore). 7M dl/sem vs ESLint 115M |
| oxlint | 50-100x plus rapide, mais 300 regles seulement, pas de formatter |

Surveiller : Biome est en forte croissance. Si React met a jour sa recommandation → reevaluer.

Sources : React docs "ESLint essential" (niv. 3), State of Frontend 2024 : 89.3% adoption (niv. 4), npm 115M/sem (niv. 4)

### Formatter

**[RECOMMANDE]** **Prettier** | Score GRADE : 5/7

React le recommande officiellement.

```bash
npm install -D prettier eslint-config-prettier
```

```json
// .prettierrc
{
  "semi": true,
  "singleQuote": true,
  "trailingComma": "all",
  "printWidth": 100,
  "tabWidth": 2
}
```

Separer les roles ESLint et Prettier (recommandation React) :
- **ESLint** = erreurs logiques (bugs, hooks)
- **Prettier** = formatting (indentation, guillemets, virgules)
- `eslint-config-prettier` desactive les regles de formatting dans ESLint

```
"We recommend disabling all formatting rules in your ESLint preset using
 eslint-config-prettier so that ESLint is only used for catching logical mistakes."
 — React docs
```

Sources : React docs (niv. 3), State of Frontend 2024 : 87.5% adoption (niv. 4)

---

## Java (Spring Boot)

### Linter (style enforcement)

**[BONNE PRATIQUE]** **Checkstyle** avec `google_checks.xml` | Score GRADE : 2/7

Spring Boot ne prescrit pas de linter aux utilisateurs. Google Java Style Guide reference `google-java-format` comme implementation de reference. Checkstyle fournit une config `google_checks.xml` officielle.

```xml
<!-- pom.xml -->
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-checkstyle-plugin</artifactId>
  <version>3.6.0</version>
  <configuration>
    <configLocation>google_checks.xml</configLocation>
    <failOnViolation>true</failOnViolation>
  </configuration>
</plugin>
```

| Alternative | Verdict |
|-------------|---------|
| PMD | Focus different (code smells, patterns) — complementaire, pas concurrent |
| SpotBugs | Focus different (bugs dans bytecode) — complementaire |
| Spring JavaFormat | Utilise par Spring, mais peu adopte en dehors de l'ecosysteme Spring |

Sources : Google Java Style Guide (niv. 3), Spring Boot utilise Checkstyle en interne (niv. 3). Pas de recommandation framework pour les utilisateurs → score plus bas.

### Formatter

**[BONNE PRATIQUE]** **google-java-format** | Score GRADE : 2/7

Zero configuration. Formatte selon le Google Java Style Guide.

```xml
<!-- pom.xml -->
<plugin>
  <groupId>com.spotify.fmt</groupId>
  <artifactId>fmt-maven-plugin</artifactId>
  <version>2.25</version>
  <executions>
    <execution>
      <goals><goal>format</goal></goals>
    </execution>
  </executions>
</plugin>
```

```
"There is no configurability as to the formatter's algorithm for formatting.
 This is a deliberate design decision to unify our code formatting on a single format."
 — google-java-format README
```

Sources : Google Java Style Guide (niv. 3), google-java-format docs (niv. 3)

---

## Analyse statique multi-langage

**[RECOMMANDE]** **SonarQube** avec quality gate "Sonar way" | Score GRADE : 4/7

OWASP liste SonarQube pour Java et JS/TS. La recherche academique le classe #1 en detection de defauts.

### Quality gate par defaut ("Sonar way")

| Condition | Seuil |
|-----------|-------|
| Nouveaux issues introduits | 0 |
| Security Hotspots revues | 100% |
| Coverage nouveau code | >= 80% |
| Duplication nouveau code | <= 3% |

Approche **"Clean as You Code"** : se concentrer sur la qualite du nouveau code, pas sur la remediation du legacy.

```
"SonarQube performs considerably well than all other tools in terms of
 defect detection across Java, C++, Python."
 — Yeboah & Popoola, 2024 (etude empirique)
```

| Alternative | Verdict |
|-------------|---------|
| CodeClimate | Pas liste par OWASP, pas d'evidence academique |
| Codacy | Agregateur (utilise PMD, Checkstyle) — SonarQube fait plus |

Sources : OWASP SAST tools (niv. 2), etude academique Yeboah 2024 (niv. 5), SonarQube docs (niv. 3)

---

## Limites de l'analyse statique

```
"Top-performing static analyzers fail to detect between 47% to 80% of
 vulnerabilities depending on evaluation scenarios."
 — Etudes empiriques (Springer, ScienceDirect, 2022-2024)
```

L'analyse statique est **necessaire mais pas suffisante**. SWEBOK la liste comme UNE des techniques primaires, aux cote des tests, reviews et debugging.

---

## Sources

- [niv. 1] SWEBOK v4 Sections 1.3, 1.5, 3.4.1, 3.6 — static analysis = primary technique, coding standards with tools
- [niv. 1] SWEBOK v4 Computing Foundations — 82% vulnerabilities from style clashes
- [niv. 2] OWASP SAST Tools — SonarQube liste pour Java et JS/TS
- [niv. 3] React docs — ESLint "essential" + Prettier recommended + eslint-config-prettier
- [niv. 3] Google Java Style Guide — reference google-java-format
- [niv. 3] Checkstyle docs — google_checks.xml built-in
- [niv. 3] SonarQube docs — quality gate "Sonar way" (80% cov, 3% dup, 0 issues)
- [niv. 3] Biome docs — 35x faster, 97% Prettier-compatible, 479 rules
- [niv. 4] State of Frontend 2024 — ESLint 89.3%, Prettier 87.5%
- [niv. 4] npm trends — ESLint 115M/sem, Biome 7M, oxlint 4.5M
- [niv. 5] Capers Jones (13 000+ projets) — static analysis 55-65% DRE, combined >97%
- [niv. 5] Yeboah & Popoola 2024 — SonarQube #1 defect detection
- [niv. 5] Empirical studies — static analysis misses 47-80% vulnerabilities alone
