object FrmCTR_CadastroDeLembretes: TFrmCTR_CadastroDeLembretes
  Left = 211
  Top = 339
  Width = 322
  Height = 220
  BorderIcons = [biSystemMenu]
  Caption = 'Lembrete'
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 314
    Height = 119
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 6
      Top = 80
      Width = 40
      Height = 13
      Caption = 'Aten'#231#227'o'
    end
    object Label2: TLabel
      Left = 107
      Top = 80
      Width = 41
      Height = 13
      Caption = 'Validade'
    end
    object MemoLembrete: TMemo
      Left = 2
      Top = 2
      Width = 310
      Height = 75
      Align = alTop
      MaxLength = 255
      TabOrder = 0
      OnExit = MemoLembreteExit
    end
    object DEdtAtencao: TDateEdit
      Left = 6
      Top = 93
      Width = 99
      Height = 21
      NumGlyphs = 2
      TabOrder = 1
      OnExit = DEdtAtencaoExit
    end
    object DEdtValidade: TDateEdit
      Left = 107
      Top = 93
      Width = 100
      Height = 21
      NumGlyphs = 2
      TabOrder = 2
      OnExit = DEdtAtencaoExit
    end
    object Panel2: TPanel
      Left = 210
      Top = 79
      Width = 98
      Height = 34
      BevelOuter = bvNone
      Caption = 'Panel2'
      TabOrder = 3
      object Label3: TLabel
        Left = 0
        Top = 0
        Width = 98
        Height = 13
        Align = alTop
        Caption = 'Cor'
      end
      object PnlCorAtencao: TPanel
        Left = 49
        Top = 13
        Width = 49
        Height = 21
        Align = alClient
        BevelInner = bvLowered
        Caption = 'Aten'#231#227'o'
        Color = clRed
        PopupMenu = PMenuCores
        TabOrder = 0
      end
      object PnlCorNormal: TPanel
        Left = 0
        Top = 13
        Width = 49
        Height = 21
        Align = alLeft
        BevelInner = bvLowered
        Caption = 'Normal'
        Color = clYellow
        PopupMenu = PMenuCores
        TabOrder = 1
      end
    end
  end
  object PnlBotoes: TPanel
    Left = 0
    Top = 119
    Width = 314
    Height = 55
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 1
    object Confirma1: TConfirma
      Left = 123
      Top = 16
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
  object MainMenu1: TMainMenu
    Left = 6
    Top = 137
    object Sada1: TMenuItem
      Caption = '&Sa'#237'da'
      OnClick = Sada1Click
    end
  end
  object QryPesquisa: TQuery
    DatabaseName = 'DbBGM'
    Left = 34
    Top = 137
  end
  object PMenuCores: TPopupMenu
    Left = 62
    Top = 137
    object IMenuCorDoFundo: TMenuItem
      Caption = 'Cor do fundo'
      ShortCut = 16454
      OnClick = IMenuCorDoFundoClick
    end
    object IMenuCorDoTexto: TMenuItem
      Caption = 'Cor do texto'
      ShortCut = 16468
      OnClick = IMenuCorDoFundoClick
    end
  end
  object ColorDialog1: TColorDialog
    Left = 90
    Top = 137
  end
end
