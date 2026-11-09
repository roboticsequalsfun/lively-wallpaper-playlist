#define AppName "Lively Playlist"
#define AppExe "LivelyPlaylist.exe"
#define AppPublisher "RoboticsEqualsFun"
; REMEBER TO CHANGE THIS EVERY VERSION!!!
#define Version "2.1.3"

[Setup]
AppName={#AppName}
AppVersion={#Version}
AppPublisher={#AppPublisher}
AppId={{EE44DAA9-EE3D-43D0-9B0F-CA9E9BD3966D}}
AppPublisherURL=https://github.com/roboticsequalsfun/lively-wallpaper-playlist
DefaultDirName={autopf}\LivelyPlaylist
PrivilegesRequired=admin
DefaultGroupName={#AppName}
OutputDir=../../dist
OutputBaseFilename=LivelyPlaylistInstaller
UninstallDisplayIcon={app}\{#AppExe}
Compression=lzma
SolidCompression=yes
WizardStyle=modern
CloseApplications=yes

[Files]
Source: "..\..\dist\{#AppExe}"; DestDir: "{app}"; Flags: ignoreversion;
Source: "..\..\resources\*"; DestDir: "{app}\resources"; Flags: ignoreversion recursesubdirs createallsubdirs;
Source: "..\..\config.json"; DestDir: "{userappdata}\LivelyPlaylist"; DestName: "config.json"; Flags: ignoreversion;

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; Flags: checkablealone;

[Icons]
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#AppExe}"; Tasks: desktopicon; WorkingDir: "{app}";
Name: "{group}\{#AppName}"; Filename: "{app}\{#AppExe}"; WorkingDir: "{app}";

[Run]
Filename: "{app}\{#AppExe}"; Description: "Launch application"; Flags: postinstall nowait skipifsilent unchecked

[UninstallRun]
Filename: "taskkill"; Parameters: "/im ""{#AppExe}"" /f"; Flags: runhidden

[UninstallDelete]
Type: filesandordirs; Name: "{app}"
Type: filesandordirs; Name: "{userappdata}\LivelyPlaylist"

[Code]
var
  PreviousPageID: Integer;
  LivelyPageCreated: Boolean;
  
  MonitorPage: TWizardPage;
  MonitorEdit: TEdit;
  Monitors: String;
  
  LivelyPathPage: TInputDirWizardPage;
  LivelyPathEdit: TEdit;
  LivelyBrowseBtn: TButton;
  LivelyPath: String;

  WallpaperPathPage: TInputDirWizardPage;
  WallpaperPathEdit: TEdit;
  WallpaperBrowseBtn: TButton;
  WallpaperPath: String;
  
function DetectLively(): String;
var
  LivelyPath: String;
begin
  LivelyPath := ExpandConstant('{localappdata}\Programs\Lively Wallpaper\Lively.exe');
  if FileExists(LivelyPath) then
  begin
    Result := LivelyPath;
    exit;
  end;

  LivelyPath := ExpandConstant('{pf}\Lively Wallpaper\Lively.exe');
  if FileExists(ExpandConstant(LivelyPath)) then
  begin
    Result := LivelyPath;
    exit;
  end;
  
  LivelyPath := ExpandConstant('{userlocalappdata}12030rocksdanister.LivelyWallpaper_97hta09mmv6hy\LocalCache\Local\Lively Wallpaper\Lively.exe');
  if FileExists(ExpandConstant(LivelyPath)) then
  begin
    Result := LivelyPath;
    exit;
  end;

  Result := '';
end;

procedure BrowseLivelyExecutable(Sender: TObject);
var
  FileName: String;
begin
  if GetOpenFileName(
    'Select Lively.exe',
    FileName,
    '',
    'Lively Executable|Lively.exe|Executable Files|*.exe',
    'exe'
  ) then
    LivelyPathEdit.Text := FileName;
end;

procedure CreateLivelyPathPage();
begin
  LivelyPathPage := CreateInputDirPage(
    PreviousPageID,
    'Lively Not Found',
    'Please enter location of Lively.exe',
    'Installer could not detect Lively automatically. Please enter the location of Lively.exe manually.',
    False,
    ExpandConstant('{localappdata}\Programs\Lively Wallpaper\Lively.exe')
  );
    
  LivelyPathEdit := TEdit.Create(WizardForm);
  LivelyPathEdit.Parent := LivelyPathPage.Surface;
  LivelyPathEdit.Left := 20;
  LivelyPathEdit.Top := LivelyPathPage.Surface.Height - 60;
  LivelyPathEdit.Width := LivelyPathPage.Surface.Width - 40;
  LivelyPathEdit.Text := ExpandConstant('{localappdata}\Programs\Lively Wallpaper\Lively.exe');
  
    // Create the browse button
  LivelyBrowseBtn := TButton.Create(WizardForm);
  LivelyBrowseBtn.Parent := LivelyPathPage.Surface;
  LivelyBrowseBtn.Left := 20;
  LivelyBrowseBtn.Top := LivelyPathEdit.Top + LivelyPathEdit.Height + 8;
  LivelyBrowseBtn.Width := 80;
  LivelyBrowseBtn.Caption := 'Browse...';
  LivelyBrowseBtn.OnClick := @BrowseLivelyExecutable;
end;

procedure BrowseWallpaperFolder(Sender: TObject);
var
  WallpaperPath: String;
begin
  if BrowseForFolder('Select Wallpaper Folder', WallpaperPath, True) then
    WallpaperPathEdit.Text := WallpaperPath;
end;

procedure CreateWallpaperPathPage();
begin
  WallpaperPathPage := CreateInputDirPage(
    PreviousPageID,
    'Wallpaper Folder',
    'Where are your Lively wallpapers stored?',
    'Enter the full path to the folder that contains your Lively wallpapers.',
    False,
    ExpandConstant('{localappdata}\Lively Wallpaper\Library')
  );
    
  WallpaperPathEdit := TEdit.Create(WizardForm);
  WallpaperPathEdit.Parent := WallpaperPathPage.Surface;
  WallpaperPathEdit.Left := 20;
  WallpaperPathEdit.Top := WallpaperPathPage.Surface.Height - 60;
  WallpaperPathEdit.Width := WallpaperPathPage.Surface.Width - 40;
  WallpaperPathEdit.Text := ExpandConstant('{localappdata}\Lively Wallpaper\Library');
  
    // Create the browse button
  WallpaperBrowseBtn := TButton.Create(WizardForm);
  WallpaperBrowseBtn.Parent := WallpaperPathPage.Surface;
  WallpaperBrowseBtn.Left := 20;
  WallpaperBrowseBtn.Top := WallpaperPathEdit.Top + WallpaperPathEdit.Height + 8;
  WallpaperBrowseBtn.Width := 80;
  WallpaperBrowseBtn.Caption := 'Browse...';
  WallpaperBrowseBtn.OnClick := @BrowseWallpaperFolder;
end;

procedure CreateMonitorPage();
begin
  MonitorPage := CreateCustomPage(
    PreviousPageID,
    'Monitors',
    'Enter the monitor amount of monitors (e.g., 2).');

  MonitorEdit := TEdit.Create(WizardForm);
  MonitorEdit.Parent := MonitorPage.Surface;
  MonitorEdit.Left := 20;
  MonitorEdit.Top := MonitorPage.Surface.Height - 60;
  MonitorEdit.Width := MonitorPage.Surface.Width - 40;
  MonitorEdit.Text := '2';
end;

function CompleteWallpaperPath(Path: String): String;
var
  p: Integer;
  i: Integer;
  LastName: String;
begin
  StringChangeEx(Path, '/', '\', True);
  
  while (Length(Path) > 0) and (Path[Length(Path)] = '\') do
    Delete(Path, Length(Path), 1);
    
  p := 0;
  for i := 1 to Length(Path) do
    if Path[i] = '\' then
      p := i;

  LastName := Copy(Path, p + 1, Length(Path));
  
  if LastName = 'wptmp' then
    Result := Path
  else if LastName = 'SaveData' then
    Result := Path + '\wptmp'
  else
    Result := Path + '\SaveData\wptmp';
end;

procedure InitializeWizard;
begin
  PreviousPageID := wpWelcome;
  
  LivelyPath:= DetectLively();

   if LivelyPath = '' then
  begin
    LivelyPageCreated := True;
    CreateLivelyPathPage();
    PreviousPageID := LivelyPathPage.ID;
  end
  else
  begin
    LivelyPageCreated := False;
  end;

  CreateWallpaperPathPage();
  PreviousPageID := WallpaperPathPage.ID;

  CreateMonitorPage();
  PreviousPageID := MonitorPage.ID;
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;
  
  if CurPageID = MonitorPage.ID then
  begin
    if Trim(MonitorEdit.Text) = '' then
    begin
      MsgBox('Please fill out field before continuing.', mbError, MB_OK);
      Result := False;
    end
    else
    begin
      Monitors := MonitorEdit.Text;
    end;
  end;
  
  if CurPageID = WallpaperPathPage.ID then
  begin
    if Trim(WallpaperPathEdit.Text) = '' then
    begin
      MsgBox('Please fill out field before continuing.', mbError, MB_OK);
      Result := False;
    end
    else
    begin
      WallpaperPath := WallpaperPathEdit.Text;
    end;
  end;
  if LivelyPageCreated then
  begin
    if CurPageID = LivelyPathPage.ID then
    begin
      if Trim(LivelyPathEdit.Text) = '' then
      begin
        MsgBox('Please fill out field before continuing.', mbError, MB_OK);
        Result := False;
      end
      else
      begin
        LivelyPath := LivelyPathEdit.Text;
      end;
    end;
  end;
end;

procedure CurPageChanged(CurPageID: Integer);
var
  TmpWallpaperPath: String;
  TmpLivelyPath: String;
  JSONContent: String;
begin
  if CurPageID = wpFinished then
  begin
    TmpLivelyPath := LivelyPath;
    StringChangeEx(TmpLivelyPath, '\', '\\', True);
    
    TmpWallpaperPath := CompleteWallpaperPath(WallpaperPath);
    StringChangeEx(TmpWallpaperPath, '\', '\\', True);

    JSONContent :=
      '{' + #13#10 +
      '  "wallpaper_folder": "' + TmpWallpaperPath + '",' + #13#10 +
      '  "delay_seconds": 2400,' + #13#10 +
      '  "monitors": ' + Monitors + ',' + #13#10 +
      '  "lively_path": "' + TmpLivelyPath + '",' + #13#10 +
      '  "dark_mode": false' + #13#10 +
      '}';
   

    SaveStringToFile(ExpandConstant('{userappdata}\LivelyPlaylist\config.json'), JSONContent, False);
  end;
end;