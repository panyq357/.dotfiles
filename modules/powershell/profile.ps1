Set-PSReadLineOption -EditMode Emacs

$paths = @(
    "${HOME}\.dotfiles\modules\bin"
)

foreach ($p in $paths) {
    if ($env:PATH -notlike "*$p*") {
        $env:PATH = "$p;$env:PATH"
    }
}

function admin {
    Start-Process powershell -Verb RunAs
}
