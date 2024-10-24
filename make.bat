@echo off
setlocal

rem Define the Coq compiler path. Adjust if necessary.
set "coqc=C:\Coq-Platform~8.18~2023.11\bin\coqc.exe"

rem Exit if coqc.exe doesn't exist
if not exist "%coqc%" (
    echo Error: coqc.exe not found at %coqc%
    pause
    exit /b 1
)

rem List of .v files. Add more files as needed
set "coqFiles=Sets.v Map.v Relations.v Var.v Invariant.v ModelCheck.v FrapWithoutSets.v Frap.v Imp.v AbstractInterpret.v SepCancel.v"

rem Compile each file
for %%F in (%coqFiles%) do (
    if not exist "%%F" (
        echo Error: %%F does not exist
        pause
        exit /b 1
    )
    echo COQC %%F
    "%coqc%" -R . Frap -w -intuition-auto-with-star -w -undeclared-scope "%%F"
    if errorlevel 1 (
        echo Error: %%F failed to compile
        pause
        exit /b 1
    )
)

echo Compilation successful.
pause
endlocal
