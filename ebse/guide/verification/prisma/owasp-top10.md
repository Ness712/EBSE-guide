# PRISMA Flow — PICOC #XX : owasp-top10

**Date de recherche** : 2026-04-17
**Bases interrogees** : OWASP.org, NIST SP (800-53/800-44/800-95), MITRE CWE/NVD, ISO/IEC 27034, IEEE Xplore, ResearchGate/IJETMS, Scientific Reports/Nature, Verizon DBIR
**Mots-cles Agent A** : "OWASP Top 10 2021 empirical study", "OWASP Top 10 2025 CVE mapping", "CWE Top 25 2024 CISA MITRE", "NIST SP 800-53 OWASP alignment", "ISO 27034 application security", "OWASP ASVS verification standard", "OWASP WSTG testing methodology", "broken access control A01 2021", "injection prevention parameterized queries", "cryptographic failures TLS web"
**Mots-cles Agent B** : "OWASP Top 10 proactive controls 2024", "NIST SP 800-53 rev5 update 2025", "NVD CVE 2024 vulnerability statistics", "Verizon DBIR 2024 exploitation rate", "SQL injection XSS CNN LSTM detection accuracy", "OWASP cheat sheet injection SQL input validation", "security misconfiguration secure defaults web", "NIST SP 800-95 web services security"
**Protocole** : methodology.md v3.0 §2.1 — double extraction independante (Agents A + B, mots-cles differents) + verification Agent C

---

## Flux

```
IDENTIFICATION
  Sources identifiees par base (Agent A + Agent B combines, avant deduplication) :
    - OWASP.org (Top 10, ASVS, WSTG, Proactive Controls, Cheat Sheets) : 8 sources
    - NIST SP publications : 4 sources (800-53, 800-44, 800-95, NVD)
    - MITRE (CWE Top 25, Taxonomie CWE) : 2 sources
    - ISO : 1 source (ISO/IEC 27034-1)
    - IEEE Xplore (SLR, etudes empiriques) : ~6 sources candidates
    - ResearchGate / IJETMS (etudes longitudinales OWASP) : ~4 sources candidates
    - Scientific Reports/Nature (etudes ML securite) : ~3 sources candidates
    - Verizon DBIR : 1 source
    - Snowballing backward : ~5 sources
  Total identifie (brut, combine A+B) : ~34
  Doublons retires (OWASP Top 10 2021 identifie par A et B) : 3
  Total apres deduplication : ~31

SCREENING (titre + resume)
  Sources screenees : ~31
  Sources exclues au screening : ~16
    - E1 (blog/opinion sans donnees) : ~7
    - E2 (hors scope PICOC — securite reseau, non web) : ~5
    - E3 (doublons partiels) : ~2
    - E4 (vendeur sans methodologie transparente) : ~2

ELIGIBILITE (lecture complete)
  Sources evaluees en detail : ~15
  Sources exclues apres lecture complete : ~2
    - Etude longitudinale ResearchGate/IJETMS 2023 : incluse mais niveau 4 (pas niv.3) — pas de peer review IEEE
    - NIST SP 800-44 v2 2007 : incluse comme source fondatrice malgre retrait NIST (valeur normative historique confirmee)

INCLUSION
  Sources incluses dans la synthese : 13
    - Niveau 1 : 7 (NIST SP 800-53 Rev.5, CWE Top 25 CISA/DHS, MITRE CWE v4.x, ISO/IEC 27034-1, NIST NVD, NIST SP 800-44 v2, NIST SP 800-95)
    - Niveau 2 : 6 (OWASP Top 10 2021, OWASP Top 10 2025, OWASP ASVS 5.0, OWASP WSTG v4.2, OWASP Proactive Controls 2024, OWASP Cheat Sheet Series)
    - Niveau 3 : 1 (Tadhani et al. 2024 Scientific Reports/Nature — CNN+LSTM)
    - Niveau 4 : 2 (IEEE SLR Vulnerability Scanners 2022 ; Verizon DBIR 2024)
    - Niveau 5 : 0

  Sources exclues avec raison documentee : 2
    - Etude IJETMS 2023 (ResearchGate) : retenue niveau 4 — classee survey large-scale apres lecture complete, non peer-reviewed IEEE
    - Blogs securite (SANS, blog.securite) : E1 redondant avec sources institutionnelles
```

---

## Documentation recherche (Table 2 Kitchenham)

### Agent A — bases interrogees

| Element | Valeur |
|---------|--------|
| Bases | OWASP.org, NIST.gov, MITRE.org, ISO catalog, IEEE Xplore |
| Mots-cles | "OWASP Top 10 empirical", "CWE Top 25 2024 CISA", "NIST SP 800-53 OWASP alignment", "OWASP ASVS WSTG verification testing" |
| Periode couverte | 2007-2026 (fondateurs) + 2021-2026 (recents) |
| Sources identifiees | ~20 |
| Sources retenues | 10 |
| Date d'extraction | 2026-04-17 |

### Agent B — bases interrogees

| Element | Valeur |
|---------|--------|
| Bases | OWASP.org, NIST.gov, NVD, Verizon DBIR, Scientific Reports/Nature, IEEE Xplore |
| Mots-cles | "OWASP proactive controls 2024", "NVD CVE statistics 2024", "Verizon DBIR 2024 exploitation", "SQL injection detection ML", "NIST SP 800-95 secure web services" |
| Periode couverte | 2007-2025 |
| Sources identifiees | ~14 |
| Sources retenues | 7 (convergence elevee avec A sur les sources OWASP et NIST) |
| Date d'extraction | 2026-04-17 |

---

## Sources exclues — raisons documentees

| Source | Raison exclusion |
|--------|-----------------|
| SANS Institute blog posts securite web | E1 — niveau 5 redondant avec sources OWASP institutionnelles |
| OWASP Testing Guide v3 (2008) | E3 — absorbe par WSTG v4.2 (version active) |
| PCI DSS v4.0 (directement) | E2 — cite OWASP mais perimetre commerce carte, pas securite web universelle. Mentionne dans etd_balance comme benefice de conformite |
| CVSSv3 scoring documentation | E2 — outil de scoring, pas referentiel de vulnerabilites web — hors PICOC direct |
| Microsoft SDL documentation | E4 — biais vendeur, methode proprietaire non replicable independamment |
| PortSwigger Web Security Academy | E1/E4 — excellent contenu pedagogique mais source commerciale Burp Suite, pas source normative independante |
