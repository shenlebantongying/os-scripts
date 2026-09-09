# echo $PROFILE
$env:Path += "$(Split-Path $PROFILE -Parent)\MyScripts"

Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

Invoke-Expression (& { (zoxide init powershell | Out-String) })
