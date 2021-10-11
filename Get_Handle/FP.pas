unit FP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, XPButton, ExtCtrls, ImgList;

type
  TFavForm = class(TForm)
    ListView: TListView;
    fr1: TPanel;
    OK: TXPButton;
    DelButton: TXPButton;
    ClearButton: TXPButton;
    ImageList: TImageList;
    Cancel: TXPButton;
    procedure FormShow(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure DelButtonClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
    procedure CancelClick(Sender: TObject);
  private

    f: TFileStream;

    Sm: HWND;
    
  public

  end;

var
  FavForm: TFavForm;

implementation

uses TP;

{$R *.dfm}

procedure AddListViewItem(const aCaption, aValue: String; aValue2: String; aValue3: String; aLV: TListView);
var
NewItem: TListItem;
begin
NewItem := aLV.Items.Add;
NewItem.Caption := aCaption;
NewItem.SubItems.Add(aValue);
NewItem.SubItems.Add(aValue2);
NewItem.SubItems.Add(aValue3);
end;

procedure TFavForm.FormShow(Sender: TObject);
begin
try
if ToolForm.ch8.Checked then
SetWindowLong(FavForm.Handle, GWL_EXSTYLE,
GetWindowLOng(FavForm.Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
f := TFileStream.Create('ListFavorites.ipf', fmOpenRead);
f.ReadComponent(ListView);
f.Free;
except
end;
end;

procedure TFavForm.OKClick(Sender: TObject);
begin
try
f := TFileStream.Create('ListFavorites.ipf', fmcreate);
f.WriteComponent(FavForm.ListView);
f.Free;
FavForm.Close;
except
end;
end;

procedure TFavForm.ClearButtonClick(Sender: TObject);
begin
ListView.Clear;
end;

procedure TFavForm.DelButtonClick(Sender: TObject);
begin
try
ListView.Items.Delete(ListView.Selected.Index);
except
end;
end;

procedure TFavForm.FormActivate(Sender: TObject);
begin
Sm := GetSystemMenu(Handle, False);
DeleteMenu(Sm, Sc_Restore, Mf_Bycommand);
DeleteMenu(Sm, Sc_Minimize, Mf_Bycommand);
DeleteMenu(Sm, Sc_Maximize, Mf_Bycommand);
end;

procedure TFavForm.FormDestroy(Sender: TObject);
begin
Sm := GetSystemMenu(Handle, True);
FavForm.OnActivate := nil;
ClearButton.Free;
DelButton.Free;
ImageList.Free;
ListView.Free;
Cancel.Free;
OK.Free;
fr1.Free;
end;

procedure TFavForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Cancel.SetFocus;
end;

procedure TFavForm.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
if Key = vk_Escape then
Cancel.OnClick(Self);
end;

procedure TFavForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
Shift: TShiftState; X, Y: Integer);
begin
if ToolForm.ch9.Checked then
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;
end;

procedure TFavForm.CancelClick(Sender: TObject);
begin
FavForm.Close;
end;

end.
