#!/bin/bash
set -e

CLUSTER_NAME="idp-platform"

echo "🚀 Creating Kind cluster: $CLUSTER_NAME..."
kind create cluster --name $CLUSTER_NAME --config clusters/kind/config.yaml

echo "🔧 Installing ArgoCD..."
kubectl create namespace argocd || true
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "🌐 Waiting for ArgoCD server to be ready..."
kubectl wait --for=condition=available --timeout=600s deployment/argocd-server -n argocd

echo "🔓 Fetching ArgoCD initial admin password..."
PASS=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
echo "ArgoCD Login: admin / $PASS"

echo "🏗️ Applying App-of-Apps Bootstrap..."
# We will apply the bootstrap manifest in the next step
