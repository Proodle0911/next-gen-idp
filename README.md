# Next-Gen CI/CD & IDP Portfolio

This project demonstrates a production-grade Internal Developer Platform (IDP) and GitOps-driven CI/CD automation.

## Project Structure

- `apps/`: Application source code and manifests.
- `bootstrap/`: Initial cluster setup and bootstrap scripts.
- `clusters/`: Cluster-specific GitOps configurations (overlays).
- `infrastructure/`: Base infrastructure components (ArgoCD, Crossplane, Backstage).
- `internal/`: Custom Backstage logic, plugins, and configurations.
- `scripts/`: Utility scripts for maintenance.

## Getting Started (Phase 1)

1. **Install Prerequisites:** `kind`, `kubectl`, `helm`, `docker`.
2. **Spin up Cluster:**
   ```powershell
   cd bootstrap
   ./cluster-init.ps1
   ```
3. **Retrieve ArgoCD Password:**
   ```powershell
   ../scripts/get-argocd-password.ps1
   ```
4. **Port Forward ArgoCD UI:**
   ```powershell
   kubectl port-forward svc/argocd-server -n argocd 8080:443
   ```

## Roadmap

- [x] Phase 1: Local Cluster & GitOps Orchestration
- [x] Phase 2: Infrastructure as Code (Crossplane Abstractions)
- [x] Phase 3: CI Pipelines & Preview Environments (AppSets)
- [x] Phase 4: Backstage IDP Portal (Golden Path Templates)
- [x] Phase 5: Observability & Cost Management (Kube-Prometheus)
