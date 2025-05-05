@echo off
REM Deo - Web Optimizer (.bat)
REM Utilise minify (si installé) pour HTML, CSS, JS

set SRC_DIR=%cd%
set DIST_DIR=%SRC_DIR%\dist

if not exist "%DIST_DIR%" (
    mkdir "%DIST_DIR%"
)

echo Optimisation des fichiers HTML...
for %%f in (%SRC_DIR%\*.html) do (
    if exist "%%f" (
        if exist "%ProgramFiles%\minify\minify.exe" (
            minify "%%f" > "%DIST_DIR%\%%~nxf"
        ) else (
            copy "%%f" "%DIST_DIR%\%%~nxf"
        )
    )
)

echo Optimisation des fichiers CSS...
for %%f in (%SRC_DIR%\*.css) do (
    if exist "%%f" (
        if exist "%ProgramFiles%\minify\minify.exe" (
            minify "%%f" > "%DIST_DIR%\%%~nxf"
        ) else (
            copy "%%f" "%DIST_DIR%\%%~nxf"
        )
    )
)

echo Optimisation des fichiers JS...
for %%f in (%SRC_DIR%\*.js) do (
    if exist "%%f" (
        if exist "%ProgramFiles%\minify\minify.exe" (
            minify "%%f" > "%DIST_DIR%\%%~nxf"
        ) else (
            copy "%%f" "%DIST_DIR%\%%~nxf"
        )
    )
)

echo Copie brute des fichiers PHP, Java, Dart...
copy %SRC_DIR%\*.php %DIST_DIR%\ 2>nul
copy %SRC_DIR%\*.java %DIST_DIR%\ 2>nul
copy %SRC_DIR%\*.dart %DIST_DIR%\ 2>nul

echo ✅ Optimisation terminée dans : %DIST_DIR%
pause
