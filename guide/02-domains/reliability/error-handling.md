# Error handling

## Strategie

**[STANDARD]** Centraliser le traitement des erreurs, ne JAMAIS exposer de details internes | Score GRADE : 6/7

```
"Error handling should be planned as an architectural concern,
 not left to individual developers' judgment at each call site."
 — SWEBOK v4, Construction Quality
```

```
"Error handling reveals stack traces or other overly informative error messages to users."
 — OWASP Top 10 A05 (Security Misconfiguration), 208 387 occurrences, 90% des apps testees
```

CWE-209 (messages d'erreur contenant des infos sensibles) : **Likelihood of Exploit = HIGH**.

Sources : SWEBOK v4 (niv. 1), RFC 9457 (niv. 1), OWASP Error Handling CS + Top 10 A05 (niv. 2), CWE-209 (niv. 2)

---

## Backend (Spring Boot) — RFC 9457 Problem Details

**[RECOMMANDE]** Utiliser **RFC 9457 ProblemDetail** via `@ControllerAdvice` | Score GRADE : 5/7

```properties
# application.properties
spring.mvc.problemdetails.enabled=true
```

```java
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(ResourceNotFoundException.class)
    public ProblemDetail handleNotFound(ResourceNotFoundException ex) {
        ProblemDetail pb = ProblemDetail.forStatusAndDetail(
            HttpStatus.NOT_FOUND, ex.getMessage());
        pb.setTitle("Ressource introuvable");
        pb.setProperty("resource", ex.getResourceName());
        return pb;
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ProblemDetail handleValidation(MethodArgumentNotValidException ex) {
        ProblemDetail pb = ProblemDetail.forStatus(HttpStatus.BAD_REQUEST);
        pb.setTitle("Erreur de validation");
        pb.setProperty("violations", ex.getFieldErrors().stream()
            .map(e -> Map.of("field", e.getField(), "message", e.getDefaultMessage()))
            .toList());
        return pb;
    }

    @ExceptionHandler(Exception.class)
    public ProblemDetail handleUnexpected(Exception ex) {
        log.error("Erreur inattendue", ex); // Log complet cote serveur
        ProblemDetail pb = ProblemDetail.forStatus(HttpStatus.INTERNAL_SERVER_ERROR);
        pb.setTitle("Erreur interne");
        pb.setDetail("Une erreur inattendue s'est produite.");
        // JAMAIS de stack trace, nom de classe, ou chemin dans la reponse
        return pb;
    }
}
```

Format de reponse (RFC 9457) :
```json
{
  "type": "about:blank",
  "title": "Erreur de validation",
  "status": 400,
  "detail": "Champs invalides",
  "instance": "/api/users",
  "violations": [
    { "field": "email", "message": "format invalide" }
  ]
}
```

### Status codes semantiques

| Code | Usage |
|------|-------|
| 400 | Validation syntaxique (format, type) |
| 401 | Non authentifie |
| 403 | Non autorise |
| 404 | Ressource introuvable |
| 409 | Conflit (ex: email deja pris) |
| 422 | Validation semantique (regle metier) |
| 500 | Erreur interne (JAMAIS de detail) |

Sources : RFC 9457 (niv. 1), RFC 9110 Section 15 (niv. 1), Spring Boot docs (niv. 3), OWASP Error Handling CS (niv. 2)

---

## Frontend (React) — Error Boundaries

**[RECOMMANDE]** Error Boundaries par section fonctionnelle + catch global async | Score GRADE : 4/7

```tsx
// Error Boundary par section (sidebar, main, bottom panel)
<ErrorBoundary fallback={<ErrorFallback />}>
  <ChatSection />
</ErrorBoundary>

// Fallback contextuel
function ErrorFallback({ error, resetErrorBoundary }) {
  return (
    <div role="alert">
      <p>Impossible de charger cette section.</p>
      <button onClick={resetErrorBoundary}>Reessayer</button>
    </div>
  );
}
```

```tsx
// Typage des erreurs API (RFC 9457)
interface ProblemDetail {
  type: string;
  title: string;
  status: number;
  detail?: string;
  instance?: string;
  violations?: { field: string; message: string }[];
}
```

| Type d'erreur | Gestion |
|---|---|
| Erreur de rendu (composant crash) | Error Boundary → fallback UI |
| Erreur async (API call, event handler) | try-catch → toast notification |
| Erreur reseau (offline, timeout) | Toast avec bouton "Reessayer" |
| Erreur 4xx (validation) | Afficher les violations par champ |
| Erreur 5xx (serveur) | Message generique "Erreur serveur" |

Sources : React docs (niv. 3), OWASP — ne jamais afficher de detail technique (niv. 2)

---

## Regles transversales

| Regle | Source |
|---|---|
| JAMAIS de stack trace dans les reponses HTTP | OWASP Error Handling CS, CWE-209 |
| JAMAIS d'exception avalee silencieusement | McConnell Code Complete, SWEBOK v4 |
| Log complet cote serveur avec correlation ID | OWASP, RFC 9457 `instance` field |
| Toute erreur API suit RFC 9457 (contrat front-back) | RFC 9457 (IETF standard) |
| 4xx = erreur client (message explicatif), 5xx = erreur serveur (message generique) | RFC 9110, OWASP |
| Error Boundary par feature, pas par composant atomique | React docs |

---

## Sources

- [niv. 1] RFC 9457 — Problem Details for HTTP APIs (IETF, 2023)
- [niv. 1] RFC 9110 — HTTP Semantics, Section 15 (IETF, 2022)
- [niv. 1] SWEBOK v4 — error handling as architectural concern, 30-50% du code de prod
- [niv. 2] OWASP Error Handling Cheat Sheet — centraliser, ne jamais exposer
- [niv. 2] OWASP Top 10 A05 — Security Misconfiguration, 208K occurrences
- [niv. 2] CWE-209 — error messages with sensitive info, exploit likelihood HIGH
- [niv. 3] Spring Boot docs — RFC 9457 natif depuis Spring 6.0, @ControllerAdvice
- [niv. 3] React docs — Error Boundaries, fallback UI
- [niv. 5] McConnell Code Complete — "the worst thing is to ignore an error"
- [niv. 5] Nygard Release It! — unhandled exceptions = #1 cause of cascading failures
