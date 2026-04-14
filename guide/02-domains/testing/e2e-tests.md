# Tests E2E

**[RECOMMANDE]** **Playwright** | Score GRADE : 4/7

## Pourquoi Playwright

| Critere | Playwright | Cypress |
|---------|-----------|---------|
| Multi-browser | Chromium + Firefox + WebKit | Chromium uniquement (gratuit) |
| Multi-tab/multi-origin | Oui | Non |
| Auto-waiting | Natif, pas de flaky cy.wait() | Requires cy.wait() |
| Parallelisation | Natif, gratuit | Payant (Cypress Cloud) |
| API testing | Integre | Plugin |
| npm dl/sem | Depasse Cypress (2025) | En plateau |

```typescript
// playwright.config.ts
export default defineConfig({
  testDir: './e2e',
  retries: process.env.CI ? 2 : 0,
  use: { baseURL: 'http://localhost:5173', trace: 'on-first-retry' },
  projects: [
    { name: 'chromium', use: { ...devices['Desktop Chrome'] } },
    { name: 'firefox', use: { ...devices['Desktop Firefox'] } },
  ],
  webServer: { command: 'npm run dev', url: 'http://localhost:5173' },
});
```

```typescript
test('login flow', async ({ page }) => {
  await page.goto('/login');
  await page.getByLabel('Email').fill('user@test.com');
  await page.getByLabel('Mot de passe').fill('password123!');
  await page.getByRole('button', { name: 'Connexion' }).click();
  await expect(page.getByText('Tableau de bord')).toBeVisible();
});
```

Sources : State of JS 2024 — Playwright #1 satisfaction (niv. 4), JetBrains 2024 — croissance la plus rapide (niv. 4), npm trends — depasse Cypress (niv. 4), Playwright docs (niv. 3)
