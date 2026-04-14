# Precision numerique

**[STANDARD]** `BigDecimal` pour les montants, alternative : stocker en centimes (integer) | Score GRADE : 5/7

Les flottants IEEE 754 (`double`, `float`) causent des erreurs d'arrondi inacceptables pour les calculs financiers : `0.1 + 0.2 = 0.30000000000000004`.

```java
// Option 1 : BigDecimal (precision arbitraire)
BigDecimal prix = new BigDecimal("19.99");
BigDecimal tva = prix.multiply(new BigDecimal("0.20")).setScale(2, RoundingMode.HALF_UP);

// Option 2 : Integer centimes (plus simple, pas d'arrondi)
int prixCentimes = 1999;  // 19.99 EUR
int tvaCentimes = prixCentimes * 20 / 100; // 399 = 3.99 EUR

// JAMAIS : double prix = 19.99;
```

| Approche | Avantages | Inconvenients |
|----------|-----------|--------------|
| BigDecimal | Precision arbitraire, standard | Verbose, plus lent |
| Integer centimes | Simple, rapide, pas d'arrondi | Limite aux 2 decimales |
| float/double | **INTERDIT pour les montants** | Erreurs d'arrondi |

Sources : IEEE 754 — limitations documentees des flottants (niv. 1), Java docs — BigDecimal pour calculs financiers (niv. 5), OWASP — rounding errors dans les paiements (niv. 3)
