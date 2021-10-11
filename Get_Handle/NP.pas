unit NP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, Buttons, ExtCtrls, XPEdit,
  XPLabel, XPButton, Menus, ShellApi, XpMan, IniFiles,
  XPMenu, ImgList, StdCtrls,  ActiveX, ComObj, Registry,
  ShlObj, ComCtrls, CommDlg, DDeMan;

  function OpenSaveFileDialog(ParentHandle: THandle; const DefExt, Filter, InitialDir,
  Title: string; var FileName: string; IsOpenDialog: Boolean): Boolean;

  const
   Tray = Wm_User + 1;
   Cherta = Wm_User + 2;
   AboutPro = Wm_User + 3;
   AlignCenter = WM_USER + 1024;

  type
   TWmMoving = record
   Msg: Cardinal;
   fwSide: Cardinal;
   lpRect: PRect;
   Result: Integer;
  end;

type
  TMainForm = class(TForm)
    fr1: TPanel;
    fr2: TPanel;
    fr3: TPanel;
    Magnifier: TSpeedButton;
    Quit: TXPButton;
    tx8: TXPLabel;
    ed5: TXPEdit;
    Logo: TImage;
    tx1: TXPLabel;
    tx2: TXPLabel;
    tx3: TXPLabel;
    MainMenu: TMainMenu;
    FileItem: TMenuItem;
    QuitItem: TMenuItem;
    ServiceItem: TMenuItem;
    MultipleItem: TMenuItem;
    HelpItem: TMenuItem;
    AboutItem: TMenuItem;
    sp9: TMenuItem;
    tx7: TXPLabel;
    ed4: TXPEdit;
    tx6: TXPLabel;
    ed3: TXPEdit;
    tx5: TXPLabel;
    ed2: TXPEdit;
    T1: TTimer;
    SendItem: TMenuItem;
    PropertiesItem: TMenuItem;
    NewWinItem: TMenuItem;
    ToolItem: TMenuItem;
    sp8: TMenuItem;
    sp7: TMenuItem;
    LangItem: TMenuItem;
    RusItem: TMenuItem;
    EngItem: TMenuItem;
    MainMenuItem: TMenuItem;
    tx4: TXPLabel;
    ed1: TXPEdit;
    RunItem: TMenuItem;
    ChooseProItem: TMenuItem;
    sp5: TMenuItem;
    CursorPosItem: TMenuItem;
    ShortCutItem: TMenuItem;
    DeskItem: TMenuItem;
    AutoStartItem: TMenuItem;
    StartMenuItem: TMenuItem;
    ProgramMenuItem: TMenuItem;
    FavoritesItem: TMenuItem;
    TrayMenu: TPopupMenu;
    RestoreProItem: TMenuItem;
    CloseItem: TMenuItem;
    OnTopItem: TMenuItem;
    sp10: TMenuItem;
    sp4: TMenuItem;
    sp1: TMenuItem;
    SaveItem: TMenuItem;
    PrintItem: TMenuItem;
    PrintDlg: TPrintDialog;
    DescriptionText: TRichEdit;
    FindItem: TMenuItem;
    sp6: TMenuItem;
    sp3: TMenuItem;
    ContextItem: TMenuItem;
    IEItem: TMenuItem;
    T2: TTimer;
    MainFavItem: TMenuItem;
    OrgFavItem: TMenuItem;
    AddFavItem: TMenuItem;
    sp2: TMenuItem;
    SourceCodeItem: TMenuItem;
    sp13: TMenuItem;
    SaveConfigItem: TMenuItem;
    SavePosItem: TMenuItem;
    sp12: TMenuItem;
    HomePageItem: TMenuItem;
    InfoItem: TMenuItem;
    sp11: TMenuItem;
    procedure T1Timer(Sender: TObject);
    procedure MagnifierMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure MagnifierMouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure QuitItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NewWinItemClick(Sender: TObject);
    procedure PropertiesItemClick(Sender: TObject);
    procedure AboutItemClick(Sender: TObject);
    procedure SendItemClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ChooseProItemClick(Sender: TObject);
    procedure RunItemClick(Sender: TObject);
    procedure CursorPosItemClick(Sender: TObject);
    procedure MultipleItemClick(Sender: TObject);
    procedure OnTopItemClick(Sender: TObject);
    procedure ToolItemClick(Sender: TObject);
    procedure DeskItemClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure StartMenuItemClick(Sender: TObject);
    procedure ProgramMenuItemClick(Sender: TObject);
    procedure AutoStartItemClick(Sender: TObject);
    procedure FavoritesItemClick(Sender: TObject);
    procedure MainMenuItemClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure RestoreProItemClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure RusItemClick(Sender: TObject);
    procedure EngItemClick(Sender: TObject);
    procedure SaveItemClick(Sender: TObject);
    procedure PrintItemClick(Sender: TObject);
    procedure FindItemClick(Sender: TObject);
    procedure CloseItemClick(Sender: TObject);
    procedure ContextItemClick(Sender: TObject);
    procedure IEItemClick(Sender: TObject);
    procedure T2Timer(Sender: TObject);
    procedure OrgFavItemClick(Sender: TObject);
    procedure AddFavItemClick(Sender: TObject);
    procedure SourceCodeItemClick(Sender: TObject);
    procedure SavePosItemClick(Sender: TObject);
    procedure SaveConfigItemClick(Sender: TObject);
    procedure HomePageItemClick(Sender: TObject);
    procedure InfoItemClick(Sender: TObject);
  private

    SM: HWND;

    r: Tregistry;

    Ini: TIniFile;

    LinkFile:IPersistFile;

    ShellObject:IUnknown;

    ShellLink:IShellLink;

    FileName,ShortcutPosition:string;

    WShortcutPosition:WideString;

    P:PItemIDList;

    S: string;

    Icon: TNOtifyIconData;

    C:array[0..1000] of char;

    Capture: Boolean;

    hMutex : THandle;

    procedure ShowHwndAndClassName(CrPos: TPoint);

    procedure ApplicationMinimized(Sender: TObject);

    procedure MySystemTray(var MySysTray: TMessage);
    message Tray;

    procedure MySystemMenu(var MySysMenu: TWmSysCommand);
    message Wm_SysCommand;

    procedure WMMoving(var msg: TWMMoving);
    message WM_MOVING;

    procedure WMHotKey(var a: TWMHotKey);
    message WM_HOTKEY;

    procedure ChangeMessageBoxPosition(var Msg: TMessage);
    message AlignCenter;

  public

  end;

var
  MainForm: TMainForm;
  msgCaption: PChar;
implementation

uses AP, TP, FP, AFP;

{$R *.dfm}

 type
   POpenFilenameA = ^TOpenFilenameA;
   POpenFilename = POpenFilenameA;
   tagOFNA = packed record
   lStructSize: DWORD;
   hWndOwner: HWND;
   hInstance: HINST;
   lpstrFilter: PAnsiChar;
   lpstrCustomFilter: PAnsiChar;
   nMaxCustFilter: DWORD;
   nFilterIndex: DWORD;
   lpstrFile: PAnsiChar;
   nMaxFile: DWORD;
   lpstrFileTitle: PAnsiChar;
   nMaxFileTitle: DWORD;
   lpstrInitialDir: PAnsiChar;
   lpstrTitle: PAnsiChar;
   Flags: DWORD;
   nFileOffset: Word;
   nFileExtension: Word;
   lpstrDefExt: PAnsiChar;
   lCustData: LPARAM;
   lpfnHook: function(Wnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): UINT stdcall;
   lpTemplateName: PAnsiChar;
   end;
   TOpenFilenameA = tagOFNA;
   TOpenFilename = TOpenFilenameA;

   function GetOpenFileName(var OpenFile: TOpenFilename): Bool; stdcall; external 'comdlg32.dll'
   name 'GetOpenFileNameA';
   function GetSaveFileName(var OpenFile: TOpenFilename): Bool; stdcall; external 'comdlg32.dll'
   name 'GetSaveFileNameA';

  const
   OFN_DONTADDTORECENT = $02000000;
   OFN_FILEMUSTEXIST = $00001000;
   OFN_HIDEREADONLY = $00000004;
   OFN_PATHMUSTEXIST = $00000800;

 function CharReplace(const Source: string; oldChar, newChar: Char): string;
 var
 i: Integer;
 begin
 Result := Source;
 for i := 1 to Length(Result) do
 if Result[i] = oldChar then
 Result[i] := newChar;
 end;

procedure TMainForm.ChangeMessageBoxPosition(var Msg: TMessage);
var
MbHwnd: longword;
MbRect: TRect;
x, y, w, h: integer;
begin
MbHwnd := FindWindow(MAKEINTRESOURCE(WC_DIALOG), msgCaption);
if (MbHwnd <> 0) then
begin
GetWindowRect(MBHWnd, MBRect);
with MbRect do
begin
w := Right - Left;
h := Bottom - Top;
end;
x := MainForm.Left + ((MainForm.Width - w) div 2);
if x < 0 then
x := 0
else if x + w > Screen.Width then x := Screen.Width - w;
y := MainForm.Top + ((MainForm.Height - h) div 2);
if y < 0 then y := 0
else if y + h > Screen.Height then y := Screen.Height - h;
SetWindowPos(MBHWnd, 0, x, y, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;
end;

function OpenSaveFileDialog(ParentHandle: THandle; const DefExt, Filter, InitialDir, Title: string; var FileName: string; IsOpenDialog: Boolean): Boolean;
var
ofn: TOpenFileName;
szFile: array[0..MAX_PATH] of Char;
begin
Result := False;
FillChar(ofn, SizeOf(TOpenFileName), 0);
with ofn do
begin
lStructSize := SizeOf(TOpenFileName);
hwndOwner := ParentHandle;
lpstrFile := szFile;
nMaxFile := SizeOf(szFile);
if (Title <> '') then
lpstrTitle := PChar(Title);
if (InitialDir <> '') then
lpstrInitialDir := PChar(InitialDir);
StrPCopy(lpstrFile, FileName);
lpstrFilter := PChar(CharReplace(Filter, '|', #0)+#0#0);
if DefExt <> '' then
lpstrDefExt := PChar(DefExt);
end;
if IsOpenDialog then
begin
if GetOpenFileName(ofn) then
begin
Result := True;
FileName := StrPas(szFile);
end;
end else
begin
if GetSaveFileName(ofn) then
begin
Result := True;
FileName := StrPas(szFile);
end;
end
end;

procedure TMainForm.ShowHwndAndClassName(CrPos: TPoint);
var
hWnd: THandle;
aName: array [0..255] of Char;
Title: string;
begin
hWnd := WindowFromPoint(CrPos);
ed5.Text := IntToStr(hWnd);
if Boolean(GetClassName(hWnd, aName, 256)) then
ed4.Text := string(aName)
else
ed4.Text := 'Class not found';
SetLength (Title, 100);
GetWindowText (hWnd, PChar (Title), 100);
ed3.Text := string(PChar(Title));
ed2.Text := IntToHex (hWnd, 8);
end;

procedure TMainForm.T1Timer(Sender: TObject);
var 
rPos: TPoint; var
Cursor: TPoint;
begin
if Boolean(GetCursorPos(rPos)) then ShowHwndAndClassName(rPos);
GetCursorPos(Cursor);
ed1.Text :=
'X= ' + IntToStr(Cursor.X) + ', Y='+ IntToStr(Cursor.Y);
end;

procedure TMainForm.MagnifierMouseDown(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
MouseCapture := True;
Capture := True;
T1.Enabled := True;
end;

procedure TMainForm.MagnifierMouseUp(Sender: TObject;
Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
T1.Enabled := False;
end;

procedure TMainForm.FormMouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
Magnifier.Perform (
wm_LButtonUp, mk_LButton, 0);
MouseCapture := False;
Capture := False;
end;

procedure TMainForm.QuitItemClick(Sender: TObject);
begin
Close;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
RegisterHotKey(Handle, 1, MOD_CONTROL or MOD_ALT, ord('R'));
Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.Ini'));
try
Top := Ini.ReadInteger('Parameters', 'Top', 100);
Left := Ini.ReadInteger('Parameters', 'Left', 100);
MainMenuItem.Checked := Ini.ReadBool('Parameters', 'Main menu', MainMenuItem.Checked);
OnTopItem.Checked := Ini.ReadBool('Parameters', 'Always on top', OnTopItem.Checked);
MultipleItem.Checked := Ini.ReadBool('Parameters', 'Forbid multiple', MultipleItem.Checked);
CursorPosItem.Checked := Ini.ReadBool('Parameters', 'Description under cursor pos', CursorPosItem.Checked);
RusItem.Checked := Ini.ReadBool('Parameters', 'Russian interface', RusItem.Checked);
EngItem.Checked := Ini.ReadBool('Parameters', 'English interface', EngItem.Checked);
finally
end;
with Icon do
begin
wnd := Handle;
szTip := 'Class Information Studio v 1.0';
hIcon := Application.Icon.Handle;
uCallBackMessage := Tray;
uFlags := nif_Tip + nif_Message + nif_Icon;
end;
Application.OnMinimize := ApplicationMinimized;
hMutex := CreateMutex(nil, true , 'IP find v 1.0');
if GetLastError = ERROR_ALREADY_EXISTS then
if MultipleItem.Checked then
halt;
end;

procedure TMainForm.NewWinItemClick(Sender: TObject);
var
PC: array[0..255] of char;
S: String;
begin
if ToolForm.ch15.Checked then
begin
SaveConfigItem.Click;
end;
{$ifdef Windows}
WinExec(StrPCopy(PC, ParamStr(0)+' '+S), Sw_Show);
{$else}
WinExec(StrPCopy(PC, ParamStr(0)+' "'+S+'"'), Sw_Show);
{$endif}
end;

procedure ShowPropertiesDialog(FName: string);
var
SExInfo: TSHELLEXECUTEINFO;
begin
ZeroMemory(Addr(SExInfo),SizeOf(SExInfo));
SExInfo.cbSize := SizeOf(SExInfo);
SExInfo.lpFile := PChar(FName);
SExInfo.lpVerb := 'properties';
SExInfo.fMask  := SEE_MASK_INVOKEIDLIST;
ShellExecuteEx(Addr(SExInfo));
end;

procedure TMainForm.PropertiesItemClick(Sender: TObject);
begin
ShowPropertiesDialog(ParamStr(0));
end;

procedure TMainForm.AboutItemClick(Sender: TObject);
begin
AboutForm.Position := poMainFormCenter;
AboutForm.ShowModal;
end;

procedure TMainForm.SendItemClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'Mailto:GoodWinNix@mail.ru', nil, nil, Sw_ShowNormal);
end;

procedure TMainForm.FormShow(Sender: TObject);
var
Reg: TRegistry;
begin
Reg := TRegistry.Create;
with Reg do begin
RootKey := HKEY_CLASSES_ROOT;
if not reg.KeyExists
('\*\Shell\Get Handle\Command\')then
ContextItem.Checked := False else
ContextItem.Checked := True;
end;
Reg := TRegistry.Create;
with Reg do begin
RootKey := HKEY_LOCAL_MACHINE;
if not reg.KeyExists
('\Software\Microsoft\Internet Explorer\Extensions\{002BC5D9-6959-412F-AD03-500CF1C64114}\')then
IEItem.Checked := False else
IEItem.Checked := True;
end;
if RusItem.Checked = False then
if  EngItem.Checked = False then
RusItem.Click;
if RusItem.Checked = True then
RusItem.Click;
if EngItem.Checked = True then
EngItem.Click;
if ToolForm.ch10.Checked then
begin
MainForm.ScreenSnap := True;
ToolForm.ScreenSnap := True;
AboutForm.ScreenSnap := True;
FavForm.ScreenSnap := True;
AddFavForm.ScreenSnap := True;
end else
begin
MainForm.ScreenSnap := False;
ToolForm.ScreenSnap := False;
AboutForm.ScreenSnap := False;
FavForm.ScreenSnap := False;
AddFavForm.ScreenSnap := False;
end;
if MainMenuItem.Checked then
begin
FileItem.Visible := True;
ServiceItem.Visible := True;
MainFavItem.Visible := True;
HelpItem.Visible := True;
MainForm.ClientHeight := 290;
end else
begin
MainForm.ClientHeight := 270;
FileItem.Visible := False;
ServiceItem.Visible := False;
MainFavItem.Visible := False;
HelpItem.Visible := False;
end;
if OnTopItem.Checked = False
then begin
SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE+SWP_NOSIZE);
end else begin
SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE+SWP_NOSIZE);
OnTopItem.Checked := true;
end;
if CursorPosItem.Checked then
T1.Enabled := True else
T1.Enabled := False;
if CursorPosItem.Checked then
Magnifier.Enabled := False else
Magnifier.Enabled := True;
if ToolForm.ch1.Checked then
begin
RyMenu.Add(MainMenu, nil);
RyMenu.Add(TrayMenu, nil);
end;
if ToolForm.Ch2.Checked then
AnimateWindow(Mainform.Handle, 500, AW_CENTER or AW_SLIDE or AW_ACTIVATE);
r := TRegistry.Create;
r.RootKey := HKEY_LOCAL_MACHINE;
r.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', false);
if ToolForm.Ch3.Checked then
r.WriteString(Application.Title, ParamStr(0)) else
r.DeleteValue(Application.Title);
r.Free;
ed1.Height := 19;
ed2.Height := 19;
ed3.Height := 19;
ed4.Height := 19;
ed5.Height := 19;
ed1.Refresh;
ed2.Refresh;
ed3.Refresh;
ed4.Refresh;
ed5.Refresh;
tx1.Refresh;
tx2.Refresh;
tx3.Refresh;
end;

procedure TMainForm.ChooseProItemClick(Sender: TObject);
begin
WinExec(Pchar('rundll32 shell32, OpenAs_RunDLL'), sw_Show);
end;

procedure TMainForm.RunItemClick(Sender: TObject);
var
ShellApplication: Variant;
begin
ShellApplication := CreateOleObject('Shell.Application');
ShellApplication.FileRun;
end;

procedure TMainForm.CursorPosItemClick(Sender: TObject);
begin
CursorPosItem.Checked := not CursorPosItem.Checked;
if CursorPosItem.Checked then
T1.Enabled := True else
T1.Enabled := False;
if CursorPosItem.Checked then
Magnifier.Enabled := False else
Magnifier.Enabled := True;
end;

procedure TMainForm.MultipleItemClick(Sender: TObject);
begin
MultipleItem.Checked := not MultipleItem.Checked;
Ini.WriteBool('Parameters', 'Forbid multiple', MultipleItem.Checked);
end;

procedure TMainForm.OnTopItemClick(Sender: TObject);
begin
OnTopItem.Checked := not OnTopItem.Checked;
if OnTopItem.Checked = False
then begin
SetWindowPos(Handle, HWND_NOTOPMOST, 0, 0, 0, 0, SWP_NOMOVE+SWP_NOSIZE);
end else begin
SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOMOVE+SWP_NOSIZE);
OnTopItem.Checked := true;
end;
end;

procedure TMainForm.ToolItemClick(Sender: TObject);
begin
ToolForm.Position := poMainFormCenter;
ToolForm.ShowModal;
end;

procedure TMainForm.DeskItemClick(Sender: TObject);
begin
ShellObject:=CreateComObject(CLSID_ShellLink);
LinkFile:=ShellObject as IPersistFile;
ShellLink:=ShellObject as IShellLink;
FileName:=ParamStr(0);
ShellLink.SetPath(pchar(FileName));
ShellLink.SetWorkingDirectory(pchar(ExtractFilePath(FileName)));
if SHGetSpecialFolderLocation(Handle,CSIDL_DESKTOP,P)=NOERROR then begin
SHGetPathFromIDList(P,C);
ShortcutPosition:=StrPas(C);
s:= 'Class Information Studio';
if RusItem.Checked then
begin
if not InputQuery('Class Information Studio',
'Вы хотите разместить ярлык на Рабочем Столе?', s)
then s := 'Class Information Studio' else
ShortcutPosition:=ShortcutPosition+'\'+ S + '.lnk';
end;
if EngItem.Checked then
begin
if not InputQuery('Class Information Studio',
'Do you want a shortcut to your Desktop?', s)
then s := 'Class Information Studio' else
ShortcutPosition:=ShortcutPosition+'\'+ S + '.lnk';
end;
WShortcutPosition:=ShortcutPosition;
LinkFile.Save(PWChar(WShortcutPosition),False);
end;
end;

procedure TMainForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
if ToolForm.ch9.Checked then
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;
end;

procedure TMainForm.StartMenuItemClick(Sender: TObject);
begin
ShellObject:=CreateComObject(CLSID_ShellLink);
LinkFile:=ShellObject as IPersistFile;
ShellLink:=ShellObject as IShellLink;
FileName:=ParamStr(0);
ShellLink.SetPath(pchar(FileName));
ShellLink.SetWorkingDirectory(pchar(ExtractFilePath(FileName)));
if SHGetSpecialFolderLocation(Handle,CSIDL_STARTMENU,P)=NOERROR then begin
SHGetPathFromIDList(P,C);
ShortcutPosition:=StrPas(C);
s:= 'Class Information Studio';
if RusItem.Checked then
begin
if not InputQuery('Class Information Studio',
'Вы хотите разместить ярлык в Главном Меню?', s)
then s := 'Class Information Studio' else
ShortcutPosition:=ShortcutPosition+'\'+ S + '.lnk';
end;
if EngItem.Checked then
begin
if not InputQuery('Class Information Studio',
'Do you want a shortcut to your Start Menu?', s)
then s := 'Class Information Studio' else
ShortcutPosition:=ShortcutPosition+'\'+ S + '.lnk';
end;
WShortcutPosition:=ShortcutPosition;
LinkFile.Save(PWChar(WShortcutPosition),False);
end;
end;

procedure TMainForm.ProgramMenuItemClick(Sender: TObject);
begin
ShellObject:=CreateComObject(CLSID_ShellLink);
LinkFile:=ShellObject as IPersistFile;
ShellLink:=ShellObject as IShellLink;
FileName:=ParamStr(0);
ShellLink.SetPath(pchar(FileName));
ShellLink.SetWorkingDirectory(pchar(ExtractFilePath(FileName)));
if SHGetSpecialFolderLocation(Handle,CSIDL_PROGRAMS,P)=NOERROR then begin
SHGetPathFromIDList(P,C);
ShortcutPosition:=StrPas(C);
s:= 'Class Information Studio';
if RusItem.Checked then
begin
if not InputQuery('Class Information Studio',
'Вы хотите разместить ярлык в Меню Программы?', s)
then s := 'Class Information Studio' else
ShortcutPosition:=ShortcutPosition+'\'+ S + '.lnk';
end;
if EngItem.Checked then
begin
if not InputQuery('Class Information Studio',
'Do you want a shortcut to your Programs Menu?', s)
then s := 'Class Information Studio' else
ShortcutPosition:=ShortcutPosition+'\'+ S + '.lnk';
end;
WShortcutPosition:=ShortcutPosition;
LinkFile.Save(PWChar(WShortcutPosition),False);
end;
end;

procedure TMainForm.AutoStartItemClick(Sender: TObject);
begin
ShellObject:=CreateComObject(CLSID_ShellLink);
LinkFile:=ShellObject as IPersistFile;
ShellLink:=ShellObject as IShellLink;
FileName:=ParamStr(0);
ShellLink.SetPath(pchar(FileName));
ShellLink.SetWorkingDirectory(pchar(ExtractFilePath(FileName)));
if SHGetSpecialFolderLocation(Handle,CSIDL_STARTUP,P)=NOERROR then begin
SHGetPathFromIDList(P,C);
ShortcutPosition:=StrPas(C);
s:= 'Class Information Studio';
if RusItem.Checked then
begin
if not InputQuery('Class Information Studio',
'Вы хотите разместить ярлык в папке Автозагрузки?', s)
then s := 'Class Information Studio' else
ShortcutPosition:=ShortcutPosition+'\'+ S + '.lnk';
end;
if EngItem.Checked then
begin
if not InputQuery('Class Information Studio',
'Do you want a shortcut to your Startup folder?', s)
then s := 'Class Information Studio' else
ShortcutPosition:=ShortcutPosition+'\'+ S + '.lnk';
end;
WShortcutPosition:=ShortcutPosition;
LinkFile.Save(PWChar(WShortcutPosition),False);
end;
end;

procedure TMainForm.FavoritesItemClick(Sender: TObject);
begin
ShellObject:=CreateComObject(CLSID_ShellLink);
LinkFile:=ShellObject as IPersistFile;
ShellLink:=ShellObject as IShellLink;
FileName:=ParamStr(0);
ShellLink.SetPath(pchar(FileName));
ShellLink.SetWorkingDirectory(pchar(ExtractFilePath(FileName)));
if SHGetSpecialFolderLocation(Handle,CSIDL_FAVORITES,P)=NOERROR then begin
SHGetPathFromIDList(P,C);
ShortcutPosition:=StrPas(C);
s:= 'Class Information Studio';
if RusItem.Checked then
begin
if not InputQuery('Class Information Studio',
'Вы хотите разместить ярлык в Избранном?', s)
then s := 'Class Information Studio' else
ShortcutPosition:=ShortcutPosition+'\'+ S + '.lnk';
end;
if EngItem.Checked then
begin
if not InputQuery('Class Information Studio',
'Do you want a shortcut to your Favorites?', s)
then s := 'Class Information Studio' else
ShortcutPosition:=ShortcutPosition+'\'+ S + '.lnk';
end;
WShortcutPosition:=ShortcutPosition;
LinkFile.Save(PWChar(WShortcutPosition),False);
end;
end;

procedure TMainForm.MainMenuItemClick(Sender: TObject);
begin
MainMenuItem.Checked := not MainMenuItem.Checked;
if MainMenuItem.Checked then
begin
FileItem.Visible := True;
ServiceItem.Visible := True;
MainFavItem.Visible := True;
HelpItem.Visible := True;
MainForm.ClientHeight := 290;
end;
if not MainMenuItem.Checked then
begin
MainForm.ClientHeight := 270;
FileItem.Visible := False;
ServiceItem.Visible := False;
MainFavItem.Visible := False;
HelpItem.Visible := False;
end;
end;

procedure TMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if ToolForm.ch13.Checked then
begin
Action := caNone;
ShowWindow(MainForm.Handle, Sw_Hide);
ShowWindow(Application.Handle, Sw_Hide);
Shell_NotifyIcon(Nim_Add, @Icon);
end;
if ToolForm.ch5.Checked then
begin
Ini.WriteInteger('Parameters', 'Top', Top);
Ini.WriteInteger('Parameters', 'Left', Left);
end;
if ToolForm.ch2.Checked then
AnimateWindow(Handle, 500, AW_BLEND or AW_HIDE);
end;

procedure TMainForm.ApplicationMinimized(Sender: TObject);
begin
if ToolForm.ch4.Checked then
begin
ShowWindow(Application.Handle, Sw_Hide);
Shell_NotifyIcon(Nim_Add, @Icon);
end;
end;

procedure TMainForm.MySystemTray(var MySysTray: TMessage);
var
Ico:TPoint;
begin
case MySysTray.LParam of
wm_LButtonDblClk:
begin
ShowWindow(Application.Handle, Sw_Show);
Application.Restore;
ShowWindow(Handle, Sw_Show);
Shell_NotifyIcon(Nim_Delete, @Icon);
end;
wm_RButtonDown:
begin
SetForegroundWindow(Handle);
GetCursorPos(Ico);
TrayMenu.Popup(Ico.X, Ico.Y);
end;
end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
Shell_NotifyIcon(Nim_Delete, @Icon);
SM := GetSystemMenu(Handle, True);
UnRegisterHotKey(Handle, 1);
MainForm.OnActivate := nil;
DescriptionText.Free;

Magnifier.Free;
MainMenu.Free;
TrayMenu.Free;
PrintDlg.Free;
T1.Free;
T2.Free;
fr1.Free;
fr2.Free;
fr3.Free;
Quit.Free;
Logo.Free;
tx1.Free;
tx2.Free;
tx3.Free;
tx4.Free;
tx5.Free;
tx6.Free;
tx7.Free;
tx8.Free;
ed1.Free;
ed2.Free;
ed3.Free;
ed4.Free;
ed5.Free;
Ini.Free;
end;

procedure TMainForm.RestoreProItemClick(Sender: TObject);
begin
ShowWindow(Application.Handle, Sw_Show);
Application.Restore;
ShowWindow(Handle, Sw_Show);
Shell_NotifyIcon(Nim_Delete, @Icon);
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
if ToolForm.ch12.Checked then
if Key = vk_Escape then
Application.Minimize;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
if not ToolForm.ch13.Checked then
if RusItem.Checked then
if ToolForm.Ch7.Checked then
CanClose :=
Application.MessageBox('Вы уверены, что хотите выйти?',
'Class Information Studio',
mb_IconQuestion + mb_YesNo) = mrYes;
if not ToolForm.ch13.Checked then
if EngItem.Checked then
if ToolForm.Ch7.Checked then
CanClose :=
Application.MessageBox('Are you sure, what do you want to exit?',
'Class Information Studio',
mb_IconQuestion + mb_YesNo) = mrYes;
end;

procedure TMainForm.WMMoving(var msg: TWMMoving);
var
r: TRect;
begin
if ToolForm.Ch11.Checked then
begin
r := Screen.WorkareaRect;
if msg.lprect^.left < r.left then
OffsetRect(msg.lprect^, r.left - msg.lprect^.left, 0);
if msg.lprect^.top < r.top then
OffsetRect(msg.lprect^, 0, r.top - msg.lprect^.top);
if msg.lprect^.right > r.right then
OffsetRect(msg.lprect^, r.right - msg.lprect^.right, 0);
if msg.lprect^.bottom > r.bottom then
OffsetRect(msg.lprect^, 0, r.bottom - msg.lprect^.bottom);
inherited;
end;
end;

procedure TMainForm.RusItemClick(Sender: TObject);
begin
RusItem.Checked := True;
EngItem.Checked := False;
SM := GetSystemMenu(Handle, True);
SM := GetSystemMenu(Handle, False);
InsertMenu(SM, Word(-1), Mf_Separator, Cherta, '');
InsertMenu(SM, Word(-2), Mf_ByPosition, AboutPro, 'О программе...');
NewWinItem.Caption := 'Создать';
SaveItem.Caption := 'Сохранить...';
PrintItem.Caption := 'Печать...';
ShortCutItem.Caption := 'Ярлык';
DeskItem.Caption := 'На Рабочем столе';
StartMenuItem.Caption := 'В Меню Пуск';
ProgramMenuItem.Caption := 'В Меню Программы';
AutoStartItem.Caption := 'В Автозагрузку';
FavoritesItem.Caption := 'В Избранное';
ContextItem.Caption := 'В контекстное меню';
IEItem.Caption := 'В Internet Explorer';
CursorPosItem.Caption := 'Под курсором';
RunItem.Caption := 'Выполнить...';
ChooseProItem.Caption := 'Обзор...';
FindItem.Caption := 'Найти...';
PropertiesItem.Caption := 'Свойства...';
QuitItem.Caption := 'Выход';
MainFavItem.Caption := 'Закладки';
AddFavItem.Caption := 'Создать закладку...';
OrgFavItem.Caption := 'Управление закладками...';
ServiceItem.Caption := 'Инструменты';
LangItem.Caption := 'Интерфейс';
RusItem.Caption := 'Русский';
EngItem.Caption := 'Английский';
MainMenuItem.Caption := 'Главное меню';
MultipleItem.Caption := 'Запуск одной копии';
OnTopItem.Caption := 'Всегда впереди';
SaveConfigItem.Caption  := 'Сохранить конфигурацию';
SavePosItem.Caption := 'Сохранить позицию окна';
ToolItem.Caption := 'Настройки...';
HelpItem.Caption := 'Помощь';
InfoItem.Caption := 'Справка...';
HomePageItem.Caption := 'Домашняя страница...';
SendItem.Caption := 'Обратная связь';
SourceCodeItem.Caption := 'Исходный код...';
AboutItem.Caption := 'О программе...';
RestoreProItem.Caption := 'Открыть';
CloseItem.Caption := 'Выход';
tx2.Caption := 'Перетащите лупу на окно, чтобы получить ее';
tx3.Caption := 'описание (включая Internet Explorer).';
tx4.Caption := 'Позиция мыши:';
tx5.Caption := 'Декриптор:';
tx6.Caption := 'Заголовок окна:';
tx7.Caption := 'Класс окна:';
tx8.Caption := 'Handle окна:';
Quit.Caption := 'Закрыть';
ToolForm.Caption := 'Параметры';
ToolForm.GeneralTab.Caption := 'Общие';
ToolForm.EventsTab.Caption := 'События';
ToolForm.WindowTab.Caption := 'Окно';
ToolForm.ch1.Caption := 'Использовать XP меню (требуется перезагрузка)';
ToolForm.ch2.Caption := 'Анимация при открытии и закрытии';
ToolForm.ch3.Caption := 'Запускать вместе с Windows OС';
ToolForm.ch4.Caption := 'Сворачивать в системный лоток';
ToolForm.ch5.Caption := 'Сохранять позицию окна';
ToolForm.ch7.Caption := 'Подтверждать выход';
ToolForm.ch8.Caption := 'Отображать модальные окна на Панели Задач';
ToolForm.ch9.Caption := 'Перемещать за клиетскую область';
ToolForm.ch10.Caption := 'Приклеивать к краям экрана';
ToolForm.ch11.Caption := 'Окно только в области клиента';
ToolForm.ch12.Caption := 'Сворачивать при нажатии Escape';
ToolForm.ch13.Caption := 'Сворачивать в лоток при закрытии окна';
ToolForm.ch14.Caption := 'Выносить окно на передний план при наведении мыши';
ToolForm.ch15.Caption := 'При создании нового окна сохранять конфигурацию';
ToolForm.OK.Caption := 'Закрыть';
FavForm.Caption := 'Упорядочить Избранное';
FavForm.DelButton.Caption := 'Удалить';
FavForm.ClearButton.Caption := 'Очистить все';
FavForm.OK.Caption := 'OK';
FavForm.Cancel.Caption := 'Отмена';
AddFavForm.Caption := 'Добавление в Избранное';
AddFavForm.txt1.Caption := 'Добавление сведений в избранное.';
AddFavForm.txt2.Caption := 'Добавляет в список избранного текущие';
AddFavForm.txt3.Caption := 'сведения из главного окна.';
AddFavForm.OK.Caption := 'Добавить';
AddFavForm.Cancel.Caption := 'Отмена';
AboutForm.Caption := 'О программе...';
AboutForm.tx1.Caption := 'Class Information Studio v 1.0';
AboutForm.tx2.Caption := 'Copyright © 2009 Домани Олег (aka ?КТО_Я?)';
AboutForm.License.Clear;
AboutForm.License.Lines.Append('Внимание! Данный программный продукт защищен');
AboutForm.License.Lines.Append('законами об авторских правах и международными');
AboutForm.License.Lines.Append('соглашениями. Незаконное воспроизведение или');
AboutForm.License.Lines.Append('распространение данной программы или ее части');
AboutForm.License.Lines.Append('влечет гражданскую и уголовную ответственность.');
AboutForm.tx4.Caption := 'Физическая память:';
AboutForm.tx5.Caption := 'Использовано:';
AboutForm.tx3.Caption := 'Пермская область, г. Чайковский';
AboutForm.SendMail.Text := '<Написать письмо автору';
AboutForm.OK.Caption := 'Закрыть';
end;

procedure TMainForm.EngItemClick(Sender: TObject);
begin
EngItem.Checked := True;
RusItem.Checked := False;
SM := GetSystemMenu(Handle, True);
SM := GetSystemMenu(Handle, False);
InsertMenu(SM, Word(-1), Mf_Separator, Cherta, '');
InsertMenu(SM, Word(-2), Mf_ByPosition, AboutPro, 'About...');
NewWinItem.Caption := 'Create';
SaveItem.Caption := 'Save...';
PrintItem.Caption := 'Print...';
ShortCutItem.Caption := 'Shortcut';
DeskItem.Caption := 'Desktop';
StartMenuItem.Caption := 'Start Menu';
ProgramMenuItem.Caption := 'Program Menu';
AutoStartItem.Caption := 'Startup';
FavoritesItem.Caption := 'Favorites';
ContextItem.Caption := 'Into Context Menu';
IEItem.Caption := 'Into Internet Explorer';
CursorPosItem.Caption := 'Follow Cursor';
RunItem.Caption := 'Execute...';
ChooseProItem.Caption := 'Choose...';
FindItem.Caption := 'Search...';
PropertiesItem.Caption := 'Properties....';
QuitItem.Caption := 'Quit';
MainFavItem.Caption := 'Bookmarks';
AddFavItem.Caption := 'Create Bookmarks...';
OrgFavItem.Caption := 'Organize Bookmarks...';
ServiceItem.Caption := 'Service';
LangItem.Caption := 'Interface';
RusItem.Caption := 'Russian';
EngItem.Caption := 'English';
MainMenuItem.Caption := 'Main Menu';
MultipleItem.Caption := 'Forbid Multiple';
OnTopItem.Caption := 'Always on Top';
SaveConfigItem.Caption  := 'Save Configuration';
SavePosItem.Caption := 'Remember Window Position';
ToolItem.Caption := 'Preferences...';
HelpItem.Caption := 'Info';
InfoItem.Caption := 'Help Contents...';
HomePageItem.Caption := 'Home Page...';
SendItem.Caption := 'Send Feedback';
SourceCodeItem.Caption := 'Source Code...';
AboutItem.Caption := 'About...';


RestoreProItem.Caption := 'Open';
CloseItem.Caption := 'Quit';
tx2.Caption := 'Drag the Magnifying Glass over the Window to Get It';
tx3.Caption := 'Description (Including Internet Explorer).';
tx4.Caption := 'Mouse Position:';
tx5.Caption := 'ID:';
tx6.Caption := 'Window Caption:';
tx7.Caption := 'Window Class:';
tx8.Caption := 'Window Handle:';
Quit.Caption := 'Close';
ToolForm.Caption := 'Preferences';
ToolForm.GeneralTab.Caption := 'General';
ToolForm.EventsTab.Caption := 'Events';
ToolForm.WindowTab.Caption := 'Window';
ToolForm.ch1.Caption := 'Use of XP Menu (you will need to restart the program)';
ToolForm.ch2.Caption := 'Animation at Opening and Closing';
ToolForm.ch3.Caption := 'Run at Windows OS Startup';
ToolForm.ch4.Caption := 'Minimize to System Tray';
ToolForm.ch5.Caption := 'Remember Window Position';
ToolForm.ch7.Caption := 'Confirmation Exit';
ToolForm.ch8.Caption := 'Show modal Windows on the Task Bar';
ToolForm.ch9.Caption := 'Move for the vlient Area';
ToolForm.ch10.Caption := 'Use of Screen Snap';
ToolForm.ch11.Caption := 'Window Only in client Area';
ToolForm.ch12.Caption := 'Minimize on pressing Escape';
ToolForm.ch13.Caption := 'Minimize to System Tray at closing';
ToolForm.ch14.Caption := 'Take out Window to the foreground';
ToolForm.ch15.Caption := 'On creating New Window saving current configuration';
ToolForm.OK.Caption := 'Close';
FavForm.Caption := 'Organize Favotites';
FavForm.DelButton.Caption := 'Remove';
FavForm.ClearButton.Caption := 'Remove All';
FavForm.OK.Caption := 'OK';
FavForm.Cancel.Caption := 'Cancel';
AddFavForm.Caption := 'Add to Favorites';
AddFavForm.txt1.Caption := 'Add Information to the Favorites.';
AddFavForm.txt2.Caption := 'Add to the Favorites list Current Information';
AddFavForm.txt3.Caption := 'from Main Window.';
AddFavForm.OK.Caption := 'Add';
AddFavForm.Cancel.Caption := 'Cancel';
AboutForm.Caption := 'About...';
AboutForm.tx1.Caption := 'Class Information Studio v 1.0';
AboutForm.tx2.Caption := 'Copyright © 2009 Domani Oleh (aka ?КТО_Я?)';
AboutForm.License.Clear;
AboutForm.License.Lines.Append('Attention! The given software is protected');
AboutForm.License.Lines.Append('laws on copyrights and international');
AboutForm.License.Lines.Append('agreements. Illegal reproduction or');
AboutForm.License.Lines.Append('distribution given programs or her parts');
AboutForm.License.Lines.Append('attracts civil and the criminal liability.');
AboutForm.tx4.Caption := 'Physical Memory:';
AboutForm.tx5.Caption := 'Memory in Use:';
AboutForm.tx3.Caption := 'Perm region, Chaykovskiy city';
AboutForm.SendMail.Text := '<Write the letter to the author';
AboutForm.OK.Caption := 'Close';
end;

procedure TMainForm.MySystemMenu(var MySysMenu: TWmSysCommand);
begin
if MySysMenu.CmdType = AboutPro then
begin
AboutForm.Position := poMainFormCenter;
AboutForm.ShowModal;
end;
inherited;
end;

procedure TMainForm.WMHotKey(var a: TWMHotKey);
begin
if a.HotKey = 1 then
begin
ShowWindow(Application.Handle, Sw_Show);
Application.Restore;
Shell_NotifyIcon(Nim_Delete, @Icon);
end;
end;

procedure TMainForm.SaveItemClick(Sender: TObject);
var
s: String;
begin
try
if EngItem.Checked then
begin
DescriptionText.Lines.Clear;
DescriptionText.Lines.Add('ID: ' + ed2.Text);
DescriptionText.Lines.Add('Window caption: ' + ed3.Text);
DescriptionText.Lines.Add('Window class: ' + ed4.Text);
DescriptionText.Lines.Add('Window handle: ' + ed5.Text);
end;
if RusItem.Checked then
begin
DescriptionText.Lines.Clear;
DescriptionText.Lines.Add('Декриптор: ' + ed2.Text);
DescriptionText.Lines.Add('Заголовок окна: ' + ed3.Text);
DescriptionText.Lines.Add('Класс окна: ' + ed4.Text);
DescriptionText.Lines.Add('Handle окна: ' + ed5.Text);
end;
if EngItem.Checked then
begin
if OpenSaveFileDialog(MainForm.Handle, '*.*', 'Normal text files (*.txt)|*.txt',
ParamStr(1), 'Save As', s, False) then
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
if FileExists(s) then
if Application.MessageBox(PChar('File "' + s +
'" already exists.' +
#13 + 'Replace?'),
'Confirmation',MB_ICONQUESTION + mb_YesNo)
<> idYes then

else
DescriptionText.Lines.SaveToFile(s);
if not FileExists(s) then
DescriptionText.Lines.SaveToFile(s);
end;
end;
if RusItem.Checked then
begin
if OpenSaveFileDialog(MainForm.Handle, '*.*', 'Обычный текстовый файл (*.txt)|*.txt',
ParamStr(1), 'Сохранить как', s, False) then
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
if FileExists(s) then
if Application.MessageBox(PChar('Файл "' + s +
'" уже существует.' +
#13 + 'Заменить?'),
'Подтверждение',MB_ICONQUESTION + mb_YesNo)
<> idYes then

else
DescriptionText.Lines.SaveToFile(s);
if not FileExists(s) then
DescriptionText.Lines.SaveToFile(s);
end;
end;
except
end;
end;

procedure TMainForm.PrintItemClick(Sender: TObject);
var
FFileName: String;
begin
if EngItem.Checked then
begin
DescriptionText.Lines.Clear;
DescriptionText.Lines.Add('ID: ' + ed2.Text);
DescriptionText.Lines.Add('Window caption: ' + ed3.Text);
DescriptionText.Lines.Add('Window class: ' + ed4.Text);
DescriptionText.Lines.Add('Window handle: ' + ed5.Text);
if PrintDlg.Execute then
DescriptionText.Print(FFileName);
end;
if RusItem.Checked then
begin
DescriptionText.Lines.Clear;
DescriptionText.Lines.Add('Декриптор: ' + ed2.Text);
DescriptionText.Lines.Add('Заголовок окна: ' + ed3.Text);
DescriptionText.Lines.Add('Класс окна: ' + ed4.Text);
DescriptionText.Lines.Add('Handle окна: ' + ed5.Text);
if PrintDlg.Execute then
DescriptionText.Print(FFileName);
end;
end;

procedure SearchInFolder(Folder: string);
begin
with TDDEClientConv.Create(nil) do
begin
ConnectMode := ddeManual;
ServiceApplication := 'Explorer.exe';
SetLink('Folders', 'AppProperties');
OpenLink;
ExecuteMacro(PChar('[FindFolder(, ' + Folder + ')]'), False);
CloseLink;
Free;
end;
end;

procedure TMainForm.FindItemClick(Sender: TObject);
begin
SearchInFolder('');
end;

procedure TMainForm.CloseItemClick(Sender: TObject);
begin
if ToolForm.ch5.Checked then
begin
Ini.WriteInteger('Parameters', 'Top', Top);
Ini.WriteInteger('Parameters', 'Left', Left);
end;
if RusItem.Checked then
if ToolForm.Ch7.Checked then
if Application.MessageBox('Вы уверены, что хотите выйти?',
'Class Information Studio',
mb_IconQuestion + mb_YesNo) = mrYes then
Halt;
if EngItem.Checked then
if ToolForm.Ch7.Checked then
if Application.MessageBox('Are you sure, what do you want to exit?',
'Class Information Studio',
mb_IconQuestion + mb_YesNo) = mrYes then
Halt;
if not ToolForm.Ch7.Checked then
Halt;
end;

procedure TMainForm.ContextItemClick(Sender: TObject);
var
Reg: TRegistry;
begin
ContextItem.Checked := not ContextItem.Checked;
if ContextItem.Checked then
begin
Reg:= TRegistry.Create;
Reg.RootKey := HKEY_CLASSES_ROOT;
Reg.OpenKey('*\Shell\Get Handle',true);
Reg.WriteString('','MyPro');
Reg.WriteString('', Application.Title);
Reg.CloseKey;
Reg.OpenKey('*\Shell\Get Handle\command',true);
Reg.WriteString('','command');
Reg.WriteString('',paramstr(1) + application.ExeName);
Reg.CloseKey;
Reg.Free;
end else
if not ContextItem.Checked then
begin
Reg:= TRegistry.Create;
Reg.RootKey := HKEY_CLASSES_ROOT;
Reg.DeleteKey('*\Shell\Get Handle');
Reg.CloseKey;
Reg.Free;
end;
end;

procedure TMainForm.IEItemClick(Sender: TObject);
const
TagID = '\{002BC5D9-6959-412F-AD03-500CF1C64114}\';
var
Reg: TRegistry;
ProgramPath: string;
RegKeyPath: string;
begin
IEItem.Checked := not IEItem.Checked;
ProgramPath := Application.ExeName;
Reg := TRegistry.Create;
try
with Reg do begin
RootKey := HKEY_LOCAL_MACHINE;
RegKeyPath := 'Software\Microsoft\Internet Explorer\Extensions';
OpenKey(RegKeyPath + TagID, True);
WriteString('ButtonText', 'Class Information Studio');
WriteString('MenuText', 'Class Information Studio');
WriteString('MenuStatusBar', 'Class Information Studio.');
WriteString('ClSid', '{1FBA04EE-3024-11d2-8F1F-0000F87ABD16}');
WriteString('Default Visible', 'Yes');
WriteString('Exec', ProgramPath);
WriteString('HotIcon', ',3');
WriteString('Icon', ',4');
end
finally
if not IEItem.Checked then
Reg.DeleteKey
('\Software\Microsoft\Internet Explorer\Extensions\{002BC5D9-6959-412F-AD03-500CF1C64114}\');
Reg.CloseKey;
Reg.Free;
end;

end;

procedure TMainForm.T2Timer(Sender: TObject);
var
p: TPoint;
begin
if ToolForm.Ch14.Checked then
begin
GetCursorPos(p);
SetForegroundWindow(WindowFromPoint(p));
end;
end;

procedure TMainForm.OrgFavItemClick(Sender: TObject);
begin
FavForm.ClientHeight := 350;
FavForm.ClientWidth := 404;
FavForm.Position := poMainFormCenter;
FavForm.ShowModal;
end;

procedure TMainForm.AddFavItemClick(Sender: TObject);
begin
AddFavForm.Position := poMainFormCenter;
AddFavForm.ShowModal;
end;

procedure TMainForm.SourceCodeItemClick(Sender: TObject);
begin
if EngItem.Checked then
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
if Application.MessageBox(
'Copyright @2009 Domani Oleg (aka ?КТО_Я?)' + #13 +
'=====================================' + #13 + #13 + '' +
'If you want to give of Source Code of Get Handle Project' + #13
+ '(archives with components library by wish user) and'
+ #13 + 'also all next new version then send e-mail to the author.' + #13 +
'' +  #13 + '=====================================' +  #13 +
'' +  #13 +
'Send mail now?',
'Class Information Studio',
mb_IconAsterisk + mb_YesNo) = idYes then
begin
ShellExecute(Handle, 'open',
'mailto:GoodWinNix@mail.ru?Subject=Class Information Studio Project' +
'&Body=Hello, please send me the source code program. Thanks!',
'', '', SW_SHOW);
end;
end;
if RusItem.Checked then
begin
PostMessage(Handle, WM_USER + 1024, 0, 0);
if Application.MessageBox(
'Copyright @2009 Домани Олег (aka ?КТО_Я?)' + #13 +
'======================================' + #13 + #13 + '' +
'Если Вы хотите получить исходный код проекта (архив ' + #13
+ 'с компонентами по желанию пользователя), а также'
+ #13 + 'все последующие новые версии программы, то' + #13 +
'отправьте электронное письмо автору.' + #13 +
'' +  #13 + '======================================' +  #13 +
'' +  #13 +
'Отправить письмо сейчас?',
'Class Information Studio',
mb_IconAsterisk + mb_YesNo) = idYes then
begin
ShellExecute(Handle, 'open',
'mailto:GoodWinNix@mail.ru?Subject=Class Information Studio Project' +
'&Body=Hello, please send me the source code program. Thanks!',
'', '', SW_SHOW);
end;
end;
end;

procedure TMainForm.SavePosItemClick(Sender: TObject);
begin
Ini.WriteInteger('Parameters', 'Top', Top);
Ini.WriteInteger('Parameters', 'Left', Left);
end;

procedure TMainForm.SaveConfigItemClick(Sender: TObject);
begin
Ini.WriteBool('Parameters', 'Main menu', MainMenuItem.Checked);
Ini.WriteBool('Parameters', 'Always on top', OnTopItem.Checked);
Ini.WriteBool('Parameters', 'Forbid multiple', MultipleItem.Checked);
Ini.WriteBool('Parameters', 'Description under cursor pos', CursorPosItem.Checked);
Ini.WriteBool('Parameters', 'Use of XP menu', ToolForm.ch1.Checked);
Ini.WriteBool('Parameters', 'Animation of window on opening and closing', ToolForm.ch2.Checked);
Ini.WriteBool('Parameters', 'Run with Windows OS start up', ToolForm.ch3.Checked);
Ini.WriteBool('Parameters', 'Minimized to system tray', ToolForm.ch4.Checked);
Ini.WriteBool('Parameters', 'Minimize on pressing Escape', ToolForm.ch12.Checked);
Ini.WriteBool('Parameters', 'Save window position', ToolForm.ch5.Checked);
Ini.WriteBool('Parameters', 'Confirmation exit', ToolForm.ch7.Checked);
Ini.WriteBool('Parameters', 'Show other win in the Task Bar', ToolForm.ch8.Checked);
Ini.WriteBool('Parameters', 'Move window of area', ToolForm.ch9.Checked);
Ini.WriteBool('Parameters', 'Screen snap', ToolForm.ch10.Checked);
Ini.WriteBool('Parameters', 'Window only in the areaclient', ToolForm.ch11.Checked);
Ini.WriteBool('Parameters', 'Minimize at closing', ToolForm.ch13.Checked);
Ini.WriteBool('Parameters', 'Take out windows to foreground', ToolForm.ch14.Checked);
Ini.WriteBool('Parameters', 'Russian interface', RusItem.Checked);
Ini.WriteBool('Parameters', 'English interface', EngItem.Checked);
end;

procedure TMainForm.HomePageItemClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'http://www.viacoding.mylivepage.ru/', nil,nil, Sw_ShowNormal);
end;

procedure TMainForm.InfoItemClick(Sender: TObject);
begin
ShellExecute(Handle, nil, 'Help.chm', nil, nil, Sw_ShowNormal);
end;

end.
