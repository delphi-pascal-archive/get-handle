program GetHandle;

uses
  Forms,
  NP in 'NP.pas' {MainForm},
  TP in 'TP.pas' {ToolForm},
  AP in 'AP.pas' {AboutForm},
  FP in 'FP.pas' {FavForm},
  AFP in 'AFP.pas' {AddFavForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Class Information Studio';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TToolForm, ToolForm);
  Application.CreateForm(TFavForm, FavForm);
  Application.CreateForm(TAddFavForm, AddFavForm);
  Application.Run;
end.
