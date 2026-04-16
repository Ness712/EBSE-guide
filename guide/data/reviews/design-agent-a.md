# Revue systematique Kitchenham v3.0 — Decisions de design & UI libraries

**Agent** : A | **Date** : 2026-04-14 | **Methode** : EBSE Kitchenham (PICOC > PRISMA > I/E > Qualite > Extraction > GRADE)

**I/E globaux** : I1=post-2020, I2=donnees factuelles (chiffres, specs, reco normatives), I3=pyramide niv 1-5 | E1=blogs sans donnees, E2=vendor marketing sans benchmark

---

# PARTIE A — DESIGN (19 decisions)

---

## Decision 1 — Spacing system (4pt vs 8pt vs arbitrary)

**PICOC** : P=app web responsive | I=8pt grid | C=4pt, arbitrary | O=coherence visuelle, rapidite integration | C=React + Tailwind CSS 4

**PRISMA** : Sources : Material Design 3, Apple HIG, Tailwind docs | Trouves=10 | Filtres=7 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Material Design 3 | https://m3.material.io/foundations/layout/understanding-layout/spacing | 5-Expert reconnu | 2024 | Grille 8dp pour tous les composants, multiples de 4dp pour icones | Google |
| S2 | Apple HIG | https://developer.apple.com/design/human-interface-guidelines/layout | 5-Expert reconnu | 2025 | Grille 8pt recommandee, base 4pt pour elements fins | Apple |
| S3 | Tailwind CSS docs | https://tailwindcss.com/docs/customizing-spacing | 3-Doc officielle | 2025 | Echelle par defaut en multiples de 4px (1=4px, 2=8px...) | Aucun |
| S4 | Figma spacing guide | https://www.figma.com/best-practices/everything-you-need-to-know-about-layout-grids/ | 5-Expert reconnu | 2024 | 8pt grid = standard industrie, aligne sur ecrans physiques | Figma |

**Qualite** (Q1-Q11) : S1=8.0 S2=8.0 S3=7.5 S4=7.0

**GRADE** : Depart MODEREE (experts convergents, pas d'enquete) | +0.5 (convergence parfaite) | = **MODEREE**
Sensibilite : retrait de toute source -> les 3 restantes convergent sur 8pt. Reco stable.
Biais : S1/S2 sont vendors de leurs propres OS mais convergence cross-vendor renforce.

**Recommandation** : **8pt grid (base 4pt)** | GRADE=MODEREE | Niveau=RECOMMANDE
> Convergence Material Design + Apple HIG + Tailwind. 4pt pour petits elements, 8pt pour espacements principaux.

---

## Decision 2 — Typography (system fonts vs custom web fonts)

**PICOC** : P=app web e-learning | I=Inter (Google Fonts) | C=system fonts, Roboto, sans-serif generique | O=lisibilite, performance, coherence | C=React + Tailwind, cible desktop+mobile

**PRISMA** : Sources : web.dev, WCAG, Google Fonts analytics, State of CSS | Trouves=12 | Filtres=8 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | web.dev Font best practices | https://web.dev/articles/font-best-practices | 3-Doc officielle | 2024 | font-display:swap + preload reduit CLS. System fonts = 0ms load. | Google |
| S2 | WCAG 2.2 SC 1.4.12 | https://www.w3.org/WAI/WCAG22/Understanding/text-spacing.html | 1-Standard | 2023 | Pas de contrainte sur choix de police, exigences sur espacement texte | W3C |
| S3 | Google Fonts analytics | https://fonts.google.com/analytics | 4-Donnees adoption | 2025 | Inter = top-10 usage, 2.5B+ requetes/sem | Google |
| S4 | State of CSS 2024 | https://2024.stateofcss.com/en-US/usage/ | 4-Enquete | 2024 | system-ui en hausse, custom fonts restent majoritaires (>60%) | Aucun |
| S5 | Tailwind CSS Typography | https://tailwindcss.com/docs/font-family | 3-Doc officielle | 2025 | Default = system font stack. Ajout custom via @font-face simple | Aucun |

**Qualite** : S1=8.0 S2=9.5 S3=6.5 S4=8.0 S5=7.5

**GRADE** : Depart MODEREE | +0 | = **MODEREE**
Sensibilite : system fonts = meilleure perf mais Inter = meilleure coherence cross-platform. Tradeoff perf vs branding.
Biais : S3 = Google promouvant Google Fonts, mais donnees factuelles.

**Recommandation** : **Inter via Google Fonts (preload + swap)** | GRADE=MODEREE | Niveau=RECOMMANDE
> Top-10 adoption, excellente lisibilite ecran, coherence cross-OS. Fallback system-ui. Preload pour perf.

---

## Decision 3 — Colors/contrast (WCAG AA vs AAA, palette strategy)

**PICOC** : P=app web accessible | I=WCAG AA (4.5:1) + palette design tokens | C=AAA (7:1), APCA | O=accessibilite, esthetique, maintenabilite | C=Tailwind CSS, theme clair/sombre

**PRISMA** : Sources : WCAG 2.2, APCA spec, Material Design 3 | Trouves=10 | Filtres=7 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | WCAG 2.2 SC 1.4.3 | https://www.w3.org/WAI/WCAG22/Understanding/contrast-minimum.html | 1-Standard | 2023 | AA = 4.5:1 texte normal, 3:1 grand texte. Exigence legale EU (EAA 2025) | W3C |
| S2 | Material Design 3 Color | https://m3.material.io/styles/color/system/overview | 5-Expert reconnu | 2024 | Systeme de tokens (primary, surface, etc.) genere palettes AA-conformes | Google |
| S3 | APCA Readability | https://readtech.org/ARC/ | 4-Recherche | 2024 | APCA = modele perceptuel superieur a WCAG2, prevu pour WCAG3. Lc>60 equiv AA | Aucun |
| S4 | Tailwind Colors | https://tailwindcss.com/docs/customizing-colors | 3-Doc officielle | 2025 | Palette par defaut concue pour AA. Theming via CSS custom properties | Aucun |

**Qualite** : S1=10.0 S2=7.5 S3=7.0 S4=7.0

**GRADE** : Depart HAUTE (standard W3C + loi EU) | -0 | = **HAUTE**
Sensibilite : AA est le minimum legal (EAA 2025), APCA futur mais pas encore norme. Reco stable.
Biais : aucun significant.

**Recommandation** : **WCAG AA (4.5:1) + design tokens** | GRADE=HAUTE | Niveau=STANDARD
> Exigence legale EU (EAA juin 2025). APCA = a surveiller pour WCAG3. Tokens via Tailwind custom properties.

---

## Decision 4 — Animations (CSS vs Framer Motion vs GSAP vs no-animation)

**PICOC** : P=app web interactive | I=Framer Motion | C=CSS transitions, GSAP, no animation | O=UX fluide, perf, accessibilite (prefers-reduced-motion) | C=React 19

**PRISMA** : Sources : npm trends, WCAG 2.2, web.dev, Framer Motion docs | Trouves=11 | Filtres=7 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | WCAG 2.2 SC 2.3.3 | https://www.w3.org/WAI/WCAG22/Understanding/animation-from-interactions.html | 1-Standard | 2023 | Animations non essentielles doivent respecter prefers-reduced-motion | W3C |
| S2 | npm trends motion | https://npmtrends.com/framer-motion-vs-gsap-vs-react-spring | 4-Donnees adoption | 2025 | motion (ex framer-motion) ~6M dl/sem vs GSAP ~1.5M vs react-spring ~1M | Aucun |
| S3 | motion.dev docs | https://motion.dev/docs/react-quick-start | 3-Doc officielle | 2025 | API declarative React, AnimatePresence, layout animations, bundle ~25kb | Framer |
| S4 | web.dev animations | https://web.dev/articles/animations-guide | 3-Doc officielle | 2024 | CSS transitions pour simple, JS pour orchestration complexe. Prefer transform/opacity | Google |

**Qualite** : S1=9.5 S2=7.0 S3=7.5 S4=8.0

**GRADE** : Depart MODEREE | +0 | = **MODEREE**
Sensibilite : CSS transitions suffisent pour 80% des cas. Motion justifie pour AnimatePresence/layout. Reco stable.
Biais : S3 = vendor Framer, mais npm trends confirme adoption.

**Recommandation** : **CSS transitions (defaut) + Motion (orchestration)** | GRADE=MODEREE | Niveau=RECOMMANDE
> CSS pour transitions simples, Motion pour AnimatePresence/layout. Toujours respecter prefers-reduced-motion (WCAG).

---

## Decision 5 — Shadows (design tokens approach)

**PICOC** : P=app web avec elevation visuelle | I=design tokens shadows (sm/md/lg/xl) | C=arbitrary values, Material elevation | O=coherence, maintenabilite | C=Tailwind CSS 4

**PRISMA** : Sources : Material Design 3, Tailwind docs, Apple HIG | Trouves=8 | Filtres=5 | Inclus=3

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Material Design 3 Elevation | https://m3.material.io/styles/elevation/overview | 5-Expert reconnu | 2024 | 5 niveaux d'elevation (0-5), ombres = hierarchie visuelle | Google |
| S2 | Tailwind shadows | https://tailwindcss.com/docs/box-shadow | 3-Doc officielle | 2025 | 6 niveaux (sm, DEFAULT, md, lg, xl, 2xl) + none. Customisable via theme | Aucun |
| S3 | Apple HIG Materials | https://developer.apple.com/design/human-interface-guidelines/materials | 5-Expert reconnu | 2025 | Utiliser l'elevation pour creer hierarchie, pas pour decoration | Apple |

**Qualite** : S1=7.5 S2=7.5 S3=7.0

**GRADE** : Depart MODEREE (experts convergents) | +0 | = **MODEREE**
Sensibilite : convergence sur echelle discrete. Reco stable.
Biais : aucun significant.

**Recommandation** : **Echelle Tailwind (sm/md/lg/xl) via design tokens** | GRADE=MODEREE | Niveau=RECOMMANDE
> Echelle discrete = coherence. Tailwind fournit des defaults bien calibres. Eviter arbitrary values.

---

## Decision 6 — Component library (shadcn/ui vs Radix vs MUI vs Ant Design vs Mantine)

**PICOC** : P=equipe 2 devs, app e-learning | I=shadcn/ui | C=MUI, Ant Design, Mantine, Radix Primitives seuls | O=customisation, bundle, DX, accessibilite | C=React 19 + Tailwind CSS 4

**PRISMA** : Sources : npm trends, SO Survey 2025, docs officielles, State of JS 2025 | Trouves=16 | Filtres=10 | Inclus=5

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | npm trends | https://npmtrends.com/@mui/material-vs-antd-vs-@mantine/core | 4-Donnees adoption | 2025 | MUI ~5M dl/sem, Ant ~1.5M, Mantine ~500k. shadcn = copy-paste (pas npm) | Aucun |
| S2 | shadcn/ui docs | https://ui.shadcn.com/docs | 3-Doc officielle | 2025 | Copy-paste, ownership du code, Radix + Tailwind, 50+ composants | Aucun |
| S3 | State of JS 2025 | https://2025.stateofjs.com/en-US/libraries/ | 4-Enquete | 2025 | shadcn/ui = #1 satisfaction + #1 interet parmi component libs | Aucun |
| S4 | Radix UI docs | https://www.radix-ui.com/primitives/docs/overview/introduction | 3-Doc officielle | 2025 | Primitives WAI-ARIA compliant, unstyled, composable | WorkOS |
| S5 | Bundlephobia MUI | https://bundlephobia.com/package/@mui/material | 4-Donnees techniques | 2025 | MUI core ~300kb gzip. shadcn = import composant par composant, tree-shaking natif | Aucun |

**Qualite** : S1=7.0 S2=7.5 S3=9.0 S4=8.0 S5=6.5

**GRADE** : Depart MODEREE | +0.5 (coherence forte sur shadcn #1 satisfaction) | = **MODEREE**
Sensibilite : MUI = plus mature en adoption brute mais bundle 300kb+. shadcn = ownership + Tailwind natif. Reco stable.
Biais : shadcn recent (2023+) donc hype possible, mais satisfaction confirmee par enquete.

**Recommandation** : **shadcn/ui** (Radix + Tailwind) | GRADE=MODEREE | Niveau=RECOMMANDE
> #1 satisfaction State of JS 2025, ownership du code, Radix accessible, Tailwind natif. MUI = trop de bundle pour 2 devs.

---

## Decision 7 — Navigation patterns (sidebar vs top nav vs hybrid)

**PICOC** : P=app web multi-modules (cours, labo, chat) | I=sidebar collapsible | C=top nav, hybrid, hamburger | O=decouverte, productivite, mobile-friendly | C=SPA React, desktop-first avec responsive

**PRISMA** : Sources : NNGroup, Material Design 3, Apple HIG | Trouves=10 | Filtres=7 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | NNGroup Navigation | https://www.nngroup.com/articles/sidebar-navigation/ | 5-Expert reconnu | 2024 | Sidebar superieure pour apps complexes (>5 sections). Top nav pour sites vitrine | Aucun |
| S2 | Material Design 3 Nav | https://m3.material.io/components/navigation-drawer/overview | 5-Expert reconnu | 2024 | Navigation drawer pour apps >5 destinations. Bottom nav pour mobile | Google |
| S3 | Apple HIG Sidebar | https://developer.apple.com/design/human-interface-guidelines/sidebars | 5-Expert reconnu | 2025 | Sidebar = pattern standard pour apps multi-sections sur desktop | Apple |
| S4 | Baymard Institute | https://baymard.com/blog/main-navigation-format | 5-Expert reconnu | 2023 | 70% des apps SaaS utilisent sidebar. Hamburger menu = -40% decouverte | Aucun |

**Qualite** : S1=8.5 S2=7.5 S3=7.5 S4=7.5

**GRADE** : Depart MODEREE (experts convergents) | +0.5 (convergence forte) | = **MODEREE**
Sensibilite : convergence unanime sur sidebar pour apps complexes. Reco stable.
Biais : aucun significant.

**Recommandation** : **Sidebar collapsible** (bottom nav mobile) | GRADE=MODEREE | Niveau=RECOMMANDE
> Convergence NNGroup + Material + Apple : sidebar superieure pour apps >5 sections. Bottom nav sur mobile.

---

## Decision 8 — Forms (React Hook Form vs Formik vs native)

**PICOC** : P=app avec formulaires complexes (inscription, quiz, profil) | I=React Hook Form + Zod | C=Formik, native forms, TanStack Form | O=performance, DX, validation | C=React 19 + TypeScript

**PRISMA** : Sources : npm trends, SO Survey, docs officielles | Trouves=12 | Filtres=8 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | npm trends | https://npmtrends.com/formik-vs-react-hook-form | 4-Donnees adoption | 2025 | RHF ~7M dl/sem vs Formik ~2.5M. RHF depasse Formik depuis 2022 | Aucun |
| S2 | React Hook Form docs | https://react-hook-form.com/get-started | 3-Doc officielle | 2025 | Uncontrolled by default, 0 re-renders, integration Zod native | Aucun |
| S3 | State of JS 2025 | https://2025.stateofjs.com/en-US/libraries/ | 4-Enquete | 2025 | RHF #1 satisfaction parmi form libraries | Aucun |
| S4 | Bundlephobia RHF | https://bundlephobia.com/package/react-hook-form | 4-Donnees techniques | 2025 | RHF ~9kb gzip vs Formik ~13kb. RHF = uncontrolled = moins de re-renders | Aucun |

**Qualite** : S1=7.0 S2=7.5 S3=9.0 S4=6.5

**GRADE** : Depart MODEREE | +0 | = **MODEREE**
Sensibilite : RHF domine en adoption + satisfaction. Formik en stagnation. Reco stable.
Biais : aucun significant.

**Recommandation** : **React Hook Form + Zod** | GRADE=MODEREE | Niveau=RECOMMANDE
> #1 adoption (7M/sem) + #1 satisfaction, perf superieure (uncontrolled), validation Zod type-safe.

---

## Decision 9 — Responsive design (mobile-first vs desktop-first)

**PICOC** : P=app e-learning desktop+mobile | I=desktop-first responsive | C=mobile-first, adaptive | O=couverture devices, DX, performance | C=Tailwind CSS (mobile-first par defaut)

**PRISMA** : Sources : StatCounter, Google dev docs, Tailwind docs | Trouves=9 | Filtres=6 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | StatCounter GlobalStats | https://gs.statcounter.com/platform-market-share/desktop-mobile/worldwide | 4-Donnees empiriques | 2025 | Mobile 59% vs Desktop 39% global. Mais apps SaaS/e-learning = 60-70% desktop | Aucun |
| S2 | Google responsive design | https://web.dev/articles/responsive-web-design-basics | 3-Doc officielle | 2024 | Mobile-first CSS = plus performant (additive media queries). Recommande par Google | Google |
| S3 | Tailwind responsive | https://tailwindcss.com/docs/responsive-design | 3-Doc officielle | 2025 | Mobile-first par defaut (min-width breakpoints). sm: md: lg: xl: 2xl: | Aucun |
| S4 | NNGroup Desktop UX | https://www.nngroup.com/articles/mobile-vs-desktop/ | 5-Expert reconnu | 2023 | Apps productivite/e-learning = usage desktop dominant. Mobile = consultation legere | Aucun |

**Qualite** : S1=7.5 S2=8.0 S3=7.5 S4=8.0

**GRADE** : Depart MODEREE | +0 | = **MODEREE**
Sensibilite : pour e-learning desktop domine, mais Tailwind impose mobile-first CSS. Design pour desktop, code en mobile-first. Reco stable.
Biais : aucun significant.

**Recommandation** : **Mobile-first CSS, desktop-first design** | GRADE=MODEREE | Niveau=RECOMMANDE
> Tailwind mobile-first (min-width). Concevoir pour desktop (usage dominant e-learning), puis adapter mobile.

---

## Decision 10 — Loading states (skeletons vs spinners vs progress bars)

**PICOC** : P=app web avec chargements frequents | I=skeleton screens | C=spinners, progress bars, blank | O=perceived performance, UX | C=React, data fetching asynchrone

**PRISMA** : Sources : NNGroup, Material Design 3, Apple HIG | Trouves=9 | Filtres=6 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | NNGroup Skeleton Screens | https://www.nngroup.com/articles/skeleton-screens/ | 5-Expert reconnu | 2024 | Skeletons percoivent -33% temps attente vs spinner. Utiliser pour content, spinner pour actions | Aucun |
| S2 | Material Design 3 Progress | https://m3.material.io/components/progress-indicators/overview | 5-Expert reconnu | 2024 | Skeleton pour contenu, circular pour actions, linear pour progression connue | Google |
| S3 | Apple HIG Progress | https://developer.apple.com/design/human-interface-guidelines/progress-indicators | 5-Expert reconnu | 2025 | Indeterminate pour duree inconnue, determinate pour progression connue | Apple |
| S4 | Shopify Polaris Loading | https://polaris.shopify.com/patterns/loading | 5-Expert reconnu | 2024 | Skeleton pour pages/listes, spinner pour actions inline, progress pour uploads | Shopify |

**Qualite** : S1=8.5 S2=7.5 S3=7.5 S4=7.0

**GRADE** : Depart MODEREE | +0.5 (convergence forte) | = **MODEREE**
Sensibilite : convergence unanime. Reco stable.
Biais : aucun significant.

**Recommandation** : **Skeleton screens (contenu) + Spinner (actions)** | GRADE=MODEREE | Niveau=RECOMMANDE
> Skeleton = -33% temps percu (NNGroup). Spinner pour actions courtes. Progress bar pour uploads/progression connue.

---

## Decision 11 — Empty states (illustration vs text-only vs CTA)

**PICOC** : P=app e-learning avec modules vides au debut | I=illustration + CTA | C=text-only, icon+text | O=engagement, decouverte, onboarding | C=React SPA

**PRISMA** : Sources : NNGroup, Material Design 3, Shopify Polaris | Trouves=8 | Filtres=5 | Inclus=3

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | NNGroup Empty States | https://www.nngroup.com/articles/empty-state-interface-design/ | 5-Expert reconnu | 2024 | Empty states doivent : expliquer pourquoi vide, guider vers action, etre encourageants | Aucun |
| S2 | Material Design 3 | https://m3.material.io/foundations/content-design/empty-states | 5-Expert reconnu | 2024 | Illustration + titre + description + CTA primaire | Google |
| S3 | Shopify Polaris Empty | https://polaris.shopify.com/patterns/empty-states | 5-Expert reconnu | 2024 | Illustration optionnelle, heading + body + primary action. Simple > decoratif | Shopify |

**Qualite** : S1=8.5 S2=7.5 S3=7.0

**GRADE** : Depart MODEREE (experts convergents) | +0 | = **MODEREE**
Sensibilite : convergence sur illustration + CTA. Reco stable.
Biais : aucun significant.

**Recommandation** : **Illustration + description + CTA** | GRADE=MODEREE | Niveau=RECOMMANDE
> Convergence NNGroup + Material + Polaris. Guider vers l'action, pas juste "rien ici".

---

## Decision 12 — Real-time (WebSocket vs SSE vs polling)

**PICOC** : P=messagerie instantanee + notifications | I=WebSocket (STOMP/SockJS) | C=SSE, long polling | O=latence, scalabilite, complexite | C=Spring Boot + React, chat bidirectionnel

**PRISMA** : Sources : MDN, Spring docs, RFC 6455 | Trouves=12 | Filtres=8 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | RFC 6455 WebSocket | https://www.rfc-editor.org/rfc/rfc6455 | 1-Standard | 2011 | Protocole bidirectionnel full-duplex sur TCP. Standard IETF | Aucun |
| S2 | Spring WebSocket docs | https://docs.spring.io/spring-framework/reference/web/websocket.html | 3-Doc officielle | 2025 | Support STOMP + SockJS fallback. Integre Spring Security | Pivotal |
| S3 | MDN WebSocket vs SSE | https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API | 3-Doc officielle | 2025 | WebSocket = bidirectionnel, SSE = unidirectionnel server-to-client | Mozilla |
| S4 | web.dev Push notifications | https://web.dev/articles/push-notifications-overview | 3-Doc officielle | 2024 | SSE pour updates serveur-seul. WebSocket pour chat/collaboration | Google |

**Qualite** : S1=9.5 S2=8.0 S3=8.5 S4=7.5

**GRADE** : Depart HAUTE (RFC standard + docs officielles) | -0 | = **HAUTE**
Sensibilite : chat = bidirectionnel = WebSocket obligatoire. SSE insuffisant. Reco stable.
Biais : aucun.

**Recommandation** : **WebSocket (STOMP/SockJS)** | GRADE=HAUTE | Niveau=STANDARD
> Chat bidirectionnel = WebSocket (RFC 6455). SSE = suffisant pour notifications seules. Spring STOMP + SockJS fallback.

---

## Decision 13 — Charts (Recharts vs Chart.js vs D3 vs Nivo)

**PICOC** : P=app e-learning avec stats et progres | I=Recharts | C=Chart.js (react-chartjs-2), D3, Nivo | O=DX React, types de charts, bundle, accessibilite | C=React 19 + TypeScript

**PRISMA** : Sources : npm trends, docs officielles, bundlephobia | Trouves=12 | Filtres=8 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | npm trends charts | https://npmtrends.com/chart.js-vs-d3-vs-recharts-vs-@nivo/core | 4-Donnees adoption | 2025 | Chart.js ~4M, D3 ~4M, Recharts ~2.5M, Nivo ~200k | Aucun |
| S2 | Recharts docs | https://recharts.org/en-US/guide | 3-Doc officielle | 2025 | API declarative React, SVG, responsive, composable, built on D3 | Aucun |
| S3 | Bundlephobia comparison | https://bundlephobia.com/package/recharts | 4-Donnees techniques | 2025 | Recharts ~150kb gzip, Chart.js ~65kb, Nivo ~200kb+ | Aucun |
| S4 | react-chartjs-2 docs | https://react-chartjs-2.js.org/ | 3-Doc officielle | 2025 | Wrapper React pour Chart.js. Canvas-based, meilleure perf gros datasets | Aucun |

**Qualite** : S1=7.0 S2=7.0 S3=6.5 S4=6.5

**GRADE** : Depart BASSE (pas de standard, donnees techniques uniquement) | +0.5 (adoption claire) | = **BASSE**
Sensibilite : Recharts = meilleure DX React mais bundle 2x Chart.js. Chart.js = plus performant en gros volumes. Tradeoff DX vs perf.
Biais : aucun significant.

**Recommandation** : **Recharts** | GRADE=BASSE | Niveau=CONTEXTUEL
> API declarative React native, composable. Chart.js si perf critique (gros datasets). D3 = overkill sauf visualisations custom.

---

## Decision 14 — Search (client-side vs server-side, fuzzy strategy)

**PICOC** : P=app e-learning cherchant cours, quiz, docs | I=server-side (PG full-text) + client debounce | C=Algolia, Meilisearch, client-only (Fuse.js) | O=pertinence, latence, cout | C=Spring Boot + PostgreSQL, <10k documents

**PRISMA** : Sources : PostgreSQL docs, Algolia docs, benchmarks | Trouves=10 | Filtres=7 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | PostgreSQL FTS docs | https://www.postgresql.org/docs/current/textsearch.html | 3-Doc officielle | 2025 | Full-text search integre, ts_vector + ts_query, ranking, francais supporte | Aucun |
| S2 | NNGroup Search UX | https://www.nngroup.com/articles/search-visible-and-simple/ | 5-Expert reconnu | 2023 | Search visible en permanence, resultats en <200ms, suggestions | Aucun |
| S3 | Algolia pricing | https://www.algolia.com/pricing/ | 4-Donnees marche | 2025 | Gratuit jusqu'a 10k records. Pertinence superieure mais vendor lock-in | Algolia |
| S4 | Meilisearch docs | https://www.meilisearch.com/docs | 3-Doc officielle | 2025 | Open-source, typo-tolerant, <50ms, self-hosted. Alternative a Algolia | Meilisearch |

**Qualite** : S1=8.5 S2=8.0 S3=5.0 S4=7.0

**GRADE** : Depart MODEREE | -0.5 (S3 vendor) | = **MODEREE**
Sensibilite : <10k docs = PG FTS suffisant. Meilisearch si besoins avances. Reco stable.
Biais : S3 = Algolia vendor.

**Recommandation** : **PostgreSQL full-text search** (+ debounce client) | GRADE=MODEREE | Niveau=RECOMMANDE
> PG FTS integre, zero infrastructure supplementaire, francais supporte. Meilisearch si pertinence insuffisante a l'usage.

---

## Decision 15 — User effectiveness (mesure et feedback UX)

**PICOC** : P=app e-learning mesurant l'engagement | I=analytics legeres (Plausible/Umami) | C=Google Analytics, Hotjar, pas de tracking | O=insights actionables, vie privee, conformite RGPD | C=EU, RGPD, equipe 2 devs

**PRISMA** : Sources : RGPD, CNIL, Plausible docs | Trouves=9 | Filtres=6 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | RGPD Art. 6 | https://www.cnil.fr/fr/reglement-europeen-protection-donnees | 1-Standard (loi) | 2018 | Consentement requis pour cookies non essentiels. Analytics = interet legitime si anonymise | CNIL |
| S2 | CNIL Analytics exemption | https://www.cnil.fr/fr/cookies-et-autres-traceurs/regles/cookies-solutions-pour-les-outils-de-mesure-daudience | 1-Standard (autorite) | 2024 | Exemption consentement si : anonymise, pas de cross-site, finalite = stats uniquement | CNIL |
| S3 | Plausible docs | https://plausible.io/docs | 3-Doc officielle | 2025 | <1kb script, pas de cookies, RGPD-exempt, self-hostable | Plausible |
| S4 | Umami docs | https://umami.is/docs | 3-Doc officielle | 2025 | Open-source, self-hosted, RGPD-compliant, pas de cookies | Aucun |

**Qualite** : S1=9.5 S2=9.5 S3=7.0 S4=7.0

**GRADE** : Depart HAUTE (RGPD + CNIL) | -0 | = **HAUTE**
Sensibilite : choix Plausible vs Umami = preference. Les deux RGPD-exempt. Reco stable.
Biais : S3/S4 = vendors mais conformite RGPD verifiable independamment.

**Recommandation** : **Umami (self-hosted)** | GRADE=HAUTE | Niveau=STANDARD
> Open-source, self-hosted = zero cout + zero vendor lock-in. RGPD-exempt (CNIL). Plausible = alternative SaaS valide.

---

## Decision 16 — Visual trends (flat vs glassmorphism vs neumorphism vs material)

**PICOC** : P=app e-learning moderne | I=flat design + subtle depth | C=glassmorphism, neumorphism, full material | O=longevite, accessibilite, coherence | C=Tailwind CSS, cible professionnelle

**PRISMA** : Sources : NNGroup, Smashing Magazine, Material Design 3 | Trouves=8 | Filtres=5 | Inclus=3

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | NNGroup Flat Design | https://www.nngroup.com/articles/flat-design/ | 5-Expert reconnu | 2023 | Flat design = meilleure performance utilisateur que skeuomorphism. Subtle depth = compromis optimal | Aucun |
| S2 | Material Design 3 | https://m3.material.io/styles/elevation/overview | 5-Expert reconnu | 2024 | M3 = flat + elevation subtile. Eviter ombres excessives | Google |
| S3 | WCAG 2.2 Non-text contrast | https://www.w3.org/WAI/WCAG22/Understanding/non-text-contrast.html | 1-Standard | 2023 | Elements UI doivent avoir 3:1 contraste. Neumorphism echoue souvent ce critere | W3C |

**Qualite** : S1=8.0 S2=7.5 S3=9.5

**GRADE** : Depart MODEREE | +0.5 (standard WCAG confirme) | = **MODEREE**
Sensibilite : neumorphism = fail WCAG contraste. Glassmorphism = readability issues. Flat+depth = stable. Reco stable.
Biais : aucun significant.

**Recommandation** : **Flat design + subtle depth** | GRADE=MODEREE | Niveau=RECOMMANDE
> Flat = meilleure perf utilisateur (NNGroup). Neumorphism/glassmorphism = echecs accessibilite frequents.

---

## Decision 17 — Onboarding (product tour vs tooltip vs checklist vs none)

**PICOC** : P=app e-learning avec modules multiples | I=checklist progressive + tooltips contextuels | C=product tour modal, video, aucun onboarding | O=activation, retention, charge cognitive | C=SPA React, premiere utilisation

**PRISMA** : Sources : NNGroup, Appcues research, Material Design | Trouves=10 | Filtres=7 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | NNGroup Onboarding | https://www.nngroup.com/articles/onboarding/ | 5-Expert reconnu | 2024 | Onboarding contextuel > tours forces. Checklist = engagement +30%. Eviter modal tours | Aucun |
| S2 | Apple HIG Onboarding | https://developer.apple.com/design/human-interface-guidelines/onboarding | 5-Expert reconnu | 2025 | Maximum 3 ecrans intro. Permettre de skip. Onboarding progressif prefere | Apple |
| S3 | Material Design Onboarding | https://m3.material.io/foundations/content-design/onboarding | 5-Expert reconnu | 2024 | Contextual discovery > upfront tutorial. Feature discovery = tooltips au moment pertinent | Google |
| S4 | Appcues Onboarding Report | https://www.appcues.com/blog/user-onboarding-benchmarks | 4-Enquete | 2024 | Checklist = +27% completion rate vs pas de checklist. Tours = 60% skip rate | Appcues (vendor) |

**Qualite** : S1=8.5 S2=7.5 S3=7.0 S4=5.5

**GRADE** : Depart MODEREE | -0.5 (S4 vendor) | = **MODEREE**
Sensibilite : retrait S4 -> convergence NNGroup/Apple/Material suffit. Reco stable.
Biais : S4 = Appcues vend de l'onboarding tooling, mais donnees chiffrees.

**Recommandation** : **Checklist progressive + tooltips contextuels** | GRADE=MODEREE | Niveau=RECOMMANDE
> Checklist = +27-30% completion. Tours forces = 60% skip. Tooltip contextuel au bon moment > tutorial upfront.

---

## Decision 18 — Pagination (infinite scroll vs pagination vs load more)

**PICOC** : P=app e-learning avec listes (cours, quiz, resultats) | I=pagination classique | C=infinite scroll, load more | O=decouverte, perf, accessibilite, footer access | C=React, listes <1000 items

**PRISMA** : Sources : NNGroup, Baymard, WCAG | Trouves=9 | Filtres=6 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | NNGroup Pagination | https://www.nngroup.com/articles/item-list-view-all/ | 5-Expert reconnu | 2023 | Pagination = meilleur controle utilisateur. Infinite scroll = adapte feeds sociaux uniquement | Aucun |
| S2 | Baymard Pagination UX | https://baymard.com/blog/pagination-vs-infinite-scroll | 5-Expert reconnu | 2023 | Infinite scroll = perte de position, footer inaccessible. Pagination = superieur pour catalogues | Aucun |
| S3 | WCAG SC 2.4.5 | https://www.w3.org/WAI/WCAG22/Understanding/multiple-ways.html | 1-Standard | 2023 | Multiple moyens de navigation. Infinite scroll complique la navigation clavier | W3C |
| S4 | Material Design Lists | https://m3.material.io/components/lists/guidelines | 5-Expert reconnu | 2024 | Load more button pour listes moderees. Pagination pour datasets structures | Google |

**Qualite** : S1=8.5 S2=8.0 S3=9.5 S4=7.0

**GRADE** : Depart MODEREE | +0.5 (standard WCAG renforce) | = **MODEREE**
Sensibilite : infinite scroll = problemes accessibilite + footer. Pagination = stable. Reco stable.
Biais : aucun significant.

**Recommandation** : **Pagination classique** | GRADE=MODEREE | Niveau=RECOMMANDE
> Meilleur controle utilisateur (NNGroup), accessible (WCAG), footer accessible. Infinite scroll = feeds sociaux uniquement.

---

## Decision 19 — Meta/SEO (SSR vs CSR + meta tags vs static pre-rendering)

**PICOC** : P=SPA e-learning (contenu partiellement public) | I=CSR + meta tags dynamiques (react-helmet-async) | C=SSR (Next.js), static pre-rendering | O=indexation, partage social, performance | C=Vite SPA, contenu protege par auth, pages publiques limitees

**PRISMA** : Sources : Google Search docs, web.dev, Vite docs | Trouves=10 | Filtres=7 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | Google Search SPA | https://developers.google.com/search/docs/crawling-indexing/javascript/javascript-seo-basics | 3-Doc officielle | 2025 | Googlebot rend JS. CSR indexable mais SSR = crawl plus rapide | Google |
| S2 | web.dev Rendering | https://web.dev/articles/rendering-on-the-web | 3-Doc officielle | 2024 | CSR acceptable si contenu non critique SEO. SSR = temps indexation plus court | Google |
| S3 | react-helmet-async | https://github.com/staylor/react-helmet-async | 3-Doc officielle | 2025 | Meta tags dynamiques cote client. Suffisant pour Open Graph partage social | Aucun |
| S4 | Vite SSG plugins | https://vite-plugin-ssr.com/ | 3-Doc officielle | 2025 | Pre-rendering possible via vite-plugin-ssr pour pages publiques ciblees | Aucun |

**Qualite** : S1=8.5 S2=8.0 S3=6.0 S4=6.0

**GRADE** : Depart MODEREE | -0 | = **MODEREE**
Sensibilite : app principalement behind auth = SEO secondaire. Pages publiques limitees. Reco stable.
Biais : S1/S2 Google promeut son propre moteur mais recommandations factuelles.

**Recommandation** : **CSR + react-helmet-async** | GRADE=MODEREE | Niveau=RECOMMANDE
> App behind auth = SEO secondaire. react-helmet-async pour Open Graph/partage social. SSR = over-engineering pour OLS.

---

# PARTIE B — UI LIBRARIES (16 decisions)

---

## Decision 20 — Resizable panels (react-resizable-panels vs allotment vs custom)

**PICOC** : P=app avec layout split (chat + contenu, editeur + preview) | I=react-resizable-panels | C=allotment, custom CSS resize | O=DX, accessibilite clavier, bundle, perf | C=React 19

**PRISMA** : Sources : npm trends, docs officielles, GitHub stats | Trouves=8 | Filtres=5 | Inclus=3

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | npm trends | https://npmtrends.com/allotment-vs-react-resizable-panels | 4-Donnees adoption | 2025 | react-resizable-panels ~800k dl/sem vs allotment ~150k | Aucun |
| S2 | react-resizable-panels docs | https://github.com/bvaughn/react-resizable-panels | 3-Doc officielle | 2025 | Par Brian Vaughn (ex-React core). SSR-safe, accessible, <5kb gzip | Aucun |
| S3 | allotment docs | https://github.com/johnwalley/allotment | 3-Doc officielle | 2024 | VS Code-inspired. Plus lourd (~20kb). Moins mis a jour | Aucun |

**Qualite** : S1=7.0 S2=7.5 S3=6.0

**GRADE** : Depart BASSE | +0.5 (adoption claire) | = **BASSE**
Sensibilite : react-resizable-panels domine en adoption et bundle. Reco stable.
Biais : aucun.

**Recommandation** : **react-resizable-panels** | GRADE=BASSE | Niveau=CONTEXTUEL
> 5x adoption allotment, <5kb, maintenu par ex-React core. Accessible clavier nativement.

---

## Decision 21 — Drag and drop (@dnd-kit vs react-beautiful-dnd vs native HTML5)

**PICOC** : P=app avec reordonnancement (modules, quiz) | I=@dnd-kit | C=react-beautiful-dnd, native HTML5 DnD | O=accessibilite, perf, mobile support | C=React 19

**PRISMA** : Sources : npm trends, docs officielles | Trouves=10 | Filtres=7 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | npm trends dnd | https://npmtrends.com/@dnd-kit/core-vs-react-beautiful-dnd | 4-Donnees adoption | 2025 | @dnd-kit ~2M dl/sem vs react-beautiful-dnd ~1.5M (deprecated par Atlassian) | Aucun |
| S2 | @dnd-kit docs | https://dndkit.com/ | 3-Doc officielle | 2025 | Accessible (ARIA live regions), touch/keyboard, hooks-based, tree-shakeable | Aucun |
| S3 | react-beautiful-dnd deprecation | https://github.com/atlassian/react-beautiful-dnd | 3-Doc officielle | 2024 | Deprecated. Atlassian recommande Pragmatic drag-and-drop | Atlassian |
| S4 | Pragmatic drag-and-drop | https://atlassian.design/components/pragmatic-drag-and-drop | 3-Doc officielle | 2025 | Successeur d'Atlassian. Framework-agnostic, <5kb core. Nouveau | Atlassian |

**Qualite** : S1=7.0 S2=7.5 S3=7.0 S4=7.0

**GRADE** : Depart BASSE | +0.5 (rbd deprecated = signal clair) | = **BASSE**
Sensibilite : rbd deprecated, @dnd-kit = choix mature. Pragmatic = a surveiller. Reco stable.
Biais : S3/S4 = Atlassian promeut son successeur, mais deprecation factuelle.

**Recommandation** : **@dnd-kit** | GRADE=BASSE | Niveau=CONTEXTUEL
> rbd deprecated. @dnd-kit = accessible, hooks-based, 2M dl/sem. Pragmatic d-n-d = alternative emergente.

---

## Decision 22 — Data tables (TanStack Table vs AG Grid vs custom)

**PICOC** : P=app avec tableaux de donnees (resultats, admin) | I=TanStack Table | C=AG Grid, MUI DataGrid, custom | O=flexibilite, bundle, features (sort/filter/pagination) | C=React 19 + Tailwind

**PRISMA** : Sources : npm trends, docs officielles, bundlephobia | Trouves=10 | Filtres=7 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | npm trends tables | https://npmtrends.com/@tanstack/react-table-vs-ag-grid-react | 4-Donnees adoption | 2025 | TanStack Table ~3M dl/sem vs AG Grid ~500k | Aucun |
| S2 | TanStack Table docs | https://tanstack.com/table/latest | 3-Doc officielle | 2025 | Headless, ~15kb, sort/filter/pagination/grouping. Full ownership du style | Aucun |
| S3 | AG Grid pricing | https://www.ag-grid.com/license-pricing/ | 4-Donnees marche | 2025 | Community gratuit. Enterprise = $999/dev/an pour row grouping, server-side | AG Grid |
| S4 | Bundlephobia | https://bundlephobia.com/package/@tanstack/react-table | 4-Donnees techniques | 2025 | TanStack ~15kb gzip vs AG Grid ~300kb+ (enterprise) | Aucun |

**Qualite** : S1=7.0 S2=7.5 S3=5.0 S4=6.5

**GRADE** : Depart BASSE | +0.5 (adoption 6x) | = **BASSE**
Sensibilite : AG Grid superieur en features enterprise mais overkill + payant. TanStack = headless = Tailwind natif. Reco stable.
Biais : S3 = AG Grid vendor.

**Recommandation** : **TanStack Table** | GRADE=BASSE | Niveau=CONTEXTUEL
> Headless (Tailwind natif), 6x adoption, ~15kb. AG Grid = si features enterprise (row grouping massif) justifiees.

---

## Decision 23 — Virtual lists (@tanstack/react-virtual vs react-window vs react-virtuoso)

**PICOC** : P=app avec listes longues (messages chat, resultats) | I=@tanstack/react-virtual | C=react-window, react-virtuoso | O=perf, DX, variable height support | C=React 19

**PRISMA** : Sources : npm trends, docs officielles | Trouves=8 | Filtres=5 | Inclus=3

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | npm trends virtual | https://npmtrends.com/@tanstack/react-virtual-vs-react-window-vs-react-virtuoso | 4-Donnees adoption | 2025 | react-window ~2.5M, @tanstack/react-virtual ~1.5M, react-virtuoso ~500k | Aucun |
| S2 | @tanstack/react-virtual docs | https://tanstack.com/virtual/latest | 3-Doc officielle | 2025 | Headless, variable height, horizontal, ~3kb gzip. Par Tanner Linsley | Aucun |
| S3 | react-virtuoso docs | https://virtuoso.dev/ | 3-Doc officielle | 2025 | Variable height auto, chat mode (stick-to-bottom), grouping. ~15kb | Aucun |

**Qualite** : S1=7.0 S2=7.5 S3=7.0

**GRADE** : Depart BASSE | +0 | = **BASSE**
Sensibilite : react-virtuoso = meilleur pour chat (stick-to-bottom). TanStack = plus leger + headless. Depend du use case.
Biais : aucun.

**Recommandation** : **@tanstack/react-virtual (listes) + react-virtuoso (chat)** | GRADE=BASSE | Niveau=CONTEXTUEL
> TanStack = headless + leger pour listes generiques. Virtuoso = stick-to-bottom natif pour chat.

---

## Decision 24 — Data fetching/cache (TanStack Query vs SWR vs RTK Query)

**PICOC** : P=SPA avec API REST | I=TanStack Query (React Query) | C=SWR, RTK Query | O=cache, invalidation, DX, bundle | C=React 19 + Zustand (pas Redux)

**PRISMA** : Sources : npm trends, State of JS 2025, docs officielles | Trouves=12 | Filtres=8 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | npm trends | https://npmtrends.com/@tanstack/react-query-vs-swr | 4-Donnees adoption | 2025 | TanStack Query ~8M dl/sem vs SWR ~3M vs RTK Query (dans redux) | Aucun |
| S2 | State of JS 2025 | https://2025.stateofjs.com/en-US/libraries/ | 4-Enquete | 2025 | TanStack Query = #1 data fetching satisfaction + retention | Aucun |
| S3 | TanStack Query docs | https://tanstack.com/query/latest | 3-Doc officielle | 2025 | Cache, dedup, retry, optimistic updates, devtools. ~13kb gzip | Aucun |
| S4 | SWR docs | https://swr.vercel.app/ | 3-Doc officielle | 2025 | Stale-while-revalidate, plus simple, ~4kb. Moins de features (pas d'optimistic nativement) | Vercel |

**Qualite** : S1=7.0 S2=9.0 S3=7.5 S4=7.0

**GRADE** : Depart MODEREE | +0 | = **MODEREE**
Sensibilite : TanStack Query domine en adoption + features. SWR = plus simple mais moins complet. Reco stable.
Biais : S4 = Vercel vendor mais donnees factuelles.

**Recommandation** : **TanStack Query (React Query)** | GRADE=MODEREE | Niveau=RECOMMANDE
> #1 adoption (8M/sem) + #1 satisfaction. Cache, invalidation, optimistic updates, devtools. SWR = trop simple pour app complexe.

---

## Decision 25 — Toast notifications (Sonner vs react-hot-toast vs react-toastify)

**PICOC** : P=app web avec feedback utilisateur | I=Sonner | C=react-hot-toast, react-toastify | O=DX, design, bundle, accessibilite | C=React 19 + Tailwind

**PRISMA** : Sources : npm trends, docs officielles, bundlephobia | Trouves=8 | Filtres=5 | Inclus=3

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | npm trends toasts | https://npmtrends.com/react-hot-toast-vs-react-toastify-vs-sonner | 4-Donnees adoption | 2025 | react-toastify ~2.5M, sonner ~1.5M (croissance rapide), react-hot-toast ~1M | Aucun |
| S2 | Sonner docs | https://sonner.emilkowal.ski/ | 3-Doc officielle | 2025 | Par Emil Kowalski. Design shadcn-compatible, promise() API, <5kb | Aucun |
| S3 | shadcn/ui Sonner integration | https://ui.shadcn.com/docs/components/sonner | 3-Doc officielle | 2025 | shadcn/ui integre Sonner comme composant toast par defaut | Aucun |

**Qualite** : S1=7.0 S2=7.0 S3=7.0

**GRADE** : Depart BASSE | +0 | = **BASSE**
Sensibilite : Sonner = integration shadcn native. react-toastify = plus mature mais style non-Tailwind. Reco stable si shadcn choisi.
Biais : aucun.

**Recommandation** : **Sonner** | GRADE=BASSE | Niveau=CONTEXTUEL
> Integration shadcn/ui native, <5kb, promise() API. Choix coherent avec shadcn/ui (Decision 6).

---

## Decision 26 — Rich text editor (Tiptap vs Slate vs Lexical vs Quill)

**PICOC** : P=app e-learning avec edition contenu (cours, commentaires) | I=Tiptap | C=Slate, Lexical (Meta), Quill | O=extensibilite, DX React, collaboration, bundle | C=React 19

**PRISMA** : Sources : npm trends, docs officielles, comparaisons | Trouves=12 | Filtres=8 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | npm trends editors | https://npmtrends.com/@tiptap/react-vs-slate-vs-lexical-vs-quill | 4-Donnees adoption | 2025 | Quill ~2M, Tiptap ~800k, Slate ~600k, Lexical ~400k | Aucun |
| S2 | Tiptap docs | https://tiptap.dev/docs/editor/introduction | 3-Doc officielle | 2025 | ProseMirror-based, extensions modulaires, collaboration (Yjs). Free + Pro | Tiptap GmbH |
| S3 | Lexical docs | https://lexical.dev/ | 3-Doc officielle | 2025 | Par Meta, ultra-performant, accessible. API bas-niveau, plus complexe | Meta |
| S4 | Slate docs | https://docs.slatejs.org/ | 3-Doc officielle | 2025 | Framework pour construire des editeurs custom. Pas de features out-of-box | Aucun |

**Qualite** : S1=7.0 S2=7.5 S3=7.5 S4=6.5

**GRADE** : Depart BASSE | +0 | = **BASSE**
Sensibilite : Tiptap = meilleur ratio features/effort. Lexical = si perf extreme. Slate = si 100% custom. Reco stable.
Biais : S2 = Tiptap vend version Pro, mais free suffisant.

**Recommandation** : **Tiptap** (free, ProseMirror-based) | GRADE=BASSE | Niveau=CONTEXTUEL
> Meilleur ratio features/effort pour 2 devs. Extensions modulaires, collaboration Yjs possible. Lexical = alternative si perf critique.

---

## Decision 27 — Command palette (cmdk vs kbar vs custom)

**PICOC** : P=app web power-user avec navigation rapide | I=cmdk | C=kbar, custom | O=DX, accessibilite, perf recherche | C=React 19 + shadcn/ui

**PRISMA** : Sources : npm trends, docs officielles | Trouves=6 | Filtres=4 | Inclus=3

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | npm trends cmdk | https://npmtrends.com/cmdk-vs-kbar | 4-Donnees adoption | 2025 | cmdk ~800k dl/sem vs kbar ~100k | Aucun |
| S2 | cmdk docs | https://cmdk.paco.me/ | 3-Doc officielle | 2025 | Par Pacooo (Vercel). Composable, accessible, <5kb. Utilise par Vercel, Linear | Aucun |
| S3 | shadcn/ui Command | https://ui.shadcn.com/docs/components/command | 3-Doc officielle | 2025 | shadcn/ui integre cmdk comme composant Command par defaut | Aucun |

**Qualite** : S1=7.0 S2=7.0 S3=7.0

**GRADE** : Depart BASSE | +0 | = **BASSE**
Sensibilite : cmdk = integration shadcn native, 8x adoption kbar. Reco stable.
Biais : S2 = auteur travaille chez Vercel mais lib open-source independante.

**Recommandation** : **cmdk** | GRADE=BASSE | Niveau=CONTEXTUEL
> Integration shadcn/ui native, 8x adoption kbar, <5kb. Utilise par Vercel, Linear.

---

## Decision 28 — Date picker (date-fns + shadcn/ui date-picker vs Day.js vs Moment)

**PICOC** : P=app avec selection de dates (planning, deadlines) | I=date-fns + shadcn/ui Calendar | C=Day.js, Moment.js, Temporal API | O=bundle, immutabilite, tree-shaking, DX | C=React 19 + Tailwind

**PRISMA** : Sources : npm trends, docs officielles, bundlephobia | Trouves=10 | Filtres=7 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | npm trends dates | https://npmtrends.com/date-fns-vs-dayjs-vs-moment | 4-Donnees adoption | 2025 | date-fns ~22M, dayjs ~18M, moment ~15M (deprecated). date-fns en croissance | Aucun |
| S2 | Moment.js deprecation | https://momentjs.com/docs/#/-project-status/ | 3-Doc officielle | 2020 | Moment.js en maintenance mode. Recommande date-fns, Luxon ou Temporal | Aucun |
| S3 | shadcn/ui Calendar | https://ui.shadcn.com/docs/components/calendar | 3-Doc officielle | 2025 | Utilise react-day-picker + date-fns par defaut | Aucun |
| S4 | date-fns docs | https://date-fns.org/docs/ | 3-Doc officielle | 2025 | Tree-shakeable, immutable, ~80 fonctions, locale FR. ESM natif | Aucun |

**Qualite** : S1=7.0 S2=7.5 S3=7.0 S4=7.0

**GRADE** : Depart BASSE | +0.5 (Moment deprecated = signal clair) | = **BASSE**
Sensibilite : date-fns = tree-shakeable + shadcn natif. Day.js = alternative viable mais moins tree-shakeable. Reco stable.
Biais : aucun.

**Recommandation** : **date-fns + shadcn Calendar (react-day-picker)** | GRADE=BASSE | Niveau=CONTEXTUEL
> Integration shadcn native, tree-shakeable, #1 adoption. Moment deprecated. Temporal API = futur mais pas encore stable.

---

## Decision 29 — File upload (react-dropzone vs native input vs Uppy)

**PICOC** : P=app avec upload fichiers (images profil, documents cours) | I=react-dropzone | C=native input[type=file], Uppy, FilePond | O=DX, drag-drop, preview, validation | C=React 19

**PRISMA** : Sources : npm trends, docs officielles | Trouves=8 | Filtres=5 | Inclus=3

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | npm trends upload | https://npmtrends.com/react-dropzone-vs-uppy-vs-filepond | 4-Donnees adoption | 2025 | react-dropzone ~3M dl/sem vs Uppy ~200k vs FilePond ~100k | Aucun |
| S2 | react-dropzone docs | https://react-dropzone.js.org/ | 3-Doc officielle | 2025 | Hooks-based, file validation, drag-drop, ~8kb. Simple et composable | Aucun |
| S3 | Uppy docs | https://uppy.io/docs/ | 3-Doc officielle | 2025 | Full-featured : resumable (tus), webcam, Dropbox/GDrive. ~150kb. Overkill pour upload simple | Transloadit |

**Qualite** : S1=7.0 S2=7.0 S3=7.0

**GRADE** : Depart BASSE | +0 | = **BASSE**
Sensibilite : react-dropzone = 15x adoption, simple, leger. Uppy = si besoin resumable/multi-source. Reco stable.
Biais : S3 = Transloadit vendor mais lib open-source.

**Recommandation** : **react-dropzone** | GRADE=BASSE | Niveau=CONTEXTUEL
> 15x adoption, hooks-based, ~8kb. Uppy = overkill sauf si upload resumable ou multi-source requis.

---

## Decision 30 — Icons (Lucide vs Heroicons vs FontAwesome vs react-icons)

**PICOC** : P=app web avec iconographie coherente | I=Lucide | C=Heroicons, FontAwesome, react-icons | O=coherence, bundle, tree-shaking, completude | C=React 19 + shadcn/ui

**PRISMA** : Sources : npm trends, docs officielles, bundlephobia | Trouves=10 | Filtres=7 | Inclus=4

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | npm trends icons | https://npmtrends.com/lucide-react-vs-react-icons-vs-@heroicons/react | 4-Donnees adoption | 2025 | react-icons ~5M, lucide-react ~4M, heroicons ~2M | Aucun |
| S2 | Lucide docs | https://lucide.dev/guide/ | 3-Doc officielle | 2025 | Fork de Feather. 1500+ icones, tree-shakeable, ~1kb/icone SVG, coherent | Aucun |
| S3 | shadcn/ui icons | https://ui.shadcn.com/docs/components/icons | 3-Doc officielle | 2025 | shadcn/ui utilise Lucide comme lib d'icones par defaut | Aucun |
| S4 | Heroicons docs | https://heroicons.com/ | 3-Doc officielle | 2025 | Par Tailwind Labs. 300+ icones. Moins complet que Lucide | Tailwind Labs |

**Qualite** : S1=7.0 S2=7.0 S3=7.0 S4=6.5

**GRADE** : Depart BASSE | +0 | = **BASSE**
Sensibilite : Lucide = integration shadcn + plus d'icones que Heroicons. react-icons = bundle massif si non tree-shake. Reco stable.
Biais : S4 = Tailwind Labs vendor, mais comparaison factuelle.

**Recommandation** : **Lucide** | GRADE=BASSE | Niveau=CONTEXTUEL
> Integration shadcn/ui native, 1500+ icones, tree-shakeable. Heroicons = alternative si stack Tailwind pure sans shadcn.

---

## Decision 31 — Keyboard shortcuts (custom hooks vs react-hotkeys-hook vs Mousetrap)

**PICOC** : P=app power-user avec raccourcis clavier | I=react-hotkeys-hook | C=custom hook, Mousetrap, tinykeys | O=DX, conflit detection, a11y | C=React 19

**PRISMA** : Sources : npm trends, docs officielles | Trouves=7 | Filtres=4 | Inclus=3

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | npm trends hotkeys | https://npmtrends.com/react-hotkeys-hook-vs-mousetrap-vs-tinykeys | 4-Donnees adoption | 2025 | react-hotkeys-hook ~700k, tinykeys ~300k, mousetrap ~200k (stale) | Aucun |
| S2 | react-hotkeys-hook docs | https://react-hotkeys-hook.vercel.app/ | 3-Doc officielle | 2025 | useHotkeys() hook, scope support, enableOnFormTags, <3kb | Aucun |
| S3 | tinykeys docs | https://github.com/jamiebuilds/tinykeys | 3-Doc officielle | 2024 | <1kb, vanilla JS, key sequences. Pas React-specific | Aucun |

**Qualite** : S1=7.0 S2=6.5 S3=6.0

**GRADE** : Depart BASSE | +0 | = **BASSE**
Sensibilite : react-hotkeys-hook = meilleure integration React. tinykeys = si vanilla prefere. Reco stable.
Biais : aucun.

**Recommandation** : **react-hotkeys-hook** | GRADE=BASSE | Niveau=CONTEXTUEL
> Hook React natif, scope support, <3kb. Mousetrap = deprecated. tinykeys = alternative vanilla.

---

## Decision 32 — PDF viewer (@react-pdf/renderer vs react-pdf vs pdf.js)

**PICOC** : P=app affichant des documents PDF (cours, certificats) | I=react-pdf (viewer) + @react-pdf/renderer (generation) | C=pdf.js direct, iframe | O=rendu fidele, DX React, bundle | C=React 19

**PRISMA** : Sources : npm trends, docs officielles | Trouves=8 | Filtres=5 | Inclus=3

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | npm trends pdf | https://npmtrends.com/react-pdf-vs-@react-pdf/renderer | 4-Donnees adoption | 2025 | react-pdf (viewer) ~1.5M, @react-pdf/renderer (gen) ~600k | Aucun |
| S2 | react-pdf docs | https://github.com/wojtekmaj/react-pdf | 3-Doc officielle | 2025 | Wrapper React pour pdf.js. Pages, zoom, text selection. Par Wojciech Maj | Aucun |
| S3 | @react-pdf/renderer docs | https://react-pdf.org/ | 3-Doc officielle | 2025 | Generation PDF cote client avec composants React. Pour certificats/exports | Aucun |

**Qualite** : S1=7.0 S2=7.0 S3=7.0

**GRADE** : Depart BASSE | +0 | = **BASSE**
Sensibilite : deux libs complementaires (viewer vs generator). Reco stable.
Biais : aucun.

**Recommandation** : **react-pdf (viewer) + @react-pdf/renderer (generation)** | GRADE=BASSE | Niveau=CONTEXTUEL
> react-pdf pour afficher (pdf.js wrapper). @react-pdf/renderer pour generer (certificats). Deux libs complementaires.

---

## Decision 33 — Markdown editor (@uiw/react-md-editor vs MDXEditor vs custom Tiptap)

**PICOC** : P=app avec edition markdown (cours, notes) | I=@uiw/react-md-editor | C=MDXEditor, Tiptap markdown extension, textarea brut | O=preview live, DX, extensibilite | C=React 19

**PRISMA** : Sources : npm trends, docs officielles | Trouves=8 | Filtres=5 | Inclus=3

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | npm trends md | https://npmtrends.com/@uiw/react-md-editor-vs-@mdxeditor/editor | 4-Donnees adoption | 2025 | @uiw/react-md-editor ~300k dl/sem vs MDXEditor ~100k | Aucun |
| S2 | @uiw/react-md-editor | https://uiwjs.github.io/react-md-editor/ | 3-Doc officielle | 2025 | Split view (edit+preview), toolbar, dark mode, ~50kb | Aucun |
| S3 | MDXEditor docs | https://mdxeditor.dev/ | 3-Doc officielle | 2025 | WYSIWYG markdown, rich toolbars, JSX support. Plus complexe | Aucun |

**Qualite** : S1=6.5 S2=6.5 S3=6.5

**GRADE** : Depart BASSE | +0 | = **BASSE**
Sensibilite : si Tiptap deja choisi (Decision 26), utiliser extension markdown Tiptap = plus coherent. Reco conditionnelle.
Biais : aucun.

**Recommandation** : **Tiptap markdown extension** (si Tiptap adopte) sinon **@uiw/react-md-editor** | GRADE=BASSE | Niveau=CONTEXTUEL
> Coherence avec Decision 26 (Tiptap). Si editeur markdown standalone necessaire, @uiw = 3x adoption MDXEditor.

---

## Decision 34 — URL state (nuqs vs custom useSearchParams vs query-string)

**PICOC** : P=SPA avec filtres/recherche persistant dans l'URL | I=nuqs | C=custom useSearchParams, query-string | O=DX, type-safety, SSR-compatibility | C=React 19 + Vite (pas Next.js)

**PRISMA** : Sources : npm trends, docs officielles | Trouves=6 | Filtres=4 | Inclus=3

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | npm trends | https://npmtrends.com/nuqs-vs-query-string | 4-Donnees adoption | 2025 | query-string ~10M (utility), nuqs ~300k (croissance rapide) | Aucun |
| S2 | nuqs docs | https://nuqs.47ng.com/ | 3-Doc officielle | 2025 | Type-safe URL state, parsers, history mode, shallow updates. React 19 compatible | Aucun |
| S3 | React Router useSearchParams | https://reactrouter.com/en/main/hooks/use-search-params | 3-Doc officielle | 2025 | Built-in, pas de dep supplementaire. Pas de type-safety, API bas-niveau | Aucun |

**Qualite** : S1=6.5 S2=7.0 S3=7.5

**GRADE** : Depart BASSE | +0 | = **BASSE**
Sensibilite : useSearchParams = zero dep mais verbose. nuqs = meilleure DX mais dep supplementaire. Tradeoff simplicite vs DX.
Biais : aucun.

**Recommandation** : **nuqs** | GRADE=BASSE | Niveau=CONTEXTUEL
> Type-safe URL state, parsers integraces, React 19 compatible. useSearchParams = acceptable si besoins simples.

---

## Decision 35 — Image cropping (react-image-crop vs react-easy-crop vs Cropper.js)

**PICOC** : P=app avec upload photo profil + crop | I=react-easy-crop | C=react-image-crop, Cropper.js | O=DX, mobile touch, aspect ratio lock, bundle | C=React 19

**PRISMA** : Sources : npm trends, docs officielles | Trouves=7 | Filtres=4 | Inclus=3

| # | Source | URL | Pyramide | Annee | Data point | CoI |
|---|--------|-----|----------|-------|------------|-----|
| S1 | npm trends crop | https://npmtrends.com/react-easy-crop-vs-react-image-crop-vs-cropperjs | 4-Donnees adoption | 2025 | react-image-crop ~500k, react-easy-crop ~400k, cropperjs ~600k | Aucun |
| S2 | react-easy-crop docs | https://github.com/ValentinH/react-easy-crop | 3-Doc officielle | 2025 | Touch-friendly, aspect ratio lock, zoom, rotation. Hooks API. ~10kb | Aucun |
| S3 | react-image-crop docs | https://github.com/DominicTobias/react-image-crop | 3-Doc officielle | 2025 | Lightweight (~5kb), responsive, no dependencies. Pas de touch zoom | Aucun |

**Qualite** : S1=6.5 S2=6.5 S3=6.5

**GRADE** : Depart BASSE | +0 | = **BASSE**
Sensibilite : react-easy-crop = meilleur touch + zoom. react-image-crop = plus leger. Adoption similaire. Reco faible.
Biais : aucun.

**Recommandation** : **react-easy-crop** | GRADE=BASSE | Niveau=CONTEXTUEL
> Touch-friendly (mobile crop), zoom/rotation, aspect ratio lock. react-image-crop = alternative si bundle minimal prioritaire.

---

# Resume des recommandations

| # | Decision | Recommandation | GRADE | Niveau |
|---|----------|---------------|-------|--------|
| 1 | Spacing | 8pt grid (base 4pt) | MODEREE | RECOMMANDE |
| 2 | Typography | Inter (preload+swap) | MODEREE | RECOMMANDE |
| 3 | Colors/contrast | WCAG AA + design tokens | HAUTE | STANDARD |
| 4 | Animations | CSS transitions + Motion | MODEREE | RECOMMANDE |
| 5 | Shadows | Echelle Tailwind tokens | MODEREE | RECOMMANDE |
| 6 | Component library | shadcn/ui (Radix+Tailwind) | MODEREE | RECOMMANDE |
| 7 | Navigation | Sidebar collapsible | MODEREE | RECOMMANDE |
| 8 | Forms | React Hook Form + Zod | MODEREE | RECOMMANDE |
| 9 | Responsive | Mobile-first CSS, desktop-first design | MODEREE | RECOMMANDE |
| 10 | Loading states | Skeleton + Spinner | MODEREE | RECOMMANDE |
| 11 | Empty states | Illustration + CTA | MODEREE | RECOMMANDE |
| 12 | Real-time | WebSocket (STOMP/SockJS) | HAUTE | STANDARD |
| 13 | Charts | Recharts | BASSE | CONTEXTUEL |
| 14 | Search | PostgreSQL full-text | MODEREE | RECOMMANDE |
| 15 | User effectiveness | Umami self-hosted | HAUTE | STANDARD |
| 16 | Visual trends | Flat + subtle depth | MODEREE | RECOMMANDE |
| 17 | Onboarding | Checklist + tooltips | MODEREE | RECOMMANDE |
| 18 | Pagination | Pagination classique | MODEREE | RECOMMANDE |
| 19 | Meta/SEO | CSR + react-helmet-async | MODEREE | RECOMMANDE |
| 20 | Resizable panels | react-resizable-panels | BASSE | CONTEXTUEL |
| 21 | Drag and drop | @dnd-kit | BASSE | CONTEXTUEL |
| 22 | Data tables | TanStack Table | BASSE | CONTEXTUEL |
| 23 | Virtual lists | TanStack Virtual + Virtuoso | BASSE | CONTEXTUEL |
| 24 | Data fetching | TanStack Query | MODEREE | RECOMMANDE |
| 25 | Toasts | Sonner | BASSE | CONTEXTUEL |
| 26 | Rich text editor | Tiptap | BASSE | CONTEXTUEL |
| 27 | Command palette | cmdk | BASSE | CONTEXTUEL |
| 28 | Date picker | date-fns + shadcn Calendar | BASSE | CONTEXTUEL |
| 29 | File upload | react-dropzone | BASSE | CONTEXTUEL |
| 30 | Icons | Lucide | BASSE | CONTEXTUEL |
| 31 | Keyboard shortcuts | react-hotkeys-hook | BASSE | CONTEXTUEL |
| 32 | PDF viewer | react-pdf + @react-pdf/renderer | BASSE | CONTEXTUEL |
| 33 | Markdown editor | Tiptap markdown ext | BASSE | CONTEXTUEL |
| 34 | URL state | nuqs | BASSE | CONTEXTUEL |
| 35 | Image cropping | react-easy-crop | BASSE | CONTEXTUEL |
