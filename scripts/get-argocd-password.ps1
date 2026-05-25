# scripts/get-argocd-password.ps1
$encodedPassword = kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}'
$password = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($encodedPassword))
Write-Host "ArgoCD Admin Password: $password" -ForegroundColor Green
