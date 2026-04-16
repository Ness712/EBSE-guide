#!/usr/bin/env node
// Regenere les recommandations pour tous les profils dans data/stacks/
// Usage : node scripts/generate-recommendations.js

const fs = require('fs');
const path = require('path');

const BASE = path.join(__dirname, '..');
const DECISIONS_DIR = path.join(BASE, 'guide/data/decisions');
const TREE_PATH = path.join(BASE, 'guide/data/decision-tree.json');
const STACKS_DIR = path.join(BASE, 'guide/data/stacks');

const tree = JSON.parse(fs.readFileSync(TREE_PATH, 'utf8'));
const files = fs.readdirSync(DECISIONS_DIR).filter(f => f.endsWith('.json'));
const decisions = files.map(f => JSON.parse(fs.readFileSync(path.join(DECISIONS_DIR, f), 'utf8')));

function filterDecisions(decisions, backend) {
  return decisions.map(d => {
    if (d.classification === 'universal' || !d.variants || Object.keys(d.variants).length === 0) {
      const p = d.universal?.principles?.[0];
      return { id: d.id, domain: d.domain, question: d.question, recommendation: p?.text ?? d.question, grade: p?.grade ?? 0, level: p?.level ?? 'CHOIX_EQUIPE', is_universal: true, sources: p?.sources?.map(s => ({ name: s.name, pyramid: s.pyramid, year: s.year })) ?? [] };
    }
    const variant = d.variants[backend] ?? Object.values(d.variants)[0];
    if (variant) {
      const sources = variant.sources ?? d.universal?.principles?.[0]?.sources ?? [];
      return { id: d.id, domain: d.domain, question: d.question, recommendation: variant.recommendation, grade: variant.grade, level: variant.level, implementation: variant.implementation, is_universal: false, sources: sources.map(s => ({ name: s.name, pyramid: s.pyramid, year: s.year })) };
    }
    const p = d.universal?.principles?.[0];
    return { id: d.id, domain: d.domain, question: d.question, recommendation: p?.text ?? d.question, grade: p?.grade ?? 0, level: p?.level ?? 'CHOIX_EQUIPE', is_universal: true, sources: p?.sources?.map(s => ({ name: s.name, pyramid: s.pyramid, year: s.year })) ?? [] };
  }).sort((a, b) => b.grade - a.grade);
}

// Trouver tous les profils projet (ceux qui ont des choices)
const profiles = fs.readdirSync(STACKS_DIR)
  .filter(f => f.endsWith('.json') && !f.endsWith('-recommendations.json'))
  .map(f => ({ file: f, data: JSON.parse(fs.readFileSync(path.join(STACKS_DIR, f), 'utf8')) }))
  .filter(p => p.data.choices?.backend);

for (const { file, data } of profiles) {
  const backend = data.choices.backend;
  const recommendations = filterDecisions(decisions, backend);
  const outFile = path.join(STACKS_DIR, file.replace('.json', '-recommendations.json'));

  const output = {
    guide_version: tree.version,
    generated_at: new Date().toISOString(),
    profile_id: data.id,
    stack: { backend: data.choices.backend, frontend: data.choices.frontend, database: data.choices.database, project_type: data.choices.project_type, scale: data.choices.scale, ai_agent: data.choices.ai_agent },
    total: recommendations.length,
    methodology: 'EBSE (Kitchenham 2004), adapted from Evidence-Based Medicine',
    recommendations
  };

  fs.writeFileSync(outFile, JSON.stringify(output, null, 2));
  console.log(`[OK] ${file} -> ${path.basename(outFile)} (${recommendations.length} recs, backend: ${backend})`);
}
