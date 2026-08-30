function module_link {
    param(
        [Parameter(Mandatory, Position = 0)][string]$Source,
        [Parameter(Mandatory, Position = 1)][string]$Target
    )
    if (Get-Item -Path $Target -ErrorAction SilentlyContinue) {
        Write-Host "Skip: $Target exists"
    } else {
        try {
            New-Item -ItemType SymbolicLink -Path $Target -Target $Source -ErrorAction Stop | Out-Null
            Write-Host "Soft link: $Source -> $Target"
        } catch {
            $itemType = if (Test-Path -Path $Source -PathType Container) { "Junction" } else { "HardLink" }
            New-Item -ItemType $itemType -Path $Target -Target $Source | Out-Null
            Write-Host "$itemType (no permission for symlink): $Source -> $Target"
        }
    }
}

function module_copy {
    param(
        [Parameter(Mandatory, Position = 0)][string]$Source,
        [Parameter(Mandatory, Position = 1)][string]$Target
    )
    if (Get-Item -Path $Target -ErrorAction SilentlyContinue) {
        Write-Host "Skip: $Target exists"
    } else {
        Write-Host "Copy: $Source -> $Target"
        Copy-Item -Path $Source -Destination $Target
    }
}
