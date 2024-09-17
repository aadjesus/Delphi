object Form3: TForm3
  Left = 173
  Top = 299
  Width = 416
  Height = 150
  Caption = 'Aviso do Sistema'
  Color = 13827066
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 154
    Top = 4
    Width = 93
    Height = 24
    Caption = 'A V I S O '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 6
    Top = 56
    Width = 374
    Height = 13
    Caption = 
      'Voc'#234' deve solicitar a Telefonista (2058) a libera'#231#227'o de se acess' +
      'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 7
    Top = 76
    Width = 398
    Height = 13
    Caption = 
      'Isto se deve ao fato de voc'#234' j'#225' estar conectado a Central Telef'#244 +
      'nica.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 8
    Top = 32
    Width = 393
    Height = 2
  end
  object BitBtn1: TBitBtn
    Left = 168
    Top = 95
    Width = 65
    Height = 25
    Caption = 'Ok'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
end
