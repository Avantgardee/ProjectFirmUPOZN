Unit FindUnit;

Interface

Uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Main, Tool, ListUnit;

Type
    TFormFind = Class(TForm)
        EditN: TEdit;
        Lbl: TLabel;
        Button: TButton;
        Procedure FindEmp();
        Procedure FindDir();
        Procedure FormClose(Sender: TObject; Var Action: TCloseAction);
        Procedure ButtonClick(Sender: TObject);
        Procedure ChangeEdit(Sender: TObject);
        Procedure EditNKeyPress(Sender: TObject; Var Key: Char);
        Procedure EdtPrjctKeyDown(Sender: TObject; Var Key: Word;
          Shift: TShiftState);
        Procedure EdtPrjctKeyPress(Sender: TObject; Var Key: Char);
    Private
        { Private declarations }
    Public
        { Public declarations }
    End;

Var
    FormFind: TFormFind;

Implementation

{$R *.dfm}
{ TFormFind }

Procedure TFormFind.ButtonClick(Sender: TObject);
Var
    L: TTasksList;
Begin
    L := TTasksList.Create;
    If Lbl.Caption = 'Название проекта' Then
    Begin
        L := FormMain.WorkList.FindDirectorProject(EditN.Text);
        If L.Size = 0 Then
            ShowMessage('0')
        Else
        Begin
            ListForm.Show;
            ListForm.NewWorkList(L);
            Close;
        End;
    End
End;

Procedure TFormFind.ChangeEdit(Sender: TObject);
Begin

        Button.Enabled := (EditN.Text <> '');
End;

Procedure TFormFind.EditNKeyPress(Sender: TObject; Var Key: Char);
Begin
    If Lbl.Caption = 'Название проекта' Then
    Begin
        If (TEdit(Sender).Text = '') And
          (((Key > #223) Or (Key < #192)) And (Key <> #08)) Then
            Key := #0;
        If (TEdit(Sender).Text <> '') And (Key < #224) And (Key <> #08) And
          (Key <> ' ') Then
            Key := #0;
    End
    Else
    Begin
        If Not(Key In ['0' .. '9', #08]) Then
            Key := #0;
    End;
End;

Procedure TFormFind.EdtPrjctKeyDown(Sender: TObject; Var Key: Word;
  Shift: TShiftState);
Begin
    If (Shift = [SsShift]) And (Key = VK_INSERT) Then
        Abort;
End;

Procedure TFormFind.EdtPrjctKeyPress(Sender: TObject; Var Key: Char);
Begin
    If (TEdit(Sender).Text = '') And (((Key > #223) Or (Key < #192)) And
      (Key <> #08)) Then
        Key := #0;
    If (TEdit(Sender).Text <> '') And (Key < #224) And (Key <> #08) And
      (Key <> ' ') Then
        Key := #0;
End;

Procedure TFormFind.FindDir;
Begin
    EditN.Text := '';
    Lbl.Caption := 'Название проекта';
    EditN.MaxLength := 10;
    EditN.NumbersOnly := False;
End;

Procedure TFormFind.FindEmp;
Var
    L: TTasksList;
Begin
 
    L := TTasksList.Create;

    L := FormMain.WorkList.FindProjectsByDate;
    If L.Size = 0 Then
        ShowMessage('0')
    Else
    Begin
        ListForm.Show;
        ListForm.NewWorkList(L);
        Close;
    End;

End;

Procedure TFormFind.FormClose(Sender: TObject; Var Action: TCloseAction);
Begin
    FormMain.Enabled := True;
End;

End.
