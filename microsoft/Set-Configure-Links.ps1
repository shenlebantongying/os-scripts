# there are no centralized place for windows

function New-link ($path, $link) {
    New-Item -Path $link -ItemType SymbolicLink -Value $path
}


if(Test-Path $PROFILE.CurrentUserAllHosts){
    Remove-Item $PROFILE.CurrentUserAllHosts
}

New-link $PSScriptRoot\backup\profile.ps1 $profile.CurrentUserAllHosts
