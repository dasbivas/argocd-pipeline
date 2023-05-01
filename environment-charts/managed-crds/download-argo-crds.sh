#!/bin/bash
# The download of new CRDs is not done as part of the gitlab ci pipeline
# as we don't want dependencies to github repository at install time

# Run this script to download new versions of CRDs
# Git commit/push must be done by developer

cd argo

version=v2.6.7
source=https://raw.githubusercontent.com/argoproj/argo-cd/$version/manifests/crds

echo Downloading CRDs for ArgoCD version $version

curl $source/application-crd.yaml -L -O
curl $source/appproject-crd.yaml -L -O
curl $source/applicationset-crd.yaml -L -O

cd ../

