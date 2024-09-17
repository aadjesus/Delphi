object Form1: TForm1
  Left = 192
  Top = 114
  Width = 870
  Height = 640
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 56
    Top = 56
    Width = 94
    Height = 13
    Caption = 'vCalculoDePedagio'
  end
  object Label2: TLabel
    Left = 184
    Top = 56
    Width = 104
    Height = 13
    Caption = 'FRACAO_PESO_MIN'
  end
  object Label3: TLabel
    Left = 320
    Top = 56
    Width = 97
    Height = 13
    Caption = 'VL_FRACAO_PESO'
  end
  object Label4: TLabel
    Left = 448
    Top = 56
    Width = 72
    Height = 13
    Caption = 'vResulPedagio'
  end
  object Label5: TLabel
    Left = 576
    Top = 56
    Width = 45
    Height = 13
    Caption = 'vPedagio'
  end
  object vCalculoDePedagio: TNumEdit
    Left = 56
    Top = 72
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Decimals = 2
    TabOrder = 0
  end
  object Button1: TButton
    Left = 64
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object FRACAO_PESO_MIN: TNumEdit
    Left = 184
    Top = 72
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Decimals = 2
    TabOrder = 2
  end
  object VL_FRACAO_PESO: TNumEdit
    Left = 320
    Top = 72
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Decimals = 2
    TabOrder = 3
  end
  object vResulPedagio: TNumEdit
    Left = 448
    Top = 72
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Decimals = 2
    TabOrder = 4
  end
  object vPedagio: TNumEdit
    Left = 576
    Top = 72
    Width = 121
    Height = 21
    Alignment = taRightJustify
    Decimals = 2
    TabOrder = 5
  end
end
