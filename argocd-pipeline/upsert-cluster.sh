#!/bin/bash

set -ea

kubectl version
helm version

# Install CRDs, ArgoCD
MANAGED_ARGOCD_VERSION=5.29.1

echo "Install/update CRDs"

# Install all CRDs for each app in the templates folder
for folder in ../environment-charts/managed-crds/argo ; do
  kubectl apply -f $folder
done

echo "Apply namespaces"
helm template ../environment-charts/managed-namespaces/ | kubectl apply -f -

echo "Install/update ArgoCD"
helm upgrade --version $MANAGED_ARGOCD_VERSION --install argocd ../environment-charts/managed-argocd/  -n argocd --skip-crds

echo "Install remote secrets for ArgoCD"
helm template ../files/cluster-secrets/ | kubectl apply -f -
