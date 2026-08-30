param(
    [Parameter(Mandatory, ValueFromRemainingArguments)]
    [string[]]$Path
)

Add-Type -AssemblyName Microsoft.VisualBasic

foreach ($p in $Path) {
    foreach ($item in Resolve-Path -Path $p) {
        $fullPath = $item.ProviderPath
        if (Test-Path -LiteralPath $fullPath -PathType Container) {
            [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteDirectory(
                $fullPath,
                [Microsoft.VisualBasic.FileIO.UIOption]::OnlyErrorDialogs,
                [Microsoft.VisualBasic.FileIO.RecycleOption]::SendToRecycleBin
            )
        } else {
            [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile(
                $fullPath,
                [Microsoft.VisualBasic.FileIO.UIOption]::OnlyErrorDialogs,
                [Microsoft.VisualBasic.FileIO.RecycleOption]::SendToRecycleBin
            )
        }
    }
}
