# Formulaires

**[RECOMMANDE]** React Hook Form + Zod + validation inline temps-reel | Score GRADE : 4/7

La validation inline (au blur/changement) reduit les erreurs de soumission de 22% vs validation a la soumission seule (Baymard). Zod garantit le type-safety bout en bout.

```typescript
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { z } from 'zod';

const schema = z.object({
  email: z.string().email('Email invalide'),
  password: z.string().min(8, 'Minimum 8 caracteres'),
});

const { register, handleSubmit, formState: { errors } } = useForm({
  resolver: zodResolver(schema),
  mode: 'onBlur', // validation inline au blur
});
```

- Labels toujours visibles (jamais placeholder seul — WCAG 3.3.2)
- Messages d'erreur sous le champ, en rouge avec icone (pas couleur seule)
- 1 colonne par defaut (Baymard : 2 colonnes augmentent le taux d'erreur)

Sources : Baymard Institute — inline validation +22% completion (niv. 3), React Hook Form docs — performance re-render minimal (niv. 5), WCAG 2.2 SC 3.3.1/3.3.2 — identification et labels d'erreur (niv. 1)
