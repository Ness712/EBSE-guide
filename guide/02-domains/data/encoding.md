# Encodage de caracteres

**[STANDARD]** UTF-8 partout : base de donnees, API, fichiers, HTML | Score GRADE : 7/7

UTF-8 est le seul encodage acceptable. Tout autre choix cause des bugs d'affichage et des failles de securite.

```yaml
# PostgreSQL — verifier a la creation de la DB
# CREATE DATABASE ols WITH ENCODING 'UTF8';

# Spring Boot
server:
  servlet:
    encoding:
      charset: UTF-8
      force: true

# HTML
# <meta charset="UTF-8">
```

| Couche | Configuration |
|--------|--------------|
| Base de donnees | `ENCODING 'UTF8'` + `LC_COLLATE 'fr_FR.UTF-8'` |
| API HTTP | `Content-Type: application/json; charset=utf-8` |
| HTML | `<meta charset="UTF-8">` en premiere balise du `<head>` |
| Fichiers source | UTF-8 sans BOM |

Sources : IETF RFC 3629 — standard UTF-8 (niv. 1), W3C — UTF-8 obligatoire pour HTML5 (niv. 1), Web Almanac 2024 — 98.2% du web en UTF-8 (niv. 4)
