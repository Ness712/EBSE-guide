# Container Registry

**[RECOMMANDE]** GHCR (GitHub Container Registry) pour les repos GitHub | Score GRADE : 4/7

GHCR s'integre nativement a GitHub Actions, aux permissions du repo, et au GITHUB_TOKEN — zero configuration supplementaire.

```yaml
# GitHub Actions — build et push vers GHCR
- name: Login to GHCR
  uses: docker/login-action@v3
  with:
    registry: ghcr.io
    username: ${{ github.actor }}
    password: ${{ secrets.GITHUB_TOKEN }}

- name: Build and push
  uses: docker/build-push-action@v6
  with:
    push: true
    tags: ghcr.io/${{ github.repository }}:${{ github.sha }}
```

| Registry | Forces | Limites |
|----------|--------|---------|
| **GHCR** | Natif GitHub, GITHUB_TOKEN, permissions repo | Ecosysteme GitHub uniquement |
| **Docker Hub** | Standard historique, pulls publics gratuits | Rate limiting (100 pulls/6h anonymous) |
| **ECR** (AWS) | Natif AWS, scanning integre | Vendor lock-in AWS |
| **Harbor** | Self-hosted, CNCF gradue | Infra a gerer |

Sources : GitHub docs — GHCR integration native avec Actions et permissions (niv. 3), CNCF Survey 2024 — container registry adoption (niv. 4), Twelve-Factor Factor V — build artifacts immutables (niv. 5)
