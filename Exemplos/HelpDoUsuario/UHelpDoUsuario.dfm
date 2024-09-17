object Form1: TForm1
  Left = 176
  Top = 174
  Width = 696
  Height = 423
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
  object PnlTopicos: TPanel
    Left = 0
    Top = 0
    Width = 249
    Height = 396
    Align = alLeft
    BevelInner = bvLowered
    TabOrder = 0
    object DBGridTopicos: TDBGrid
      Left = 2
      Top = 2
      Width = 245
      Height = 392
      Align = alClient
      Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      PopupMenu = PMenuTopicos
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          Title.Alignment = taCenter
          Title.Caption = 'T'#243'picos'
          Width = 213
          Visible = True
        end>
    end
  end
  object PnlDescTopico: TPanel
    Left = 249
    Top = 0
    Width = 439
    Height = 396
    Align = alClient
    BevelInner = bvLowered
    Caption = 'PnlDescTopico'
    TabOrder = 1
    object MemoDescTopico: TMemo
      Left = 2
      Top = 43
      Width = 435
      Height = 351
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      Lines.Strings = (
        'MemoDescTopico')
      TabOrder = 0
    end
    object Panel3: TPanel
      Left = 2
      Top = 2
      Width = 435
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel3'
      TabOrder = 1
      object PnlTituloTopico: TLabel
        Left = 10
        Top = 0
        Width = 425
        Height = 41
        Align = alClient
        Caption = 'PnlTituloTopico'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 10
        Height = 41
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
      end
    end
  end
  object PMenuTopicos: TPopupMenu
    Left = 176
    Top = 48
    object IMenuIncluir: TMenuItem
      Caption = 'Incluir'
      ShortCut = 16457
    end
    object IMenuAlterar: TMenuItem
      Caption = 'Alterar'
      ShortCut = 16449
    end
    object IMenuExcluir: TMenuItem
      Caption = 'Excluir'
      ShortCut = 16453
    end
  end
end
