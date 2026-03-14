[Setup]
AppName=LivelyShufflePlaylist
AppVersion=0.5.0-alpha
AppPublisher=RoboticsEqualsFun
AppId=LivelyShufflePlaylist
AppPublisherURL=https://github.com/followedmefully/Lively-Wallpaper-Playlist
DefaultDirName={autopf}\LivelyShufflePlaylist
PrivilegesRequiredOverridesAllowed=dialog
DefaultGroupName=LivelyShufflePlaylist
OutputBaseFilename=LivelyShufflePlaylistInstaller
UninstallDisplayIcon={app}\LivelyShufflePlaylist
Compression=lzma
SolidCompression=yes
WizardStyle=modern
CloseApplications=yes

[Files]
Source: "LivelyShufflePlaylist.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "config.json"; DestDir: "{app}"; Flags: ignoreversion
Source: "icon.ico"; DestDir: "{app}"; Flags: ignoreversion; Attribs: hidden

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional shortcuts:"

[Icons]
Name: "{group}\LivelyShufflePlaylist"; Filename: "{app}\LivelyShufflePlaylist"; IconFilename: "{app}\icon.ico"
Name: "{userdesktop}\LivelyShufflePlaylist"; Filename: "{app}\LivelyShufflePlaylist"; IconFilename: "{app}\icon.ico"; Tasks: desktopicon

[Run]
Filename: "{app}\LivelyShufflePlaylist"; Description: "Launch LivelyShufflePlaylist after installation"; Flags: nowait postinstall skipifsilent

[InstallDelete]
Type: dirifempty; Name: "{app}"

[Code]
var
  ManualLivelyPage: TInputQueryWizardPage;
  WallpaperPage: TInputDirWizardPage;
  WallpaperPathEdit: TEdit;
  MonitorPage: TWizardPage;
  MonitorEdit: TEdit;
  LivelyPath: String;
  PreviousPageID: Integer;
  WallpaperBrowseBtn: TButton;
  
  // --------- Lively.exe detect ---------
function DetectLively(): String;
var
  Path: String;
begin
  Path := ExpandConstant('{localappdata}\Programs\Lively Wallpaper\Lively.exe');
  if FileExists(Path) then
  begin
    Result := Path;
    exit;
  end;

  Path := ExpandConstant('{pf}\Lively Wallpaper\Lively.exe');
  if FileExists(Path) then
  begin
    Result := Path;
    exit;
  end;

  Result := '';
end;

function CompleteWallpaperPath(Path: String): String;
begin
  StringChangeEx(Path, '/', '\', True);

  // Check if it already ends with \SaveData\wptmp
  if (Length(Path) >= 15) and (Copy(Path, Length(Path)-14, 15) = '\SaveData\wptmp') then
    Result := Path
  // Check if it ends with \SaveData but missing \wptmp
  else if (Length(Path) >= 9) and (Copy(Path, Length(Path)-8, 9) = '\SaveData') then
    Result := Path + '\wptmp'
  else
    Result := Path + '\SaveData\wptmp'; // Append everything if missing
end;

procedure BrowseWallpaperFolder(Sender: TObject);
var
  Folder: String;
begin
  Folder := '';
  // Added 'True' as the third parameter
  if BrowseForFolder('Select your wallpaper folder', Folder, True) then
  begin
    WallpaperPathEdit.Text := CompleteWallpaperPath(Folder);
  end;
end;

procedure InitializeWizard;
begin
  // Assume previous page is the welcome page
  PreviousPageID := wpWelcome;
  
  // --------- Lively install page if no Lively.exe was found ---------
  LivelyPath := DetectLively();

  if LivelyPath = '' then
  begin
    ManualLivelyPage :=
      CreateInputQueryPage(
        PreviousPageID,
        'Lively Not Found',
        'Please enter location of Lively.exe',
        'Installer could not detect Lively automatically.');

    ManualLivelyPage.Add('Path:', False);
    PreviousPageID := ManualLivelyPage.ID; // Chain next page after this
  end;

  // --------- Wallpaper Page ---------
  WallpaperPage := CreateInputDirPage(
    PreviousPageID,
    'Wallpaper Folder',
    'Where are your Lively wallpapers stored?',
    'Enter the full path to the folder that contains your Lively wallpapers.',
    False,
    ExpandConstant('{localappdata}\Lively Wallpaper\Library\SaveData\wptmp')
  );
    
  WallpaperPathEdit := TEdit.Create(WizardForm);
  WallpaperPathEdit.Parent := WallpaperPage.Surface;
  WallpaperPathEdit.Left := 20;
  WallpaperPathEdit.Top := WallpaperPage.Surface.Height - 60;
  WallpaperPathEdit.Width := WallpaperPage.Surface.Width - 40;
  WallpaperPathEdit.Text := ExpandConstant('{localappdata}\Lively Wallpaper\Library\SaveData\wptmp');
  
    // Create the browse button
  WallpaperBrowseBtn := TButton.Create(WizardForm);
  WallpaperBrowseBtn.Parent := WallpaperPage.Surface;
  WallpaperBrowseBtn.Left := 20;
  WallpaperBrowseBtn.Top := WallpaperPathEdit.Top + WallpaperPathEdit.Height + 8;
  WallpaperBrowseBtn.Width := 80;
  WallpaperBrowseBtn.Caption := 'Browse...';
  WallpaperBrowseBtn.OnClick := @BrowseWallpaperFolder;

  PreviousPageID := WallpaperPage.ID;
  
  // --------- Monitor Page ---------
  MonitorPage := CreateCustomPage(
    PreviousPageID,
    'Monitors',
    'Enter the monitor numbers (e.g., 1,2).');

  MonitorEdit := TEdit.Create(WizardForm);
  MonitorEdit.Parent := MonitorPage.Surface;
  MonitorEdit.Left := 20;
  MonitorEdit.Top := MonitorPage.Surface.Height - 60;
  MonitorEdit.Width := MonitorPage.Surface.Width - 40;
  MonitorEdit.Text := '1,2';
end;

procedure DoubleBackslashes(var S: String);
begin
  StringChangeEx(S, '\', '\\', True); // True = replace all occurrences
end;

// Write config.json after installation
procedure CurStepChanged(CurStep: TSetupStep);
var
  ConfigFile, JsonStr, WallpaperFolder, Monitors: String;
begin
  if CurStep = ssPostInstall then
  begin
    if (LivelyPath = '') and Assigned(ManualLivelyPage) then
      LivelyPath := ManualLivelyPage.Values[0];
    ConfigFile := ExpandConstant('{app}\config.json');

    Monitors := MonitorEdit.Text;
    WallpaperFolder := WallpaperPathEdit.Text;

    // Replace backslashes
    DoubleBackslashes(WallpaperFolder);
    DoubleBackslashes(LivelyPath);

    JsonStr :=
      '{' + #13#10 +
      '  "wallpaper_folder": "' + WallpaperFolder + '",' + #13#10 +
      '  "delay_seconds": 2400,' + #13#10 +
      '  "monitors": [' + Monitors + '],' + #13#10 +
      '  "lively_path": "' + LivelyPath + '"' + #13#10 +
      '}';

    SaveStringToFile(ConfigFile, JsonStr, False);
  end;
end;