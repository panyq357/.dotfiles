$modules = @(
    "powershell",
    "psmux",
    "clash-verge-rev"
)

foreach ($x in $modules) {
    & "$HOME/.dotfiles/modules/$x/setup.ps1"
}
