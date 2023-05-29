object WrkForm: TWrkForm
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = #1057#1086#1090#1088#1091#1076#1085#1080#1082
  ClientHeight = 496
  ClientWidth = 442
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object LabelFN: TLabel
    Left = 200
    Top = 108
    Width = 29
    Height = 18
    Caption = #1048#1084#1103
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Montserrat'
    Font.Style = []
    ParentFont = False
  end
  object LabelSN: TLabel
    Left = 183
    Top = 159
    Width = 64
    Height = 18
    Caption = #1060#1072#1084#1080#1083#1080#1103
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Montserrat'
    Font.Style = []
    ParentFont = False
  end
  object LabelMN: TLabel
    Left = 185
    Top = 210
    Width = 62
    Height = 18
    Caption = #1054#1090#1095#1077#1089#1090#1074#1086
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Montserrat'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 167
    Top = 64
    Width = 107
    Height = 18
    Caption = #1050#1086#1076' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Montserrat'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 180
    Top = 261
    Width = 74
    Height = 18
    Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Montserrat'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 125
    Top = 312
    Width = 188
    Height = 18
    Caption = #1063#1080#1089#1083#1086' '#1095#1072#1089#1086#1074' '#1088#1072#1073#1086#1090#1099' '#1074' '#1089#1091#1090#1082#1080
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Montserrat'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 155
    Top = 371
    Width = 123
    Height = 18
    Caption = #1050#1086#1076' '#1088#1091#1082#1086#1074#1086#1076#1080#1090#1077#1083#1103
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Montserrat'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 32
    Top = 17
    Width = 385
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1085#1086#1074#1086#1075#1086' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072' '#1092#1080#1088#1084#1099
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -18
    Font.Name = 'Montserrat SemiBold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ButtonAdd: TButton
    Left = 48
    Top = 429
    Width = 147
    Height = 46
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Enabled = False
    ModalResult = 1
    TabOrder = 0
  end
  object ButtonCncl: TButton
    Left = 240
    Top = 429
    Width = 147
    Height = 46
    Caption = #1054#1090#1084#1077#1085#1080#1090#1100
    ModalResult = 2
    TabOrder = 1
  end
  object EditName: TEdit
    Left = 157
    Top = 132
    Width = 121
    Height = 21
    MaxLength = 10
    PopupMenu = PopupMenu1
    TabOrder = 2
    OnChange = ChangeEdit
    OnKeyDown = EditSKeyDown
    OnKeyPress = EditPress
  end
  object EditS: TEdit
    Left = 157
    Top = 183
    Width = 121
    Height = 21
    MaxLength = 10
    PopupMenu = PopupMenu1
    TabOrder = 3
    OnChange = ChangeEdit
    OnKeyDown = EditSKeyDown
    OnKeyPress = EditPress
  end
  object EditM: TEdit
    Left = 157
    Top = 234
    Width = 121
    Height = 21
    MaxLength = 15
    PopupMenu = PopupMenu1
    TabOrder = 4
    OnChange = ChangeEdit
    OnKeyDown = EditSKeyDown
    OnKeyPress = EditPress
  end
  object EditPst: TEdit
    Left = 157
    Top = 285
    Width = 121
    Height = 21
    MaxLength = 20
    PopupMenu = PopupMenu1
    TabOrder = 5
    OnChange = ChangeEdit
    OnKeyDown = EditSKeyDown
    OnKeyPress = EditPress
  end
  object EditTime: TNumberBox
    Left = 157
    Top = 344
    Width = 121
    Height = 21
    MinValue = 1.000000000000000000
    MaxValue = 12.000000000000000000
    PopupMenu = PopupMenu1
    TabOrder = 6
    Value = 1.000000000000000000
    OnKeyDown = EditSKeyDown
  end
  object EditCode: TEdit
    Left = 157
    Top = 88
    Width = 121
    Height = 21
    MaxLength = 4
    NumbersOnly = True
    PopupMenu = PopupMenu1
    TabOrder = 7
    OnChange = ChangeEdit
    OnKeyDown = EditSKeyDown
  end
  object EditDirCode: TEdit
    Left = 157
    Top = 395
    Width = 121
    Height = 21
    MaxLength = 4
    NumbersOnly = True
    PopupMenu = PopupMenu1
    TabOrder = 8
    OnChange = ChangeEdit
    OnKeyDown = EditSKeyDown
  end
  object PopupMenu1: TPopupMenu
    Left = 416
    Top = 480
  end
end
