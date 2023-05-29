unit Work;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Mask, Vcl.StdCtrls,
  Vcl.NumberBox, tool, Vcl.Menus, Vcl.ExtCtrls;

type
  TWorkForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    MonthCalendar1: TMonthCalendar;
    ButtonAdd: TButton;
    ButtonCncl: TButton;
    NumberBox1: TNumberBox;
    EditCode: TEdit;
    EditDirCode: TEdit;
    PopupMenu1: TPopupMenu;
    Panel1: TPanel;
    Label7: TLabel;
    procedure Clear;
    function ShowForNew(var W : TTask): TModalResult;
    function ShowForEdit(var W : TTask): TModalResult;
    procedure ChangeEdit(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure EdtPrjctKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  WorkForm: TWorkForm;

implementation
{$R *.dfm}

{ TForm2 }

procedure TWorkForm.ChangeEdit(Sender: TObject);
begin
    if     (Edit1.Text <> '') and
    (Edit2.Text <> '') and (EditDirCode.Text <> '')
    and (EditCode.Text <> '') then
        ButtonAdd.Enabled := True
    Else
        ButtonAdd.Enabled := False;
end;

procedure TWorkForm.Clear;
begin
    Edit1.Text := '';
    Edit2.Text := '';
    EditDirCode.Text :='';
    EditCode.Text :='';
    NumberBox1.Text := '1';
end;

procedure TWorkForm.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
    If (TEdit(Sender).Text = '') and (((Key > #223) or (Key < #192)) and (Key <> #08)) Then
        Key := #0;
    If (TEdit(Sender).Text <> '') and(Key < #224) and (Key <> #08)and (Key <> ' ') Then
        Key := #0;
end;

procedure TWorkForm.EdtPrjctKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    If (Shift = [ssShift]) And (Key = VK_INSERT) Then Abort;
end;



function TWorkForm.ShowForEdit(var W: TTask): TModalResult;
begin
    Edit1.Text := W.Name;
    Edit2.Text := W.Task;
    EditCode.Text := W.Implementers;
    EditDirCode.Text := W.Director;
    MonthCalendar1.Date := W.Date;
    NumberBox1.Text := IntToStr(W.Period);

    Result := ShowModal;
    if Result = mrOk then
    begin
        W := Tool.Work(Edit1.Text, Edit2.Text, EditCode.Text, EditDirCode.Text, MonthCalendar1.Date, StrToInt(NumberBox1.Text));
    end
end;

function TWorkForm.ShowForNew(var W: TTask): TModalResult;
begin
    Clear;
    Result := ShowModal;
    if Result = mrOk then
    begin
        W := Tool.Work(Edit1.Text, Edit2.Text, EditCode.Text, EditDirCode.Text, MonthCalendar1.Date, StrToInt(NumberBox1.Text));
    end
end;

end.
