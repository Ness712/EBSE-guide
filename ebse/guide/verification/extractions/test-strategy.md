# Double Extraction — PICOC test-strategy

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0 §2.1 — double extraction independante
**Agent A** : mots-cles : "test pyramid Mike Cohn agile unit integration E2E", "SWEBOK software testing levels unit integration system acceptance", "ISO IEC IEEE 29119 test process standard", "Continuous Delivery deployment pipeline testing Humble Farley", "shift-left testing DevOps regression detection"
**Agent B** : mots-cles : "testing trophy Kent Dodds integration confidence maintenance", "DORA State of DevOps automated testing CI Definition of Done", "ROI test automation GUI empirical study", "static TypeScript linting zero cost defect detection", "IEEE shift-left testing DevOps 2024"

---

## PICOC

```
P  = Equipes developpement et agents IA gerant une codebase evolutive
I  = Definir et appliquer une strategie de test globale (test pyramid, types de tests, couverture)
C  = Tests ad hoc sans strategie formalisee, couverture insuffisante ou mal repartie
O  = Maintenabilite/Testabilite, detection precoce des regressions, confiance au deploiement
Co = Applications web (toutes stacks) — universel
```

---

## Comparaison des extractions

| # | Source | Agent A | Agent B | Accord inclusion ? | Note |
|---|--------|---------|---------|:-----------------:|------|
| 1 | SWEBOK v4 IEEE — Ch.5 Software Testing | Inclus niv.1 | Inclus niv.1 | ✓ | Source fondatrice niv.1 |
| 2 | ISO/IEC/IEEE 29119-2 — Test Processes | Inclus niv.1 | Inclus niv.1 | ✓ | Standard international niv.1 |
| 3 | Mike Cohn — Succeeding with Agile 2009 | Inclus niv.5 | Inclus niv.5 | ✓ | Inventeur pyramide |
| 4 | Martin Fowler — TestPyramid bliki 2012 | Inclus niv.5 | Inclus niv.5 | ✓ | Definition canonique |
| 5 | Ham Vocke (ThoughtWorks) — Practical Test Pyramid 2018 | Inclus niv.5 | Inclus niv.5 | ✓ | Anti-pattern ice cream cone |
| 6 | Kent C. Dodds — Testing Trophy 2018 | Inclus niv.5 | Inclus niv.5 | ✓ | Modele trophee frontend |
| 7 | DORA State of DevOps 2023+2024 | Inclus niv.4 | Inclus niv.4 | ✓ | N=39 000+ empirique |
| 8 | Humble & Farley — Continuous Delivery 2010 | Inclus niv.5 | Absent | divergence | A retenu, B juge absorbe par DORA |
| 9 | IEEE Shift-Left Testing DevOps 2024 | Absent | Inclus niv.3 | divergence | B retenu (peer-reviewed IEEE) |
| 10 | ArXiv 2019 — ROI GUI Test Automation | Absent | Inclus niv.3 | divergence | B retenu (ROI quantifie) |
| 11 | Kent C. Dodds — 2017 blog | Absent | Inclus niv.5 | divergence | Fusionne avec Dodds 2018 (meme auteur) |
| 12 | Crispin & Gregory — Agile Testing 2008 | Inclus niv.5 | Absent | divergence | Exclu — absorbe par Cohn |
| 13 | USF Thesis ROI Metrics | Absent | Inclus niv.3 | divergence | Exclu — these non peer-reviewed |

**Accord sur sources communes** : 7/7 → kappa sources communes = 1.0
**Divergences** : 6 sources — resolues voir section ci-dessous
**Accord recommandation** : 2/2 agents convergent sur la necessite d'une strategie multi-niveaux formalisee

---

## Resolution des divergences

**Humble & Farley 2010 (A-only)** : Inclus comme reference historique du pipeline CI/CD teste — non decompte separement dans GRADE car substance couverte par DORA empiriquement.

**IEEE Shift-Left Testing 2024 (B-only)** : Inclus — apport peer-reviewed IEEE 2024 sur DevOps context, complement methodologique a DORA (survey). Retient le principe operationnel shift-left en contexte CI.

**ArXiv ROI GUI automation 2019 (B-only)** : Inclus — quantifie le ROI (~250%, ~6 mois) que les sources praticiens ne font pas. Justifie l'investissement en tests automatises.

**Dodds 2017 vs 2018** : Fusionne en une seule source (meme auteur, meme concept — formulation 2018 retenue comme reference principale).

**Crispin & Gregory 2008 (A-only)** : Exclu — quadrants agile testing hors scope question pyramide/ratios ; absorbe par Cohn.

**USF Thesis (B-only)** : Exclu — these non peer-reviewed, ROI couvert par ArXiv 2019.

---

## Divergence notable : pyramide vs trophee

Agent A met en avant la pyramide (Cohn/Fowler) avec ratio oriente 70/20/10. Agent B met en avant le trophee (Dodds) avec integration comme priorite. Les deux agents reconnaissent que ce ne sont pas des modeles contradictoires :

- **Accord** : strategie multi-niveaux formalisee, tests statiques en couche zero, shift-left, integration dans la DoD
- **Divergence** : ratio relatif unit vs integration — pyramide favorise unit (backend-heavy) ; trophee favorise integration (frontend-heavy React/browser)
- **Resolution** : les deux modeles sont retenus comme complementaires selon le contexte. La recommandation principale affirme la structure, pas un ratio rigide.

---

## Analyse de sensibilite {#analyse-de-sensibilite}

| Source retiree | Score sans | Niveau sans | Changement ? |
|----------------|-----------|------------|:------------:|
| SWEBOK v4 (niv.1) | 5 (depart 3, +1 conv, +1 effet, -1 indirect — ISO 29119 maintient niv.1) | [STANDARD] | NON — ISO 29119 maintient le niveau 1 |
| ISO/IEC/IEEE 29119-2 (niv.1) | 5 (depart 3, +1 conv, +1 effet, -1 indirect — SWEBOK maintient niv.1) | [STANDARD] | NON — SWEBOK maintient le niveau 1 |
| Les deux sources niv.1 simultanement | 3 (depart 2, +1 conv, +1 effet, -1 indirect — niv.4 DORA est la source la plus haute) | [RECOMMANDE] | OUI — degrade d'un niveau |
| DORA 2023+2024 (niv.4) | 4 (depart 4, +1 conv, -1 indirect — perd +1 effet grande echelle) | [RECOMMANDE] | OUI — perd le facteur "effet important" |
| Cohn (niv.5) | 5 (Fowler + Vocke + Dodds maintiennent la convergence niv.5) | [STANDARD] | NON |
| Fowler (niv.5) | 5 (Cohn + Vocke + Dodds maintiennent la convergence niv.5) | [STANDARD] | NON |
| Dodds (niv.5) | 5 (pyramide (Cohn/Fowler/Vocke) maintient la convergence niv.5) | [STANDARD] | NON |
| Toutes sources niv.5 simultanement | 4 (depart 4, +1 effet DORA, -1 indirect — perd +1 convergence) | [RECOMMANDE] | OUI — perd le facteur convergence |
| ArXiv ROI 2019 (niv.3) | 5 (DORA maintient l'effet grande echelle, ArXiv marginale dans GRADE) | [STANDARD] | NON |
| IEEE Shift-Left 2024 (niv.3) | 5 (DORA couvre la substance empirique) | [STANDARD] | NON |

**Conclusion : ROBUSTE** — [STANDARD] stable pour tout retrait individuel. Trois scenarios de downgrade : (1) retrait simultane des deux sources niv.1 → [RECOMMANDE] ; (2) retrait de DORA (seule source niv.4) → [RECOMMANDE] ; (3) retrait de toutes les sources niv.5 → [RECOMMANDE]. Les scenarios (1) et (2) sont peu plausibles : SWEBOK v4 et ISO 29119 sont des standards normatifs IEEE stables ; DORA est un programme de recherche Google continu avec 10+ annees de donnees. La robustesse [STANDARD] est confirmee : double couverture niv.1 + DORA N=39 000+ + convergence 4 experts reconnus.

---

## Recherche systematique

Bases consultees pour ce PICOC :
- Standards internationaux : IEEE (SWEBOK v4, IEEE 29119-2), ISO catalog
- Consortiums ouverts : aucun applicable directement (testing strategy = domaine praticien/academique)
- Documentation officielle : martinfowler.com, kentcdodds.com, dora.dev
- Enquetes grande echelle : DORA State of DevOps 2023+2024 (N=39 000+)
- Academique : arXiv (cs.SE), IEEE Xplore
- Experts reconnus : Cohn, Fowler, Vocke/ThoughtWorks, Dodds, Humble & Farley

Mots-cles derives du PICOC (strategie globale + pyramide/ratios + confiance deploiement + cout maintenance).
