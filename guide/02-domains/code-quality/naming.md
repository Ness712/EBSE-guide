# Conventions de nommage

**[BONNE PRATIQUE]** Conventions coherentes par langage et contexte | Score GRADE : 3/7

Un nommage incoherent ralentit la lecture du code et introduit des bugs (confusion entre entites). La convention est moins importante que sa **coherence**.

## Conventions par contexte

| Contexte | Convention | Exemple |
|----------|-----------|---------|
| Variables, methodes (Java) | camelCase | `findUserById`, `isActive` |
| Variables, fonctions (TS) | camelCase | `getUserName`, `isLoading` |
| Classes, interfaces (Java) | PascalCase | `UserService`, `JwtFilter` |
| Composants React (TSX) | PascalCase | `UserCard`, `ChatMessage` |
| Fichiers composants React | PascalCase | `UserCard.tsx` |
| Fichiers utilitaires (TS) | kebab-case | `date-utils.ts`, `api-client.ts` |
| Constantes | SCREAMING_SNAKE_CASE | `MAX_RETRIES`, `API_BASE_URL` |
| Tables SQL | snake_case | `user_sessions`, `chat_messages` |
| Endpoints REST | kebab-case | `/api/v1/chat-messages` |
| Variables d'env | SCREAMING_SNAKE_CASE | `DATABASE_URL`, `JWT_SECRET` |

## Regles universelles

| Regle | Exemple bon | Exemple mauvais |
|-------|------------|-----------------|
| Noms descriptifs, pas d'abreviations | `userRepository` | `usrRepo`, `ur` |
| Booleens avec prefixe is/has/can | `isActive`, `hasAccess` | `active`, `access` |
| Collections au pluriel | `users`, `messages` | `userList`, `messageArray` |
| Fonctions = verbe + nom | `findUser`, `deleteMessage` | `user`, `message` |

## Sources

- [niv. 3] Google Java Style Guide — camelCase methods, PascalCase classes
- [niv. 3] Spring Boot conventions — repository, service, controller naming
- [niv. 5] Clean Code (Martin) — meaningful names, intention-revealing names
