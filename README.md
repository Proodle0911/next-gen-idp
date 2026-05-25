# Next-Gen CI/CD & Internal Developer Platform (IDP)

This project provides an enterprise-grade, GitOps-driven Internal Developer Platform (IDP) architecture designed to optimize developer velocity, enforce compliance through declarative infrastructure, and provide real-time observability and cost management visibility.

---

## 🏛️ Architectural Blueprint

This project follows the **"Golden Path"** philosophy, providing developers with self-service infrastructure while maintaining centralized governance.

1.  **Interface Layer (The Portal):** A custom, lightweight IDP Dashboard provides a centralized catalog for service discovery and infrastructure status.
2.  **Deployment Orchestration:** **ArgoCD** implements GitOps for continuous, declarative reconciliation of the cluster state.
3.  **Infrastructure Control Plane:** **Crossplane** manages cloud-native resources as Kubernetes objects, abstracting complex cloud APIs into simple, self-service claims.
4.  **Continuous Integration Core:** Automated pipeline workflows handle multi-stage Docker builds, code compliance, and ephemeral "Preview Environments" triggered via Pull Request lifecycle.
5.  **Observability Stack:** **Prometheus & Grafana** provide deep telemetry into platform performance and resource utilization.

---

## 🗺️ Development Roadmap

- [x] **Phase 1: Local Cluster & GitOps Orchestration:** Initializing a multi-node Kind cluster and bootstrapping ArgoCD using the "App of Apps" pattern.
- [x] **Phase 2: Infrastructure as Code (Crossplane):** Establishing infrastructure abstractions (XRDs and Compositions) to allow self-service namespace and quota management.
- [x] **Phase 3: CI Pipelines & Preview Environments:** Implementing ArgoCD ApplicationSets for automated, dynamic preview environment generation per Pull Request.
- [x] **Phase 4: Developer Portal:** Deploying a custom, lightweight IDP Dashboard to provide a unified catalog of platform resources and services.
- [x] **Phase 5: Observability:** Integrating Prometheus and Grafana for full-stack platform monitoring.

---

## 🚀 Getting Started

### Prerequisites
Ensure the following tools are installed on your machine:
*   [Docker](https://www.docker.com/)
*   [Kubernetes CLI (`kubectl`)](https://kubernetes.io/docs/tasks/tools/)
*   [Kind](https://kind.sigs.k8s.io/)
*   [Git](https://git-scm.com/)

### 1. Repository Setup
```bash
git clone https://github.com/Proodle0911/next-gen-idp.git
cd next-gen-idp
```

### 2. Spin Up the Platform
Run the automated bootstrap script. This will provision the Kind cluster, NGINX Ingress, and ArgoCD.
```powershell
cd bootstrap
./cluster-init.ps1
```

### 3. Deploy Infrastructure & Applications
Apply the Root Application to ArgoCD to trigger the automatic reconciliation of the platform.
```powershell
kubectl apply -f ../clusters/local/root-app.yaml
```

### 4. Accessing the Platform
*   **ArgoCD UI:** 
    *   Run `kubectl port-forward svc/argocd-server -n argocd 8080:443`
    *   Visit `https://localhost:8080` (use `../scripts/get-argocd-password.ps1` for login credentials).
*   **IDP Dashboard:**
    *   Run `kubectl port-forward svc/idp-dashboard 9090:80`
    *   Visit `http://localhost:9090`

---

## 🛠️ Operational Guide

### Handling Platform Drift
ArgoCD continuously monitors your Git repository. To update the cluster state, simply commit and push changes to `main`:
```bash
git add .
git commit -m "Update platform configuration"
git push origin main
```
ArgoCD will automatically synchronize the cluster within ~3 minutes.

### Managing Environments
To provision a new developer environment, apply the sample claim:
```bash
kubectl apply -f apps/samples/environment-claim.yaml
```
Crossplane will automatically reconcile this into a ready-to-use Kubernetes Namespace with predefined resource quotas.

---

## 🤝 Contributing
This project is designed as an architectural reference. Feel free to fork, customize, or open issues to discuss new infrastructure abstractions or integration patterns.
