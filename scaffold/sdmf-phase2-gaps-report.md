# SDMF Plan 2 — Rapport de synthèse Agent C

**Date :** 2026-04-18
**Méthode :** 6 phases SDMF (ODD, FMEA, KAOS, STRIDE, Kassab RE, MIT AI Risk) + synthèse Agent C indépendant
**Référence scaffold :** `scaffold/scaffold-claude.md` v2.0
**Compliance matrix :** `scaffold/compliance-matrix.md` (17/24 Mandatory hookés avant ce rapport)

---

## 1. Convergences inter-phases (gaps cités dans 3+ phases — priorité maximale)

| Gap | Phases sources | Niveau BSAF | Hookable | Notes |
|-----|---------------|-------------|----------|-------|
| **Secrets exposés en clair (PR, commits, messages)** | FMEA(G2-17%), KAOS(G2), STRIDE(InfoDisc), MIT(2.3) | MANDATORY | ✅ | Regex patterns pre-commit + pre-pr-create |
| **Sub-agent : credentials dans le prompt** | KAOS(G17), STRIDE(InfoDisc), FMEA | MANDATORY | ✅ | Deny : contexte VIERGE obligatoire |
| **browser_close() non denié** | KAOS(G18-0%), STRIDE(Spoofing), FMEA | MANDATORY | ✅ | Ajouter à deny list |
| **Test E2E sans assertion réelle** | FMEA(RPN 336), Kassab(D3), STRIDE(Spoofing) | MANDATORY | ✅ | Hook grep `expect\|assert\|toBe` |
| **CI rouge → push non bloqué** | ODD, KAOS(G10), Kassab(D3), FMEA | MANDATORY | ✅ | Hook pre-push : `gh run view` avant push |
| **Gate PII non mécanisée** | ODD, KAOS(G6-0%), STRIDE, MIT(2.3) | MANDATORY | ✅ | Hook pre-commit : regex email/SSN/phone |
| **Urgence prod / PO indisponible** | ODD, Kassab(D3-critique), KAOS | MANDATORY | ❌ | Section CLAUDE.md SEV1/SEV2/SEV3 |
| **Boucle infinie de corrections** | Kassab(D3), KAOS(G22), STRIDE(DoS) | MANDATORY | ❌ | Règle : max 5 itérations → escalade |
| **Sous-agents contradictoires** | Kassab(D3/D4), KAOS(G21) | REQUIRED | ❌ | Protocole de réconciliation |
| **Bash exit code ignoré** | FMEA(RPN 392), STRIDE(Repudiation) | MANDATORY | ✅ | Hook enforce `set -e; set -o pipefail` |
| **Modifications hors scope du plan** | FMEA(RPN 360), STRIDE(Tampering) | MANDATORY | ✅ | pre-commit : diff vs plan explicite |
| **Prompt injection / jailbreak** | KAOS(G23), STRIDE(EoP), MIT(7.3) | MANDATORY | ✅ (partiel) | Hook pre-tool-use : regex patterns injection |

---

## 2. Gaps Mandatory hookables (nouveaux — pas encore dans compliance matrix)

Ces hooks sont mécanisables et doivent être ajoutés aux scripts existants.

### H1 — browser_close() deny
**Mécanisme :** Ajouter `mcp__playwright__browser_close` à la deny list dans `.claude/settings.json`
**Effort :** 5 min
**Source :** KAOS G18, STRIDE Spoofing Playwright

### H2 — Secrets masking (pre-commit + pre-pr-create)
**Mécanisme :** `pre-commit-quality.sh` — grep patterns dans fichiers stagés :
```bash
grep -rE "(password|apikey|api_key|secret|token|bearer)\s*=\s*['\"][^'\"]{8,}" "$STAGED_FILES" && exit 2
```
**Effort :** 1h
**Source :** FMEA G2, KAOS G2, STRIDE InfoDisc, MIT 2.3

### H3 — Co-Authored-By hook pre-commit
**Mécanisme :** Vérifier que chaque commit message contient `Co-Authored-By:`
```bash
git log -1 --pretty=%B | grep -q 'Co-Authored-By' || { echo "[hook] Co-Authored-By manquant" >&2; exit 2; }
```
**Effort :** 30 min
**Source :** FMEA(RPN 245), compliance matrix Required → upgrade Mandatory

### H4 — .env validation (keys vs .env.example)
**Mécanisme :** `pre-push-quality.sh` — vérifier que toutes les clés de `.env.example` existent dans `.env`
**Effort :** 1h
**Source :** FMEA(RPN 196), KAOS G2

### H5 — CI status pre-push
**Mécanisme :** `pre-push-quality.sh` — vérifier dernier run CI avant push :
```bash
LAST_STATUS=$(gh run list --limit 1 --json status -q '.[0].status' 2>/dev/null || echo "unknown")
if [ "$LAST_STATUS" = "failure" ]; then
  echo "[hook] CI en échec — corriger avant push" >&2; exit 2
fi
```
**Effort :** 45 min
**Source :** ODD, Kassab D3, KAOS G10

### H6 — Gate PII detection (pre-commit)
**Mécanisme :** Grep patterns PII dans fichiers stagés (emails, téléphones, patterns SSN)
```bash
PII_FOUND=$(git diff --cached -U0 | grep -E '([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}|(\+33|0)[1-9][0-9]{8}|\b\d{3}-\d{2}-\d{4}\b)' || true)
if [ -n "$PII_FOUND" ]; then
  echo "[hook][GATE] MANDATORY — PII détectée dans le commit. Gate PO requise." >&2; exit 2
fi
```
**Effort :** 1.5h
**Source :** KAOS G6, ODD, STRIDE InfoDisc, MIT 2.3

### H7 — Bash shellcheck (scripts)
**Mécanisme :** `pre-commit-quality.sh` — si fichiers `.sh` stagés, lancer shellcheck
**Effort :** 30 min
**Source :** FMEA(RPN 224) — bash variable non initialisée

### H8 — Branche outdated avant PR
**Mécanisme :** `pre-pr-create.sh` — vérifier age divergence avec main :
```bash
BEHIND=$(git rev-list HEAD..origin/main --count 2>/dev/null || echo 0)
if [ "$BEHIND" -gt 10 ]; then
  echo "[hook] Branche outdated ($BEHIND commits behind main) — rebase avant PR" >&2; exit 2
fi
```
**Effort :** 30 min
**Source :** FMEA(RPN 168)

### H9 — .claude/settings.json read-only (pre-commit)
**Mécanisme :** Bloquer toute modification de `.claude/settings.json` par l'agent
```bash
SETTINGS=$(git diff --cached --name-only | grep '.claude/settings.json' || true)
if [ -n "$SETTINGS" ]; then
  echo "[hook][GATE] MANDATORY — .claude/settings.json ne peut être modifié que manuellement par le PO" >&2; exit 2
fi
```
**Effort :** 15 min
**Source :** STRIDE EoP — agent s'ajoute des permissions

### H10 — Prompt injection filter (pre-tool-use)
**Mécanisme :** Hook PreToolUse — filtrer inputs avant exécution LLM
Patterns à détecter : `[SYSTEM]`, `<|im_start|>`, `Ignore previous instructions`, injection SQL-style
**Effort :** 2h (patterns + tests)
**Source :** KAOS G23, STRIDE EoP, MIT 7.3

---

## 3. Gaps Mandatory non-hookables (sections CLAUDE.md à ajouter/réviser)

### N1 — Mode urgence / incident prod
**Section à ajouter :** `## Mode urgence (SEV)`

```markdown
## Mode urgence (SEV) [MANDATORY]

Quand tu détectes un incident en production :

| Sévérité | Définition | Autonomie permise | Délai escalade |
|----------|-----------|-------------------|---------------|
| **SEV1** | Prod down / data loss / security breach | HOTL — agis d'abord, escalade immédiatement | 0 min |
| **SEV2** | Fonctionnalité critique dégradée | HITL — escalade PO avant action | < 30 min |
| **SEV3** | Bug non-critique, workaround possible | HITL normal | < 24h |

**Si PO est indisponible > 4h et SEV1 détecté :**
1. Appliquer le correctif minimal (rollback si possible)
2. Logger TOUTES les actions dans l'audit trail
3. Notifier par le canal alternatif configuré : `[CONFIGURER: slack/email/SMS]`
4. Ne JAMAIS faire de changements d'architecture sous urgence

`Source: Google SRE Book + PICOC #30 ai-agent-monitoring-review-cadence`
```

**Source :** ODD, Kassab D3/D4, KAOS

### N2 — Boucle infinie de corrections
**Section à ajouter dans "Plan = Contrat" :**

```markdown
**Limite d'itérations** : si après 5 tentatives successives une correction en génère une autre (cascade), **STOP** — escalade PO avec le format structuré. Ne jamais continuer indéfiniment une boucle de corrections qui cassent d'autres choses.
```

**Source :** Kassab D3, KAOS G22

### N3 — Sous-agents contradictoires
**Section à ajouter dans "Tâches intermédiaires" :**

```markdown
**Si deux sous-agents produisent des résultats contradictoires :**
1. Ne PAS arbitrer seul
2. Escalader au PO avec : résultat A, résultat B, points de divergence, recommandation motivée
3. ATTENDRE arbitrage avant de continuer

`Source: PICOC #25 MAST failure modes (attribution causale 53.5%)`
```

**Source :** Kassab D3/D4

### N4 — Staging vs Main distinctions
**À ajouter dans "Workflow Git" :**

```markdown
**Distinctions staging / main :**
- `staging` : tests E2E obligatoires avant merge + monitoring GlitchTip post-deploy 30 min
- `main` : audit pre-release complet (PICOC #29) + approbation PO explicite + tag version automatique
- PRs vers staging : review sub-agent suffit
- PRs vers main : review sub-agent + audit pre-release + relecture PO chemins critiques
```

**Source :** Kassab D2

### N5 — Critère de classification "chemin critique"
**À ajouter dans "Configuration projet" section Chemins critiques :**

```markdown
**Un chemin est "critique" si au moins un des critères suivants s'applique :**
- Contient de la logique d'authentification ou d'autorisation
- Manipule des données personnelles (PII)
- Contrôle l'accès à des secrets ou credentials
- Orchestre des déploiements ou migrations de données
- Modifie la configuration réseau ou infra
- Contient des paiements ou données financières

`Source: PICOC #13 Shukla 2025 +37.6% vulnérabilités après 5 itérations IA sans review active`
```

**Source :** Kassab D2, ODD

### N6 — Sub-agent protocole de délégation formalisé
**À améliorer dans "Tâches intermédiaires" :**

Ajouter règle explicite sur le modèle à utiliser :
- Tâche recherche/exploration simple : `model: "haiku"`
- Tâche review ou audit : `model: "sonnet"`
- Tâche critique (sécurité, architecture) : `model: "sonnet"` avec vérification PO

**Source :** Kassab D2

---

## 4. Gaps Required (règles importantes, non Mandatory)

| Gap | Section cible | Note |
|-----|--------------|------|
| CI/CD responsabilité : qui lance quoi (hooks vs pipeline) | Vérification proactive | Clarifier que hooks = pré-push local, CI = post-push GitHub |
| Impact environnemental tokens | Gestion quota | Ajouter éco-scoring : Haiku << Sonnet << Opus par défaut |
| Deprecation API détection | Vérification deps | `npm outdated` + check deprecated flag |
| Whitelist domaines Playwright | Monitoring/E2E | `[CONFIGURER: domaines autorisés pour browser_navigate]` |
| Rapport sub-agent immutable | Méthode d'audit | Préciser : rapporter tel quel, jamais interpréter/modifier |
| Audit trail : sous-agents propagent vers parent | Monitoring | Préciser que sous-agents doivent logger vers le même audit.log |

---

## 5. Nouveaux PICOCs nécessaires (Plan 3)

Ces domaines n'ont pas d'évidence sourcée suffisante dans les PICOCs existants.

| PICOC candidat | Justification | Effort SLR | Priorité |
|---------------|--------------|-----------|---------|
| `ai-agent-prompt-injection-defense` | 94.4% LLMs vulnérables (Lupinacci 2025), défenses peu documentées — PICOC #22 couvre attaque, pas défense runtime | 40-60h | HAUTE |
| `ai-agent-mast-monitoring-runtime` | PICOC #25 documente taxonomie MAST, mais monitoring proactif (pas post-mortem) absent de la littérature | 25-35h | HAUTE |
| `ai-agent-incident-response` | SEV1/SEV2/SEV3 + PO indisponible — aucun PICOC ne couvre la gestion d'incidents agentiques | 30-40h | HAUTE |
| `ai-agent-hallucination-detection-runtime` | Post-hoc (PICOC #10) existe, détection temps réel absente — potentiel PICOC GRADE 2 | 30-40h | MOYENNE |
| `ai-agent-regulatory-compliance` | GDPR/SOC2/HIPAA pour agents IA — matrice obligations non sourcée | 40-50h | MOYENNE |
| `ai-agent-environmental-impact` | MIT AI Risk 6.3 — éco-scoring tokens, seuils d'alerte — émergent 2025-2026 | 15-25h | BASSE |

---

## 6. Règles directes (évidence dans sources existantes, pas de SLR)

Ces gaps peuvent être résolus par des règles directes basées sur des sources déjà dans les PICOCs.

| Règle | Source dans PICOCs existants |
|-------|------------------------------|
| browser_close() deny list | Claude Code docs (officiel) |
| Sub-agent depth limit max 3 | PICOC #24 (structure multi-agents) + PICOC #25 (attribution causale) |
| Bash `set -e; set -o pipefail` obligatoire dans tous les scripts | Google Shell Style Guide + shellcheck (évidence universelle) |
| Co-Authored-By obligatoire (upgrade Mandatory) | PICOC #17 Provenance/audit trail |
| CI status check avant push | PICOC #4 (déterministic gates) + `gh run watch` officiel Claude Code |
| Staging vs main comportements distincts | PICOC #3 Human-only gates + workflow Git existant |
| Critère chemin critique (≥1 condition) | PICOC #13 Shukla 2025 |
| Urgence SEV1/SEV2/SEV3 (minimum viable) | PICOC #30 + Google SRE Book |

---

## 7. Plan d'action priorisé

### Phase A — Hooks Mandatory (1-2 semaines, effort ~8h)

| Action | Hook | Effort | Impact |
|--------|------|--------|--------|
| Deny browser_close | settings.json | 5 min | ✅ KAOS G18 |
| Settings.json read-only | pre-commit | 15 min | ✅ STRIDE EoP |
| Co-Authored-By pre-commit | pre-commit | 30 min | ✅ FMEA 245 |
| Branche outdated pre-pr-create | pre-pr-create | 30 min | ✅ FMEA 168 |
| Bash shellcheck | pre-commit | 30 min | ✅ FMEA 224 |
| CI status pre-push | pre-push | 45 min | ✅ ODD/Kassab |
| .env validation | pre-push | 1h | ✅ FMEA 196 |
| Secrets masking pre-commit | pre-commit | 1h | ✅ STRIDE InfoDisc |
| Gate PII detection | pre-commit | 1.5h | ✅ MIT 2.3 |
| Prompt injection filter | pre-tool-use | 2h | ✅ MIT 7.3 |

### Phase B — Sections CLAUDE.md (1 semaine, effort ~5h doc)

| Action | Section | Effort |
|--------|---------|--------|
| Mode urgence SEV1/SEV2/SEV3 | Section nouvelle | 2h |
| Staging vs main distinctions | Workflow Git | 45 min |
| Critère chemins critiques | Configuration projet | 30 min |
| Limite 5 itérations corrections | Plan = Contrat | 15 min |
| Sous-agents contradictoires | Tâches intermédiaires | 30 min |
| Sub-agent modèle routing | Tâches intermédiaires | 30 min |

### Phase C — Nouveaux PICOCs (Plan 3, priorité 1-3)

1. `ai-agent-prompt-injection-defense` (HAUTE, 40-60h)
2. `ai-agent-incident-response` (HAUTE, 30-40h)
3. `ai-agent-mast-monitoring-runtime` (HAUTE, 25-35h)

---

## Récapitulatif — Impact estimé sur la compliance matrix

| Catégorie | Avant Plan 2 | Après Phase A+B | Après Phase C |
|-----------|-------------|----------------|---------------|
| Mandatory hookés | 17/24 | 24/31 (+7 nouveaux) | 27/31 |
| Mandatory non-hookables | 7 gaps | 5 gaps (-2) | 5 gaps |
| Required | 31 | 37 (+6) | 40 |
| Coverage MIT AI Risk (pertinents) | 55% | 70% | 82% |
| Kassab RE score | 55% | 70% | 80% |

---

*Rapport produit par Agent C indépendant — synthèse de 6 phases SDMF parallèles.*
*Prochaine étape : Plan 3 SDMF (domaines sans PICOC) + implémentation Phase A hooks.*
