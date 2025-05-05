REM ====================================
REM   ____                         __  __ 
REM  |  _ \  ___  _ __ ___   ___  |  \/  |
REM  | | | |/ _ \| '_ ` _ \ / _ \ | |\/| |
REM  | |_| | (_) | | | | | |  __/ | |  | |
REM  |____/ \___/|_| |_| |_|\___| |_|  |_|
REM                                      
REM          DEUS M - Web Optimizer
REM ====================================
REM Optimise vos projets HTML/CSS/JS/PHP/Java/Dart/Flutter :
REM - Minification HTML/CSS
REM - Obfuscation JavaScript
REM - Compilation Java et Dart
REM - Build Flutter Web
REM - Copie des fichiers PHP

REM   ____             _     
REM  |  _ \  ___   ___| |__  
REM  | | | |/ _ \ / __| '_ \ 
REM  | |_| | (_) | (__| | | |
REM  |____/ \___/ \___|_| |_|
REM                           
REM     DEUS - Web Optimizer
REM ====================================

@echo off
REM === CONFIGURATION ===
set SRC_DIR=%cd%
set DIST_DIR=%SRC_DIR%\dist

if not exist "%DIST_DIR%" (
    mkdir "%DIST_DIR%"
)

REM === HTML ===
echo Minification des fichiers HTML...
for /r "%SRC_DIR%\html" %%f in (*.html) do (
    for %%F in ("%%~nxf") do (
        html-minifier "%%f" -o "%DIST_DIR%\%%~nxf" --collapse-whitespace --remove-comments --minify-js true --minify-css true
    )
)

REM === CSS ===
echo Minification des fichiers CSS...
for /r "%SRC_DIR%\css" %%f in (*.css) do (
    for %%F in ("%%~nxf") do (
        cleancss -o "%DIST_DIR%\%%~nxf" "%%f"
    )
)

REM === JS ===
echo Obfuscation des fichiers JavaScript...
for /r "%SRC_DIR%\js" %%f in (*.js) do (
    for %%F in ("%%~nxf") do (
        javascript-obfuscator "%%f" --output "%DIST_DIR%\%%~nxf"
    )
)

REM === PHP ===
echo Copie brute des fichiers PHP...
for /r "%SRC_DIR%\php" %%f in (*.php) do (
    copy "%%f" "%DIST_DIR%\"
)

REM === JAVA ===
echo Compilation des fichiers Java...
if not exist "%DIST_DIR%\java_classes" (
    mkdir "%DIST_DIR%\java_classes"
)
for /r "%SRC_DIR%\java" %%f in (*.java) do (
    javac -d "%DIST_DIR%\java_classes" "%%f"
)

REM === DART ===
echo Compilation des fichiers Dart...
for /r "%SRC_DIR%\dart" %%f in (*.dart) do (
    for %%F in ("%%~nxf") do (
        dart compile exe "%%f" -o "%DIST_DIR%\%%~nxf.exe"
    )
)

REM === FLUTTER (web build) ===
if exist "%SRC_DIR%\flutter" (
    echo Build Flutter Web...
    cd flutter
    flutter build web
    xcopy /E /I /Y build\web "%DIST_DIR%\"
    cd ..
)

echo Optimisation terminée. Les fichiers sont dans : %DIST_DIR%
pause
