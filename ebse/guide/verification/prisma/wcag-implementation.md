# PRISMA Flow — PICOC wcag-implementation

**Date de recherche** : 2026-04-17
**Bases interrogées** : W3C WAI (WCAG, APG), MDN Web Docs, Deque Systems (axe-core), React documentation, WebAIM, WebSearch général
**Mots-clés Agent A** : "WCAG 2.1 AA implementation technical HTML semantics", "ARIA authoring practices guide W3C", "axe-core WCAG automated testing coverage", "keyboard navigation focus visible CSS accessibility", "React accessibility aria props htmlFor"
**Mots-clés Agent B** : "WCAG implementation focus trap modal dialog accessibility", "ARIA roles states properties practical guide", "axe-core playwright accessibility testing", "color contrast ratio WCAG 4.5:1 implementation", "skip to content link keyboard navigation pattern"
**Protocole** : methodology.md v3.0 §2.1 — double extraction indépendante (Agents A + B, mots-clés différents) + synthèse Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiées par base (Agent A + Agent B combinés, avant déduplication) :
    - Standards normatifs W3C (WCAG 2.1, APG, ARIA spec) : ~8 résultats candidats
    - Documentation MDN / Mozilla : ~6 résultats candidats
    - Deque Systems / axe-core : ~5 résultats candidats
    - React documentation (react.dev) : ~4 résultats candidats
    - WebAIM surveys et guides : ~6 résultats candidats
    - Blog posts et articles accessibilité : ~14 résultats candidats
    - Snowballing backward : ~5 sources
  Total identifié (brut, combiné A+B) : ~48
  Doublons retirés (même source identifiée par A et B) : 5 (WCAG 2.1, APG, MDN, axe-core, React docs)
  Total après déduplication : ~43

SCREENING (titre + résumé)
  Sources screenées : ~43
  Sources exclues au screening : ~30
    - E1 (blog opinion sans données ou méthodologie) : ~12
    - E2 (hors scope PICOC — WCAG AAA, WCAG 3.0 draft, historique) : ~7
    - E3 (doublons partiels — couverts par standards W3C déjà inclus) : ~6
    - E4 (vendeur / marketing overlay accessibility sans substance technique) : ~5

ELIGIBILITÉ (lecture complète)
  Sources évaluées en détail : ~13
  Sources exclues après lecture complète : ~8
    - Hors scope PICOC strict (audit accessibilité organisationnel, pas implémentation technique) : 3
    - Redondance forte avec W3C APG sans apport différencié : 3
    - Niveau de preuve insuffisant (pure opinion, pas de standard référencé) : 2

INCLUSION
  Sources incluses dans la synthèse : 5
    - Niveau 1 : 2 (W3C WAI APG 2023, W3C WCAG 2.1 2018)
    - Niveau 3 : 3 (MDN Accessibility Guide, Deque axe-core docs, React documentation)

  Sources exclues avec raison documentée : 8
    - WCAG 2.2 (2023) : absorbé par WCAG 2.1 — les nouveaux critères 2.4.11, 2.4.12, 2.5.7, 2.5.8 sont mentionnés dans le principe existant wcag-level
    - ARIA in HTML W3C Note : absorbé par APG 1.2 (plus complet et plus prescriptif)
    - WebAIM — screen reader survey : pertinent mais hors scope implémentation technique
    - Radix UI / shadcn/ui accessibilité docs : niveau 3, absorbé par APG + React docs
    - focus-trap-react documentation : niveau 3, mentionné en implémentation sans être source primaire
    - Lighthouse documentation : absorbé par axe-core Deque (couverture WCAG plus détaillée)
    - ISO 9241-171 (Ergonomics of Human-System Interaction) : redondant avec WCAG 2.1, moins prescriptif pour le web
    - Blog posts accessibilité (≥5 sources) : niveau 5 redondant avec W3C APG + MDN
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | W3C WAI (WCAG, APG), MDN Web Docs, Deque/axe-core, React.dev, WebSearch général |
| Mots-clés | "WCAG 2.1 AA implementation technical HTML semantics", "ARIA authoring practices guide W3C", "axe-core WCAG automated testing coverage", "keyboard navigation focus visible CSS", "React accessibility aria props htmlFor" |
| Période couverte | 2018-2024 |
| Sources identifiées | ~26 |
| Sources retenues | 5 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogées

| Élément | Valeur |
|---------|--------|
| Bases | W3C WAI, MDN, Deque Systems, React.dev, WebAIM, WebSearch |
| Mots-clés | "WCAG implementation focus trap modal dialog accessibility", "ARIA roles states properties practical guide", "axe-core playwright accessibility testing", "color contrast ratio WCAG 4.5:1", "skip to content link keyboard navigation" |
| Période couverte | 2018-2024 |
| Sources identifiées | ~22 |
| Sources retenues | 5 (convergence complète avec A) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentées

| Source | Raison exclusion |
|--------|-----------------|
| WCAG 2.2 W3C Recommendation (2023) | Absorbé par WCAG 2.1 — les critères supplémentaires de 2.2 sont couverts dans le principe wcag-level existant |
| ARIA in HTML W3C Note | Absorbé par APG 1.2 (plus complet, inclut les patterns d'interaction, plus prescriptif) |
| WebAIM — Screen Reader User Survey | Hors scope — données d'usage lecteurs d'écran, pas guidance d'implémentation technique |
| Radix UI accessibility documentation | Niveau 3 redondant — absorbé par React docs + APG qui définissent les patterns de base |
| focus-trap-react README | Niveau 3 trop spécifique à une librairie — mentionné en exemple d'implémentation sans être source primaire |
| Google Lighthouse documentation | Absorbé par axe-core Deque (couverture WCAG plus détaillée, score de couverture documenté) |
| ISO 9241-171 (Ergonomics, accessibility) | Redondant avec WCAG 2.1 pour le contexte web, moins prescriptif sur l'implémentation |
| Blog posts accessibilité (≥5 sources) | Niveau 5 redondant avec W3C APG + MDN qui couvrent les mêmes pratiques avec rigueur normative |
