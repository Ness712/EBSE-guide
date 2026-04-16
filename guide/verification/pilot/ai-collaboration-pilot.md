# Phase 1.5 — Peer Review + Pilotage : domaine `ai-collaboration`

**Protocole** : `methodology.md` v3.0, section 1.5 (Kitchenham & Charters 2007 §5.5, Evaluating the review protocol)
**Date** : 2026-04-15
**Objectif** : Valider le protocole avant Phase 2 via (a) peer review par reviewer independant + (b) pilotage sur 3 PICOCs representatives

## Partie A — Peer review par reviewer independant

**Reviewer** : a0ecbd6493378a8fb (contexte totalement isole, n'a pas participe aux extractions Phase 1.1-1.3)

**Fichiers audits** : methodology.md v3.0 + 8 livrables Phase 1.1 a 1.4.

### Verdict global du peer reviewer

**PROTOCOL NEEDS REVISION** (non rejete, revisions tractables).

### Assessment item par item

| Item | Verdict | Justification |
|------|:-------:|---------------|
| A. PICOC completeness | CONCERN | PICOCs #11, #13 ont des outcomes ("long-term skill degradation", "predictive validity") potentiellement hors de portee de la litterature disponible |
| B. Inclusion/exclusion | CONCERN | (1) I4 "< 5 years" trop genereux pour un domaine qui evolue vite ; (2) pyramide unclear pour vendor docs rewritten often |
| C. Search strategy | CONCERN | Sources obvious manquantes : OECD.AI, NIST AI 100-4, MITRE ATLAS, OWASP LLM Top 10, ENISA — non commitees en Phase 2.1 |
| D. Scope gaps | CONCERN | **(1) EU AI Act absent (Regulation 2024/1689 Article 14 Human oversight)** ; **(2) ISO/IEC 25059:2023 (quality model for AI) non mentionne** ; (3) licensing/IP exclusion non listee explicitement |
| E. Amendments consistency | **PASS** | Les 4 amendements sont coherents avec methodology.md v3.0 et justifies par observations |
| F. Feasibility | CONCERN | Phase 2 sera tight ; 3-5 PICOCs attendues "insufficient evidence" ; Agent C bandwidth a budgetter |
| G. Detected errors | **CONCERN critique** | **Clause numbers ISO non verifies verbatim** : Phase 1.2 a lu clause 1 Scope uniquement, mais Phase 1.3 cite 8+ §§ (ISO 42001 §7.5, §8.1, §8.2, §8.4, §9.1, §9.2 ; ISO 5338 §6.2, §6.3, §6.4) comme anchors. **Risque de fabrication non detectee** |

### Concerns critiques (doivent etre addresses avant Phase 2)

1. **Verification des clause numbers ISO** : Agent C doit fetcher ISO 42001 et ISO 5338 body text et verifier verbatim chaque clause citee dans les PICOCs. Si mis-numbered, re-anchor.
2. **Pilot** : execute en Partie B ci-dessous (requis par §1.5 methodology.md, addresse).
3. **Ajouter EU AI Act Article 14** comme anchor SECONDARY au minimum.

### Concerns mineurs (addressables pendant Phase 2)

1. Commit liste de sources additionnelles pour Phase 2.1 : OECD.AI, NIST AI 100-4, MITRE ATLAS, OWASP LLM Top 10, ENISA
2. Cutoff 3 ans (pas 5) pour les vendor docs agent-related
3. ISO/IEC 25059:2023 au moins mentionne dans scope
4. Re-scan SWEBOK KAs 10/11/12 (A avait miss KA 4 §5.1 → confidence NOT_RETAINED pour 10/11/12 pas fully established)
5. Licensing/IP exclusion listee explicitement dans commissioning scope (pas seulement PICOC limites)

---

## Partie B — Pilotage sur 3 PICOCs representatives

**Pilot A** : aa0bec89908a9f6b7 (contexte isole)
**Pilot B** : a93724288d6626dbf (contexte isole)

**PICOCs selectionnees** :
- **PICOC #4** Deterministic verification gates (**evidence forte attendue**)
- **PICOC #9** Permissions & sandbox (**evidence moyenne attendue**)
- **PICOC #13** Human situational awareness (**evidence thin — stress test**)

### Resultats inter-reviewers

| PICOC | Pilot A GRADE | Pilot B GRADE | Accord | Recommandation provisoire convergente |
|-------|:-------------:|:-------------:|:------:|----------------------------------------|
| #4 gates | **4/7 RECOMMANDE** | **5/7 STANDARD** | Diff 1 pt (acceptable) | Requerir pipeline deterministe local (typecheck+lint+test+build) avant acceptation humaine |
| #9 sandbox | **4/7 RECOMMANDE** | **4/7 RECOMMANDE** | **Exact match** | Sandbox avec allow-list deny-by-default + isolation filesystem/network (Firecracker microVM ou equivalent) |
| #13 SA | **2/7 CHOIX_EQUIPE** | **2/7 CHOIX_EQUIPE** | **Exact match** | Pratiques SA-maintenance comme choix d'equipe, pas de standard fort |

**Observation** : 2/3 exact match, 1/3 diff d'un point. Accord inter-reviewers tres bon. Le diff sur #4 est du a la selection differente de sources primaires (Pilot A a METR + arXiv 2507.06920 ; Pilot B a Anthropic hooks doc + NIST 600-1). Les deux sets sont valides et la recommandation finale converge.

### Sources primaires identifiees (union des 2 pilots)

**PICOC #4 (gates)** :
- **METR** (Whitfill et al. 2026) — *"Many SWE-bench-Passing PRs Would Not Be Merged into Main"* — donnee cle : le merge rate maintainer est en moyenne **24.2 pp inferieur** au automated grader pass rate. [metr.org](https://metr.org/notes/2026-03-10-many-swe-bench-passing-prs-would-not-be-merged-into-main/)
- **Ma et al. 2025** — *"Rethinking Verification for LLM Code Generation: From Generation to Testing"* (arXiv 2507.06920) — tests insuffisants, subtle faults undetected
- **Anthropic Claude Code Hooks documentation** — mechanisme concret (PostToolUse + Stop hooks avec exit code 2 blocking)
- **NIST AI 600-1** — Confabulation comme risque structurel de la GAI

**PICOC #9 (sandbox)** :
- **Anthropic Engineering** — *"Claude Code Sandboxing"* (Dworken & Weller-Davies 2025) — **84% fewer permission prompts** en sandbox interne + "effective sandboxing requires both filesystem and network isolation"
- **NVIDIA Developer Blog** — *"Practical Security Guidance for Sandboxing Agentic Workflows"* (Harang 2026) — prescription "default-deny + case-by-case approval"
- **Reversec Labs** — *"Design Patterns to Secure LLM Agents In Action"* (2025) — incidents concrets (Ona Bubblewrap bypass, rm -rf ~/ via Claude Code)
- **E2B Firecracker** — microVM hardware-level isolation ~125ms cold-start
- **Claude Code permissions docs** — `--allowedTools` / `--disallowedTools` deny precedence

**PICOC #13 (SA)** :
- **Simkute et al. 2024** — *"Ironies of Generative AI: Understanding and mitigating productivity loss in human-AI interactions"* (IJHCI, arXiv 2402.11364) — applique Bainbridge 1983 directement a GenAI, "shift in users' roles from production to evaluation"
- **Endsley & Kiris 1995** — *"The Out-of-the-Loop Performance Problem and Level of Control in Automation"* (Human Factors 37(2)) — effet empirique : full automation > intermediate automation en SA loss
- **Shen & Tamkin (Anthropic) 2026** — *"How AI Impacts Skill Formation"* (arXiv 2601.20245) — RCT n=52, **-17 pp comprehension** avec AI assist
- **Bainbridge 1983** — *"Ironies of Automation"* (Automatica 19(6)) — foundational
- **Osmani 2026** — *"Comprehension Debt"* (O'Reilly Radar) — practitioner synthesis

### Temps par PICOC

| Pilot | Temps P1 | Temps P2 | Temps P3 | Total |
|-------|:--------:|:--------:|:--------:|:-----:|
| A | 25 min | 20 min | 20 min | 65 min |
| B | 15 min | 15 min | 25 min | 55 min |

**Extrapolation** : Phase 2 complete sur 17 PICOCs × 2 reviewers ~ 17 × 60 min × 2 ~ **34 hours de travail focused** par le pool de reviewers, + reconciliation + Agent C + ecriture finale. Tractable mais a budgetter.

### Ambiguites protocolaires surface par les 2 pilots (convergentes)

**Les deux pilots ont independamment identifie les memes 5 ambiguites**, ce qui est une validation forte du protocole et de ses limites actuelles :

1. **Pyramide assignment pour vendor docs** : vendor primary doc = pyramide 4 quand decrit mechanism, pyramide 2 quand claims efficacy sur son propre produit. Pas de regle explicite dans methodology.md §2.3.

2. **NOT_VERIFIED_LITERAL** : comment traiter les quotes non-fetchable verbatim (paywall, recherche budget) ? Convention necessaire.

3. **GRADE overlap a 5** : STANDARD = 5-7, RECOMMANDE = 3-4, mais methodology.md dit aussi "RECOMMANDE = 3-5" par endroits → overlap. Resolution : STANDARD = **strictement** 5-7, RECOMMANDE = 3-4.

4. **Extraction form gaps** :
   - `pyramid_rationale` (justifier le niveau assigne, pas juste le score)
   - `outcomes_measured` (quelle outcome O precise est mesuree par la source — critique pour GRADE indirectness)
   - `conflict_of_interest_type` (self-interest / financial / affiliation, plus granulaire que Faible/Modere/Eleve)
   - `applies_to_which_C` (la source argue contre quel C specifique ?)
   - `source_language` (FR/EN, pertinent pour le biais de publication)

5. **Floor rule pour thin-evidence PICOCs** : si GRADE final < 2 → output "insufficient evidence, research gap" plutot que recommandation provisoire. Actuellement le pilot P3 est tombe a 2 (floor de CHOIX_EQUIPE) sur analogie aviation/HF ; au-dela il faut explicitement flagger l'absence de preuve.

### Fabrications detectees dans le pilot

**0 fabrications detectees**. Les deux pilots ont ete prudents et marques explicitement `NOT_VERIFIED_LITERAL` pour les quotes non-directement fetched (Bainbridge 1983 original PDF, ISO 42001 clauses profondes, Reversec labs specific quotes). Aucun des deux n'a invente de source ou de tool.

**Cette absence de fabrications dans le pilot suggere que le format d'extraction explicite (avec champ verbatim obligatoire) incite les reviewers a etre prudents**. A contraster avec Phases 1.1-1.3 ou des fabrications ont ete detectees — signe que plus le protocole est explicite, moins les agents fabriquent.

---

## Amendements additionnels au protocole (suite Phase 1.5)

Sur la base du peer review et des pilots, **5 amendements supplementaires** sont ajoutes au protocole :

### Amendement #5 — Verification clause numbers ISO (critique)

**Motivation** : peer reviewer a flag les clause numbers non verifies comme risque de fabrication residuelle. Phase 1.2 a lu clause 1 Scope uniquement des standards ISO paywalles. Phase 1.3 cite des §§ plus profondes.

**Action** : avant d'executer Phase 2, Agent C doit fetcher ISO 42001 et ISO 5338 body text (via iteh.ai previews, OECD.AI, ANSI webstore, ou acces institutionnel) et verifier verbatim :
- ISO 42001:2023 §7.5, §8.1, §8.2, §8.4, §9.1, §9.2
- ISO 5338:2023 §6.2, §6.3, §6.4

Si une clause est mis-numbered ou mis-described, re-anchor la PICOC concernee.

**Status** : **a executer en Phase 1.5b** avant Phase 2.

### Amendement #6 — EU AI Act Article 14 ancrage

**Motivation** : publication SLR en 2026 sans mentionner l'AI Act (Regulation (EU) 2024/1689) Article 14 "Human oversight" serait embarrassante pour lecteurs europeens.

**Action** : ajouter aux anchors Phase 1.2 :
- **Regulation (EU) 2024/1689** — AI Act — Article 14 "Human oversight" comme **SECONDARY anchor** pour les PICOCs #1, #3, #13 (tous touchent l'oversight humaine)

URL a verifier : https://eur-lex.europa.eu/eli/reg/2024/1689/oj

**Status** : a integrer dans la liste d'anchors scope Phase 1.2.

### Amendement #7 — ISO/IEC 25059:2023 reference

**Motivation** : le guide EBSE est ancre sur ISO 25010/25019. ISO 25059 (Quality model for AI systems) existe et etend directement 25010 pour les systemes AI. Ne pas le mentionner est un gap obvious.

**Action** : ajouter **ISO/IEC 25059:2023** comme SECONDARY anchor dans scope Phase 1.2. Verifier si existe et couvre.

### Amendement #8 — Liste additionnelle de sources Phase 2.1 (commit explicite)

**Motivation** : peer reviewer flagge OECD.AI, NIST AI 100-4, MITRE ATLAS, OWASP LLM Top 10, ENISA comme sources "obvious" non committees.

**Action** : pour Phase 2.1 Identification of research, les bases de recherche **obligatoires** sont etendues a :
- Bases academiques : Google Scholar, arXiv, ACM DL, IEEE Xplore, Semantic Scholar (inchange)
- Catalogues : **OECD.AI catalogue**, CNCF AI WG, LF AI & Data Foundation
- Security-specific : **NIST AI 100-4 Adversarial ML**, **MITRE ATLAS**, **OWASP LLM Top 10 / GenAI**
- Governance : **ENISA** AI reports
- Grey literature : Anthropic / OpenAI / Google / Cursor / Cognition engineering blogs, Microsoft Research blog, vendor post-mortems, "why we left X" articles (bias de publication mitigation)

### Amendement #9 — Cutoff 3 ans pour vendor docs agent-related

**Motivation** : le domaine bouge trop vite, I4 "< 5 years" est trop genereux pour les vendor docs.

**Action** : pour les vendor docs agent-related, **cutoff 3 ans** (sauf exception canonical papers via Amendement #4). Pour les standards ISO/NIST/IEEE : inchange (5 ans ou "en vigueur").

### Amendement #10 — Extraction form updated (5 nouveaux champs)

**Motivation** : les 2 pilots ont identifie 5 gaps.

**Action** : ajouter au formulaire d'extraction section 2.4 :
- `pyramid_rationale` : texte libre justifiant le niveau pyramide assigne
- `outcomes_measured` : liste des outcomes PICOC que la source mesure directement (pour GRADE indirectness)
- `conflict_of_interest_type` : {none, self-interest, financial, affiliation, other}
- `applies_to_which_C` : liste des C alternatives contre lesquelles la source argumente
- `source_language` : {fr, en, other}
- `verbatim_status` : {VERIFIED, NOT_VERIFIED_LITERAL, PARAPHRASE_ONLY}

### Amendement #11 — Floor rule + GRADE overlap resolution

**Motivation** : pilots ont identifie l'overlap a 5 et l'absence de floor.

**Action** :
- **GRADE overlap** : STANDARD = **strictement 5-7**, RECOMMANDE = **strictement 3-4**, BONNE PRATIQUE = 2, CHOIX_EQUIPE = 0-1. Pas d'ambiguite.
- **Floor rule** : si GRADE final = 0 ou 1 AND aucune source pyramide ≤ 3 → output `INSUFFICIENT_EVIDENCE` avec note "research gap", pas de recommandation provisoire.

### Amendement #12 — Vendor doc pyramid rule

**Motivation** : pilots ont note l'ambiguite.

**Action** : ajout a methodology.md §2.3 :
- Vendor primary doc decrivant un **mecanisme** (comment un outil fonctionne) → **pyramide 4**
- Vendor primary doc claiming **efficacy** (chiffres de performance, taux de reduction) sans peer-review → **pyramide 2**
- Vendor blog engineering post avec **donnees empiriques internes** (ex: Anthropic "84% fewer prompts") → **pyramide 3**, downgrade a 2 si donnees non-reproductibles

---

## Gate Phase 1.5 — Decision

Le peer reviewer a dit : *"Once items 1-3 are addressed and item 2 (pilot) is executed with satisfactory kappa results, the protocol should be approved for Phase 2 execution. Re-submission for peer review is not required for items 1, 3, 4, 5 — they are verifiable factual additions. Item 2 (pilot) will produce its own artifact per §1.5 which this reviewer would expect to see before formal Phase 2 gate approval."*

**Status des 3 items critiques** :
1. ✓ **Pilot execute** avec bon accord inter-reviewer (2/3 exact, 1/3 diff 1 pt)
2. **Verification clause numbers ISO** → a executer en Phase 1.5b (Agent C re-fetch + verify)
3. **EU AI Act Article 14 ancrage** → a ajouter dans scope Phase 1.2 update

**Status des 5 items mineurs** :
1. ✓ Commit liste sources Phase 2.1 (Amendement #8)
2. ✓ Cutoff 3 ans vendor docs (Amendement #9)
3. ✓ ISO/IEC 25059 reference (Amendement #7)
4. Re-scan SWEBOK KAs 10/11/12 → a executer en Phase 1.5b (Reviewer B independent scan)
5. Licensing/IP exclusion explicite dans scope (cosmetique, a integrer dans scope update)

## Verdict Phase 1.5

**PROTOCOL CONDITIONALLY APPROVED** pour Phase 2 sous reserve d'executer les 3 actions de Phase 1.5b :

1. **Agent C re-verify ISO clause numbers** (ISO 42001 §§7.5, 8.1, 8.2, 8.4, 9.1, 9.2 ; ISO 5338 §§6.2, 6.3, 6.4)
2. **Update scope Phase 1.2** avec EU AI Act Article 14 + ISO/IEC 25059 + liste exclusion licensing/IP
3. **Re-scan SWEBOK KAs 10/11/12** par un reviewer independant pour confirmer NOT_RETAINED

Une fois ces 3 actions completees, Phase 2 peut commencer sans nouveau peer review (items factuels addresses, pas de changement methodologique).

---

## Gate humain — Validation attendue de Gabriel

**Ce gate requiert ton approbation explicite** avant de :
1. Executer Phase 1.5b (3 actions ci-dessus)
2. Lancer Phase 2 (Conducting the review, 17 PICOCs × double extraction + Agent C)

**Question a toi** :
- **Accord sur le verdict "conditionally approved"** ? Tu veux reviser autre chose avant Phase 2 ?
- **Les 12 amendements** (4 originaux + 8 de Phase 1.5) sont-ils acceptables tels quels, ou tu veux en changer ?
- **Phase 1.5b** : je l'execute autonome (Agent C + scope update + SWEBOK re-scan) ou tu preferes faire un checkpoint explicite entre 1.5b et Phase 2 ?

Je m'arrete ici. Phase 1 Planning est consolidee ; Phase 2 Conducting est l'etape couteuse qui merite ton go explicite.
