# Double Extraction v3.0 — Design + UI Libraries (35 decisions)

**Date** : 2026-04-14
**Agent A** : ab4b13459f297dce0
**Agent B** : ad91b097c1b244303

## Resultats

- **Accord outil : 35/35 (100%)**
- **0 divergence sur les recommandations**
- **GRADE : ±1-2 entre agents (calibration design systems = niveau 5 par defaut)**

## Design (19 decisions)

| # | Decision | Reco | GRADE conservatif |
|---|----------|------|-------------------|
| 1 | Spacing | 8px grid | 4/7 [RECOMMANDE] |
| 2 | Typography | 16px, 1.5 lh, self-hosted | 6/7 [STANDARD] |
| 3 | Colors/contrast | WCAG AA 4.5:1 | 5/7 [STANDARD] |
| 4 | Animations | CSS + Framer Motion, 200-300ms | 5/7 [RECOMMANDE] |
| 5 | Shadows | Elevation tokens | 5/7 [RECOMMANDE] |
| 6 | Component library | shadcn/ui | 4/7 [RECOMMANDE] |
| 7 | Navigation | Sidebar + bottom nav mobile | 6/7 [STANDARD] |
| 8 | Forms | RHF + Zod, single column, on-blur | 6/7 [STANDARD] |
| 9 | Responsive | Mobile-first, Tailwind breakpoints | 5/7 [RECOMMANDE] |
| 10 | Loading states | Skeleton screens | 5/7 [RECOMMANDE] |
| 11 | Empty states | Icon + title + CTA | 4/7 [RECOMMANDE] |
| 12 | Real-time | WebSocket + SSE | 5/7 [STANDARD] |
| 13 | Charts | Recharts | 4/7 [RECOMMANDE] |
| 14 | Search | PostgreSQL FTS (<100K docs) | 4/7 [RECOMMANDE] |
| 15 | User effectiveness | Task success + SUS | 5/7 [RECOMMANDE] |
| 16 | Visual trends | Flat 2.0 + subtle elevation | 4/7 [BONNE_PRATIQUE] |
| 17 | Onboarding | Progressive disclosure + checklist | 4/7 [RECOMMANDE] |
| 18 | Pagination | Cursor API + classic UI | 5/7 [RECOMMANDE] |
| 19 | Meta/SEO | title + meta + OG + JSON-LD | 5/7 [RECOMMANDE] |

## UI Libraries (16 decisions)

| # | Decision | Reco | GRADE conservatif |
|---|----------|------|-------------------|
| 20 | Resizable panels | react-resizable-panels | 5/7 [RECOMMANDE] |
| 21 | Drag and drop | @dnd-kit | 5/7 [RECOMMANDE] |
| 22 | Data tables | TanStack Table | 5/7 [RECOMMANDE] |
| 23 | Virtual lists | @tanstack/react-virtual | 4/7 [RECOMMANDE] |
| 24 | Data fetching | TanStack Query | 4/7 [RECOMMANDE] |
| 25 | Toast | Sonner | 4/7 [RECOMMANDE] |
| 26 | Rich text | Tiptap | 4/7 [RECOMMANDE] |
| 27 | Command palette | cmdk | 5/7 [RECOMMANDE] |
| 28 | Date picker | shadcn Calendar + date-fns | 4/7 [RECOMMANDE] |
| 29 | File upload | react-dropzone | 4/7 [RECOMMANDE] |
| 30 | Icons | Lucide React | 5/7 [RECOMMANDE] |
| 31 | Keyboard shortcuts | react-hotkeys-hook | 4/7 [RECOMMANDE] |
| 32 | PDF viewer | react-pdf | 4/7 [RECOMMANDE] |
| 33 | Markdown editor | @uiw/react-md-editor | 4/7 [RECOMMANDE] |
| 34 | URL state | nuqs | 3/7 [BONNE_PRATIQUE] |
| 35 | Image cropping | react-easy-crop | 4/7 [RECOMMANDE] |
