# Bundle Optimization

**[RECOMMANDE]** Vite code splitting + lazy routes + tree shaking | Score GRADE : 4/7

Cible : bundle initial < 200KB gzipped, LCP < 2.5s (Core Web Vital).

## Lazy routes

```tsx
const Laboratoire = lazy(() => import('./pages/laboratoire/Laboratoire'));
const Chat = lazy(() => import('./pages/chat/Chat'));

const router = createBrowserRouter([
  { path: '/lab', element: <Suspense fallback={<Skeleton />}><Laboratoire /></Suspense> },
  { path: '/chat', element: <Suspense fallback={<Skeleton />}><Chat /></Suspense> },
]);
```

## Vendor splitting

```ts
// vite.config.ts
build: {
  rollupOptions: {
    output: {
      manualChunks: {
        react: ['react', 'react-dom', 'react-router'],
        ui: ['@radix-ui/react-dialog', '@radix-ui/react-dropdown-menu'],
      },
    },
  },
},
```

Sources : Vite docs Build Optimizations (niv. 3), web.dev Core Web Vitals (niv. 4), web.dev code splitting guide (niv. 5)
