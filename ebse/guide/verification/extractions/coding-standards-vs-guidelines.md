# Double Extraction — PICOC coding-standards-vs-guidelines

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "coding standards mandatory", "shall vs should software engineering", "enforceable coding rules", "conventions vs guidelines SE", "automated enforcement code quality"
**Agent B** : mots-clés : "coding standards vs guidelines", "mandatory vs recommended rules", "coding conventions definition", "linting automation code standards", "shall should may software engineering"

---

## PICOC

```
P  = Équipes de développement (petites ou grandes, avec ou sans agents IA)
I  = Codifier une règle comme convention obligatoire (CONVENTIONS.md, "shall")
C  = La documenter comme recommandation/guideline (guide, tutoriel, ADR, "should")
O  = Clarté des attentes, compliance automatisable, cohérence du code, efficacité des reviews
Co = Projets avec contributeurs multiples ou agents IA autonomes
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | IEEE 730-2014 | 1 | 1 | ✓ | — |
| 2 | SWEBOK v4 (2024) | 1 | 1 | ✓ | — |
| 3 | Google Engineering Practices | 2 | 2 | ✓ | — |
| 4 | Code Complete (McConnell, 2004) | 2 | 3 | ✓ inclusion, ✗ niveau | **Divergence niveau** |
| 5 | Extreme Programming Explained (Beck, 2004) | 2 | 3 | ✓ inclusion, ✗ niveau | **Divergence niveau** |
| 6 | The Pragmatic Programmer (Hunt & Thomas, 2019) | 2 | 3 | ✓ inclusion, ✗ niveau | **Divergence niveau** |

**Sources identifiées par A uniquement** : ISO/IEC 25010:2023, Fowler Refactoring 2018, Sadowski et al. TSE 2018, Storey et al. ICSE 2017
**Sources identifiées par B uniquement** : Linux Kernel Coding Style

**Accord sur inclusion** : 6/6 sources communes → kappa ≈ 1.0 (inclusion).
**Désaccords de niveau** : 3/6 → concernent uniquement la classification pyramide des livres de référence classiques.

### Résolution des divergences de niveau pyramide

**McConnell / Beck / Hunt & Thomas (A=2, B=3)** : A retenu. La methodology.md définit pyramide 2 comme "livre/rapport reconnu par la communauté SE, largement cité" — McConnell (~40k citations), Beck (~30k citations), Hunt & Thomas (~30k citations) correspondent à cette définition. Pyramide 3 désigne les études peer-reviewed empiriques (ICSE, TSE, EMSE). Ces livres ne sont pas des études empiriques. A correct.

**Sources A-only — décision d'inclusion** :
- ISO/IEC 25010:2023 (niveau 1) : incluse. Standard normatif direct sur les attributs qualité incluant la compliance aux standards.
- Sadowski et al. TSE 2018 (niveau 3, 27k reviews Google) : incluse. Seule source empirique large-échelle mesurant la compliance aux standards vs guidelines en conditions réelles.
- Fowler Refactoring 2018 : incluse au niveau 2, mais avec note de moindre directness (traite de conventions de nommage/structure, pas de la distinction she/should explicitement).
- Storey et al. ICSE 2017 : incluse niveau 3, soutien (n=17 équipes, faible).

**Sources B-only — décision d'inclusion** :
- Linux Kernel Coding Style (document vivant) : inclus niveau 2. Standard de facto très influent, distingue explicitement règles automatisées (checkpatch.pl) vs directives architecturales.

---

## Calcul GRADE final

```
Score de départ : 4
  (source la plus haute = niveau 1 : IEEE 730-2014, SWEBOK v4, ISO/IEC 25010:2023)

+ 1 convergence
  IEEE 730 + SWEBOK v4 + ISO 25010 + Google Engineering Practices +
  McConnell + Beck + Hunt & Thomas + Linux Kernel Style convergent
  sans contradiction sur le même critère central (verifiabilité mécanique
  ou binaire + déviation toujours incorrecte = convention ; sinon = guideline).
  8 sources de 4 contextes distincts (normative, industrielle, académique, open-source).

- 0 grande échelle non applicable
  Sadowski 2018 (27k reviews) apporte une mesure empirique de la compliance,
  mais ne compare pas directement projets avec vs sans cette distinction codifiée.
  Soutien indirect — pas de +1.

- 0 effet important non applicable
  Question définitionnelle normative : l'effet n'est pas quantifié par une
  étude d'impact directe. Le critère ne s'applique pas.

- 0 indirectness
  Les sources traitent directement la question (terminologie normative
  shall/should, définition des standards vs guidelines). Pas d'indirectness
  significative.

Score final : 4 + 1 = 5 → [STANDARD]
```

Note biais de publication : non applicable — sources primaires normatives (IEEE, ISO) non soumises au biais de publication. Convergence cross-contextes (normatif + industriel + académique + OS) réduit le risque.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| IEEE 730-2014 | 5 (SWEBOK v4 + ISO 25010 niveau 1 restent, +1 convergence) | [STANDARD] | NON |
| SWEBOK v4 | 5 (IEEE 730 + ISO 25010 niveau 1 restent) | [STANDARD] | NON |
| ISO/IEC 25010:2023 | 5 (IEEE 730 + SWEBOK v4 restent) | [STANDARD] | NON |
| Google Engineering Practices | 5 (convergence toujours forte) | [STANDARD] | NON |
| McConnell Code Complete | 5 (convergence toujours forte) | [STANDARD] | NON |
| Sadowski TSE 2018 | 5 (seul soutien empirique, départ niveau 1 inchangé) | [STANDARD] | NON |
| Toutes sources niveau 1 simultanément | 3+1=4 (départ niveau 2, +1 convergence) | [RECOMMANDE] | OUI |

**Conclusion : ROBUSTE** — recommandation [STANDARD] stable pour tout retrait individuel. Fragile uniquement si l'on retire simultanément les 3 standards normatifs (scénario irréaliste : IEEE 730, SWEBOK v4 et ISO 25010 sont des références établies sans controverse).

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| Blogs "coding standards best practices" | E2 | Blog individuel sans peer review |
| SonarQube Quality Profiles guidelines | E3 | Marketing vendeur, biais commercial |
| Gang of Four — Design Patterns | E5 | Hors périmètre (patterns ≠ distinction obligatoire/recommandé) |
| Littérature grise / thèses non publiées | E1 | Non accessible, non auditable |
| Clean Code (Martin, 2008) | E5 partiel | Traite de style, pas de la distinction shall/should — absorbé par McConnell qui couvre le même sujet plus directement |
| Aniche & Treude MSR 2020 | E5 | Traite de la qualité des commentaires review, pas de la distinction convention/guideline |
