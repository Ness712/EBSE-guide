# Double Extraction — PICOC wcag-implementation

**Date** : 2026-04-17
**Protocole** : methodology.md v3.0
**Agent A** : mots-clés : "WCAG 2.1 AA implementation technical HTML semantics", "ARIA authoring practices guide W3C", "axe-core WCAG automated testing coverage", "keyboard navigation focus visible CSS accessibility", "React accessibility aria props htmlFor"
**Agent B** : mots-clés : "WCAG implementation focus trap modal dialog accessibility", "ARIA roles states properties practical guide", "axe-core playwright accessibility testing", "color contrast ratio WCAG 4.5:1 implementation", "skip to content link keyboard navigation pattern"

---

## PICOC

```
P  = Équipes de développement frontend (React / TypeScript)
I  = Implémenter techniquement les critères WCAG 2.1 AA :
     HTML sémantique, ARIA, navigation clavier, contrastes, tests automatisés
C  = Absence de pratiques d'accessibilité systématiques
O  = Conformité WCAG 2.1 AA, accessibilité effective, détection de régressions
Co = Applications web React avec shadcn/ui / Radix UI, CI avec Playwright
```

---

## Accord Reviewer A / Reviewer B

### Sources évaluées par les deux reviewers

| # | Source | Niveau A | Niveau B | Accord inclusion ? | Note divergence |
|---|--------|---------|---------|:-----------------:|-----------------|
| 1 | W3C WAI — ARIA Authoring Practices Guide (APG) 1.2 (2023) | 1 | 1 | ✓ | — |
| 2 | W3C — WCAG 2.1 — Success Criteria 1.4.3, 1.4.11, 2.1.1, 2.4.7 (2018) | 1 | 1 | ✓ | — |
| 3 | MDN Web Docs — Accessibility Guide (Mozilla, 2024) | 3 | 3 | ✓ | — |
| 4 | Deque Systems — axe-core WCAG Automation Coverage (2024) | 3 | 3 | ✓ | — |
| 5 | React Documentation — DOM Elements accessibility props (2024) | 3 | 3 | ✓ | — |
| 6 | WebAIM — Screen Reader User Survey | hors scope | hors scope | ✗ | **Accord exclusion** — données usage, pas guidance |
| 7 | WCAG 2.2 (2023) | absorbé | absorbé | ✗ | **Accord exclusion** — couvert dans wcag-level existant |
| 8 | Radix UI accessibility docs | 3 | 3 | ✗ | **Accord exclusion** — redondant avec APG + React docs |

**Sources identifiées par A uniquement** : aucune (convergence complète)
**Sources identifiées par B uniquement** : aucune (convergence complète)

**Accord sur inclusion des sources communes** : 5/5 → kappa ≈ 1.0 (inclusion)
**Désaccords d'inclusion** : 0/8 → accord complet A et B

### Résolution des divergences

Aucune divergence d'inclusion. Les deux agents A et B ont identifié les mêmes 5 sources à inclure avec le même niveau de preuve. Convergence parfaite sur l'ensemble du corpus.

---

## Calcul GRADE final

```
Score de départ : 4
  (source la plus haute = niveau 1 : W3C WAI APG 1.2 ET W3C WCAG 2.1 —
   deux sources normatives de niveau 1 indépendantes)

+ 1 convergence
  W3C WCAG 2.1 (niveau 1, standard normatif) + W3C WAI APG (niveau 1, guide normatif)
  + MDN Accessibility Guide (niveau 3) + Deque axe-core docs (niveau 3)
  + React documentation (niveau 3)
  convergent sans contradiction sur :
  - HTML sémantique d'abord, ARIA en dernier recours
  - Focus visible obligatoire (WCAG 2.4.7)
  - Contraste 4.5:1 texte normal, 3:1 grand texte et composants UI
  - Tests automatisés axe-core ~57% couverture, complétés par tests manuels
  5 sources indépendantes de 4 organisations (W3C, Mozilla, Deque, Meta/React)

- 0 nuance empirique (pas de malus)
  Les sources sont cohérentes. La limite de 57% de couverture automatique
  est documentée par Deque eux-mêmes et cohérente avec MDN et W3C APG.
  Pas de contradiction entre sources.

Score final : 4 + 1 = 5 → [STANDARD]
```

Note biais de publication : W3C WCAG 2.1 et APG sont des standards normatifs non soumis au biais de publication. MDN est maintenu par Mozilla avec révision communautaire. Deque est l'auteur d'axe-core — biais possible vers la mise en valeur de l'automatisation, atténué par leur propre documentation des limites (57%, pas 100%). React docs : biais possible vers l'écosystème React, hors scope limité aux props d'accessibilité standard.

---

## Analyse de sensibilité {#analyse-de-sensibilite}

| Source retirée | Score sans | Niveau sans | Changement ? |
|---------------|-----------|------------|:------------:|
| W3C WAI APG 2023 | 4+1=5 (WCAG 2.1 niveau 1 reste, convergence MDN+Deque+React maintenue) | [STANDARD] | NON |
| W3C WCAG 2.1 2018 | 4+1=5 (APG niveau 1 reste, convergence MDN+Deque+React maintenue) | [STANDARD] | NON |
| MDN Accessibility Guide | 4+1=5 (deux sources niveau 1, convergence Deque+React) | [STANDARD] | NON |
| Deque axe-core docs | 4+1=5 (deux sources niveau 1, convergence MDN+React) | [STANDARD] | NON |
| React Documentation | 4+1=5 (deux sources niveau 1, convergence MDN+Deque) | [STANDARD] | NON |
| Les deux sources niveau 1 simultanément | 2+1=3 (départ niveau 3, convergence MDN+Deque+React) | [RECOMMANDE] | OUI |

**Conclusion : ROBUSTE** — recommandation [STANDARD] stable pour tout retrait individuel. Le seul scénario de déclassement est le retrait simultané des deux sources normatives W3C (WCAG 2.1 et APG), ce qui est irréaliste : ces deux standards sont des références fondatrices stables et largement adoptées. La convergence de 5 sources indépendantes de 4 organisations différentes renforce la robustesse.

---

## Sources exclues

| Source | Critère | Raison |
|--------|---------|--------|
| WCAG 2.2 W3C Recommendation (2023) | E3 | Absorbé par WCAG 2.1 pour ce principe. Les critères supplémentaires (2.4.11, 2.5.8) sont couverts dans le principe wcag-level existant de ce fichier |
| ARIA in HTML W3C Note | E3 | Absorbé par APG 1.2 qui est plus complet et plus prescriptif sur les patterns d'interaction |
| WebAIM Screen Reader User Survey 2024 | E2 | Hors scope PICOC — données d'usage (quels lecteurs d'écran sont utilisés), pas guidance d'implémentation technique |
| Radix UI / shadcn/ui accessibility docs | E3 | Niveau 3 redondant — absorbé par React docs + APG. Mentionné en implémentation sans être source primaire |
| focus-trap-react README | E3 | Trop spécifique à une librairie. Mentionné comme exemple d'implémentation dans le texte du principe |
| Google Lighthouse accessibility docs | E3 | Absorbé par axe-core Deque (couverture WCAG plus détaillée, chiffre de couverture automatique documenté) |
| ISO 9241-171 Ergonomics accessibility | E3 | Redondant avec WCAG 2.1 pour le web. Moins prescriptif sur l'implémentation frontend |
| Blog posts accessibilité (≥5 sources) | E1/E3 | Niveau 5 redondant avec W3C APG + MDN. Pas d'apport différencié identifiable |
