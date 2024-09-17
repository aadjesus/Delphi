object Form1: TForm1
  Left = 227
  Top = 108
  Width = 592
  Height = 190
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 72
    Top = 24
    Width = 74
    Height = 13
    Caption = 'Usando Thread'
  end
  object Label2: TLabel
    Left = 320
    Top = 24
    Width = 179
    Height = 13
    Caption = 'Modo convencional    =/    (vai travar)'
  end
  object Button1: TBitBtn
    Left = 72
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Rodar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TBitBtn
    Left = 152
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Parar'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 72
    Top = 80
    Width = 435
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object BitBtn1: TBitBtn
    Left = 352
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Rodar'
    TabOrder = 3
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 432
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Parar'
    TabOrder = 4
    OnClick = BitBtn2Click
  end
end
