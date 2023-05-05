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



apiVersion: v1
kind: Config
current-context: minikube
contexts:
- name: minikube
  context:
    cluster: minikube
    user: devops-cluster-admin
clusters:
- name: minikube
  cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCakNDQWU2Z0F3SUJBZ0lCQVRBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwdGFXNXAKYTNWaVpVTkJNQjRYRFRJek1EVXdOREExTWpVd05Gb1hEVE16TURVd01qQTFNalV3TkZvd0ZURVRNQkVHQTFVRQpBeE1LYldsdWFXdDFZbVZEUVRDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTXFDCjBDc21wSThPWHlxM3hNZkNtbXNzNkhVak1DZjBNU1FOdVBUbld3V0dKU1QxVlpQYWJKb1EzV3hHSFE3L0xxK2MKSTF4MXI4UWw4ZDR1T3lYc050dFlGK2pGczFWRjFjaW9oZE92b0xnalZJUHAvc3FzRUVYbXlUbHpsL2lZM2hkcApSclpOcENIOEt4L2EwZ3Q0UGZJcm93dWs1bDIvKzJuaWxrT2pITk51UnVvOHRXelRBLzhMbzI0dm5DZzdPaXFlCnZETkdBYUpuSmZ3MEM3RndMSkZ3bWlHalpmS3NNR2VRaUtGZmlKWXpmQlkxdnBjRWJKNHljZldCWmxISjV0MUQKcnFNZnlwc2UyNVR0VmNKNG01c3ZyeHhPbEZYVlhwN1VyRlNwTzVEeFRxZGVTOVUvNXowdGxZNS9Id2hsSlEyKwpLWXJtN3VrNUpvYUNObGVVWHVVQ0F3RUFBYU5oTUY4d0RnWURWUjBQQVFIL0JBUURBZ0trTUIwR0ExVWRKUVFXCk1CUUdDQ3NHQVFVRkJ3TUNCZ2dyQmdFRkJRY0RBVEFQQmdOVkhSTUJBZjhFQlRBREFRSC9NQjBHQTFVZERnUVcKQkJTbWM5b2k1ZDVqczJCNjVIMXBtQTQyWGw5MVN6QU5CZ2txaGtpRzl3MEJBUXNGQUFPQ0FRRUFOa0x6RXpHUApzMnZYMTAvTW1BTUMzdDA5dnNWRXA2cDVxNEw2YmVtSm81UVdrOUsyb0F5RzdIWnVveWpBaHhmVFZ6UE1jM3R1CnVuOXRydGNUeFVXWFJac21zcDZINnI4aUFYanA4Zml0bzNBYlZIaXltZm4yRTRzekNsR05PckYzdWxmL3Ywb2sKNHZ5UGM4ZG5FVklTOXFkS2hxMDFBMm9IanlWQllCSWxGcHRRN1dHa3hiVlc3VS8rWmdPWDl1QXJ2SEZTcHlhcAplbnBuaGlGcFR5OW1xdGZ3RVJ2akczMThLWkZxQXR2b0lvYUcwS1UxK1FOcEZUZU5BYVl6bUcrYmlrVU9VRkJzCk5FbnFSLzhRNXo3NWlyRThMSmNSUVkyRVBHdjhCRFFnQnR1SC9RR1B1djJqVzRzem1WTG5jUjV0RC96SXVwNGgKUzVFbjZCSGtVeEhKbFE9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
    server: https://3.236.122.63:8443
users:
- name: devops-cluster-admin
  user:
    token: eyJhbGciOiJSUzI1NiIsImtpZCI6IkZROEVsV01BTk9oa0dxWUNwZUtHTXBRMjd0WlVxVWlzMHJfbThiNGJkZEkifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJkZXZvcHMtY2x1c3Rlci1hZG1pbi10b2tlbi1tZnc0dyIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJkZXZvcHMtY2x1c3Rlci1hZG1pbiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6Ijg4OTE1MGUwLTVkNWYtNDlkMS04MDMzLTRmMDgxNDZkZjI5YSIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDprdWJlLXN5c3RlbTpkZXZvcHMtY2x1c3Rlci1hZG1pbiJ9.ves_T_Gnp4x6q9JSckhNCk5pEDmpL3NFTEBY3w_8X6rFHfcsJK2c6bAYjZ_TZW1i_11FizuLlyd_LlcXuBU0ni4kOBjANNrg2PBDPVttYuU0qXfBnLvQ50KORIpgwuo1MFp_opHIEPbO0OkNc7NqyNAzQAZg0VIQKlPIC0WUW23eTj4MYLRXoy6DYx9jRFtFI43-3ODcUWYVd0tKexNcgwAfZbkW_NDnI8qlpYn8JQEuc1nS4It_l0HKCjdjM8xh055I0tzIpbZlTEBes31qlZ7TxKF55LuC5uTG-UowXIErbEMu-bmfmxKc7DLODf3Ki3dhmGxX9lxCJGzthKpCvw
