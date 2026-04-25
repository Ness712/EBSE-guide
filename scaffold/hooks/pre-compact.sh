#!/bin/bash
# Claude Code hook — PreCompact
# Perimetre : re-injecte les instructions critiques avant compaction du contexte
# Declencheur : quand le contexte approche la limite et une compaction va se produire
#
# Source : PICOC ai-agent-extended-hook-lifecycle GRADE 3 RECOMMANDE
#          PICOC ai-agent-context-compaction GRADE 2 BONNE PRATIQUE
#          docs.anthropic.com/en/docs/claude-code/hooks#precompact
#
# Pourquoi : apres compaction, les instructions en fin de contexte sont perdues.
# Ce hook re-injecte les regles MANDATORY via stdout → Claude les voit avant compaction.
# Garder < 50 lignes stdout pour ne pas surcharger le contexte post-compaction.

echo "=== PRE-COMPACT REMINDER ==="
echo "INSTRUCTIONS CRITIQUES A CONSERVER APRES COMPACTION :"
echo ""

# [CONFIGURER: lister ici les regles MANDATORY les plus critiques pour votre projet]
# Exemples generiques :

echo "MANDATORY — Gates humaines : merge main/staging, schema DB, secrets, prod deploy → PO approval requis"
echo "MANDATORY — Co-Authored-By dans chaque commit"
echo "MANDATORY — Pas de merge vers main/staging sans approbation PO"
echo "MANDATORY — Override gate uniquement via CLAUDE.local.md documente"
echo ""

# [CONFIGURER: ajouter les regles specifiques au projet]
# echo "MANDATORY — [regle specifique projet]"

echo "=== FIN PRE-COMPACT REMINDER ==="

exit 0
