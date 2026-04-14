# Conformite RGPD

**[STANDARD]** Conformite RGPD obligatoire pour tout traitement de donnees personnelles UE | Score GRADE : 7/7

Le RGPD est une **obligation legale**, pas une bonne pratique. Non-conformite = amende jusqu'a 4% du CA mondial.

## Exigences cles

| Exigence | Article RGPD | Implementation |
|----------|-------------|----------------|
| Consentement explicite | Art. 6, 7 | Banner cookie avec opt-in (pas pre-coche) |
| Droit d'acces / export | Art. 15, 20 | Endpoint `GET /api/v1/users/me/data` (JSON) |
| Droit a l'effacement | Art. 17 | Endpoint `DELETE /api/v1/users/me` + anonymisation |
| Minimisation des donnees | Art. 5(1)(c) | Ne collecter que le strict necessaire |
| Privacy by design | Art. 25 | Chiffrement, pseudonymisation, acces minimal |

## Endpoint d'export (Spring Boot)

```java
@GetMapping("/api/v1/users/me/data")
public ResponseEntity<UserDataExport> exportMyData(@AuthenticationPrincipal User user) {
    UserDataExport export = userService.collectAllPersonalData(user.getId());
    return ResponseEntity.ok()
        .header("Content-Disposition", "attachment; filename=mes-donnees.json")
        .body(export);
}
```

## Checklist minimale

- [ ] Banner de consentement avec refus aussi simple qu'acceptation
- [ ] Politique de confidentialite accessible et a jour
- [ ] Endpoint export des donnees personnelles (format machine-readable)
- [ ] Endpoint suppression / anonymisation du compte
- [ ] Registre des traitements (Art. 30)
- [ ] Retention des donnees definie et appliquee automatiquement

## Sources

- [niv. 1] Reglement UE 2016/679 (RGPD) — Art. 5, 6, 7, 15, 17, 20, 25, 30
- [niv. 1] CNIL — Guidelines consentement, droit a l'effacement, privacy by design
- [niv. 2] OWASP Top 10 Privacy Risks — data minimization, consent management
