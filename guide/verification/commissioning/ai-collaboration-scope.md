# Phase 1.2 — Scope : domaine `ai-collaboration`

**Protocole** : `methodology.md` v3.0, section 1.2 (Kitchenham & Charters 2007 §5.2, Commissioning)
**Date** : 2026-04-15
**Methode** : double extraction (Reviewer A + Reviewer B, contextes isoles) + verification sources (Agent C isole) + reconciliation superviseur
**Tracability** : [`verification/extractions/phase-1-2-ai-collaboration-scope.md`](../extractions/phase-1-2-ai-collaboration-scope.md)

## Sujet du nouveau domaine

Domaine `ai-collaboration` : decisions techniques et organisationnelles pour **deleguer du travail d'ingenierie logicielle a un agent de codage IA** (Claude Code, Cursor, Devin, Copilot, SWE-agent) **avec des checkpoints humains explicites** — modele "manager delegue a une equipe de dev".

## Justification de l'ajout du domaine

Le domaine est justifie par le gate Phase 1.1 (DARE) : aucune SLR existante ne couvre ce scope a DARE >= 2.5 ([voir phase-1-1-ai-collaboration-dare.md](../extractions/phase-1-1-ai-collaboration-dare.md)).

De plus, **SWEBOK v4 KA 9 SE Management** dit explicitement (p. 9-5/9-6, verbatim verifie par Agent C) :

> *"The complexity of the end-to-end DevSecOps tools and of using emerging technologies such as artificial intelligence (AI) and machine learning (ML) to leverage those tools adds another dimension [15]. For example, Agile and DevOps approaches are reasonably well-established, but in case of AI-based software, new SLDCs maybe required to manage the complexity brought by AI to the software."*

Le corps de reference SWEBOK justifie donc l'existence d'un nouveau domaine pour les nouvelles pratiques SDLC liees a l'AI.

## Ancrage de scope — 3 niveaux (coherence avec methodology.md §1.2)

### Niveau 1 — SCOPE (quels sujets couvrir)

Le scope existant du guide (ISO 25010:2023 + ISO 25019:2023 + SWEBOK v4) est **etendu** pour ce domaine avec les standards AI-specifiques suivants.

#### Standards AI — PRIMARY anchors (5)

| # | Standard | Role | URL / Access |
|---|----------|------|--------------|
| 1 | **ISO/IEC 5338:2023** | AI system life cycle processes — bridge 12207/15288 → AI | [iso.org/standard/81118](https://www.iso.org/standard/81118.html) (paywalled, preview via iteh.ai) |
| 2 | **ISO/IEC 42001:2023** | AI management system (certifiable) — controles organisationnels | [iso.org/standard/81230](https://www.iso.org/standard/81230.html) (paywalled) |
| 3 | **ISO/IEC 23894:2023** | Guidance on AI risk management (base ISO 31000) | [iso.org/standard/77304](https://www.iso.org/standard/77304.html) (paywalled) |
| 4 | **NIST AI 100-1** (AI RMF 1.0, Jan 2023) | GOVERN-MAP-MEASURE-MANAGE + MAP 3.5 human oversight | [nvlpubs.nist.gov/nistpubs/ai/nist.ai.100-1.pdf](https://nvlpubs.nist.gov/nistpubs/ai/nist.ai.100-1.pdf) (free) |
| 5 | **NIST AI 600-1** (GAI Profile, Jul 2024) | Top anchor topologique — cite verbatim "code generation and review" + §2.7 "Human-AI Configuration" | [nvlpubs.nist.gov/nistpubs/ai/NIST.AI.600-1.pdf](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.600-1.pdf) (free) |

**Verbatim cles** (verifies par Agent C) :

- **ISO/IEC 5338:2023 Scope** (clause 1) :
  > *"This document defines a set of processes and associated concepts for describing the life cycle of AI systems based on machine learning and heuristic systems. It is based on ISO/IEC/IEEE 15288 and ISO/IEC/IEEE 12207 with modifications and additions of AI-specific processes from ISO/IEC 22989 and ISO/IEC 23053. [...] When an element of an AI system is traditional software or a traditional system, the software life cycle processes in ISO/IEC/IEEE 12207 and the system life cycle processes in ISO/IEC/IEEE 15288 can be used to implement that element."*

- **ISO/IEC 42001:2023 Scope** (clause 1) :
  > *"This document specifies the requirements and provides guidance for establishing, implementing, maintaining and continually improving an AI (artificial intelligence) management system within the context of an organization. [...] This document is intended to help the organization develop, provide or use AI systems responsibly in pursuing its objectives and meet applicable requirements..."*

- **ISO/IEC 23894:2023 Scope** (clause 1) :
  > *"This document provides guidance on how organizations that develop, produce, deploy or use products, systems and services that utilize artificial intelligence (AI) can manage risk specifically related to AI. [...] It moreover describes processes for the effective implementation and integration of AI risk management."*

- **NIST AI RMF 1.0 — MAP 3.5 subcategory** (verbatim) :
  > *"MAP 3.5: Processes for human oversight are defined, assessed, and documented in accordance with organizational policies from the GOVERN function."*

- **NIST AI RMF 1.0 — Appendix C** (TOC, verbatim) :
  > *"Appendix C: AI Risk Management and Human-AI Interaction"*

- **NIST AI 600-1 — Appendix A.1.2** (verbatim) :
  > *"AI technology can produce varied outputs in multiple modalities [...] These can include data labeling and preparation, development of GAI models, content moderation, **code generation and review**, text generation and editing, image and video generation, summarization, search, and chat."*

- **NIST AI 600-1 — §2.7** (verbatim heading) :
  > *"2.7. Human-AI Configuration"*

### Additions Phase 1.5b (post-peer-review)

**PRIMARY additionnels** :

| # | Standard | Role | URL / Access |
|---|----------|------|--------------|
| 6 | **Regulation (EU) 2024/1689** — **AI Act — Article 14 "Human oversight"** | Ancrage legal/regulatoire pour les PICOCs touchant human oversight (#1, #3, #13). Exigence legale UE pour high-risk AI systems | [eur-lex.europa.eu/eli/reg/2024/1689/oj](https://eur-lex.europa.eu/eli/reg/2024/1689/oj) (free) |

**SECONDARY additionnels** :

| # | Standard | Role |
|---|----------|------|
| 12 | **ISO/IEC 25059:2023** — Quality model for AI systems | Extension de ISO 25010 pour AI. Deja ancrage du guide existant via 25010 → transitif. |

### Exclusions explicites (scope)

Le domaine `ai-collaboration` **exclut explicitement** les topics suivants (a couvrir en SLR separees si besoin) :

- **Licensing / IP provenance** du code genere par l'agent → stream legal/compliance separe, necessite RQ juridiques distinctes
- **Agent UX / IDE integration depth** (inline vs panel vs CLI vs background) → question product-preference, pas EBSE-answerable
- **Safety-critical AI** (aerospace, medical devices, automotive) → couvert par ISO/IEC TR 5469:2024 et standards specifiques (DO-178C, IEC 62304)
- **Training / fine-tuning d'agents** → focus du domaine est l'*usage* d'agents existants, pas leur construction
- **Inclusivity of AI-assisted workflows** (non-English prompting, junior/senior parity, accessibility of escalation UX, access to premium tools) → ajoutee Phase 1.5c retrofit suite a GAP-A matrice ; adressable par SLR future distincte focus IC Inclusivity × Professional Practice

#### Standards AI — SECONDARY anchors (6, cite-only)

| # | Standard | Role |
|---|----------|------|
| 6 | ISO/IEC 22989:2022 | Terminology (human-in-the-loop / AI agent vocabulary) |
| 7 | ISO/IEC TR 24028:2020 | Trustworthiness overview (pre-LLM, largely superseded par 23894 + 42001) |
| 8 | ISO/IEC/IEEE 12207:2017 | Software life cycle baseline (herite via 5338) |
| 9 | ISO/IEC/IEEE 15288:2023 | System life cycle baseline (herite via 5338) |
| 10 | IEEE 7000-2021 | Ethics in system design (generic — hook si PICOC ethique emerge en 1.3) |
| 11 | ISO/IEC TR 5469:2024 | Functional safety for AI (cite only if safety-critical delegation is discussed) |

#### SWEBOK v4 KAs — PRIMARY anchors (3 + 1 bonus)

| # | KA | Section | Verbatim cle |
|---|----|---------|--------------|
| KA 4 | Software Construction | Ch 4 §5.1 Development Environments, p. 4-14/4-15 | *"modern IDEs are often equipped with AI-assisted programming which is boosted by the recent advances in Large Language Models (LLMs). [...] The programmer lets the LLM complete many of the details, but still reviews the generated code and integrates it into their project."* |
| KA 5 | Software Testing | Ch 5 §7.1 Testing of Emerging Technologies + §7.2 Testing Through Emerging Technologies, p. 5-26/5-27 | *"Testing artificial intelligence (AI), ML/ deep learning (DL) [...] is challenging and might be very expensive"* / *"AI, ML or DL techniques are successfully used to reduce the effort involved in several activities in software engineering"* |
| KA 9 | SE Management | Ch 9 Introduction, p. 9-5/9-6 | *"in case of AI-based software, new SLDCs maybe required to manage the complexity brought by AI to the software."* |
| **KA 16** (bonus, hors liste initiale) | Computing Foundations | Ch 16 §9.6 AI and Software Engineering, p. 16-27/16-28 | *"Software engineering and AI are mutually related to each other in basically two ways: AI applications in software engineering (i.e., AI for SE) and software engineering for AI systems (i.e., SE for AI). AI for SE aims to establish efficient ways of building high-quality software systems by replicating human developers' behavior."* |

**Note importante sur KA 4 §5.1** : cette quote est **l'evidence SWEBOK la plus directement alignee** avec notre topic. Elle decrit verbatim le modele manager-delegation (developer outlines → LLM generates → developer reviews). Reviewer A l'avait MISSED ; Reviewer B l'a trouvee ; Agent C l'a confirmee. Sans double extraction, cette evidence cle aurait ete perdue.

#### SWEBOK v4 KAs — SECONDARY anchors (2)

| KA | Role |
|----|------|
| KA 14 Professional Practice | Codes d'ethique + responsabilite professionnelle (accountability quand l'agent ecrit du code) |
| KA 6 SE Operations | Automation & DevOps (hook si PICOC sur CI/CD gates pour output agent emerge) |

#### SWEBOK v4 KAs — NOT_RETAINED

KA 10 SE Process, KA 11 Models & Methods, KA 12 Quality : pas de verbatim AI-specific surface en Phase 1.2. A reconfirmer en Phase 1.3 si une PICOC le necessite.

### Niveau 2 — MESURE (comment savoir si c'est atteint)

Les metriques existantes restent applicables :

- **ISO/IEC 25023** : metriques pour les caracteristiques ISO 25010 (applicables a la qualite du code produit par l'agent)
- **NIST AI RMF MEASURE function** : metriques de risque AI (application au travail delegue)
- **DORA metrics** (Accelerate) : deployment frequency, lead time, change failure rate, MTTR — applicables directement a l'equipe "humain + agent"
- **SPACE framework** (Forsgren et al. 2021, ACM Queue) : Satisfaction, Performance, Activity, Communication, Efficiency — avertissement explicite contre l'usage d'une metrique seule

### Niveau 3 — OPERATIONNALISATION (standards specialises par domaine)

Pour le domaine `ai-collaboration`, les standards operationnels emergeront des PICOC en Phase 1.3. Anticipation (a verifier et sourcer en 1.3) :

- OWASP LLM Top 10 (si une PICOC securite LLM emerge)
- MITRE ATLAS (si une PICOC adversarial AI emerge)
- Anthropic / OpenAI safety policies (si une PICOC model provider governance emerge)

## Equipe de recherche (section 1.2 methodology.md)

- **Reviewer A** : Agent IA 1 (contexte isole par session)
- **Reviewer B** : Agent IA 2 (contexte isole par session)
- **Agent C** : Verificateur de sources (contexte isole, role separe A/B)
- **Superviseur humain** : Gabriel (approbation du protocole, resolution finale des divergences non tranchees par C)

## Scope et plateformes

| Plateforme | Applicabilite domaine `ai-collaboration` |
|-----------|------------------------------------------|
| **Web** (backend + frontend) | Oui — primary scope, meme hypotheses que guide existant |
| **Mobile web** (PWA/Capacitor) | Oui — herite du scope web |
| **Mobile natif** | Hors scope (meme raison que le guide existant) |
| **Desktop** | Hors scope |
| **Embedded / safety-critical** | Hors scope (TR 5469 non retain comme PRIMARY) |

**Note** : les recommandations du domaine `ai-collaboration` sont **universelles** (independantes du backend framework), car elles concernent des decisions de **processus** et de **gouvernance**, pas des choix d'outils stack-specific. Les sous-decisions individuelles (ex: "quel tool de review" ou "quel MCP server") pourront avoir des variantes stack-specific en Phase 2.

## Matrice de couverture (placeholder pour Phase 1.3)

La matrice complete sub-characteristiques ISO 25010 × SWEBOK KAs pour `ai-collaboration` sera construite en Phase 1.3 avec double extraction. Pre-identification des cellules probablement actives (a valider en 1.3) :

| Sub-caracteristique ISO 25010 | KA SWEBOK pertinente | Decision probable |
|-------------------------------|---------------------|-------------------|
| Functional correctness | KA 4 Construction §5.1 + KA 5 Testing §7.1 | Gates deterministes (tests, lint, types) avant merge agent |
| Reliability > Fault tolerance | KA 9 Management + NIST RMF | Niveau d'automation par type de tache (Parasuraman LoA equivalent via 23894 risk) |
| Security > Integrity | KA 9 + NIST 600-1 | Permissions agent + sandbox + allowlist/denylist |
| Maintainability > Analysability | KA 4 §5.1 + KA 14 | Accountability — qui est responsable du code ecrit par l'agent |
| Interaction Capability > User assistance | KA 9 + NIST RMF App C | Protocole d'escalation agent → humain |

(Les cellules finales + les decisions seront fixees par double extraction en Phase 1.3.)

## Pre-identification des decisions candidates du domaine

Liste de depart pour Phase 1.3 (formulation PICOC). Chaque decision est une question a resoudre via EBSE :

1. **Niveau d'automation par type de tache** — quand l'agent agit seul, quand il propose, quand il demande
2. **Gates humaines obligatoires** — quelles decisions doivent rester humaines (irreversibilite, blast radius, conformite)
3. **Gates deterministes automatiques** — quelles verifications techniques avant d'accepter output agent
4. **Protocole d'escalation** — format et declencheurs de remontee agent → humain
5. **Architecture single-agent vs multi-agent** — quand un seul agent, quand plusieurs
6. **Pattern writer / reviewer** — comment valider le travail d'un agent par un autre agent + gates deterministes
7. **Gestion du contexte agent** — persistance, compaction, memoire, CLAUDE.md equivalent
8. **Permissions et sandbox** — allowlist/denylist tools, limitation blast radius
9. **Monitoring d'echecs silencieux** — detection d'hallucinations, package invention, semantic drift
10. **Metriques de l'equipe humain+agent** — DORA / SPACE adaptes
11. **Selection du modele par tache** — quand utiliser plus ou moins de compute / reasoning
12. **Situational awareness humaine** — comment rester "in the loop" sur les parties critiques (Bainbridge 1983 hook)
13. **Onboarding agent sur un projet** — project instructions, conventions, memoire persistante

Cette liste sera **validee, reformulee en PICOC, et etendue** en Phase 1.3 par double extraction.

## Limites documentees

1. **Abstracts ISO lus via mirrors** (iteh.ai, OECD.AI) — scopes normatifs verifies verbatim, mais corps + annexes des standards ISO paywalles non fetches. Coverage criteres (a)-(e) pour ces standards se base sur la clause 1 Scope uniquement. Impact : evaluation probablement conservative (le corps du standard est typiquement plus riche que son scope).
2. **IEEE 7000-2021** : clause 1 Scope normative non fetch verbatim (paywall IEEE Xplore). Retain en SECONDARY par prudence, a reconfirmer si necessite.
3. **SWEBOK v4 KAs 10/11/12** non retenus apres verification negative par les deux reviewers. A reconfirmer en 1.3 si une PICOC le necessite.
4. **Fabrication B detectee** (DIV-6, mineure : ajout de "different types or" dans une quote KA 9 SWEBOK). Aucun impact sur le livrable car A avait le verbatim correct. Documentee dans le fichier tracability.
5. **Misses A detectes** (DIV-5 KA 4 §5.1 — major ; DIV-7 KA 5 §7.2 — minor). Tous corriges via B + Agent C. Documente.
6. **Re-execution** : si Phase 2 demarre > 3 mois apres 2026-04-15, re-fetch les standards pour confirmer qu'aucun n'a ete revise (notamment ISO/IEC 22989 Amd 1 Generative AI en draft).

## Prochaine etape

**Phase 1.3** — Specifying research questions : formulation des questions PICOC pour chaque decision du domaine, avec double extraction et verification. Le corpus candidat de 13 decisions ci-dessus sera **valide, raffine, et eventuellement etendu** par les reviewers A et B sur la base du scope defini dans ce fichier.
