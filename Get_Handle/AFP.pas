unit AFP;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, XPLabel, ExtCtrls, XPGroupBox, XPButton, ComCtrls;

type
  TAddFavForm = class(TForm)
    OK: TXPButton;
    Cancel: TXPButton;
    fr1: TXPGroupBox;
    Logo: TImage;
    txt1: TXPLabel;
    txt2: TXPLabel;
    txt3: TXPLabel;
    procedure OKClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
    procedure CancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

  public

  end;

var
  AddFavForm: TAddFavForm;

implementation

uses NP, TP, FP;

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

procedure TAddFavForm.OKClick(Sender: TObject);
var
f: TFileStream;
begin
try
AddListViewItem(MainForm.ed2.Text, MainForm.ed3.Text, MainForm.ed4.Text,
MainForm.ed5.Text, FavForm.ListView);
f := TFileStream.Create('ListFavorites.ipf', fmcreate);
f.WriteComponent(FavForm.ListView);
f.Free;
AddFavForm.Close;
except
end;
end;

procedure TAddFavForm.FormKeyDown(Sender: TObject; var Key: Word;
Shift: TShiftState);
begin
if Key = vk_Escape then
Cancel.OnClick(Self);
end;

procedure TAddFavForm.CancelClick(Sender: TObject);
begin
AddFavForm.Close;
end;

procedure TAddFavForm.FormDestroy(Sender: TObject);
begin
AddFavForm.OnActivate := nil;
Cancel.Free;
Logo.Free;
txt1.Free;
txt2.Free;
txt3.Free;
fr1.Free;
OK.Free;
end;

procedure TAddFavForm.FormShow(Sender: TObject);
begin
if ToolForm.ch8.Checked then
SetWindowLong(AddFavForm.Handle, GWL_EXSTYLE,
GetWindowLOng(AddFavForm.Handle, GWL_EXSTYLE) or WS_EX_APPWINDOW);
end;

procedure TAddFavForm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if ToolForm.ch9.Checked then
begin
ReleaseCapture;
Perform(Wm_SysCommand, $f012, 0);
end;
end;

procedure TAddFavForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Cancel.SetFocus;
end;

end.
