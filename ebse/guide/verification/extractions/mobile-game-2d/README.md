# Extraction Forms — mobile-game-2d SLR

**Scope** : 37 PICOCs, Phase 2 extraction (Kitchenham & Charters 2007 §2.4).

## Canonical §2.4 structure

Each extraction form contains the 10 canonical elements :

1. PICOC formal definition (P, I, C, O, C + Anchor)
2. Candidates discovered (Amendment G-1 : no pre-identification)
3. Exclusions at screening (E1-E5 codes)
4. O-matrix ordinal scoring (5 outcome axes minimum, typically 7)
5. Top-3 ranking
6. Kappa A vs B + tier agreement
7. GRADE synthesis with factors
8. Sources extracted (Kitchenham Table 2)
9. Primary recommendation
10. Decision + traceability

## Index

| Batch | Theme | Files |
|-------|-------|-------|
| A | Engine + core runtime | [A1-engine-selection.md](A1-engine-selection.md), [A4p-simulation-update.md](A4p-simulation-update.md), [A6-touch-input-a11y.md](A6-touch-input-a11y.md), [A7-offline-persistence.md](A7-offline-persistence.md), [A8-asset-pipeline.md](A8-asset-pipeline.md) |
| B | Authoring + media runtime | [B7-tile-editor.md](B7-tile-editor.md), [B8-font-rendering.md](B8-font-rendering.md), [B9-audio-runtime.md](B9-audio-runtime.md), [B10-2d-animation.md](B10-2d-animation.md), [B11-pixel-art-tool.md](B11-pixel-art-tool.md) |
| C | Save systems | [C12-save-serialization.md](C12-save-serialization.md), [C13-save-scheduling.md](C13-save-scheduling.md), [C14-schema-migration.md](C14-schema-migration.md), [C15-save-integrity.md](C15-save-integrity.md) |
| D | Distribution + privacy | [D17-publishing-workflow.md](D17-publishing-workflow.md), [D19-dynamic-delivery.md](D19-dynamic-delivery.md), [D20-privacy-manifest.md](D20-privacy-manifest.md), [D21-launch-surface.md](D21-launch-surface.md) |
| E | Monetisation | [E22-ads-architecture.md](E22-ads-architecture.md), [E22b-ad-ux-policy.md](E22b-ad-ux-policy.md), [E23-iap-abstraction.md](E23-iap-abstraction.md), [E24-monetization-model.md](E24-monetization-model.md), [E25-receipt-validation.md](E25-receipt-validation.md) |
| F | Social + attribution | [F26-leaderboards.md](F26-leaderboards.md), [F28-identity.md](F28-identity.md), [F29-deep-linking.md](F29-deep-linking.md) |
| G | Internationalisation | [G30-localization-workflow.md](G30-localization-workflow.md), [G31-rtl-bidi.md](G31-rtl-bidi.md), [G32-message-format.md](G32-message-format.md) |
| H | CI / CD + observability | [H33-cicd.md](H33-cicd.md), [H34-device-testing.md](H34-device-testing.md), [H35-crash-reporting.md](H35-crash-reporting.md), [H36-analytics.md](H36-analytics.md), [H37-remote-config.md](H37-remote-config.md) |
| I | Quality | [I37-test-methodology.md](I37-test-methodology.md), [I39-accessibility.md](I39-accessibility.md) |
| J | AI collaboration (game-specific residual) | [J43-ai-asset-gate.md](J43-ai-asset-gate.md) |

## Totals

- 37 / 37 PICOCs in canonical Kitchenham §2.4 format
- Batches A - J
- Plus 17 `ai-collaboration` PICOCs inherited at synthesis with parameter adjustments
