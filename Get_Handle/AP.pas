unit AP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, XPLabel, XPButton, StdCtrls, ComCtrls, Drawer,
  XPGroupBox, XPPanel, ShellApi, Buttons;

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
  TAboutForm = class(TForm)
    fr1: TPanel;
    tx1: TXPLabel;
    tx2: TXPLabel;
    tx5: TXPLabel;
    tx4: TXPLabel;
    tx3: TXPLabel;
    spr1: TBevel;
    spr2: TBevel;
    License: TRichEdit;
    fr2: TPanel;
    OK: TXPButton;
    SendMail: TEdit;
    Drawer: TDrawer;
    tx8: TXPLabel;
    tx9: TXPLabel;
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure CancelClick(Sender: TObject);
    procedure tx8Click(Sender: TObject);
    procedure tx9Click(Sender: TObject);
    procedure tx8MouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure tx8MouseLeave(Sender: TObject);
    procedure tx8MouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure tx9MouseMove(Sender: TObject; Shift: TShiftState; X,
    Y: Integer);
    procedure tx9MouseLeave(Sender: TObject);
    procedure tx9MouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure SendMailClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);

  private

    SM: HWND;

    procedure WMMoving(var msg: TWMMoving);
    message WM_MOVING;

    procedure wmNCLButtonDown(var Msg: TWMNCLButtonDown);
    message WM_NCLBUTTONDOWN;

    procedure wmNCLButtonUp(var Msg: TWMNCLButtonUp);
    message WM_NCLBUTTONUP;

    procedure ChangeMessageBoxPosition(var Msg: TMessage);
    message mbMessage;

    procedure CMMouseLeave(var msg: TMessage);
    message CM_MOUSELEAVE;

  public

  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.dfm}  uses  TP, NP;

procedure TAboutForm.WMMoving(var msg: TWMMoving);
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

procedure TAboutForm.FormShow(Sender: TObject);
var
MS: TMemoryStatus;
begin
GlobalMemoryStatus(MS);
if MainForm.EngItem.Checked then
begin
tx4.Caption := 'Memory Available to Windows: ' + FormatFloat('#,###" KB"', MS.dwTotalPhys / 1024);
tx5.Caption := 'Use: ' + Format('%d %%', [MS.dwMemoryLoad]);
end;
if MainForm.RusItem.Checked then
begin
tx4.Caption := 'Физическая память: ' + FormatFloat('#,###" KB"', MS.dwTotalPhys / 1024);
tx5.Caption := 'Использовано: ' + Format('%d %%', [MS.dwMemoryLoad]);
end;
if ToolForm.ch8.Checked then
SetWindowLong(AboutForm.Handle, GWL_EXSTYLE,
GetWindowLOng(AboutForm.Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TAboutForm.FormActivate(Sender: TObject);
begin
SM := GetSystemMenu(Handle, False);
DeleteMenu(SM, Sc_Restore, Mf_String);
DeleteMenu(SM, Sc_Size, Mf_String);
DeleteMenu(SM, Sc_Minimize, Mf_String);
DeleteMenu(SM, Sc_Maximize, Mf_String);
end;

procedure TAboutForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
if ToolForm.ch9.Checked then
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;
end;

procedure TAboutForm.wmNCLButtonDown(var Msg: TWMNCLButtonDown);
begin
if Msg.HitTest = HTHELP then
begin
Msg.Result := 0;
end else
inherited;
end;

procedure TAboutForm.wmNCLButtonUp(var Msg: TWMNCLButtonUp);
begin
if Msg.HitTest = HTHELP then
begin
Msg.Result := 0;
PostMessage(Handle, WM_USER + 1024, 0, 0);
if MainForm.RusItem.Checked then
Application.MessageBox('Программа предназначена для определения класса окна,' +
#13 + 'ее хендла, а также краткого описания.',
'Class Information Studio',
mb_IconAsterisk + mb_OK);
if MainForm.EngItem.Checked then
Application.MessageBox('Class Information Studio program is intended for definition' +
#13 + 'of window class, it handle and also short description.',
'Class Information Studio',
mb_IconAsterisk + mb_OK);
end
else
inherited;
end;

procedure TAboutForm.ChangeMessageBoxPosition(var Msg: TMessage);
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
x := AboutForm.Left + ((AboutForm.Width - w) div 2);
if x < 0 then
x := 0
else if x + w > Screen.Width then x := Screen.Width - w;
y := AboutForm.Top + ((AboutForm.Height - h) div 2);
if y < 0 then y := 0
else if y + h > Screen.Height then y := Screen.Height - h;
SetWindowPos(MBHWnd, 0, x, y, 0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
end;
end;

procedure TAboutForm.CancelClick(Sender: TObject);
begin
AboutForm.Close;
end;

procedure TAboutForm.CMMouseLeave(var msg: TMessage);
begin
tx8.ForegroundColor := $00FF8000;
tx9.ForegroundColor := $00FF8000;
end;

procedure TAboutForm.tx8Click(Sender: TObject);
begin
ShellExecute(Handle, nil, 'Mailto:GoodWinNix@mail.ru',
nil, nil, Sw_ShowNormal);
end;

procedure TAboutForm.tx9Click(Sender: TObject);
begin
ShellExecute(Handle, nil, 'http://www.viacoding.mylivepage.ru/', nil,nil, Sw_ShowNormal);
end;

procedure TAboutForm.tx8MouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
tx8.ForegroundColor := $00FF8000;
end;

procedure TAboutForm.tx8MouseLeave(Sender: TObject);
begin
tx8.ForegroundColor := $00FF8000;
end;

procedure TAboutForm.tx8MouseMove(Sender: TObject; Shift: TShiftState; X,
Y: Integer);
begin
tx8.ForegroundColor := clRed;
end;

procedure TAboutForm.tx9MouseMove(Sender: TObject; Shift: TShiftState; X,
Y: Integer);
begin
tx9.ForegroundColor := clRed;
end;

procedure TAboutForm.tx9MouseLeave(Sender: TObject);
begin
tx9.ForegroundColor := $00FF8000;
end;

procedure TAboutForm.tx9MouseUp(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
tx9.ForegroundColor := $00FF8000;
end;

procedure TAboutForm.SendMailClick(Sender: TObject);
begin
Drawer.Open;
end;

procedure TAboutForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
OK.SetFocus;
end;

procedure TAboutForm.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
if Key = vk_Escape then
Close;
end;

procedure TAboutForm.FormDestroy(Sender: TObject);
begin
AboutForm.OnActivate := nil;
SendMail.Free;
OK.Free;
end;

end.
