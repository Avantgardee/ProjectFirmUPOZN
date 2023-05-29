program Practice;

uses
  Vcl.Forms,
  Main in 'Main.pas' {FormMain},
  Tool in 'Tool.pas',
  ListUnit in 'ListUnit.pas' {ListForm},
  WrkUnit in 'WrkUnit.pas' {WrkForm},
  Work in 'Work.pas' {WorkForm},
  FindUnit in 'FindUnit.pas' {FormFind},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Tablet Light');
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TListForm, ListForm);
  Application.CreateForm(TWrkForm, WrkForm);
  Application.CreateForm(TWorkForm, WorkForm);
  Application.CreateForm(TFormFind, FormFind);
  Application.Run;
end.
