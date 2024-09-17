object Form1: TForm1
  Left = 201
  Top = 106
  Width = 696
  Height = 480
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
  object vPanelAux: TPanel
    Left = 2
    Top = 6
    Width = 655
    Height = 347
    Caption = 'vPanelAux'
    TabOrder = 1
  end
  object Button1: TButton
    Left = 86
    Top = 396
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Panel1: TPanel
    Left = 71
    Top = 222
    Width = 226
    Height = 19
    BevelOuter = bvNone
    Caption = 'vPnlLembrete'
    Color = clRed
    TabOrder = 2
    object Label1: TLabel
      Left = 0
      Top = 0
      Width = 226
      Height = 13
      Align = alTop
      Caption = 'vLblLembrete'
    end
    object Bevel1: TBevel
      Left = 0
      Top = 13
      Width = 226
      Height = 2
      Align = alTop
      Shape = bsTopLine
      Style = bsRaised
    end
    object Memo1: TMemo
      Left = 0
      Top = 15
      Width = 226
      Height = 74
      Align = alTop
      BevelOuter = bvNone
      BorderStyle = bsNone
      Lines.Strings = (
        '1234567890123456789012345678901234567'
        '8901234567890'
        '1234567890123456789012345678901234567'
        '8901234567890'
        '1234567890123456789012345678901234567'
        '8901234567890'
        '1234567890123456789012345678901234567'
        '8901234567890'
        '1234567890123456789012345678901234567'
        '8901234567890')
      ParentColor = True
      TabOrder = 0
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 214
    Top = 368
    object asdas1: TMenuItem
      Caption = 'asdas'
    end
  end
end
