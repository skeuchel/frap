# Run this script with PowerShell. If it opens an editor when you double-click,
# try right-click -> "Run with PowerShell".

# Define the Coq compiler path. Adjust if necessary.
$coqc = "C:\Coq-Platform~8.18~2023.11\bin\coqc.exe"

# Exit if coqc.exe doesn't exist
if (-Not (Test-Path $coqc)) {
    Write-Error "Error: coqc.exe not found at $coqc"
    Read-Host -Prompt "Press Enter to exit"
    exit 1
}

# List of .v files. Add more files as needed
$coqFiles = "Sets.v", "Map.v", "Relations.v", "Var.v", "Invariant.v", "ModelCheck.v", "FrapWithoutSets.v", "Frap.v", "Imp.v", "AbstractInterpret.v", "SepCancel.v"

# Compile each file
foreach ($file in $coqFiles) {
    $filePath = Join-Path (Get-Location) $file
    if (-Not (Test-Path $filePath)) {
        Write-Error "Error: $file does not exist"
        Read-Host -Prompt "Press Enter to exit"
        exit 1
    }
    Write-Host "COQC $file"
    & $coqc -R . Frap -w -intuition-auto-with-star -w -undeclared-scope $filePath
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Error: $file failed to compile"
        Read-Host -Prompt "Press Enter to exit"
        exit 1
    }
}

Write-Host "Compilation successful."
Read-Host -Prompt "Press Enter to exit"
