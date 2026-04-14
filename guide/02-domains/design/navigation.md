# Patterns de navigation

**[RECOMMANDE]** Sidebar pour apps complexes (>5 sections), top-nav pour sites vitrine | Score GRADE : 3/7

La sidebar offre un acces permanent aux sections et supporte la navigation profonde. La top-nav convient aux sites avec peu de pages.

```
Arbre de decision :
  Nombre de sections > 5 ? → Sidebar
  Navigation imbriquee (2+ niveaux) ? → Sidebar
  App type dashboard/outil ? → Sidebar
  Site vitrine / marketing ? → Top-nav
  Mobile ? → Bottom tab bar (max 5 items)
```

| Pattern | Quand l'utiliser | Exemple |
|---------|-----------------|---------|
| Sidebar collapsible | Apps complexes, dashboards | Gmail, Notion |
| Top-nav horizontale | Sites < 7 liens principaux | Blogs, landing pages |
| Bottom tab bar | Mobile, < 5 sections | Instagram, Spotify |

Sources : Nielsen Norman Group — F-pattern eye-tracking, sidebar superieur pour apps (niv. 3), Material Design 3 Navigation (niv. 5), Apple HIG — Tab bars mobile, sidebar desktop (niv. 5)
