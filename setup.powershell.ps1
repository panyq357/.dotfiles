$modules = @(
    "powershell",
    "psmux"
)

foreach ($x in $modules) {
    & "$HOME/.dotfiles/modules/$x/setup.ps1"
}
