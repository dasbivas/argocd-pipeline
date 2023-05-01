# argoCD Offical Chart
Add Repo:
```
helm repo add argo https://argoproj.github.io/argo-helm
```
Install Chart
```
helm install my-argo-cd argo/argo-cd --version 5.29.1
```

If want to skip CRD to install along with argocd 
```
--set crds.install=false 
helm install --set crds.install=false my-argo-cd02 argo/argo-cd --version 5.29.1
next time skip --skip-crds
```


# Ref:
```
https://artifacthub.io/packages/helm/argo/argo-cd
https://github.com/argoproj/argo-helm
```
