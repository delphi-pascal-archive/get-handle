unit TP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPCheckBox, XPGroupBox, XPButton, IniFiles, Registry, StdCtrls,
  ComCtrls, ExtCtrls;

  type
   TTabSheet = class(ComCtrls.TTabSheet);

  const
   mbMessage = WM_USER + 1024;

  type
   TWmMoving = record
   Msg: Cardinal;
   fwSide: Cardinal;
   lpRect: PRect;
   Result: Integer;
  end;

type
  TToolForm = class(TForm)
    OK: TXPButton;
    HandlePage: TPageControl;
    GeneralTab: TTabSheet;
    EventsTab: TTabSheet;
    WindowTab: TTabSheet;
    ch1: TXPCheckBox;
    ch2: TXPCheckBox;
    ch3: TXPCheckBox;
    ch10: TXPCheckBox;
    ch9: TXPCheckBox;
    ch11: TXPCheckBox;
    ch8: TXPCheckBox;
    Ch14: TXPCheckBox;
    ch5: TXPCheckBox;
    ch7: TXPCheckBox;
    ch13: TXPCheckBox;
    ch12: TXPCheckBox;
    ch4: TXPCheckBox;
    sp1: TBevel;
    sp2: TBevel;
    sp3: TBevel;
    sp5: TBevel;
    sp6: TBevel;
    sp4: TBevel;
    ch15: TXPCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure OKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ch3Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

    Ini: TIniFile;

    FColor: TColor;

    procedure SetColor(Value: TColor);

    procedure WMEraseBkGnd(var Msg: TWMEraseBkGnd); 
    message WM_ERASEBKGND;

    procedure WMMoving(var msg: TWMMoving);
    message WM_MOVING;

  public

    constructor Create(aOwner: TComponent); override;
    property Color: TColor read FColor write SetColor;

  end;

var
  ToolForm: TToolForm;

implementation

uses NP, AP, FP, AFP;

{$R *.dfm}

procedure TToolForm.FormShow(Sender: TObject);
begin
HandlePage.ActivePageIndex := 0;
if ToolForm.ch8.Checked then
SetWindowLong(ToolForm.Handle, GWL_EXSTYLE,
GetWindowLOng(ToolForm.Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TToolForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
if ToolForm.ch9.Checked then
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;
end;

procedure TToolForm.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
if Key = vk_Escape then
OK.OnClick(Self);
end;

procedure TToolForm.OKClick(Sender: TObject);
begin
if ch10.Checked then
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
ToolForm.Close;
end;

procedure TToolForm.FormCreate(Sender: TObject);
begin
Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.Ini'));
try
ch1.Checked := Ini.ReadBool('Parameters', 'Use of XP menu', ch1.Checked);
ch2.Checked := Ini.ReadBool('Parameters', 'Animation of window on opening and closing', ch2.Checked);
ch3.Checked := Ini.ReadBool('Parameters', 'Run with Windows OS start up', ch3.Checked);
ch4.Checked := Ini.ReadBool('Parameters', 'Minimized to system tray', ch4.Checked);
ch12.Checked := Ini.ReadBool('Parameters', 'Minimize on pressing Escape', ch12.Checked);
ch5.Checked := Ini.ReadBool('Parameters', 'Save window position', ch5.Checked);
ch7.Checked := Ini.ReadBool('Parameters', 'Confirmation exit', ch7.Checked);
ch8.Checked := Ini.ReadBool('Parameters', 'Show other win in the Task Bar', ch8.Checked);
ch9.Checked := Ini.ReadBool('Parameters', 'Move window of area', ch9.Checked);
ch10.Checked := Ini.ReadBool('Parameters', 'Screen snap', ch10.Checked);
ch11.Checked := Ini.ReadBool('Parameters', 'Window only in the areaclient', ch11.Checked);
ch13.Checked := Ini.ReadBool('Parameters', 'Minimize at closing', ch13.Checked);
ch14.Checked := Ini.ReadBool('Parameters', 'Take out windows to foreground', ch14.Checked);
finally
end;
end;

procedure TToolForm.ch3Click(Sender: TObject);
var
R: TRegistry;
begin
R := TRegistry.Create;
R.RootKey := HKEY_LOCAL_MACHINE;
R.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', false);
if Ch3.Checked then
R.WriteString(Application.Title, ParamStr(0)) else
R.DeleteValue(Application.Title);
R.Free;
end;

procedure TToolForm.WMMoving(var msg: TWMMoving);
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

procedure TToolForm.FormDestroy(Sender: TObject);
begin
ToolForm.OnActivate := nil;
HandlePage.Free;
ch1.Free;
ch2.Free;
ch3.Free;
ch4.Free;
ch5.Free;
ch7.Free;
ch8.Free;
ch9.Free;
ch10.Free;
ch11.Free;
ch12.Free;
ch13.Free;
ch14.Free;
ch15.Free;
Ini.Free;
OK.Free;
end;

constructor TToolForm.Create(aOwner: TComponent);
begin
inherited; 
FColor := clWhite;
end;

procedure TToolForm.SetColor(Value: TColor);
begin
if FColor = Value then
begin
FColor := Value;
Invalidate;
end;
end;

procedure TToolForm.WMEraseBkGnd(var Msg: TWMEraseBkGnd);
begin
if FColor = clWhite then
inherited else
begin
Brush.Color := FColor;
Windows.FillRect(Msg.dc, ClientRect, Brush.Handle);
Msg.Result := 1;
end;
end;

procedure TToolForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
OK.SetFocus;
end;

end.
