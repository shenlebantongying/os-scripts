# echo $PROFILE
$env:Path += "$(Split-Path $PROFILE -Parent)\MyScripts"

Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

function prompt {
"[$(Get-Date -Format "HH:mm:ss")] $($executionContext.SessionState.Path.CurrentLocation)`n$('>' * ($nestedPromptLevel + 1)) ";
}

just --completions powershell | Out-String | Invoke-Expression

Invoke-Expression (& { (zoxide init powershell | Out-String) })
