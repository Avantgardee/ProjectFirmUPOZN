object FormFind: TFormFind
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1053#1072#1081#1090#1080' '#1079#1072#1076#1072#1085#1080#1103' '#1087#1088#1086#1077#1082#1090#1072
  ClientHeight = 115
  ClientWidth = 304
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Lbl: TLabel
    Left = 64
    Top = 8
    Width = 164
    Height = 24
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1087#1088#1086#1077#1082#1090#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Montserrat'
    Font.Style = []
    ParentFont = False
  end
  object EditN: TEdit
    Left = 64
    Top = 38
    Width = 169
    Height = 21
    TabOrder = 0
    OnChange = ChangeEdit
    OnKeyDown = EdtPrjctKeyDown
    OnKeyPress = EditNKeyPress
  end
  object Button: TButton
    Left = 88
    Top = 82
    Width = 113
    Height = 25
    Caption = #1053#1072#1081#1090#1080
    Enabled = False
    TabOrder = 1
    OnClick = ButtonClick
  end
end
