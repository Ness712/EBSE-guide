# Threat Modeling

**[BONNE PRATIQUE]** Modelisation des menaces avec **STRIDE** en phase de conception | Score GRADE : 3/7

Le threat modeling identifie les menaces **avant** l'implementation. A realiser a chaque nouvelle fonctionnalite ou changement d'architecture.

## Methodologie STRIDE

| Menace | Description | Exemple | Mitigation |
|--------|-------------|---------|------------|
| **S**poofing | Usurpation d'identite | Faux JWT | Authentification forte |
| **T**ampering | Modification non autorisee | Body HTTP modifie | Validation + signatures |
| **R**epudiation | Nier une action | "Je n'ai pas supprime" | Audit logging |
| **I**nformation Disclosure | Fuite de donnees | Stack trace exposee | Error handling, chiffrement |
| **D**enial of Service | Rendre indisponible | Flood de requetes | Rate limiting |
| **E**levation of Privilege | Escalade de droits | IDOR, role bypass | RBAC, validation cote serveur |

## Quand threat modeler ?

| Moment | Action |
|--------|--------|
| Conception d'un nouveau module | STRIDE complet sur le DFD |
| Ajout d'une API externe | Evaluer S, T, I |
| Changement d'authentification | STRIDE complet |
| Avant chaque release majeure | Revue des menaces existantes |

## Processus minimal

1. Dessiner le **Data Flow Diagram** (DFD) du composant
2. Appliquer **STRIDE** sur chaque flux / trust boundary
3. Prioriser par impact (DREAD ou matrice risque)
4. Documenter les mitigations dans les tickets

## Sources

- [niv. 1] SWEBOK v4 Security Knowledge Area — threat modeling in design phase
- [niv. 2] OWASP Threat Modeling Cheat Sheet — STRIDE methodology, DFD-based approach
- [niv. 5] Microsoft SDL — STRIDE originator, threat modeling mandatory in design
