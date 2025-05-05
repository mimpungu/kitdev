
[Setup]
AppName=DEUS M - Web Optimizer
AppVersion=1.0
DefaultDirName={pf}\DeusMWebOptimizer
DefaultGroupName=Deus M - Web Optimizer
UninstallDisplayIcon={app}\interface_optimiseur.exe
OutputDir=.
OutputBaseFilename=DeusMInstaller
Compression=lzma
SolidCompression=yes

[Files]
Source: "interface_optimiseur.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "script-optimize.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "README.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "Guide_Protection_Code_Web.pdf"; DestDir: "{app}"; Flags: ignoreversion

[Icons]
Name: "{group}\DEUS M - Optimiseur Graphique"; Filename: "{app}\interface_optimiseur.exe"
Name: "{group}\Désinstaller DEUS M"; Filename: "{uninstallexe}"
