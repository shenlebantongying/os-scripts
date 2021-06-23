function write-hello(){
    Write-Host 'Hello, World!'
}

function open-miscrosoft {Set-Location C:\script\microsoft}
Set-Alias -Name s -Value open-miscrosoft
