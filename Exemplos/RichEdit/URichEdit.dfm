object Form1: TForm1
  Left = 192
  Top = 174
  Width = 670
  Height = 195
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
  object RxRichEdit1: TRxRichEdit
    Left = 24
    Top = 16
    Width = 609
    Height = 105
    Lines.Strings = (
      '12345678901234567890123456789012345678901234567890'
      '12345678901234567890123456789012345678901234567890'
      '12345678901234567890123456789012345678901234567890')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 24
    Top = 128
    Width = 200
    Height = 25
    Caption = 'Marcar texto selecionado'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 232
    Top = 128
    Width = 200
    Height = 25
    Caption = 'Marcar texto inteiro'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 440
    Top = 128
    Width = 200
    Height = 25
    Caption = 'Marcar palavra sob o cursor'
    TabOrder = 3
    OnClick = Button3Click
  end
end
