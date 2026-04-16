# Double Extraction — Phase 1.2 : Scope `ai-collaboration`

**Date** : 2026-04-15
**Protocole** : methodology.md v3.0, section 1.2 (Kitchenham & Charters 2007 §5.2, Commissioning)
**Agent A** : a610699bf4b0b76ea (contexte independant)
**Agent B** : a673e5d4e62d0f2ce (contexte independant)
**Agent C (verificateur)** : aa756ca0d0e309ad2 (contexte independant)
**Superviseur** : Claude Opus 4.6 (reconciliation)

## Objectif

Etape 1.2 du protocole : definir le scope du nouveau domaine `ai-collaboration` en identifiant les standards internationaux et les sections SWEBOK v4 a ancrer, avec evidence verbatim. Liste de candidats **fixee** par le superviseur (contrairement a Phase 1.1) pour eliminer la divergence de corpus.

## Corpus candidat (fixe pour A et B)

**Standards** (11) : ISO/IEC 22989:2022, 23894:2023, 42001:2023, 5338:2023, TR 5469:2024, TR 24028:2020, NIST AI 100-1, NIST AI 600-1, IEEE 7000-2021, ISO/IEC/IEEE 12207:2017, 15288:2023.

**SWEBOK v4 KAs** (8) : KA 4 Construction, KA 5 Testing, KA 6 Operations, KA 9 Management, KA 10 Process, KA 11 Models & Methods, KA 12 Quality, KA 14 Professional Practice.

## Comparaison A vs B (verdicts retain)

| # | Standard | A retain | B retain | Accord |
|---|----------|:--------:|:--------:|:------:|
| 1 | ISO/IEC 22989:2022 | SECONDARY | SECONDARY | ✓ |
| 2 | ISO/IEC 23894:2023 | **PRIMARY** | **PRIMARY** | ✓ |
| 3 | ISO/IEC 42001:2023 | **PRIMARY** | SECONDARY | ✗ |
| 4 | ISO/IEC 5338:2023 | **PRIMARY** | **PRIMARY** | ✓ |
| 5 | ISO/IEC TR 5469:2024 | SECONDARY | NOT_RETAINED | ✗ |
| 6 | ISO/IEC TR 24028:2020 | SECONDARY | SECONDARY | ✓ |
| 7 | NIST AI 100-1 | **PRIMARY** | **PRIMARY** | ✓ |
| 8 | NIST AI 600-1 | **PRIMARY** | **PRIMARY** | ✓ |
| 9 | IEEE 7000-2021 | NOT_RETAINED | SECONDARY | ✗ |
| 10 | ISO/IEC/IEEE 12207:2017 | SECONDARY | SECONDARY | ✓ |
| 11 | ISO/IEC/IEEE 15288:2023 | SECONDARY | SECONDARY | ✓ |

**Accord brut standards** : 8/11 = **72.7%** (> 60%, acceptable mais perfectible). Divergences : ISO 42001, TR 5469, IEEE 7000.

| # | SWEBOK KA | A retain | B retain | Accord |
|---|-----------|:--------:|:--------:|:------:|
| 4 | Software Construction | NO | **PRIMARY** | ✗ |
| 5 | Software Testing | SECONDARY | **PRIMARY** | ✗ |
| 6 | SE Operations | NO | SECONDARY | ✗ |
| 9 | SE Management | SECONDARY | **PRIMARY** | ✗ |
| 10 | SE Process | NO | SECONDARY | ✗ |
| 11 | Models & Methods | NO | NO | ✓ |
| 12 | Quality | NO | SECONDARY | ✗ |
| 14 | Professional Practice | SECONDARY | SECONDARY | ✓ |
| 16 §9.6 (hors liste) | Computing Foundations — AI & SE | SECONDARY | — | A seul |

**Accord brut KAs** : 2/8 = **25%** — divergence massive. Cause identifiee via Agent C : A a **mal lu certaines sections SWEBOK** et rate des passages directs (DIV-5, DIV-7).

## Verification Agent C (8 divergences testees)

Agent C a fetche chaque source contestee et quote verbatim pour trancher.

### DIV-1 : ISO/IEC 42001:2023 Scope — **A correct**

B avait lu la promo iso.org HTML ("world's first AI management system..."), pas la clause normative. A avait fetche le sample iteh.ai PDF et quote la clause 1 Scope. Agent C confirme verbatim :

> "This document specifies the requirements and provides guidance for establishing, implementing, maintaining and continually improving an AI (artificial intelligence) management system within the context of an organization. [...] This document is intended to help the organization develop, provide or use AI systems responsibly in pursuing its objectives..."

**Resolution** : ISO 42001:2023 → **PRIMARY** (A correct). Retain verbatim scope de A.

### DIV-2 : ISO/IEC 5338:2023 Scope — **Both correct, A fuller**

Agent C confirme la version longue de A, incluant :

> "These processes can also be used within an organization or a project when developing or acquiring AI systems. When an element of an AI system is traditional software or a traditional system, the software life cycle processes in ISO/IEC/IEEE 12207 and the system life cycle processes in ISO/IEC/IEEE 15288 can be used to implement that element."

**Resolution** : ISO 5338:2023 → **PRIMARY** (accord). Retain quote fuller de A (la phrase qui pointe vers 12207/15288 est importante car elle justifie le maintien de ces baseline standards en SECONDARY).

### DIV-3 : NIST AI 100-1 MAP 3.5 et Appendix C — **A correct**

Agent C confirme verbatim dans le PDF NIST :

> "MAP 3.5: Processes for human oversight are defined, assessed, and documented in accordance with organizational policies from the GOVERN function."
>
> "Appendix C: AI Risk Management and Human-AI Interaction 40"

**Resolution** : NIST AI 100-1 → **PRIMARY**. HITL coverage = **DIRECT** (non PARTIAL comme B prudemment scored). Retain verbatim A.

### DIV-4 : NIST AI 600-1 — **Both correct, merge**

Agent C confirme **les deux** quotes. A a quote Appendix A.1.2 avec "code generation and review" comme cas d'usage GAI. B a trouve la section 2.7 "Human-AI Configuration" dans le TOC. Les deux sont verbatim dans le PDF. **Merge des deux** dans le livrable final.

**Resolution** : NIST AI 600-1 → **PRIMARY** (top anchor). Citer les deux quotes (A : "code generation and review" ; B : "§2.7 Human-AI Configuration").

### DIV-5 : SWEBOK KA 4 §5.1 — **B correct, A MISSED (critique)**

C'est la divergence la plus importante. A a conclu que KA 4 Construction n'avait pas de contenu AI-specific ("no verbatim mention of AI-assisted coding or LLM agents in the Construction KA chapter"). B a trouve la quote. Agent C confirme verbatim p. 4-14/4-15 :

> "Moreover, modern IDEs are often equipped with AI-assisted programming which is boosted by the recent advances in Large Language Models (LLMs). With the support a programmer can define a function in pseudo-code comments or outline its implementation as a prompt for an LLM to generate or complete the code. **The programmer lets the LLM complete many of the details, but still reviews the generated code and integrates it into their project.**"

**Impact** : c'est **la** quote SWEBOK la plus directement alignee avec notre topic. Le dernier sentence decrit verbatim le modele manager-delegation (developer outlines → LLM generates → developer reviews). A a fait un **miss majeur** — si seul A avait extrait, cette evidence cle aurait ete perdue.

**Resolution** : KA 4 Software Construction → **PRIMARY** (B correct). Retain verbatim de B. Note : Section correcte est "Chapter 4, §5.1 Development Environments", pas KA 4 §5.1 generique.

### DIV-6 : SWEBOK KA 9 — **A correct, FABRICATION B**

A a quote *"in case of AI-based software, new SLDCs maybe required to manage the complexity brought by AI to the software"*. B a quote la meme phrase avec un ajout : *"different types or new SDLCs"*. Agent C verifie verbatim et confirme que **"different types or" n'existe pas dans le source**.

**Verbatim correct** (spanning p. 9-5 → 9-6) :
> "The complexity of the end-to-end DevSecOps tools and of using emerging technologies such as artificial intelligence (AI) and machine learning (ML) to leverage those tools adds another dimension [15]. For example, Agile and DevOps approaches are reasonably well-established, but in case of AI-based software, new SLDCs maybe required to manage the complexity brought by AI to the software."

(Typos "SLDCs" et "maybe" sont dans le source original — conserves verbatim.)

**Impact** : fabrication mineure de B (ajout de 3 mots). Detectee par A+C. Le protocole double extraction fait son travail.

**Resolution** : KA 9 SE Management → **PRIMARY** (accord apres suppression de la fabrication B). Retain verbatim de A.

### DIV-7 : SWEBOK KA 5 §7.2 — **B correct, A under-reported**

A a quote seulement §7.1 (Testing of AI). B a quote §7.1 **et** §7.2 ("Testing Through Emerging Technologies" — AI/ML utilisees **pour** tester). Agent C confirme que §7.2 existe verbatim :

> "7.2. Testing Through Emerging Technologies"
> "Testing through ML [13]: AI, ML or DL techniques are successfully used to reduce the effort involved in several activities in software engineering..."

**Resolution** : KA 5 Software Testing → **PRIMARY** (B correct). Les deux cotes du loop sont relevantes : (1) tester les systemes AI (§7.1), (2) utiliser AI pour tester (§7.2). Retain quotes de B pour les deux sections.

### DIV-8 : SWEBOK KA 16 §9.6 — **A correct (bonus finding)**

A a surface KA 16 §9.6 "AI and Software Engineering" qui n'etait **pas dans la liste fixe** de 8 KAs. Agent C confirme verbatim p. 16-27/16-28 :

> "Software engineering and AI are mutually related to each other in basically two ways: AI applications in software engineering (i.e., AI for SE) and software engineering for AI systems (i.e., SE for AI). AI for SE aims to establish efficient ways of building high-quality software systems by replicating human developers' behavior..."

**Resolution** : KA 16 §9.6 → **SECONDARY** (hors de la liste fixe initiale, mais verbatim DIRECT sur notre scope). A bien fait de surface cet element. Retain comme bonus anchor.

## Scope reconcilie — standards

### PRIMARY (5 anchors)

1. **ISO/IEC 5338:2023** — AI system life cycle processes. Bridge 12207/15288 → AI. Justifie que notre scope herite transitivement des baselines classiques.
2. **ISO/IEC 42001:2023** — Management system (certifiable). Couche controles organisationnels / accountability.
3. **ISO/IEC 23894:2023** — Guidance risk management. Couche evaluation de risque → ou placer les gates humaines.
4. **NIST AI 100-1 (AI RMF 1.0)** — Free, GOVERN-MAP-MEASURE-MANAGE + MAP 3.5 human oversight + Appendix C Human-AI Interaction. Couche operationnelle.
5. **NIST AI 600-1 (GAI Profile)** — Free, 2024, cite verbatim "code generation and review" comme cas d'usage GAI + §2.7 "Human-AI Configuration". **Top anchor topologiquement**.

### SECONDARY (6 anchors, cite seulement)

- **ISO/IEC 22989:2022** — Terminology (human-in-the-loop vocabulary)
- **ISO/IEC TR 24028:2020** — Trustworthiness overview (largely superseded by 23894 + 42001)
- **ISO/IEC/IEEE 12207:2017** — Software life cycle baseline (herite via 5338)
- **ISO/IEC/IEEE 15288:2023** — System life cycle baseline (herite via 5338)
- **IEEE 7000-2021** — Ethics process (generic ; SECONDARY plutot que NOT_RETAINED pour permettre referencement si une PICOC ethique emerge en 1.3)
- **ISO/IEC TR 5469:2024** — Functional safety (safety-critical, **downgrade** de A SECONDARY et B NOT_RETAINED vers SECONDARY "cite only when safety-critical delegation is discussed" — regle conservative : retain comme reference disponible)

### NOT_RETAINED

Aucun standard exclu totalement. Rationale : tous les standards candidats verifies ont au moins une relevance PARTIAL et pourraient etre cites dans une PICOC particuliere.

## Scope reconcilie — SWEBOK v4

### PRIMARY (3 KAs + 1 bonus hors liste)

1. **KA 4 Software Construction, Chapter 4 §5.1 Development Environments** (p. 4-14/4-15)
   - Verbatim : description du modele manager-delegation (developer outlines → LLM generates → developer reviews).
   - **Retain comme evidence cle** (DIV-5, B correct, A MISSED — important pour memoire).

2. **KA 5 Software Testing, §7.1 et §7.2** (p. 5-26/5-27)
   - §7.1 Testing of Emerging Technologies (tester les systemes AI).
   - §7.2 Testing Through Emerging Technologies (AI utilise pour tester — pertinent pour "gates deterministes" dans notre scope).

3. **KA 9 SE Management, Introduction** (p. 9-5/9-6)
   - Verbatim : "in case of AI-based software, new SLDCs maybe required to manage the complexity brought by AI to the software". Justifie directement l'existence d'un nouveau domaine `ai-collaboration` dans le guide (nouvelles pratiques SDLC pour AI-based software).

4. **KA 16 Computing Foundations, §9.6 AI and Software Engineering** (p. 16-27/16-28) — *hors liste fixe mais retenu*
   - Verbatim distinction AI for SE vs SE for AI. Notre domaine est "AI for SE" (utiliser AI pour ecrire du SE).

### SECONDARY (2 KAs)

- **KA 14 Professional Practice** — codes d'ethique, responsabilite professionnelle. Support le "who is accountable when the agent writes code".
- **KA 6 SE Operations** — Automation & DevOps, cite indirectement IaC/SRE automation. Pertinent si une PICOC sur "gates CI/CD pour output agent" emerge.

### NOT_RETAINED (3 KAs)

- **KA 10 SE Process**, **KA 11 Models & Methods**, **KA 12 Quality** — pas de verbatim AI-specific surface par les reviewers. A reconfirmer en Phase 1.3 si une PICOC le necessite.

## Journal de decisions

| # | Date | Decision | Justification | Decideur |
|---|------|----------|---------------|----------|
| 1 | 2026-04-15 | Liste candidats fixee (11 std + 8 KAs) | Eliminer divergence corpus observee Phase 1.1 | Superviseur |
| 2 | 2026-04-15 | ISO 42001 → PRIMARY | DIV-1 : A correct via verbatim scope iteh.ai | Agent C |
| 3 | 2026-04-15 | Retain quote 5338 fuller | DIV-2 : phrase 12207/15288 importante pour scope transitif | Agent C |
| 4 | 2026-04-15 | NIST 100-1 HITL = DIRECT | DIV-3 : verbatim MAP 3.5 confirme par C | Agent C |
| 5 | 2026-04-15 | KA 4 → PRIMARY (etait NO chez A) | DIV-5 : A a MISSED le passage cle LLM+review, B correct | Agent C |
| 6 | 2026-04-15 | KA 9 retain A wording | DIV-6 : B a fabrique "different types or" | Agent C |
| 7 | 2026-04-15 | KA 5 §7.2 ajoute | DIV-7 : A under-reported | Agent C |
| 8 | 2026-04-15 | KA 16 §9.6 retain SECONDARY | DIV-8 : bonus finding de A, hors liste fixe | Superviseur |
| 9 | 2026-04-15 | TR 5469 retain SECONDARY (vs NOT_RETAINED) | Regle conservative | Superviseur |

## Resultats agreges

- **Accord brut standards** : 8/11 = 72.7% (> 60%, acceptable)
- **Accord brut SWEBOK KAs** : 2/8 = 25% (< 60%, mais resolu par Agent C qui a demasque 2 misses de A et 1 fabrication de B)
- **Fabrications detectees par Agent C** : **1** (B sur DIV-6 KA 9, ajout de "different types or")
- **Misses detectes** : **2 par A** (DIV-5 KA 4 §5.1 LLM passage, DIV-7 KA 5 §7.2)
- **Bonus findings** : **1 par A** (DIV-8 KA 16 §9.6, hors liste fixe)

Le mecanisme A+B+C fonctionne : un reviewer a fabrique du contenu, l'autre en a manque, Agent C a detecte les deux. Aucune erreur n'est entree dans le livrable final.

## Limites documentees

1. **Abstracts ISO paywalles** : les scopes normatifs ont ete lus via mirrors iteh.ai et OECD.AI. Les full texts (Annex A controles ISO 42001, Annexes ISO 23894) ne sont pas verifies verbatim au-dela des scopes. Impact : coverage criteres (a)-(e) pour ces standards se base sur la clause 1 Scope uniquement, ce qui est probablement **conservateur** (scope est typiquement plus etroit que le corps normatif).
2. **SWEBOK v4** : A a lu 22 924 lignes en texte extrait mais a rate KA 4 §5.1 (pourtant verbatim direct). Cause probable : PDF extraction incomplete ou search terms mal calibres. Pour Phase 1.3+, ajouter instructions explicites aux reviewers pour fetch par section targeted plutot que full-text search.
3. **IEEE 7000-2021** : clause 1 Scope normative non fetch verbatim (IEEE Xplore paywall). Retain comme SECONDARY plutot que NOT_RETAINED, mais a verifier si une PICOC ethique emerge.
4. **A re-verifier** : si Phase 2 demarre > 3 mois apres 2026-04-15, re-fetch les standards pour confirmer qu'aucun n'a ete revise.

## Livrable final

Fichier scope reconcilie : `verification/commissioning/ai-collaboration-scope.md`

## Prochaine etape

Phase 1.3 — Specifying research questions (PICOC) : formulation des questions de recherche PICOC pour chaque decision du domaine, sur la base du scope ci-dessus. Double extraction A + B + C avec liste de decisions candidates fixee par superviseur.
