# next-gen-idp/bootstrap/cluster-init.ps1

Write-Host "🚀 Starting Next-Gen IDP Cluster Setup..." -ForegroundColor Cyan

# 1. Create Kind Cluster
$clusterExists = kind get clusters | Select-String -Pattern "^idp-cluster$"
if (-not $clusterExists) {
    Write-Host "Creating Kind cluster..." -ForegroundColor Yellow
    kind create cluster --config kind-config.yaml --name idp-cluster
} else {
    Write-Host "Kind cluster 'idp-cluster' already exists. Skipping creation." -ForegroundColor Gray
}

# 2. Install Ingress NGINX
Write-Host "Installing NGINX Ingress Controller..." -ForegroundColor Yellow
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

# 3. Setup ArgoCD
Write-Host "Installing ArgoCD (Server-Side Apply with Force Conflicts)..." -ForegroundColor Yellow
kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml --server-side --force-conflicts

# 4. Wait for ArgoCD to be ready
Write-Host "Waiting for ArgoCD pods to be ready..." -ForegroundColor Yellow
kubectl wait --for=condition=Ready pods --all -n argocd --timeout=300s

# 5. Apply the Root "App of Apps"
# This will be created in the next step
# kubectl apply -f ../clusters/local/root-app.yaml

Write-Host "✅ Cluster setup complete! ArgoCD is running in the 'argocd' namespace." -ForegroundColor Green
Write-Host "Retrieve your admin password with:" -ForegroundColor Cyan
Write-Host "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String(`$_`))"
