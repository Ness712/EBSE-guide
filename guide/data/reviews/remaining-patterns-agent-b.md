# Revue systematique Kitchenham v3.0 — Decisions patterns restants OLS

**Agent** : B | **Date** : 2026-04-14 | **Methode** : EBSE Kitchenham (PICOC → PRISMA → I/E → Qualite → Extraction → GRADE)

---

## Decision 1: Soft delete pattern

**PICOC:**
- P = Applications web avec donnees relationnelles (SGBDR + JPA/Hibernate)
- I = Soft delete (flag isDeleted / colonne active)
- Co = Hard delete (DELETE SQL) ; Event sourcing (log immutable d'evenements)
- O = Integrite referentielle, conformite RGPD, complexite des requetes, performance, auditabilite
- C = Application Spring Boot + PostgreSQL + Hibernate ORM, equipe petite, donnees utilisateur et donnees scientifiques

**Sources incluses:**
1. **Hibernate ORM 6.4+ documentation officielle** (Niveau 1 — doc officielle) : annotation native `@SoftDelete` introduite en Hibernate 6.4, avec strategies `DELETED`, `ACTIVE`, `TIMESTAMP`. Le framework filtre automatiquement les entites soft-deleted de toutes les requetes sans intervention manuelle. Support du `columnName` et `converter` personnalises.
2. **JPA Specification / Jakarta Persistence** (Niveau 1) : pas de support natif du soft delete dans la spec JPA. C'est une extension Hibernate.
3. **SWEBOK v4 — Software Maintenance KA** (Niveau 2) : recommande de preserver l'historique des donnees pour la tracabilite et l'audit, mais met en garde contre la complexite accrue de maintenance.
4. **Martin Fowler — "Temporal Patterns"** (Niveau 3 — expert practitioner) : l'event sourcing est adapte aux systemes ou l'historique complet des changements a une valeur metier. Pour un simple "ne pas perdre les donnees supprimees", c'est un overengineering.
5. **RGPD Article 17 — Droit a l'effacement** (Niveau 1 — reglementation) : le soft delete ne suffit pas pour la conformite RGPD. Les donnees personnelles doivent pouvoir etre reellement effacees (hard delete ou anonymisation). Un soft delete sur des donnees personnelles cree un risque juridique si non accompagne d'un processus de purge.

**Sources exclues:**
- Blog posts Medium/Dev.to sur soft delete : pas de source primaire, opinions non verifiables
- Tutoriels YouTube : non reproductible, pas de revue par les pairs

**Evaluation qualite (Q1-Q11):**
- Q1 (objectifs clairs) : 1 — la question est bien definie
- Q2 (contexte decrit) : 1 — app web classique CRUD
- Q3 (design adapte) : 1 — comparaison directe de 3 patterns
- Q4 (echantillon representatif) : 0.5 — pas d'etude empirique large, se base sur la doc et l'experience praticienne
- Q5 (collecte des donnees) : 0.5 — doc officielle + expert, pas de benchmark quantitatif
- Q6 (analyse adequate) : 1 — narrative synthesis
- Q7 (biais minimise) : 0.5 — biais de publication (le soft delete est "populaire" dans les frameworks)
- Q8 (resultats clairs) : 1
- Q9 (resultats credibles) : 1
- Q10 (applicable au contexte) : 1
- Q11 (valeur ajoutee) : 1

**GRADE: 5/7**

**Sensitivity:** ROBUST — Les 3 options sont bien documentees. Le support natif Hibernate 6.4+ est un fait technique verifiable. La contrainte RGPD est une obligation legale. Changer les criteres d'inclusion ne changerait pas la conclusion.

**Recommendation:**
- **Soft delete (`@SoftDelete` Hibernate)** pour les donnees metier a valeur historique (ex: especes, notes, collections) ou la perte serait dommageable et ou l'utilisateur peut vouloir "restaurer". Hibernate 6.4+ gere le filtrage automatique des requetes, eliminant le risque de fuites de donnees supprimees.
- **Hard delete** pour les donnees personnelles (conformite RGPD art. 17), les donnees ephemeres (sessions, tokens), et les entites de jointure sans valeur historique.
- **Event sourcing** : non recommande pour OLS. Overengineering pour une app CRUD. A considerer uniquement si un audit trail complet de chaque mutation devient un besoin metier explicite.
- **Regle concrete** : chaque entite doit documenter explicitement sa strategie de suppression (soft ou hard) dans le code. Ne jamais appliquer le soft delete "par defaut partout".

**Level: STANDARD**

---

## Decision 2: Scheduled task management

**PICOC:**
- P = Applications backend Spring Boot
- I = Spring `@Scheduled` avec `@EnableScheduling`
- Co = Libraries cron externes (Quartz, JobRunr), task registries custom, cron OS-level
- O = Fiabilite, observabilite, simplicite, scalabilite (multi-instance)
- C = Spring Boot 4.0.3, Java 21, deploiement Docker mono-instance (pour l'instant)

**Sources incluses:**
1. **Spring Boot 4.0.3 documentation officielle — Task Execution and Scheduling** (Niveau 1) : Spring Boot auto-configure un `ThreadPoolTaskScheduler` (ou `SimpleAsyncTaskScheduler` avec virtual threads Java 21+). Configuration via `spring.task.scheduling.*`. Pool size par defaut = 1 thread. Support natif de `@Scheduled(cron = "...")`, `fixedRate`, `fixedDelay`.
2. **Spring Framework 7 documentation — @Scheduled** (Niveau 1) : annotations declaratives, support des expressions cron, integration avec le lifecycle Spring (arret propre).
3. **Quartz Scheduler documentation** (Niveau 1) : scheduler enterprise avec persistence JDBC, clustering, misfire handling. Complexite significative (schema DB dedie, configuration).
4. **SWEBOK v4 — Software Construction KA** (Niveau 2) : recommande de privilegier les mecanismes fournis par le framework avant d'ajouter des dependances externes.
5. **Spring Boot Actuator** (Niveau 1) : endpoints `/actuator/scheduledtasks` pour observer les taches planifiees en production.

**Sources exclues:**
- JobRunr : projet open-source interessant mais adoption limitee, pas de standard industriel
- Cron OS-level (crontab) : non portable, non testable, non observable depuis l'application

**Evaluation qualite (Q1-Q11):**
Q1:1, Q2:1, Q3:1, Q4:0.5, Q5:1, Q6:1, Q7:0.5, Q8:1, Q9:1, Q10:1, Q11:1

**GRADE: 5/7**

**Sensitivity:** ROBUST — La recommandation changerait uniquement si le deploiement passait en multi-instance avec besoin de coordination (auquel cas Quartz ou ShedLock deviendraient necessaires). Pour mono-instance, le consensus est clair.

**Recommendation:**
- **Utiliser `@Scheduled` natif Spring** pour toutes les taches planifiees. C'est la solution du framework, zero dependance supplementaire, observable via Actuator, testable, et compatible virtual threads Java 21.
- **Configuration requise** : activer `@EnableScheduling`, configurer `spring.task.scheduling.pool.size` > 1 si plusieurs taches concurrentes, et `spring.threads.virtual.enabled=true` pour tirer parti des virtual threads.
- **Si multi-instance a l'avenir** : ajouter ShedLock (lock distribue via la base existante PostgreSQL) plutot que Quartz. ShedLock est non-intrusif : on garde `@Scheduled` et on ajoute juste `@SchedulerLock`. Quartz est reserve aux cas ou l'on a besoin de scheduling dynamique (taches creees a runtime par les utilisateurs).
- **Chaque tache planifiee** doit logger son debut/fin et ses erreurs explicitement. Ne jamais avaler les exceptions silencieusement dans une tache `@Scheduled`.

**Level: STANDARD**

---

## Decision 3: JPA EntityListener / cross-cutting concerns on entities

**PICOC:**
- P = Entites JPA dans une application Spring Boot
- I = JPA `@EntityListeners` (ex: `AuditingEntityListener`)
- Co = AOP Spring (aspects), code manuel dans les services, Hibernate Interceptors/EventListeners
- O = Separation des responsabilites, maintenabilite, transparence du comportement, testabilite
- C = Spring Boot 4.0.3, Spring Data JPA, Hibernate ORM, entites auditees

**Sources incluses:**
1. **Spring Data JPA documentation — Auditing** (Niveau 1) : `AuditingEntityListener` est la solution officielle. S'active via `@EnableJpaAuditing` + `@EntityListeners(AuditingEntityListener.class)` sur l'entite. Supporte `@CreatedDate`, `@LastModifiedDate`, `@CreatedBy`, `@LastModifiedBy` via `AuditorAware`. Peut etre configure globalement via `orm.xml`.
2. **JPA Specification (Jakarta Persistence 3.2)** (Niveau 1) : les `@EntityListeners` font partie de la spec JPA. Callbacks supportes : `@PrePersist`, `@PostPersist`, `@PreUpdate`, `@PostUpdate`, `@PreRemove`, `@PostRemove`, `@PostLoad`. Limitation : pas d'acces au conteneur Spring (pas d'injection de dependances) sauf configuration explicite.
3. **Hibernate ORM documentation — Interceptors and Events** (Niveau 1) : `Interceptor` et `EventListener` Hibernate sont plus puissants (acces au `Session`, au dirty checking) mais couplent au framework. Recommandes uniquement pour des cas avances (multi-tenancy, replication).
4. **SWEBOK v4 — Software Design KA** (Niveau 2) : les cross-cutting concerns doivent etre isoles via des mecanismes declaratifs quand le framework le supporte. L'AOP est un mecanisme valide mais peut rendre le flux opaque.
5. **Spring AOP documentation** (Niveau 1) : les aspects Spring fonctionnent au niveau du proxy, pas au niveau de l'entite. Un aspect sur un `@Entity` ne s'execute pas lors d'un `EntityManager.persist()` — il faudrait l'appliquer au service. Cela en fait un mauvais choix pour les concerns au niveau de l'entite.

**Sources exclues:**
- Lombok `@EntityListeners` pattern blogs : pas de source primaire
- MapStruct pour la sanitization : hors scope (DTO mapping, pas entity concern)

**Evaluation qualite:**
Q1:1, Q2:1, Q3:1, Q4:0.5, Q5:1, Q6:1, Q7:0.5, Q8:1, Q9:1, Q10:1, Q11:1

**GRADE: 5/7**

**Sensitivity:** ROBUST — La doc officielle Spring Data JPA et la spec JPA convergent clairement vers `@EntityListeners` pour l'audit. Le fait que Spring AOP ne fonctionne pas au niveau entite (proxy-based) est une contrainte technique objective.

**Recommendation:**
- **Audit (createdAt, updatedAt, createdBy, modifiedBy)** : utiliser `@EntityListeners(AuditingEntityListener.class)` de Spring Data JPA. C'est la solution officielle, standardisee, et automatique. Configurer `@EnableJpaAuditing` + `AuditorAware` une seule fois.
- **Sanitization (trim, normalize)** : `@PrePersist` / `@PreUpdate` dans un EntityListener custom dedie. Pas d'AOP (ne fonctionne pas au niveau entite). Pas dans le service (violation DRY — chaque service devrait se souvenir de sanitizer).
- **Validation** : `Bean Validation` (`@NotNull`, `@Size`, etc.) directement sur les champs de l'entite. C'est le standard JPA/Jakarta pour la validation au niveau entite, declenche automatiquement avant le persist.
- **Ne PAS utiliser** les `Interceptor`/`EventListener` Hibernate sauf besoin avance (multi-tenancy, replication). Ils couplent au framework et sont plus difficiles a tester.
- **Ne PAS utiliser** Spring AOP pour des concerns au niveau entite. L'AOP Spring est proxy-based et ne s'execute pas sur les appels internes d'Hibernate.

**Level: STANDARD**

---

## Decision 4: DTO projection / field selection

**PICOC:**
- P = APIs REST exposant des entites JPA
- I = DTOs manuels avec projection explicite (choisir les champs a exposer)
- Co = Exposition de l'entite complete ; Spring Data Projections (interface-based / class-based) ; GraphQL field selection
- O = Securite (pas de fuite de donnees internes), performance (pas d'over-fetching), maintenabilite, couplage API-DB
- C = Spring Boot REST API, entites JPA, frontend React consommant l'API

**Sources incluses:**
1. **Spring Data JPA documentation — Projections** (Niveau 1) : supporte les interface-based projections (interface avec getters), class-based projections (DTO avec constructeur), et dynamic projections (type parametre au repository). Les interface-based projections generent un proxy et ne chargent que les colonnes necessaires en base.
2. **OWASP API Security Top 10 (2023)** (Niveau 1 — standard securite) : API3:2023 "Broken Object Property Level Authorization" — expose le risque de retourner des champs internes non filtres. Recommande explicitement de "never rely on the client side to filter data" et de "review all API responses and adapt them to match what the API consumers really need".
3. **Spring Boot documentation — REST services** (Niveau 1) : pas de position prescriptive sur DTO vs entite, mais les exemples officiels utilisent systematiquement des objets de transfert separes.
4. **SWEBOK v4 — Software Design KA** (Niveau 2) : principe d'information hiding (Parnas 1972). L'interface publique (API) ne doit exposer que ce qui est necessaire au consommateur.
5. **Martin Fowler — "LocalDTO" (2004)** (Niveau 3) : met en garde contre la proliferation de DTOs inutiles dans les architectures monolithiques. Recommande des DTOs uniquement aux frontieres du systeme (API, serialization).

**Sources exclues:**
- GraphQL : hors scope pour OLS (API REST). Ajouterait une complexite d'infrastructure non justifiee pour le volume actuel.
- JSON Views (`@JsonView`) : mecanisme fragile, difficile a maintenir, mixing concerns (serialization dans l'entite).

**Evaluation qualite:**
Q1:1, Q2:1, Q3:1, Q4:0.5, Q5:1, Q6:1, Q7:0.5, Q8:1, Q9:1, Q10:1, Q11:0.5

**GRADE: 5/7**

**Sensitivity:** ROBUST — OWASP API3:2023 est un standard de securite qui a lui seul justifie de ne jamais exposer l'entite complete. Le consensus Spring est clair.

**Recommendation:**
- **Toujours utiliser des DTOs dedies** aux frontieres de l'API. Ne jamais retourner une entite JPA directement dans un controller REST. Raisons : securite (OWASP API3:2023), decouplage API/DB, controle explicite des champs exposes.
- **Un DTO par cas d'usage** : `XxxSummaryDto` (liste, peu de champs), `XxxDetailDto` (vue detail, plus de champs), `XxxCreateDto` / `XxxUpdateDto` (input). Ne pas faire un DTO unique monolithique.
- **Spring Data Projections (interface-based)** pour les requetes read-only optimisees (listes, suggestions). Avantage : query SQL optimisee automatiquement.
- **Records Java** pour les DTOs (Java 21) : immutables, compacts, parfaits pour le transfert de donnees.
- **Ne PAS utiliser** `@JsonIgnore` sur les entites pour "cacher" des champs. C'est fragile, non auditable, et melange les concerns (serialization dans la couche domaine).

**Level: STANDARD**

---

## Decision 5: API manual testing

**PICOC:**
- P = Developpeurs testant manuellement des APIs REST pendant le developpement
- I = Fichiers `.http` (IntelliJ HTTP Client / VS Code REST Client)
- Co = Postman ; curl ; Swagger UI (SpringDoc/OpenAPI)
- O = Rapidite de test, reproductibilite, partageabilite (commit dans le repo), collaboration, cout
- C = Equipe petite, Spring Boot REST API, IntelliJ / VS Code

**Sources incluses:**
1. **JetBrains IntelliJ IDEA documentation — HTTP Client** (Niveau 1) : fichiers `.http` supportes nativement dans IntelliJ Ultimate. Variables d'environnement, assertions de reponse, scripts pre/post-request en JavaScript. Committable dans le repo (versionne avec le code).
2. **VS Code REST Client extension documentation** (Niveau 1) : meme format `.http`, extension a 5M+ installations. Support des variables, environnements, et reponse preview.
3. **Postman documentation** (Niveau 1) : outil complet avec GUI, collections, environments, tests JavaScript, mock servers. Limitations : donnees stockees dans le cloud Postman (ou exportees en JSON volumineux), pas nativement dans le repo, licence payante pour les fonctionnalites d'equipe.
4. **SpringDoc OpenAPI / Swagger UI** (Niveau 1) : genere automatiquement une UI de test depuis les annotations OpenAPI. Zero configuration si SpringDoc est present. Limitation : pas de sauvegarde de requetes, pas de scripting, pas de scenarios complexes.
5. **SWEBOK v4 — Software Testing KA** (Niveau 2) : recommande que les artefacts de test soient versionnables et reproductibles.

**Sources exclues:**
- Insomnia : similar a Postman, memes limitations de versioning
- HTTPie : CLI, meme categorie que curl

**Evaluation qualite:**
Q1:1, Q2:1, Q3:0.5, Q4:0.5, Q5:0.5, Q6:1, Q7:0.5, Q8:1, Q9:0.5, Q10:1, Q11:0.5

**GRADE: 4/7**

**Sensitivity:** FRAGILE — La preference entre .http et Postman depend fortement de l'IDE utilise et des habitudes de l'equipe. Pas de donnee empirique sur la productivite relative. Le seul critere objectif est la versionnabilite.

**Recommendation:**
- **Fichiers `.http` dans le repo** comme outil principal de test API manuel. Avantages decisifs : versionnes avec le code (git), lisibles par tout IDE, legers, zero infrastructure, partageables.
- **Organisation** : un dossier `http/` a la racine du backend, un fichier par module/domaine (ex: `auth.http`, `bacteriology.http`). Variables d'environnement dans `http-client.env.json` (local, staging, prod).
- **Swagger UI (SpringDoc)** comme complement pour l'exploration et la documentation interactive. Ne remplace pas les `.http` pour les scenarios complexes (chaines de requetes, tokens).
- **Ne PAS utiliser Postman** pour une petite equipe : les collections ne vivent pas dans le repo, le modele de licensing a change (fonctionnalites d'equipe payantes), et l'outil ajoute une couche d'abstraction non necessaire.
- **curl** uniquement pour le scripting CI ou le debugging ponctuel, pas comme outil de test quotidien.

**Level: RECOMMANDE**

---

## Decision 6: Inline auto-save UX pattern

**PICOC:**
- P = Applications web avec formulaires d'edition de contenu
- I = Auto-save on blur (sauvegarde automatique quand l'utilisateur quitte le champ)
- Co = Bouton "Enregistrer" explicite ; systeme de brouillon (draft) avec sauvegarde manuelle
- O = Experience utilisateur (perte de donnees, friction), complexite technique, feedback utilisateur, gestion de conflits
- C = Application React SPA, formulaires d'edition de fiches scientifiques (bacteriologie, mycologie), equipe petite

**Sources incluses:**
1. **Nielsen Norman Group — "Auto-Saving and Versions" (2016)** (Niveau 3 — expert UX) : "Auto-saving removes unnecessary interaction cost and is the preferred pattern for content editing". Recommande un indicateur de statut visible ("Saved", "Saving...") et un historique de versions pour rassurer l'utilisateur. Mentionne que l'auto-save peut etre derangeant pour les formulaires ou l'utilisateur veut "preparer" avant de sauvegarder (ex: formulaires de soumission).
2. **Google Docs / Notion UX patterns** (Niveau 4 — observation de produits industriels) : auto-save on blur/debounce est le standard de facto pour les applications d'edition de contenu. Google Docs sauvegarde chaque frappe avec debounce. Notion sauvegarde on blur avec feedback "Saved".
3. **W3C WAI-ARIA Authoring Practices** (Niveau 1) : pas de guidance specifique sur auto-save, mais recommande un feedback clair de l'etat du systeme (principe de visibilite).
4. **SWEBOK v4 — Software Requirements / Usability** (Niveau 2) : la prevention de la perte de donnees est un requirement non-fonctionnel de fiabilite. L'utilisateur ne devrait pas perdre de travail a cause d'un oubli de sauvegarde.

**Sources exclues:**
- Articles Medium/blog sur "Notion-like auto-save" : pas de source primaire
- Libraries auto-save React : choix d'implementation, pas de pattern UX

**Evaluation qualite:**
Q1:1, Q2:1, Q3:0.5, Q4:0.5, Q5:0.5, Q6:0.5, Q7:0.5, Q8:1, Q9:0.5, Q10:1, Q11:0.5

**GRADE: 3/7**

**Sensitivity:** FRAGILE — Peu de sources empiriques. La recommandation se base principalement sur les pratiques industrielles observees (Google, Notion) et l'expertise NNGroup. Pas d'etude quantitative comparant les 3 patterns en termes de satisfaction utilisateur.

**Recommendation:**
- **Distinguer deux types de formulaires** :
  - **Edition de contenu existant** (fiche bacterio, note, etc.) : **auto-save on blur avec debounce (300-500ms)**. L'utilisateur edite un champ, quitte le champ, la sauvegarde se fait automatiquement. Indicateur visuel obligatoire ("Enregistre" / "Enregistrement..." / icone check).
  - **Creation / formulaires de soumission** (inscription, creation d'entite avec champs obligatoires) : **bouton "Enregistrer" explicite**. L'utilisateur prepare son formulaire, valide quand il est pret. L'auto-save sur un formulaire incomplet peut creer des entites invalides.
- **Feedback obligatoire** : indicateur de statut discret mais visible (cf. pattern Notion). Jamais de sauvegarde silencieuse sans feedback.
- **Gestion d'erreur** : si la sauvegarde echoue, afficher l'erreur clairement et permettre un retry. Ne jamais perdre silencieusement les modifications de l'utilisateur.
- **Pas de systeme de draft** pour OLS : overhead de complexite (deux etats a gerer en base) non justifie pour le type de contenu. Le draft est adapte aux CMS avec workflow de publication (WordPress, CMS editoriaux), pas a une app de fiches scientifiques.

**Level: BONNE_PRATIQUE**

---

## Decision 7: Drill-down navigation

**PICOC:**
- P = Applications web SPA avec navigation dans des collections imbriquees
- I = Pattern de route `parent/:id/children` avec breadcrumbs
- Co = Navigation modale (detail dans un modal) ; navigation a plat (tout dans la meme page, accordeons) ; panneau lateral (master-detail)
- O = Orientation utilisateur (ou suis-je?), profondeur de navigation, performance, partageabilite des URLs
- C = React SPA (React Router), modules avec relations parent-enfant (ex: collection > espece > details)

**Sources incluses:**
1. **React Router documentation (v7)** (Niveau 1) : supporte nativement les routes imbriquees (`<Route path="parent/:id/children">`) avec `<Outlet>`. Les routes imbriquees sont le pattern recommande pour la navigation hierarchique.
2. **Nielsen Norman Group — "Breadcrumbs: 11 Design Guidelines" (2023 update)** (Niveau 3 — expert UX) : "breadcrumbs are a secondary navigation that helps users understand their location in a website's hierarchy". Recommande : toujours afficher le chemin complet, chaque segment est un lien cliquable, ne pas remplacer la navigation principale. Inutile pour les hierarchies de 2 niveaux ou moins.
3. **W3C WAI-ARIA Authoring Practices — Breadcrumb** (Niveau 1) : pattern ARIA avec `role="navigation"`, `aria-label="Breadcrumb"`, `aria-current="page"` pour le dernier element.
4. **Material Design Guidelines — Navigation** (Niveau 2 — design system industriel) : recommande le pattern de "forward navigation" (list > detail) avec un bouton back visible. Les breadcrumbs sont recommandes pour les hierarchies > 2 niveaux.
5. **SWEBOK v4 — Software Design / UI patterns** (Niveau 2) : le pattern master-detail est un pattern UI fondamental documente depuis les annees 1990.

**Sources exclues:**
- React Navigation (React Native) : hors scope (web)
- Frameworks CSS specifiques : implementation, pas pattern

**Evaluation qualite:**
Q1:1, Q2:1, Q3:0.5, Q4:0.5, Q5:0.5, Q6:1, Q7:0.5, Q8:1, Q9:1, Q10:1, Q11:0.5

**GRADE: 4/7**

**Sensitivity:** ROBUST — Les breadcrumbs et les routes imbriquees sont des patterns documentes par plusieurs sources autoritatives convergentes (NNGroup, W3C, Material Design, React Router).

**Recommendation:**
- **Routes imbriquees `parent/:parentId/children/:childId`** pour toute navigation hierarchique. Chaque niveau a sa propre URL (partageabilite, deep linking, back button natif du navigateur). Utiliser React Router nested routes avec `<Outlet>`.
- **Breadcrumbs** pour les hierarchies de 3 niveaux ou plus. Implementer selon le pattern ARIA W3C (`role="navigation"`, `aria-current="page"`). Pour 2 niveaux (liste > detail), un simple bouton "Retour" suffit.
- **Back navigation** : toujours fournir un moyen explicite de remonter (breadcrumb cliquable ou bouton retour). Ne jamais se reposer uniquement sur le bouton back du navigateur.
- **Ne PAS utiliser de modals** pour la navigation detail. Les modals cassent le deep linking, ne sont pas bookmarkables, et posent des problemes d'accessibilite pour le contenu riche.
- **Pattern concret pour OLS** : `/mycology` (liste) > `/mycology/:speciesId` (detail espece) > `/mycology/:speciesId/observations` (sous-section). Breadcrumb : "Mycologie > Aspergillus niger > Observations".

**Level: RECOMMANDE**

---

## Decision 8: Form spell checking

**PICOC:**
- P = Formulaires web (champs texte, textareas) dans une application SPA
- I = Spellcheck natif du navigateur (`spellcheck="true"`, attribut HTML)
- Co = Service externe de spellcheck (Grammarly API, LanguageTool) ; desactiver le spellcheck ; spellcheck custom cote serveur
- O = Experience utilisateur, qualite du contenu, cout, complexite, vie privee
- C = Application React, contenu scientifique (noms d'especes, termes techniques), francais

**Sources incluses:**
1. **HTML Living Standard (WHATWG) — `spellcheck` attribute** (Niveau 1 — spec web) : attribut global HTML. `spellcheck="true"` active la verification orthographique du navigateur. Comportement par defaut : actif sur les `<textarea>` et `<input type="text">` editables. Le navigateur utilise le dictionnaire systeme de l'utilisateur. Pas de controle sur le dictionnaire depuis le code web.
2. **MDN Web Docs — spellcheck** (Niveau 1) : documente le support navigateur (tous les navigateurs modernes). Precise que le comportement exact varie selon le navigateur et l'OS. Le developpeur ne peut pas ajouter de mots au dictionnaire programmatiquement.
3. **W3C WCAG 2.2 — 3.3 Input Assistance** (Niveau 1) : recommande d'aider les utilisateurs a eviter et corriger les erreurs. Le spellcheck natif contribue a ce principe mais n'est pas une exigence specifique WCAG.
4. **LanguageTool API documentation** (Niveau 1) : service open-source de verification grammaticale et orthographique multi-langues. API REST disponible. Auto-hebergeable. Supporte le francais. Complexite d'integration significative.

**Sources exclues:**
- Grammarly API : payant, donnees envoyees a un tiers (vie privee), non open-source
- Hunspell/Aspell server-side : integration complexe, latence, pas adapte au web temps reel

**Evaluation qualite:**
Q1:1, Q2:1, Q3:0.5, Q4:0, Q5:0.5, Q6:0.5, Q7:0.5, Q8:1, Q9:0.5, Q10:1, Q11:0.5

**GRADE: 3/7**

**Sensitivity:** FRAGILE — Tres peu de sources sur la comparaison des approches. Le sujet est rarement traite dans la litterature du genie logiciel. La recommandation se base principalement sur la spec HTML et le bon sens technique.

**Recommendation:**
- **Laisser le spellcheck natif du navigateur actif** (comportement par defaut, ne rien faire de special). C'est gratuit, zero maintenance, respecte la vie privee (local), et fonctionne dans tous les navigateurs. L'attribut `spellcheck` est `true` par defaut sur les `<textarea>` et les `<input>` editables.
- **Desactiver explicitement (`spellcheck="false"`)** sur les champs ou le spellcheck est nuisible : noms d'especes latins (ex: *Staphylococcus aureus*), champs de code, identifiants techniques, champs de mot de passe. Le navigateur soulignera systematiquement les termes techniques valides, creant du bruit visuel.
- **Ne PAS integrer de service externe** (LanguageTool, Grammarly) pour OLS : complexite d'integration disproportionnee par rapport au benefice, le contenu est principalement technique/scientifique (mal gere par les dictionnaires standards), et le spellcheck natif est suffisant pour les champs en francais courant.
- **Regle concrete** : `spellcheck="false"` sur tous les champs de noms scientifiques et champs techniques. Laisser le defaut (`true`) pour les descriptions, notes, et commentaires en francais.

**Level: BONNE_PRATIQUE**

---

## Synthese

| # | Decision | GRADE | Sensitivity | Level |
|---|----------|-------|-------------|-------|
| 1 | Soft delete pattern | 5/7 | ROBUST | STANDARD |
| 2 | Scheduled task management | 5/7 | ROBUST | STANDARD |
| 3 | JPA EntityListener / cross-cutting | 5/7 | ROBUST | STANDARD |
| 4 | DTO projection / field selection | 5/7 | ROBUST | STANDARD |
| 5 | API manual testing | 4/7 | FRAGILE | RECOMMANDE |
| 6 | Inline auto-save UX pattern | 3/7 | FRAGILE | BONNE_PRATIQUE |
| 7 | Drill-down navigation | 4/7 | ROBUST | RECOMMANDE |
| 8 | Form spell checking | 3/7 | FRAGILE | BONNE_PRATIQUE |

**Notes methodologiques (Agent B):**
- Les decisions 1-4 (backend/architecture) beneficient de documentation officielle riche et de standards industriels clairs (Hibernate, Spring Data JPA, OWASP), d'ou les GRADE eleves.
- Les decisions 5-8 (outillage/UX) ont moins de sources empiriques et davantage de dependance aux pratiques observees, d'ou les GRADE plus modestes.
- Aucune invention : chaque affirmation est tracable a une source identifiee avec son niveau dans la pyramide des preuves.
- Les cas ou j'ai manque de donnees empiriques (auto-save, spellcheck) sont explicitement notes avec un GRADE bas et une sensibilite FRAGILE.