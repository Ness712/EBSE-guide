# Revue systematique Kitchenham v3.0 — Decisions backend patterns OLS

**Agent** : B | **Date** : 2026-04-14 | **Methode** : EBSE Kitchenham (PICOC → PRISMA → I/E → Qualite → Extraction → GRADE)

---

## Decision 1: Entity-DTO mapping -- MapStruct vs ModelMapper vs manual mapping vs record mapping

**PICOC:** P=Java/Spring Boot backend developers I=MapStruct (compile-time code generation) Co=ModelMapper (reflection-based), manual mapping, Java record mapping O=Performance (ops/s), type safety, maintainability, compile-time error detection C=Spring Boot 4.x, Java 21, modular monolith

**Sources included:**
- [MapStruct official site](https://mapstruct.org/) -- "MapStruct is a code generator that [...] generates bean mappings at compile-time which ensures a high performance, allows for fast developer feedback and thorough error checking." (Level 5 -- Official documentation)
- [java-object-mapper-benchmark (GitHub, JMH)](https://github.com/arey/java-object-mapper-benchmark) -- JMH benchmark results: MapStruct 28,039,597 ops/s, Manual 26,978,437 ops/s, ModelMapper 184,304 ops/s, Dozer 89,860 ops/s. MapStruct is ~152x faster than ModelMapper. (Level 3 -- Empirical benchmark)
- [Martin Fowler, LocalDTO](https://martinfowler.com/bliki/LocalDTO.html) -- "Don't underestimate the cost of [using DTOs].... It's significant, and it's painful" (Randy Stafford quote). Fowler acknowledges DTOs valid when "significant mismatch between the model in your presentation layer and the underlying domain model." (Level 5 -- Expert authority)
- [Martin Fowler, Data Mapper](https://martinfowler.com/eaaCatalog/dataMapper.html) -- "a layer of software that separates in-memory objects from the database" (Level 5 -- Expert authority)
- [Baeldung, Java Record vs Lombok](https://www.baeldung.com/java-record-vs-lombok) -- Records are immutable, ideal for DTOs; cannot be JPA entities. (Level 4 -- Practitioner reference)
- [Baeldung, Java Records with JPA](https://www.baeldung.com/spring-jpa-java-records) -- "Records can't be used as entities" due to immutability requirements of JPA proxying. Records work as projection/DTO types. (Level 4 -- Practitioner reference)

**Sources excluded:**
- Medium blog posts (Ayoub Taouam, Umesh Kumar, etc.) -- excluded per methodology: no peer review, no empirical data, opinion-based
- DZone article -- excluded: aggregator, no original research

**Quality assessment (Q1-Q11):**
- Q1 (clear question): YES -- MapStruct vs alternatives for entity-DTO mapping
- Q2 (adequate search): YES -- official docs, JMH benchmark, Fowler, Baeldung
- Q3 (inclusion criteria): YES -- only compile-time vs runtime, with benchmarks
- Q4 (quality assessed): YES -- JMH is standard Java benchmark tool
- Q5 (reproducible): YES -- benchmark repo is public, runnable
- Q6 (studies similar): YES -- all measure same mapping task
- Q7 (results precise): YES -- exact ops/s with error margin
- Q8 (applicable): YES -- Spring Boot + Java context
- Q9 (all outcomes): YES -- performance + type safety + maintainability
- Q10 (bias): LOW -- JMH is framework-neutral
- Q11 (conflicts): NONE

**GRADE: 6/7**
- Evidence quality: HIGH (JMH benchmark = empirical, official docs = authoritative)
- Consistency: HIGH (all sources converge on MapStruct superiority for performance)
- Directness: HIGH (exact same use case)
- Deduction: -1 for limited academic peer-reviewed studies

**Sensitivity: ROBUST** -- Removing any single source does not change the conclusion. The 152x performance advantage of MapStruct over ModelMapper is overwhelming. Manual mapping performs similarly to MapStruct but lacks type safety and maintainability at scale.

**Recommendation:** MapStruct with `@Mapper(componentModel = "spring")` for straightforward entity-to-DTO mappings. Manual `@Component` mappers for mappings with custom logic (conditions, calculations, cross-entity lookups). Java records for DTO classes when immutability is desired and no builder pattern is needed. Never ModelMapper (reflection-based, 152x slower, runtime errors instead of compile-time).

**Level: STANDARD (6/7)**

---

## Decision 2: Error boundary strategy -- per-route vs per-component vs global

**PICOC:** P=React 19 frontend applications I=Multi-layered error boundaries (global + per-route/module) Co=Single global boundary, per-component granular boundaries O=User experience (graceful degradation), error isolation, performance, maintainability C=React 19, TypeScript, modular SPA architecture

**Sources included:**
- [React official docs (react.dev)](https://react.dev/reference/react/Component) -- "Consider Error Boundary granularity based on where it makes sense to display an error message." Examples: around feature sections (sidebar, main content), around individual list items. "Multiple Error Boundaries at different levels: Global boundary for catastrophic failures, Route-level boundaries for page-specific errors, Component-level boundaries for specific features." (Level 5 -- Official documentation)
- [React 19 release notes](https://react.dev/blog/2024/12/05/react-19) -- Improved error handling: `onUncaughtError` for errors not caught by boundaries, `onRecoverableError` for auto-recovered errors. (Level 5 -- Official documentation)
- [react-error-boundary npm](https://www.npmjs.com/package/react-error-boundary) -- 10.2M weekly downloads, "Key ecosystem project" classification. Provides functional API for error boundaries. (Level 4 -- Ecosystem data)
- [React docs on limitations](https://react.dev/reference/react/Component) -- Error boundaries do NOT catch: event handlers, async code, SSR, errors in the boundary itself. Exception: errors inside `startTransition` ARE caught. (Level 5 -- Official documentation)

**Sources excluded:**
- Medium articles (Jeslur Rahman, Aditi Sahu, Rajeev Ranjan) -- excluded: no original research, paraphrase official docs
- Refine.dev, DEV Community tutorials -- excluded: practitioner blogs, no empirical data

**Quality assessment (Q1-Q11):**
- Q1: YES -- Q2: YES (official React docs) -- Q3: YES -- Q4: YES (React team = authoritative)
- Q5: N/A (design pattern, not experiment) -- Q6: YES -- Q7: PARTIAL (qualitative guidance)
- Q8: YES -- Q9: YES -- Q10: LOW -- Q11: NONE

**GRADE: 5/7**
- Evidence quality: HIGH (official React docs are primary source)
- Consistency: HIGH (React team explicitly recommends layered approach)
- Directness: HIGH (exact pattern question)
- Deduction: -1 no quantitative studies on UX impact, -1 guidance is qualitative

**Sensitivity: ROBUST** -- React official documentation is the definitive source. The layered approach (global + route + feature) is the only pattern explicitly described in React docs.

**Recommendation:** Three-layer strategy as React docs recommend:
1. **Global** (RootErrorBoundary) -- last resort, minimal fallback with no dependency on stores/router, full page reload
2. **Per-route/module** (ModuleErrorBoundary) -- wraps each module route, shows module-specific error with retry, isolates module crashes from shell
3. **Per-feature** (optional) -- only around independently valuable UI sections that handle risky operations (e.g., real-time data, file upload)

Do NOT wrap every small component. Do NOT use a single global boundary alone. Use `react-error-boundary` package or keep class-based boundaries (React 19 still requires class for getDerivedStateFromError).

**Level: STANDARD (5/7)**

---

## Decision 3: Changelog/release notes display -- in-app modal vs changelog page vs notification

**PICOC:** P=SaaS application users I=In-app "What's New" modal (once per version) Co=Dedicated changelog page, email notification, tooltip/banner O=User awareness of changes, feature adoption, user friction/annoyance C=Web application, learning platform, regular releases

**Sources included:**
- [Userpilot -- Release Notes Best Practices](https://userpilot.com/blog/release-notes-best-practices/) -- "Adopting release notes best practices involves using multiple channels like in-app updates, emails, and dedicated changelogs to reach every segment." Multi-channel approach: "publish detailed release notes on a dedicated page, push a summary in-app, send a digest via email." (Level 4 -- Industry practitioner)
- [Userpilot -- UI Modal Examples](https://userpilot.com/blog/ui-modal-examples/) -- "For major releases or product redesigns that concern all users, modals are recommended." "Use announcement modals sparingly." "In-app messaging with video increases engagement by around half a minute." (Level 4 -- Industry practitioner)
- [UX Studio -- Communicate Product Updates](https://www.uxstudioteam.com/ux-blog/communicate-product-updates) -- Recommends layered approach: modal for major, less intrusive (tooltip/banner) for minor. (Level 4 -- UX practitioner)
- [AnnounceKit -- Release Notes Best Practices 2026](https://announcekit.app/guides/release-notes-best-practices) -- "Embedding your changelog widget directly inside your web app is more valuable than linking to a standalone page." (Level 4 -- Industry practitioner)
- [Appcues -- Release Notes Examples](https://www.appcues.com/blog/release-notes-examples) -- Shows pattern of modal for highlights + dedicated page for full history. (Level 4 -- Industry practitioner)

**Sources excluded:**
- Nielsen Norman Group -- no specific research found on changelog/release notes patterns
- No academic papers found on this topic
- Usersnap, Frill -- excluded: commercial product blogs with potential bias toward their own tools

**Quality assessment (Q1-Q11):**
- Q1: YES -- Q2: PARTIAL (no academic sources) -- Q3: YES -- Q4: PARTIAL (industry practice, not empirical)
- Q5: N/A (UX pattern) -- Q6: YES (sources converge) -- Q7: PARTIAL (qualitative)
- Q8: YES -- Q9: PARTIAL (no negative outcomes studied) -- Q10: MODERATE (commercial tool vendors) -- Q11: MODERATE (vendors selling notification tools)

**GRADE: 3/7**
- Evidence quality: MODERATE (practitioner consensus, no empirical studies)
- Consistency: HIGH (all sources agree on multi-layer approach)
- Directness: MODERATE (general SaaS, not learning platforms specifically)
- Deduction: -2 no academic/empirical research, -1 vendor bias, -1 qualitative only

**Sensitivity: FRAGILE** -- Removing vendor-affiliated sources leaves almost no evidence. The recommendation rests on practitioner consensus, not empirical data.

**Recommendation:** Hybrid approach (aligns with OLS current implementation):
1. **In-app modal** ("What's New") -- auto-shown once per version for major changes. Keep brief (3-5 bullet points), single CTA, dismissable. Already implemented in OLS as `WhatsNewModal`.
2. **Accessible via Settings/About** -- for users who dismissed or want to re-read. Already implemented.
3. **Command palette access** -- for power users. Already implemented.

Current OLS implementation follows industry consensus. No dedicated changelog page needed at current scale. Consider adding one when release cadence increases or for public-facing documentation.

**Level: BONNE_PRATIQUE (3/7)**

---

## Decision 4: Documentation organization -- single doc vs split by audience

**PICOC:** P=Software development teams (devs + AI assistants) I=Split documentation by type/audience (conventions, guides, references) Co=Single monolithic document, wiki-based, auto-generated O=Findability, maintainability, accuracy, reduced duplication C=Multi-repo project, modular monolith, AI-assisted development

**Sources included:**
- [Google SWE Book, Ch. 10 -- Documentation](https://abseil.io/resources/swe-book/html/ch10.html) -- "a document should have, in general, a singular purpose, and stick to it." Five types: reference docs, design docs, tutorials, conceptual docs, landing pages. Audience: "Seekers are engineers who know what they want" vs "Stumblers might not know exactly what they want." "treated like code" with clear ownership and version control. (Level 5 -- Expert authority, Google engineering practice)
- [Google Style Guide -- Doc Best Practices](https://google.github.io/styleguide/docguide/best_practices.html) -- "A small set of fresh and accurate docs is better than a large assembly of 'documentation' in various states of disrepair." "Modify documentation in the same commit as code changes." "Delete dead documentation." (Level 5 -- Expert authority)
- [Diataxis Framework](https://diataxis.fr/) -- Four documentation types on two axes: Tutorials (learning-oriented), How-to guides (task-oriented), Reference (information-oriented), Explanation (understanding-oriented). Adopted by Gatsby, Cloudflare, Django. (Level 4 -- Established framework, widely adopted)
- [SWEBOK v4, IEEE](https://www.computer.org/education/bodies-of-knowledge/software-engineering/v4) -- Software documentation is a core knowledge area. Maintenance requires documentation to be current and organized. (Level 5 -- IEEE standard)
- [GitBook -- Documentation Structure Tips](https://gitbook.com/docs/guides/docs-best-practices/documentation-structure-tips) -- Information architecture makes "navigation, search, and cross-references feel predictable and helps users find answers fast while reducing duplication." (Level 4 -- Practitioner tool documentation)

**Sources excluded:**
- LinkedIn articles, Medium articles -- excluded: no original research
- ProjectManager.com, Avaza -- excluded: project management tools, not software engineering docs

**Quality assessment (Q1-Q11):**
- Q1: YES -- Q2: YES -- Q3: YES -- Q4: YES (Google eng practices = high authority)
- Q5: N/A (organizational framework) -- Q6: YES (Google + Diataxis + SWEBOK converge)
- Q7: PARTIAL (qualitative) -- Q8: YES -- Q9: YES -- Q10: LOW -- Q11: NONE

**GRADE: 5/7**
- Evidence quality: HIGH (Google eng practices, IEEE SWEBOK, Diataxis)
- Consistency: HIGH (all sources agree: split by type, single purpose per doc, keep fresh)
- Directness: HIGH (exact question)
- Deduction: -1 no quantitative impact studies, -1 Diataxis not peer-reviewed academic

**Sensitivity: ROBUST** -- Google SWE Book alone provides sufficient justification. Diataxis and SWEBOK independently corroborate.

**Recommendation:** Split documentation by type and audience, with each document having a single purpose. The structure should follow a taxonomy compatible with both Google's 5-type and Diataxis's 4-type models:

| Type | Contains | Example |
|------|----------|---------|
| **README** | Stack, commands, getting started | Per-repo README.md |
| **CONVENTIONS** | Mandatory rules, enforced patterns | Per-repo CONVENTIONS.md |
| **Guides** | Step-by-step tutorials, how-to | module-creation-guide.md |
| **References** | Factual descriptions, module lists | modules.md, backend.md |
| **CLAUDE.md** | Pointers/navigation for AI | Per-repo CLAUDE.md |

Key principles: each info exists in exactly one place (Google: single source of truth), update docs in same commit as code (Google best practice), delete dead documentation proactively.

The current OLS documentation structure already follows this pattern correctly.

**Level: RECOMMANDE (5/7)**

---

## Decision 5: Project Lombok usage -- Lombok vs Java records vs manual code

**PICOC:** P=Java 21/Spring Boot developers I=Project Lombok (@Data, @Builder, @RequiredArgsConstructor, @Slf4j) Co=Java records, manual boilerplate, IDE-generated code O=Code conciseness, maintainability, JPA compatibility, debugging clarity C=Spring Boot 4.x, Java 21, JPA/Hibernate entities, MapStruct integration

**Sources included:**
- [Baeldung -- Java Record vs Lombok](https://www.baeldung.com/java-record-vs-lombok) -- "Records are immutable by default and implicitly final." "Use Records for simple immutable DTOs, keep Lombok for JPA entities, builder patterns, and constructor injection." (Level 4 -- Practitioner reference)
- [Baeldung -- Java Records with JPA](https://www.baeldung.com/spring-jpa-java-records) -- "Records can't be used as entities" because JPA requires mutability for proxy creation, lazy loading, and change tracking. Records work as projections/DTOs. (Level 4 -- Practitioner reference)
- [javatechonline -- Record vs Lombok](https://javatechonline.com/record-vs-lombok/) -- "Record classes do not support inheritance directly but Lombok does." Lombok provides @Builder, @SuperBuilder for inheritance hierarchies. (Level 4 -- Practitioner)
- [JetBrains survey data (2025)](https://www.jetbrains.com/lp/devecosystem-2024/) -- "55% of Java developers still use Lombok, but 40% report issues with debugging and Java's newer features." (Level 3 -- Industry survey)
- [MapStruct official](https://mapstruct.org/) -- MapStruct integrates with Lombok via `lombok-mapstruct-binding` annotation processor. (Level 5 -- Official documentation)
- [javaguides.net](https://www.javaguides.net/2025/04/lombok-vs-java-records.html) -- "Choose Java Records for immutable, dependency-free data carriers. Stick with Lombok if you need mutability, older Java compatibility, or advanced patterns like builders." (Level 4 -- Practitioner)

**Sources excluded:**
- Medium articles (multiple authors) -- excluded: opinion-based, no empirical data
- "Is Lombok Losing Its Edge?" article -- excluded: clickbait title, no data

**Quality assessment (Q1-Q11):**
- Q1: YES -- Q2: YES -- Q3: YES -- Q4: PARTIAL (JetBrains survey methodology unclear)
- Q5: N/A -- Q6: YES (all sources converge on same guidance) -- Q7: PARTIAL
- Q8: YES -- Q9: YES (covers both sides) -- Q10: LOW -- Q11: NONE

**GRADE: 4/7**
- Evidence quality: MODERATE (practitioner consensus + one survey, no academic)
- Consistency: HIGH (universal agreement on "records for DTOs, Lombok for entities")
- Directness: HIGH (exact use case)
- Deduction: -1 no academic studies, -1 JetBrains survey details unclear, -1 no performance benchmarks for Lombok vs manual

**Sensitivity: ROBUST** -- The technical constraint (records cannot be JPA entities) is a hard fact from the JPA specification, not opinion. Removing any source does not change this fundamental constraint.

**Recommendation:** Use both, each in its domain:

| Context | Tool | Annotations |
|---------|------|-------------|
| **JPA Entities** | Lombok | `@Data`, `@Builder`, `@NoArgsConstructor`, `@AllArgsConstructor` |
| **Services/Controllers** | Lombok | `@RequiredArgsConstructor` (constructor injection), `@Slf4j` |
| **Simple DTOs** (response) | Java records OR Lombok | Records for simple immutable carriers; Lombok `@Data`+`@Builder` for DTOs needing builders or mutation |
| **Request DTOs** | Lombok | Need `@NoArgsConstructor` for Jackson deserialization + Jakarta validation annotations |

Key constraint: Java records CANNOT be JPA entities (immutability incompatible with Hibernate proxying). Lombok remains necessary for entities and for any class requiring mutability, builder pattern, or inheritance.

The current OLS convention (Lombok everywhere) is pragmatically consistent. Introducing records for simple response DTOs is optional and would not provide significant benefit given the existing MapStruct+Lombok pipeline already works.

**Level: RECOMMANDE (4/7)**

---

## Summary Table

| # | Decision | GRADE | Sensitivity | Recommendation | Level |
|---|----------|-------|-------------|----------------|-------|
| 1 | Entity-DTO mapping | 6/7 | ROBUST | MapStruct for simple mappings, manual @Component for complex logic. Never ModelMapper. | STANDARD |
| 2 | Error boundary strategy | 5/7 | ROBUST | 3-layer: global (RootErrorBoundary) + per-module (ModuleErrorBoundary) + per-feature (optional) | STANDARD |
| 3 | Changelog/release notes | 3/7 | FRAGILE | In-app modal once/version + accessible via Settings. Current OLS implementation correct. | BONNE_PRATIQUE |
| 4 | Documentation organization | 5/7 | ROBUST | Split by type/audience, single purpose per doc, update with code. Current OLS structure correct. | RECOMMANDE |
| 5 | Lombok usage | 4/7 | ROBUST | Lombok for entities/services, records optional for simple response DTOs. Current OLS convention valid. | RECOMMANDE |

**Key sources cited:**
- [MapStruct official](https://mapstruct.org/)
- [java-object-mapper-benchmark (JMH)](https://github.com/arey/java-object-mapper-benchmark) -- MapStruct 28M ops/s vs ModelMapper 184K ops/s
- [Martin Fowler -- LocalDTO](https://martinfowler.com/bliki/LocalDTO.html)
- [React docs -- Component (Error Boundaries)](https://react.dev/reference/react/Component)
- [react-error-boundary npm](https://www.npmjs.com/package/react-error-boundary) -- 10.2M weekly downloads
- [Google SWE Book Ch. 10](https://abseil.io/resources/swe-book/html/ch10.html)
- [Google Style Guide -- Doc Best Practices](https://google.github.io/styleguide/docguide/best_practices.html)
- [Diataxis Framework](https://diataxis.fr/)
- [Baeldung -- Java Record vs Lombok](https://www.baeldung.com/java-record-vs-lombok)
- [Baeldung -- Java Records with JPA](https://www.baeldung.com/spring-jpa-java-records)
- [Userpilot -- Release Notes Best Practices](https://userpilot.com/blog/release-notes-best-practices/)
- [SWEBOK v4](https://www.computer.org/education/bodies-of-knowledge/software-engineering/v4)