# echo $PROFILE
$env:Path += "$(Split-Path $PROFILE -Parent)\MyScripts"

Invoke-Expression (& { (zoxide init powershell | Out-String) })
