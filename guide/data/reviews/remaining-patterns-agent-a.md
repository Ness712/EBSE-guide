# Revue systematique Kitchenham v3.0 — Decisions patterns restants OLS

**Agent** : A | **Date** : 2026-04-14 | **Methode** : EBSE Kitchenham (PICOC → PRISMA → I/E → Qualite → Extraction → GRADE)

---

## Decision 1: Soft delete pattern

**PICOC:** P=Application web avec entites owned par utilisateur, donnees relationnelles (PostgreSQL) | I=Soft delete (champ `deletedAt`) | Co=Hard delete, event sourcing | O=Integrite referentielle, conformite RGPD, simplicite de requetes, restauration possible | C=Monolithe modulaire Spring Boot, ~30 modules CRUD

**Sources included:**
- [L4 — Official doc] Spring Data JPA documentation: auditing et entity lifecycle callbacks (`@PreRemove`, filtrage via `@Where`)
- [L4 — Official doc] JPA 3.1 specification (Jakarta Persistence): entity lifecycle callbacks, `@PreRemove`, `@PostRemove`
- [L4 — Official doc] Hibernate ORM 7 documentation: `@SoftDelete` annotation (Hibernate 7.0+, supported since 6.4), `@Filter` pour le filtrage automatique
- [L5 — SWEBOK] SWEBOK v4 ch.4 (Software Design): separation of concerns, information hiding — le pattern soft delete releve du design de persistance
- [L6 — Practitioner consensus] Martin Fowler, "Temporal Patterns" — recommande le soft delete pour les entites auditables; l'event sourcing pour les domaines a haute tracabilite (finance, compliance)
- [L6 — Practitioner consensus] Vlad Mihalcea (Hibernate lead), "The best way to soft delete with Hibernate" — recommande `deletedAt` timestamp (pas boolean), filtre automatique via `@Where` ou `@SoftDelete`
- [L7 — OLS codebase] `SoftDeletable` interface existante avec `deletedAt`/`isDeleted()`, implementee sur CalendarEvent, StoredFile, et toutes les entites owned via `AbstractOwnedCrudService.delete()`

**Sources excluded:**
- Event sourcing (Axon Framework, EventStore): exclu car surdimensionne pour un CRUD owned monolithique sans besoin de replay d'evenements (complexite x10, aucun benefice pour OLS)
- Blog posts/tutorials: exclu par methodologie

**Quality assessment:**
- Q1 (clear question): Oui — soft delete vs hard delete pour entites owned
- Q2 (adequate search): Oui — JPA spec, Hibernate docs, SWEBOK, practitioner references
- Q3 (inclusion criteria): Oui — pattern de persistance pour CRUD applicatif
- Q4 (quality assessed): Oui — sources officielles convergentes
- Q5 (sufficient detail): Oui — implementation specifique documentee
- Q6 (consistency): Forte — toutes les sources recommandent `deletedAt` timestamp plutot que boolean
- Q7 (results applicable): Oui — Spring Boot + JPA + PostgreSQL
- Q8-Q11: N/A (pas d'etude quantitative)

**GRADE: 5/7**

**Sensitivity:** ROBUST — Le pattern `deletedAt` timestamp est un consensus fort. L'alternative `@SoftDelete` de Hibernate 7 pourrait simplifier le code mais le pattern actuel d'OLS (interface `SoftDeletable`) est equivalent et plus explicite.

**Recommendation:** Utiliser le soft delete avec champ `deletedAt` (Instant, nullable) pour toutes les entites owned qui ont une valeur utilisateur (notes, contacts, fichiers, events calendrier). Utiliser le hard delete pour les entites techniques sans valeur de restauration (archive entries, tokens, sessions, labels). Ne pas utiliser l'event sourcing — aucun cas d'usage dans OLS ne le justifie. OLS applique deja correctement ce pattern via `SoftDeletable` + `AbstractOwnedCrudService`.

**Regle:** Soft delete = entite que l'utilisateur peut vouloir restaurer. Hard delete = entite technique ou ephemere.

**Level: STANDARD**

---

## Decision 2: Scheduled task management

**PICOC:** P=Backend Spring Boot monolithique avec taches periodiques (cleanup tokens, cleanup historique, alertes peremption) | I=Spring `@Scheduled` + registre de monitoring | Co=Quartz Scheduler, Spring Batch, cron systeme externe, bibliotheques tierces | O=Simplicite, observabilite, fiabilite, pas de SPOF | C=Spring Boot 4.0.3, Java 21 (virtual threads), monolithe single-instance

**Sources included:**
- [L4 — Official doc] Spring Boot 4.0.3 reference: Task Execution and Scheduling — `@Scheduled`, `@EnableScheduling`, `ThreadPoolTaskScheduler`, virtual threads support avec `SimpleAsyncTaskScheduler`
- [L4 — Official doc] Spring Framework 7 reference: `@Scheduled(cron=...)`, `@Scheduled(fixedRate=...)`, `@Scheduled(fixedDelay=...)`, `@Async`
- [L5 — SWEBOK] SWEBOK v4 ch.11 (Software Maintenance): maintenance tasks, batch processing — recommande des mecanismes simples et observables
- [L6 — Practitioner consensus] Josh Long (Spring Developer Advocate): pour un monolithe single-instance, `@Scheduled` est le bon choix; Quartz uniquement pour du clustering ou de la persistance de jobs
- [L7 — OLS codebase] `SchedulerRegistry` existant dans `config/` — pattern registre de monitoring avec `register()`, `recordExecution()`, endpoint admin `GET /api/admin/scheduler`. Trois schedulers existants: `HistoryCleanupScheduler`, `TokenCleanupScheduler`, `SessionCleanupScheduler`

**Sources excluded:**
- Quartz Scheduler: exclu car OLS est single-instance, pas besoin de persistence de jobs ni de clustering. Quartz ajoute une complexite significative (tables BDD, configuration) sans benefice
- Spring Batch: exclu car les taches OLS sont des cleanups simples, pas du batch processing massif
- Cron systeme (crontab): exclu car non portable, non observable, decouple du contexte Spring

**Quality assessment:**
- Q1-Q4: Clairs et adequats
- Q5: Implementation documentee avec exemples
- Q6: Forte convergence — `@Scheduled` est le standard pour Spring single-instance
- Q7: Directement applicable

**GRADE: 6/7**

**Sensitivity:** ROBUST — Le seul scenario qui changerait la recommandation serait un passage a du multi-instance (clustering), qui necessiterait ShedLock ou Quartz. Pas prevu pour OLS.

**Recommendation:** Continuer avec `@Scheduled` de Spring + le `SchedulerRegistry` existant pour le monitoring. Chaque scheduler doit s'enregistrer dans le registre au `@PostConstruct` et appeler `recordExecution()` a chaque execution. Utiliser `fixedDelay` pour les taches de cleanup (eviter l'accumulation), `cron` pour les taches a horaire fixe. Configurer le pool size a 2+ si plus de 3 taches concurrentes (`spring.task.scheduling.pool.size`). Avec Java 21, considerer `spring.threads.virtual.enabled=true` pour beneficier du `SimpleAsyncTaskScheduler`.

**Level: STANDARD**

---

## Decision 3: JPA EntityListener / cross-cutting concerns on entities

**PICOC:** P=Entites JPA avec preoccupations transversales (audit timestamps, sanitization HTML, validation) | I=JPA EntityListener (`@EntityListeners`) | Co=Spring AOP (`@Aspect`), traitement manuel dans les services | O=Separation des responsabilites, couverture garantie, simplicite, debuggabilite | C=Spring Boot 4.0.3, Hibernate 7, AuditableEntity comme MappedSuperclass

**Sources included:**
- [L4 — Official doc] JPA 3.1 specification: Entity Listeners, callback methods (`@PrePersist`, `@PreUpdate`, `@PostPersist`, etc.), `@EntityListeners` annotation
- [L4 — Official doc] Spring Data JPA documentation: `AuditingEntityListener` — implementation officielle de l'audit via EntityListener
- [L4 — Official doc] Hibernate ORM 7 documentation: entity lifecycle events, interceptors
- [L5 — SWEBOK] SWEBOK v4 ch.4: Cross-cutting concerns, Aspect-Oriented Programming — les preoccupations transversales doivent etre separees du code metier
- [L6 — Practitioner consensus] Spring team (official stance): utiliser `AuditingEntityListener` pour l'audit, EntityListeners custom pour les preoccupations liees au lifecycle de l'entite, AOP pour les preoccupations au niveau service/controller
- [L7 — OLS codebase] `AuditableEntity` avec `@EntityListeners({AuditingEntityListener.class, HtmlSanitizationListener.class})` — deux listeners: audit officiel Spring + sanitization custom

**Sources excluded:**
- Spring AOP pour la sanitization: exclu car AOP opere au niveau des methodes de service, pas du lifecycle JPA — un `entity.setDescription(...)` dans un mapper ne serait pas intercepte
- Traitement manuel dans les services: exclu car violation du DRY, risque d'oubli sur 30+ modules

**Quality assessment:**
- Q1-Q7: Tous satisfaits. Le pattern est directement issu de la specification JPA et de l'implementation officielle Spring.

**GRADE: 6/7**

**Sensitivity:** ROBUST — JPA EntityListener est le mecanisme standard de la specification pour le lifecycle des entites. Le choix AOP vs EntityListener depend du niveau d'interception: entite = EntityListener, service/controller = AOP.

**Recommendation:** Utiliser JPA `@EntityListeners` pour les preoccupations liees au lifecycle des entites (audit, sanitization, validation pre-persist). Utiliser Spring AOP (`@Aspect`) pour les preoccupations au niveau service (logging, rate limiting, securite). Ne jamais faire de traitement transversal manuellement dans les services — c'est le chemin vers l'oubli. OLS applique deja correctement ce pattern: `AuditingEntityListener` (officiel Spring) pour les timestamps + `HtmlSanitizationListener` (custom) pour la sanitization, les deux enregistres sur `AuditableEntity`.

**Regle de partage:**
| Niveau | Mecanisme |
|--------|-----------|
| Lifecycle entite (persist, update) | JPA EntityListener |
| Methode service/controller | Spring AOP |
| Requete HTTP (auth, CORS, rate limit) | Servlet Filter / Spring Security |

**Level: STANDARD**

---

## Decision 4: DTO projection / field selection

**PICOC:** P=API REST avec entites JPA, DTOs de reponse exposes au frontend | I=DTOs manuels (record/class) avec champs selectionnes | Co=Exposition de l'entite complete, Spring Data projections (interface-based), GraphQL field selection | O=Securite (pas de fuite de donnees internes), performance (pas de champs inutiles), maintenabilite | C=Spring Boot 4.0.3, MapStruct, API REST (pas GraphQL), ~30 modules

**Sources included:**
- [L4 — Official doc] Spring Data JPA documentation: Projections — interface-based projections (open/closed), class-based DTO projections (record), `@Query` avec constructor expressions
- [L4 — Official doc] Spring Boot reference: Jackson serialization, `@JsonIgnore`, `@JsonView`
- [L5 — SWEBOK] SWEBOK v4 ch.4 (Software Design): Information hiding, encapsulation — ne jamais exposer la structure interne d'une entite
- [L6 — Practitioner consensus] Vlad Mihalcea: "The best way to map a projection query to a DTO" — DTO class/record > interface projection (performance), jamais d'entite directe en API
- [L6 — Practitioner consensus] Thorben Janssen (Hibernate expert): DTO projections sont 5-15% plus rapides que les entites pour les lectures (pas de dirty checking, pas de cache L1)
- [L7 — OLS codebase] Pattern existant: `CreateXxxRequest` (entree), `XxxDTO` (sortie), `XxxMapper` (MapStruct ou `@Component` custom). Chaque module declare explicitement ses DTOs.

**Sources excluded:**
- GraphQL: exclu car OLS est REST, l'ajout de GraphQL pour du field selection serait surdimensionne
- `@JsonView`: exclu car complexe a maintenir et source de bugs subtils (un champ expose par erreur dans une vue)
- Interface-based projections Spring Data: exclu car moins performantes que les class-based (proxy generation), et OLS utilise deja MapStruct

**Quality assessment:**
- Q1-Q7: Tous satisfaits. Convergence forte des sources.

**GRADE: 5/7**

**Sensitivity:** ROBUST — Le consensus est unanime: DTO explicite > entite directe. Le seul point de variation est MapStruct vs projection Spring Data, mais les deux sont valides.

**Recommendation:** Toujours exposer un DTO explicite, jamais l'entite JPA directement. Utiliser des DTOs de sortie (records Java ou classes avec `@Data`) qui ne contiennent que les champs necessaires au frontend. Utiliser MapStruct (`@Mapper`) pour les mappings simples, `@Component` mapper pour les mappings avec logique. Ne pas implementer de field selection dynamique (GraphQL-like) — la complexite n'est pas justifiee pour OLS. Si un endpoint a besoin de moins de champs, creer un DTO de resume (`XxxSummaryDTO`). OLS applique deja correctement ce pattern.

**Level: STANDARD**

---

## Decision 5: API manual testing

**PICOC:** P=Developpeur testant manuellement des endpoints REST pendant le developpement | I=Fichiers `.http` (IntelliJ HTTP Client) | Co=Postman, curl, Swagger UI, Insomnia, Thunder Client | O=Rapidite d'iteration, versionnabilite (git), partage en equipe, integration IDE | C=Spring Boot 4.0.3, OpenAPI/Swagger, equipe petite (2 devs), IntelliJ IDEA

**Sources included:**
- [L4 — Official doc] JetBrains IntelliJ IDEA documentation: HTTP Client — fichiers `.http`/`.rest`, variables d'environnement (`http-client.env.json`), scripts de test en JavaScript, integration Git native
- [L4 — Official doc] Postman documentation: collections, environments, tests, collaboration — outil standalone, pas versionne dans git par defaut
- [L4 — Official doc] Spring Boot reference: Swagger UI via springdoc-openapi — `http://localhost:8080/swagger-ui.html`, generation automatique depuis les annotations
- [L5 — SWEBOK] SWEBOK v4 ch.9 (Software Testing): test d'API = test d'integration, besoin de reproductibilite et documentation
- [L6 — Practitioner consensus] ThoughtWorks Technology Radar (2023): `.http` files recommande ("Adopt") pour les projets versionnés — versionnable, leger, pas de vendor lock-in
- [L7 — OLS codebase] Convention existante: `http-requests/{module}/{entity}.http`, obligation documentee dans `CONVENTIONS.md`

**Sources excluded:**
- curl: exclu comme outil principal car non ergonomique pour des tests complexes (auth JWT, bodies JSON) — acceptable en complement
- Insomnia/Thunder Client: exclu car equivalent a Postman sans avantage distinctif
- Postman: exclu comme outil principal car non versionne nativement (Postman Cloud payant), vendor lock-in, necessiste un outil separe

**Quality assessment:**
- Q1-Q6: Satisfaits. ThoughtWorks Technology Radar est une source reconnue.
- Q7: Directement applicable (IntelliJ + Git)

**GRADE: 4/7**

**Sensitivity:** FRAGILE — Le choix depend de l'IDE. Si l'equipe passait a VS Code, les fichiers `.http` resteraient lisibles mais sans execution native (extension REST Client necessaire). Swagger UI reste le complement universel quel que soit l'IDE.

**Recommendation:** Fichiers `.http` comme outil principal de test manuel, organises dans `http-requests/{module}/{entity}.http`, versionnes dans git. Swagger UI (`/swagger-ui.html`) comme complement pour l'exploration et la documentation visuelle. Chaque module doit avoir son fichier `.http` couvrant tous les endpoints CRUD + cas d'erreur. OLS applique deja cette convention.

**Level: RECOMMANDE**

---

## Decision 6: Inline auto-save UX pattern

**PICOC:** P=Application web CRUD avec edition d'entites (detail panels, formulaires) | I=Auto-save on blur (Notion-like) pour les detail panels, formulaire avec draft pour la creation | Co=Bouton save explicite, auto-save periodique (timer), pas de save (tout en memoire) | O=Experience utilisateur fluide, pas de perte de donnees, feedback visuel, performance reseau | C=React 19, React Hook Form, Zustand, detail panels inline-editable, ~30 modules

**Sources included:**
- [L4 — Official doc] React Hook Form documentation: `mode: 'onBlur'`, `trigger()` pour validation par champ, `getValues()` pour lecture
- [L4 — Official doc] Notion UX documentation (help.notion.so): inline editing, auto-save immediat, pas de bouton save — standard de l'industrie pour les apps de productivite
- [L5 — SWEBOK] SWEBOK v4 ch.12 (Software Quality): usability, user experience — principe de moindre surprise, feedback immediat
- [L6 — Practitioner consensus] Nielsen Norman Group (nngroup.com): "Auto-Save" (2016) — recommande l'auto-save avec indicateur visuel ("Saving...", "Saved") pour les apps web modernes. Attention: ne convient pas pour les formulaires a forte consequence (paiement, suppression irreversible)
- [L6 — Practitioner consensus] Figma, Linear, Notion, Google Docs: convergence industrielle sur l'auto-save pour l'edition de contenu
- [L7 — OLS codebase] `useInlineAutoSave` hook existant — save on blur pour les text fields, save immediat pour selects/toggles, debounce 300ms, indicateur visuel (`SaveIndicator`), revert automatique en cas d'erreur. `useDraftForm` pour la creation avec persistence workspace.

**Sources excluded:**
- Bouton save explicite: exclu pour les detail panels car friction inutile pour des modifications champ par champ
- Auto-save periodique (timer): exclu car envoie des requetes inutiles si rien n'a change, et peut sauvegarder un etat intermediaire invalide

**Quality assessment:**
- Q1-Q7: Satisfaits. Convergence forte entre les sources UX et les implementations industrielles.

**GRADE: 5/7**

**Sensitivity:** ROBUST — Le pattern est devenu un standard de l'industrie pour les apps de productivite. Le seul cas ou il ne s'applique pas: formulaires a forte consequence (paiement, suppression de compte).

**Recommendation:** Deux patterns complementaires selon le contexte:

| Contexte | Pattern | Implementation OLS |
|----------|---------|-------------------|
| Edition d'une entite existante (detail panel) | Auto-save on blur, champ par champ | `useInlineAutoSave` + `InlineText`/`InlineSelect` |
| Creation d'une nouvelle entite (editor panel) | Formulaire avec draft + bouton submit | `useDraftForm` + formulaire classique |
| Actions a forte consequence | Confirmation modale explicite | Dialog de confirmation |

OLS applique deja correctement ces deux patterns. L'indicateur de save (`SaveIndicator`: idle/saving/saved/error) est indispensable pour le feedback utilisateur.

**Level: STANDARD**

---

## Decision 7: Drill-down navigation

**PICOC:** P=Application web avec collections imbriquees (parent/enfants: Supplier->SupplierContact, Project->Milestone->Experiment) | I=Route pattern `parent/:id/children` + breadcrumbs dynamiques + factory `createDrilldownPage` | Co=Modale pour les enfants, accordion/expansion inline, onglets dans le detail parent, flat list avec filtre | O=Navigation intuitive, contexte parent visible, URL partageable, scalabilite (N niveaux) | C=React Router, breadcrumbs dynamiques, collection layout generique

**Sources included:**
- [L4 — Official doc] React Router documentation: nested routes, `useParams()`, `<Outlet>` — support natif du pattern parent/:id/children
- [L5 — SWEBOK] SWEBOK v4 ch.12: usability, navigation — principe de navigation hierarchique, breadcrumbs comme aide a l'orientation
- [L6 — Practitioner consensus] Nielsen Norman Group: "Breadcrumbs: 11 Design Guidelines for Desktop and Mobile" (2023) — breadcrumbs indispensables pour la navigation hierarchique, doivent refleter la hierarchie du contenu (pas l'historique du navigateur)
- [L6 — Practitioner consensus] Material Design (Google): navigation patterns — master-detail, drill-down = standard pour les collections imbriquees
- [L6 — Practitioner consensus] Apple HIG: hierarchical navigation — "push" vers le detail, breadcrumb/back pour remonter
- [L7 — OLS codebase] `createDrilldownPage` factory existante — extrait le `parentId` de la route, charge le parent pour le breadcrumb, affiche les enfants dans un `CollectionLayout`. `useBreadcrumbStore` pour les labels dynamiques.

**Sources excluded:**
- Modale pour les enfants: exclu car ne scale pas (modales imbriquees = UX cauchemar), pas d'URL partageable
- Accordion inline: exclu car performance degradee avec beaucoup d'enfants, pas de pagination possible
- Flat list avec filtre parent: exclu car perte du contexte hierarchique

**Quality assessment:**
- Q1-Q7: Satisfaits. Pattern standard du web.

**GRADE: 5/7**

**Sensitivity:** ROBUST — Le pattern route + breadcrumbs est le standard universel du web pour la navigation hierarchique. Aucune alternative credible pour les collections imbriquees.

**Recommendation:** Route pattern `parent/:id/children` avec:
1. **Route explicite** dans le router (`/lab/suppliers/:id/contacts`)
2. **Breadcrumbs dynamiques** avec le nom du parent (via `useBreadcrumbStore`)
3. **Factory `createDrilldownPage`** pour generer les pages drill-down de facon standardisee
4. **Back navigation** via breadcrumb (pas de bouton "retour" custom)

OLS applique deja correctement ce pattern. Pour les hierarchies a plus de 2 niveaux (ex: emplacements avec self-reference), le breadcrumb doit afficher le chemin complet (`fullPath`).

**Level: STANDARD**

---

## Decision 8: Form spell checking

**PICOC:** P=Formulaires web avec champs texte (notes, descriptions, commentaires) | I=Spellcheck natif du navigateur (`spellcheck` HTML attribute) + service LanguageTool cote backend | Co=Service de correction externe (Grammarly API, Azure Text Analytics), desactiver le spellcheck, bibliotheque JS cote client | O=Qualite du contenu utilisateur, pas de friction, performance, cout | C=React, formulaires inline, public francophone (sciences)

**Sources included:**
- [L4 — Official doc] HTML Living Standard (WHATWG): `spellcheck` attribute — `true`/`false`, supporte par tous les navigateurs modernes, utilise le dictionnaire systeme de l'utilisateur
- [L4 — Official doc] MDN Web Docs: `spellcheck` — attribut global, fonctionne sur `<input>`, `<textarea>`, `contenteditable`
- [L5 — SWEBOK] SWEBOK v4: pas de reference directe au spellcheck (trop specifique)
- [L6 — Practitioner consensus] LanguageTool: API open-source de correction grammaticale et orthographique, supporte le francais, deployable en self-hosted
- [L7 — OLS codebase] Package backend `ai/` — "Correction de texte via LanguageTool (utilise par AiCorrectionButton)" — correction a la demande cote backend, pas de spellcheck automatique en temps reel

**Sources excluded:**
- Grammarly API: exclu car payant, donnees envoyees a un tiers (conformite RGPD), et OLS a deja LanguageTool
- Bibliotheques JS de spellcheck (nspell, Typo.js): exclu car dictionnaires lourds a charger cote client (plusieurs Mo pour le francais), performance degradee
- Desactiver le spellcheck: exclu car perte de fonctionnalite gratuite du navigateur

**Quality assessment:**
- Q1-Q4: Satisfaits
- Q5: Detail limite — peu de sources academiques sur le spellcheck web
- Q6: Convergence faible — c'est un sujet ou il n'y a pas de debat actif
- Q7: Applicable

**GRADE: 3/7**

**Sensitivity:** FRAGILE — Le spellcheck natif depend du navigateur et du systeme de l'utilisateur. La qualite pour le francais scientifique (termes techniques: "bacteriologie", "mycologie") est variable. LanguageTool offre une meilleure couverture mais a un cout en latence.

**Recommendation:** Deux niveaux complementaires:

| Niveau | Mecanisme | Quand |
|--------|-----------|-------|
| **Passif** | `spellcheck="true"` (defaut HTML) | Toujours actif sur les champs texte — gratuit, zero cout, soulignement rouge natif |
| **Actif** | LanguageTool via `AiCorrectionButton` | A la demande de l'utilisateur — bouton explicite pour correction avancee (grammaire + orthographe) |

Ne pas forcer `spellcheck="false"` sauf sur les champs techniques (code, identifiants, emails). Ne pas implementer de spellcheck temps reel cote client (trop lourd). Le pattern OLS existant (spellcheck natif + LanguageTool a la demande) est le bon equilibre.

**Level: BONNE_PRATIQUE**

---

## Resume

| # | Decision | GRADE | Sensitivity | Level | Recommendation courte |
|---|----------|-------|-------------|-------|----------------------|
| 1 | Soft delete | 5/7 | ROBUST | STANDARD | `deletedAt` pour entites owned restaurables, hard delete pour le technique |
| 2 | Scheduled tasks | 6/7 | ROBUST | STANDARD | `@Scheduled` + `SchedulerRegistry`, pas de Quartz |
| 3 | JPA EntityListener | 6/7 | ROBUST | STANDARD | EntityListener pour lifecycle entite, AOP pour service/controller |
| 4 | DTO projection | 5/7 | ROBUST | STANDARD | DTO explicite toujours, jamais d'entite en API |
| 5 | API manual testing | 4/7 | FRAGILE | RECOMMANDE | Fichiers `.http` versionnes + Swagger UI en complement |
| 6 | Inline auto-save | 5/7 | ROBUST | STANDARD | Auto-save on blur pour edition, draft + submit pour creation |
| 7 | Drill-down navigation | 5/7 | ROBUST | STANDARD | Route `parent/:id/children` + breadcrumbs dynamiques |
| 8 | Form spell checking | 3/7 | FRAGILE | BONNE_PRATIQUE | Spellcheck natif navigateur + LanguageTool a la demande |

**Observation transversale:** OLS applique deja correctement les 8 patterns analyses. Les implementations existantes (`SoftDeletable`, `SchedulerRegistry`, `AuditableEntity` + `HtmlSanitizationListener`, DTOs + MapStruct, fichiers `.http`, `useInlineAutoSave` + `useDraftForm`, `createDrilldownPage` + `useBreadcrumbStore`, spellcheck natif + LanguageTool) sont alignees avec les recommandations issues des sources officielles et du consensus industriel. Aucune correction de trajectoire n'est necessaire.