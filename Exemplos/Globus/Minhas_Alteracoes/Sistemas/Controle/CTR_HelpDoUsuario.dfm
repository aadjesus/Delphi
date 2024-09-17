object FrmCTR_HelpDoUsuario: TFrmCTR_HelpDoUsuario
  Left = 176
  Top = 174
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'FrmCTR_HelpDoUsuario'
  ClientHeight = 392
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnlTopicos: TPanel
    Left = 0
    Top = 0
    Width = 249
    Height = 392
    Align = alLeft
    BevelInner = bvLowered
    TabOrder = 0
    object DBGridTopicos: TDBGrid
      Left = 2
      Top = 2
      Width = 245
      Height = 388
      Align = alClient
      DataSource = DSTopicos
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection]
      PopupMenu = PMenuTopicos
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnTitleClick = DBGridTopicosTitleClick
      Columns = <
        item
          Expanded = False
          FieldName = 'TOPICO'
          Title.Alignment = taCenter
          Title.Caption = 'T'#243'picos'
          Width = 195
          Visible = True
        end>
    end
  end
  object PnlTelaTopicos: TPanel
    Left = 249
    Top = 0
    Width = 439
    Height = 392
    Align = alClient
    BevelOuter = bvNone
    Caption = 'PnlTelaTopicos'
    TabOrder = 1
    object PnlBotoes: TPanel
      Left = 0
      Top = 337
      Width = 439
      Height = 55
      Align = alBottom
      BevelInner = bvLowered
      TabOrder = 0
      Visible = False
      object Confirma1: TConfirma
        Left = 176
        Top = 13
        Width = 85
        Height = 30
        Caption = 'Gravar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = Confirma1Click
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
      end
    end
    object PnlDadosTopico: TPanel
      Left = 0
      Top = 0
      Width = 439
      Height = 337
      Align = alClient
      BevelInner = bvLowered
      Caption = 'PnlDadosTopico'
      TabOrder = 1
      object MemoTopico: TMemo
        Left = 2
        Top = 36
        Width = 435
        Height = 299
        Align = alClient
        ReadOnly = True
        TabOrder = 1
        OnExit = EdtTopicoExit
      end
      object PnlTopico: TPanel
        Left = 2
        Top = 2
        Width = 435
        Height = 34
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        Visible = False
        object Label1: TLabel
          Left = 6
          Top = 11
          Width = 40
          Height = 13
          Caption = 'T'#243'pico'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object CBoxMostra: TCheckBox
          Left = 283
          Top = 8
          Width = 148
          Height = 17
          Caption = 'Mostra para todos usu'#225'rios'
          Checked = True
          State = cbChecked
          TabOrder = 1
        end
        object EdtTopico: TEdit
          Left = 49
          Top = 7
          Width = 228
          Height = 21
          TabOrder = 0
          OnExit = EdtTopicoExit
        end
      end
    end
  end
  object PMenuTopicos: TPopupMenu
    OnPopup = PMenuTopicosPopup
    Left = 344
    Top = 352
    object IMenuIncluir: TMenuItem
      Caption = 'Incluir'
      ShortCut = 16457
      OnClick = IMenuIncluirClick
    end
    object IMenuAlterar: TMenuItem
      Caption = 'Alterar'
      ShortCut = 16449
      OnClick = IMenuIncluirClick
    end
    object IMenuExcluir: TMenuItem
      Caption = 'Excluir'
      ShortCut = 16453
      OnClick = IMenuIncluirClick
    end
  end
  object DSTopicos: TDataSource
    DataSet = MDTopicos
    Left = 260
    Top = 352
  end
  object QryPesquisa: TQuery
    DatabaseName = 'DbBGM'
    Left = 316
    Top = 352
  end
  object MDTopicos: TRxMemoryData
    FieldDefs = <>
    AfterScroll = MDTopicosAfterScroll
    Left = 288
    Top = 352
  end
  object MainMenu1: TMainMenu
    Left = 373
    Top = 352
    object Sada1: TMenuItem
      Caption = 'Sa'#237'da'
      OnClick = Sada1Click
    end
  end
end
