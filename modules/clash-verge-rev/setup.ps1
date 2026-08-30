. "$HOME/.dotfiles/modules/util.ps1"

$profilesDir = "$env:APPDATA/io.github.clash-verge-rev.clash-verge-rev/profiles"

foreach ($name in @("Merge.yaml", "Script.js")) {
    $source = "$HOME/.dotfiles/modules/clash-verge-rev/$name"
    $target = "$profilesDir/$name"

    # Replace a pre-existing regular file (not already a link) so module_link can take over.
    $item = Get-Item -Path $target -ErrorAction SilentlyContinue
    if ($item -and -not $item.LinkType) {
        Remove-Item -Path $target -Force
    }

    module_link $source $target
}
