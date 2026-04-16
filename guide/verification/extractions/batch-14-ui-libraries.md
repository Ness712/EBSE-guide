# Double Extraction — Batch 14 : Librairies UI React (16 decisions)

**Date** : 2026-04-14
**Agent A** : a221249586c14f248
**Agent B** : a96a97abbad5d9e2e

## Resultats

- **Accord outils : 14/16 (87.5%)**
- **2 divergences** : date picker (react-day-picker vs react-datepicker), markdown editor (react-markdown vs @mdxeditor)

| # | Besoin | Reco | GRADE conservatif |
|---|--------|------|-------------------|
| 1 | Panels redimensionnables | react-resizable-panels | 6/7 |
| 2 | Drag and drop | @dnd-kit/core + @dnd-kit/sortable | 6/7 |
| 3 | Tables tri/filtre/page | @tanstack/react-table | 7/7 |
| 4 | Listes virtualisees | @tanstack/react-virtual | 6/7 |
| 5 | Data fetching + cache | @tanstack/react-query | 7/7 |
| 6 | Toast notifications | sonner | 5/7 |
| 7 | Editeur rich text | TipTap (@tiptap/react) | 5/7 |
| 8 | Command palette | cmdk | 6/7 |
| 9 | Date picker | react-day-picker (shadcn default) | 4/7 |
| 10 | File upload | react-dropzone | 6/7 |
| 11 | Icones | lucide-react | 7/7 |
| 12 | Keyboard shortcuts | react-hotkeys-hook | 5/7 |
| 13 | PDF viewer | react-pdf | 5/7 |
| 14 | Markdown editor | react-markdown (affichage) + TipTap markdown (edition) | 4/7 |
| 15 | URL state | nuqs | 5/7 |
| 16 | Image cropping | react-easy-crop | 4/7 |

## Divergences resolues

- **#9 Date picker** : A recommande react-day-picker (shadcn default), B recommande react-datepicker (npm leader). Resolution : react-day-picker retenu car deja dans l'ecosysteme shadcn/Radix et headless (Tailwind-friendly).
- **#14 Markdown** : A recommande react-markdown + @uiw editor, B recommande @mdxeditor. Resolution : react-markdown pour l'affichage (2.5M/sem, standard), TipTap avec extension markdown pour l'edition WYSIWYG.
