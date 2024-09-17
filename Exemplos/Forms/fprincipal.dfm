object FormPrincipal: TFormPrincipal
  Left = 202
  Top = 165
  Width = 696
  Height = 480
  Caption = 'Menu Principal'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 104
    Top = 144
    Width = 500
    Height = 44
    Caption = 'Controle Forms Abertos vers'#227'o 1.0'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Palatino Linotype'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object MainMenu1: TMainMenu
    Left = 368
    Top = 24
    object Arquivo1: TMenuItem
      Caption = 'Arquivo'
      object ela11: TMenuItem
        Caption = 'Form 2'
        OnClick = ela11Click
      end
      object ela21: TMenuItem
        Caption = 'Form 3'
        OnClick = ela21Click
      end
      object ela31: TMenuItem
        Caption = 'Form 4'
        OnClick = ela31Click
      end
    end
    object Janelas1: TMenuItem
      AutoCheck = True
      Caption = 'Forms abertos'
    end
    object Sobre1: TMenuItem
      Caption = 'Ajuda'
      object Sobreosistema1: TMenuItem
        Caption = 'Sobre o sistema'
        OnClick = Sobreosistema1Click
      end
    end
  end
end
