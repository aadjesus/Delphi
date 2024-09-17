object FrmCGSContProgramacaoDeContainer: TFrmCGSContProgramacaoDeContainer
  Left = 366
  Top = 128
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Programa'#231#227'o de container'
  ClientHeight = 584
  ClientWidth = 778
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
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnlFiltro: TPanel
    Left = 0
    Top = 0
    Width = 778
    Height = 205
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object TLabel
      Left = 8
      Top = 11
      Width = 49
      Height = 13
      Alignment = taRightJustify
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label27: TLabel
      Left = 6
      Top = 60
      Width = 51
      Height = 13
      Caption = 'Garagem'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label14: TLabel
      Left = 30
      Top = 35
      Width = 27
      Height = 13
      Alignment = taRightJustify
      Caption = 'Filial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BGMPedeEmpresa: TBgmPedeEmpresa
      Left = 59
      Top = 8
      Width = 297
      Height = 21
      AutoComplete = False
      ItemHeight = 13
      TabOrder = 0
      Text = 'BGMPedeEmpresa'
      OnPedeEmpresaExit = BGMPedeEmpresaPedeEmpresaExit
      DataBase = dm.DbBGM
      CodigoEmpresa = 0
    end
    object BGMPedeFilial: TBGMPedeFilialGaragem
      Left = 59
      Top = 33
      Width = 297
      Height = 21
      AutoComplete = False
      ItemHeight = 13
      TabOrder = 1
      Text = 'BGMPedeFilial'
      OnPedeFilialGaragemExit = BGMPedeFilialPedeFilialGaragemExit
      DataBase = dm.DbBGM
      CodigoEmpresa = 0
      CodigoFG = 0
      NomeFantasia = True
      ApenasNomeFantasia = False
      CidadeUF = True
    end
    object BgmPedeGaragem: TBgmPedeGaragem
      Left = 59
      Top = 59
      Width = 297
      Height = 21
      AutoComplete = False
      ItemHeight = 13
      TabOrder = 2
      Text = 'BgmPedeGaragem'
      OnPedeGaragemExit = BgmPedeGaragemPedeGaragemExit
      DataBase = dm.DbBGM
      CodigoEmpresa = 0
      CodigoFilial = 0
      CodigoGa = 0
      FiltraUsuariosGaragem = False
    end
    object RGroupTpServico: TRadioGroup
      Left = 360
      Top = 3
      Width = 95
      Height = 78
      Caption = ' Tipo de servi'#231'o '
      ItemIndex = 2
      Items.Strings = (
        'Importa'#231#227'o'
        'Exporta'#231#227'o'
        'Ambos')
      TabOrder = 3
      OnClick = RGroupTpServicoClick
    end
    object GBoxDataPedido: TGroupBox
      Left = 458
      Top = 3
      Width = 135
      Height = 78
      Caption = ' Data Programa'#231#227'o '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object Label10: TLabel
        Left = 8
        Top = 24
        Width = 14
        Height = 13
        Alignment = taRightJustify
        Caption = 'De'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 6
        Top = 52
        Width = 16
        Height = 13
        Alignment = taRightJustify
        Caption = 'At'#233
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object DEdtDataPedidoIni: TDateEdit
        Left = 27
        Top = 20
        Width = 103
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 0
        Text = '01/01/2001'
        OnExit = DEdtDataPedidoIniExit
      end
      object DEdtDataPedidoFin: TDateEdit
        Left = 27
        Top = 48
        Width = 103
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 1
        Text = '01/01/2001'
        OnExit = DEdtDataPedidoIniExit
      end
    end
    object GBoxClientes: TGroupBox
      Left = 596
      Top = 3
      Width = 174
      Height = 78
      Caption = ' Cliente solicitante '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      object Label6: TLabel
        Left = 6
        Top = 24
        Width = 27
        Height = 13
        Alignment = taRightJustify
        Caption = 'Inicial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label7: TLabel
        Left = 11
        Top = 52
        Width = 22
        Height = 13
        Alignment = taRightJustify
        Caption = 'Final'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object MEdtClienteIni: TMaskEdit
        Left = 36
        Top = 20
        Width = 130
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 20
        ParentFont = False
        TabOrder = 0
        Text = 'MEdtClienteIni'
        OnExit = DEdtDataPedidoIniExit
      end
      object MEdtClienteFin: TMaskEdit
        Left = 36
        Top = 48
        Width = 130
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 20
        ParentFont = False
        TabOrder = 1
        Text = 'MEdtClienteFin'
        OnExit = DEdtDataPedidoIniExit
      end
    end
    object GBoxBooking: TGroupBox
      Left = 6
      Top = 81
      Width = 212
      Height = 79
      Caption = ' Booking/DI '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      object Label1: TLabel
        Left = 6
        Top = 24
        Width = 27
        Height = 13
        Alignment = taRightJustify
        Caption = 'Inicial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 11
        Top = 52
        Width = 22
        Height = 13
        Alignment = taRightJustify
        Caption = 'Final'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object MEdtBookingIni: TMaskEdit
        Left = 36
        Top = 20
        Width = 168
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 18
        ParentFont = False
        TabOrder = 0
        Text = 'MEdtBookingIni'
        OnExit = DEdtDataPedidoIniExit
      end
      object MEdtBookingFin: TMaskEdit
        Left = 36
        Top = 48
        Width = 168
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 18
        ParentFont = False
        TabOrder = 1
        Text = 'MEdtBookingFin'
        OnExit = DEdtDataPedidoIniExit
      end
    end
    object GBoxContainer: TGroupBox
      Left = 221
      Top = 81
      Width = 211
      Height = 79
      Caption = ' Container '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      object Label3: TLabel
        Left = 6
        Top = 24
        Width = 27
        Height = 13
        Alignment = taRightJustify
        Caption = 'Inicial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 11
        Top = 52
        Width = 22
        Height = 13
        Alignment = taRightJustify
        Caption = 'Final'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object MEdtContainerIni: TMaskEdit
        Left = 36
        Top = 20
        Width = 168
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 18
        ParentFont = False
        TabOrder = 0
        Text = 'MEdtContainerIni'
        OnExit = DEdtDataPedidoIniExit
      end
      object MEdtContainerFin: TMaskEdit
        Left = 36
        Top = 48
        Width = 168
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 18
        ParentFont = False
        TabOrder = 1
        Text = 'MEdtContainerFin'
        OnExit = DEdtDataPedidoIniExit
      end
    end
    object GBoxVeiculos: TGroupBox
      Left = 435
      Top = 81
      Width = 110
      Height = 79
      Caption = ' Ve'#237'culo '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      object Label5: TLabel
        Left = 6
        Top = 24
        Width = 27
        Height = 13
        Alignment = taRightJustify
        Caption = 'Inicial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label8: TLabel
        Left = 11
        Top = 52
        Width = 22
        Height = 13
        Alignment = taRightJustify
        Caption = 'Final'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object MEdtVeiculoIni: TMaskEdit
        Left = 36
        Top = 20
        Width = 67
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 7
        ParentFont = False
        TabOrder = 0
        Text = 'MEdtVeiculoIni'
        OnExit = DEdtDataPedidoIniExit
      end
      object MEdtVeiculoFin: TMaskEdit
        Left = 36
        Top = 48
        Width = 67
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 7
        ParentFont = False
        TabOrder = 1
        Text = 'MEdtVeiculoFin'
        OnExit = DEdtDataPedidoIniExit
      end
    end
    object GBoxTpCont: TGroupBox
      Left = 548
      Top = 81
      Width = 110
      Height = 79
      Caption = ' Tp container '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      object Label9: TLabel
        Left = 6
        Top = 24
        Width = 27
        Height = 13
        Alignment = taRightJustify
        Caption = 'Inicial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 11
        Top = 52
        Width = 22
        Height = 13
        Alignment = taRightJustify
        Caption = 'Final'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object MEdtTpContainerIni: TMaskEdit
        Left = 36
        Top = 20
        Width = 65
        Height = 21
        EditMask = '!999999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 6
        ParentFont = False
        TabOrder = 0
        Text = '      '
        OnExit = DEdtDataPedidoIniExit
      end
      object MEdtTpContainerFin: TMaskEdit
        Left = 36
        Top = 48
        Width = 65
        Height = 21
        EditMask = '!999999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 6
        ParentFont = False
        TabOrder = 1
        Text = '      '
        OnExit = DEdtDataPedidoIniExit
      end
    end
    object GBoxTerminal: TGroupBox
      Left = 661
      Top = 81
      Width = 110
      Height = 79
      Caption = ' Terminal '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      object Label13: TLabel
        Left = 6
        Top = 24
        Width = 27
        Height = 13
        Alignment = taRightJustify
        Caption = 'Inicial'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = 11
        Top = 52
        Width = 22
        Height = 13
        Alignment = taRightJustify
        Caption = 'Final'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object MEdtTerminalIni: TMaskEdit
        Left = 36
        Top = 20
        Width = 65
        Height = 21
        EditMask = '!999999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 6
        ParentFont = False
        TabOrder = 0
        Text = '      '
        OnExit = DEdtDataPedidoIniExit
      end
      object MEdtTerminalFin: TMaskEdit
        Left = 36
        Top = 48
        Width = 65
        Height = 21
        EditMask = '!999999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 6
        ParentFont = False
        TabOrder = 1
        Text = '      '
        OnExit = DEdtDataPedidoIniExit
      end
    end
    object PnlBotaoConsSet: TPanel
      Left = 2
      Top = 163
      Width = 774
      Height = 40
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 11
      object PnlSetas: TPanel
        Left = 743
        Top = 6
        Width = 27
        Height = 27
        BevelOuter = bvNone
        TabOrder = 3
        object ImageSetaU: TImage
          Left = 18
          Top = 22
          Width = 32
          Height = 16
          AutoSize = True
          Picture.Data = {
            07544269746D617076010000424D760100000000000076000000280000002000
            0000100000000100040000000000000100000000000000000000100000001000
            0000000000000000800000800000008080008000000080008000808000007F7F
            7F00BFBFBF000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
            FF003333330003333333333333777F33333333333309033333333333337F7F33
            333333333309033333333333337F7F33333333333309033333333333337F7F33
            333333333309033333333333337F7F33333333333309033333333333FF7F7FFF
            F3333330000900003333333777737777F333333099999990333333373F333337
            3333333309999903333333337F33337F33333333099999033333333373F33373
            33333333309990333333333337F337F3333333333099903333333333373F3733
            333333333309033333333333337F7F3333333333330903333333333333737333
            3333333333303333333333333337F33333333333333033333333333333373333
            3333}
          Visible = False
        end
        object ImageSetaD: TImage
          Left = -2
          Top = 21
          Width = 32
          Height = 27
          ParentShowHint = False
          Picture.Data = {
            07544269746D617076010000424D760100000000000076000000280000002000
            0000100000000100040000000000000100000000000000000000100000001000
            0000000000000000800000800000008080008000000080008000808000007F7F
            7F00BFBFBF000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
            FF00333333303333333333333337F33333333333333033333333333333373F33
            333333333309033333333333337F7F33333333333309033333333333337373F3
            33333333309990333333333337F337F33333333330999033333333333733373F
            3333333309999903333333337F33337F33333333099999033333333373333373
            F33333309999999033333337FFFF3FF7F33333300009000033333337777F7777
            333333333309033333333333337F7F33333333333309033333333333337F7F33
            333333333309033333333333337F7F33333333333309033333333333337F7F33
            333333333309033333333333337F7F3333333333330003333333333333777333
            3333}
          ShowHint = False
          Stretch = True
          Visible = False
        end
        object SButSetas: TSpeedButton
          Left = 0
          Top = 0
          Width = 27
          Height = 27
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            0400000000000001000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
            3333333333777F33333333333309033333333333337F7F333333333333090333
            33333333337F7F33333333333309033333333333337F7F333333333333090333
            33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
            3333333777737777F333333099999990333333373F3333373333333309999903
            333333337F33337F33333333099999033333333373F333733333333330999033
            3333333337F337F3333333333099903333333333373F37333333333333090333
            33333333337F7F33333333333309033333333333337373333333333333303333
            333333333337F333333333333330333333333333333733333333}
          Layout = blGlyphTop
          Margin = 3
          NumGlyphs = 2
          OnClick = SButSetasClick
        end
      end
      object Consultar: TConfirma
        Left = 638
        Top = 6
        Width = 104
        Height = 27
        Caption = '&Consultar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        OnClick = ConsultarClick
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000010000000000000000000
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
      object CBoxDesmembrado: TCheckBox
        Left = 460
        Top = 5
        Width = 172
        Height = 16
        Caption = 'Somente os desmembrado'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 1
      end
      object RadioGStatus: TRadioGroup
        Left = 6
        Top = 2
        Width = 449
        Height = 33
        Caption = ' Status '
        Color = clBtnFace
        Columns = 5
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 4
        Items.Strings = (
          'Pendente'
          'Escalado'
          'Programado'
          'Realizado'
          'Todos')
        ParentColor = False
        ParentFont = False
        TabOrder = 0
      end
      object CBoxMostraCancelados: TCheckBox
        Left = 460
        Top = 21
        Width = 172
        Height = 16
        Caption = 'Mostra os servi'#231'os cancelados'
        TabOrder = 4
      end
    end
  end
  object PnlTela: TPanel
    Left = 0
    Top = 205
    Width = 778
    Height = 305
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 778
      Height = 305
      ActivePage = TabSProgramacao
      Align = alClient
      TabOrder = 0
      object TabSProgramacao: TTabSheet
        Caption = 'TabSProgramacao'
        object PnlProg: TPanel
          Left = 0
          Top = 0
          Width = 770
          Height = 277
          Align = alClient
          BevelOuter = bvNone
          Caption = 'PnlProg'
          TabOrder = 0
          object DBGridProg: TDBGrid
            Left = 0
            Top = 0
            Width = 770
            Height = 176
            Align = alClient
            DataSource = DSProg
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection]
            PopupMenu = PMenuGeral
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnDrawColumnCell = DBGridProgDrawColumnCell
            OnKeyUp = DBGridProgKeyUp
            OnTitleClick = DBGridProgTitleClick
            Columns = <
              item
                Expanded = False
                FieldName = 'MARCA'
                Title.Caption = ' '
                Width = 17
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DESCTPSERV'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                Title.Caption = 'Servi'#231'o'
                Width = 53
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'TIPO_PEDIDO'
                Title.Caption = 'Tp'
                Width = 20
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SOLICITANTE'
                Title.Caption = 'Cliente solicitante'
                Width = 161
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'NUMBOOKING'
                Title.Caption = 'Booking/DI'
                Width = 127
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'NUMCONTAINER'
                Title.Caption = 'N'#186' Container'
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DATAHORA_ABERTURA'
                Title.Caption = 'Data/hora abertura'
                Width = 101
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DATAHORA_DEADLINE'
                Title.Caption = 'Data limite'
                Width = 105
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'TOTAL_PREST'
                Title.Caption = 'Valor container'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'NOME_MOTORISTA'
                Title.Caption = 'Motorista'
                Width = 141
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PREFIXO_VEICULO'
                Title.Caption = 'Ve'#237'culo'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PREFIXO_CARRETA'
                Title.Caption = 'Carreta 1'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PREFIXO_CARRETA_2'
                Title.Caption = 'Carreta 2'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DESCTIPO_CONTAINER'
                Title.Caption = 'Tipo de container'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DESCTERMINAL'
                Title.Caption = 'Terminal'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'TIPO_VEICULO'
                Title.Caption = 'Tp Ve'#237'c.'
                Visible = True
              end>
          end
          object DBGridProgUltDoc: TDBGrid
            Left = 0
            Top = 176
            Width = 770
            Height = 101
            Align = alBottom
            Color = clBtnFace
            DataSource = DSProgUltDoc
            Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection]
            PopupMenu = PMenuGeral
            TabOrder = 1
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'DESCTPSERV'
                Title.Caption = 'Servi'#231'o'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'SERIE_DOCTO'
                Title.Caption = 'S'#233'rie'
                Width = 73
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'NUMERO_DOCTO'
                Title.Caption = 'N'#186' Docto'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DATA_DOCTO'
                Title.Caption = 'Emiss'#227'o'
                Width = 94
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'DATA_BAIXA'
                Title.Caption = 'Baixa'
                Width = 81
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'NOME_MOTORISTA'
                Title.Caption = 'Motorista'
                Width = 127
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PREFIXO_VEICULO'
                Title.Caption = 'Ve'#237'culo'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PREFIXO_CARRETA'
                Title.Caption = 'Carreta 1'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'PREFIXO_CARRETA_2'
                Title.Caption = 'Carreta 2'
                Visible = True
              end>
          end
        end
      end
      object TabSVarios: TTabSheet
        Caption = 'TabSVarios'
        ImageIndex = 1
        object PnlEscala: TPanel
          Left = 0
          Top = 0
          Width = 770
          Height = 97
          Align = alTop
          BevelInner = bvLowered
          TabOrder = 0
          object LblMotorista: TLabel
            Left = 6
            Top = 16
            Width = 43
            Height = 13
            Caption = 'Motorista'
          end
          object lblVeiculo: TLabel
            Left = 476
            Top = 15
            Width = 37
            Height = 13
            Caption = 'Ve'#237'culo'
          end
          object Label28: TLabel
            Left = 572
            Top = 15
            Width = 34
            Height = 13
            Caption = 'Carreta'
          end
          object Label29: TLabel
            Left = 669
            Top = 15
            Width = 43
            Height = 13
            Caption = 'Carreta 2'
          end
          object spbMotorista: TSpeedButton
            Tag = 14
            Left = 77
            Top = 30
            Width = 23
            Height = 21
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            Glyph.Data = {
              42010000424D4201000000000000760000002800000011000000110000000100
              040000000000CC00000000000000000000001000000010000000000000000000
              BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
              DDDDD0000000DDDDD000DDDDD000D0000000DDDDD070DDDDD070D0000000DDDD
              D0008DDD8000D0000000DDDDD00000000000D0000000D444407000070000D000
              0000D4FFF07000070000D0000000D4F8800000000000D0000000D4FFFF000070
              000DD0000000D4F88F80088F00DDD0000000D4FFFFF00FFF00DDD0000000D4F8
              8F80088F00DDD0000000D4FFFFFFFFFF4DDDD0000000D444444444444DDDD000
              0000D474474474474DDDD0000000D444444444444DDDD0000000DDDDDDDDDDDD
              DDDDD0000000}
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            OnClick = spbMotoristaClick
          end
          object spbVeiculo: TSpeedButton
            Tag = 15
            Left = 548
            Top = 30
            Width = 23
            Height = 21
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            Glyph.Data = {
              42010000424D4201000000000000760000002800000011000000110000000100
              040000000000CC00000000000000000000001000000010000000000000000000
              BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
              DDDDD0000000DDDDD000DDDDD000D0000000DDDDD070DDDDD070D0000000DDDD
              D0008DDD8000D0000000DDDDD00000000000D0000000D444407000070000D000
              0000D4FFF07000070000D0000000D4F8800000000000D0000000D4FFFF000070
              000DD0000000D4F88F80088F00DDD0000000D4FFFFF00FFF00DDD0000000D4F8
              8F80088F00DDD0000000D4FFFFFFFFFF4DDDD0000000D444444444444DDDD000
              0000D474474474474DDDD0000000D444444444444DDDD0000000DDDDDDDDDDDD
              DDDDD0000000}
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            OnClick = spbMotoristaClick
          end
          object spbCarreta1: TSpeedButton
            Tag = 17
            Left = 645
            Top = 30
            Width = 23
            Height = 21
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            Glyph.Data = {
              42010000424D4201000000000000760000002800000011000000110000000100
              040000000000CC00000000000000000000001000000010000000000000000000
              BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
              DDDDD0000000DDDDD000DDDDD000D0000000DDDDD070DDDDD070D0000000DDDD
              D0008DDD8000D0000000DDDDD00000000000D0000000D444407000070000D000
              0000D4FFF07000070000D0000000D4F8800000000000D0000000D4FFFF000070
              000DD0000000D4F88F80088F00DDD0000000D4FFFFF00FFF00DDD0000000D4F8
              8F80088F00DDD0000000D4FFFFFFFFFF4DDDD0000000D444444444444DDDD000
              0000D474474474474DDDD0000000D444444444444DDDD0000000DDDDDDDDDDDD
              DDDDD0000000}
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            OnClick = spbMotoristaClick
          end
          object spbCarreta2: TSpeedButton
            Tag = 20
            Left = 740
            Top = 30
            Width = 23
            Height = 21
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            Glyph.Data = {
              42010000424D4201000000000000760000002800000011000000110000000100
              040000000000CC00000000000000000000001000000010000000000000000000
              BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
              DDDDD0000000DDDDD000DDDDD000D0000000DDDDD070DDDDD070D0000000DDDD
              D0008DDD8000D0000000DDDDD00000000000D0000000D444407000070000D000
              0000D4FFF07000070000D0000000D4F8800000000000D0000000D4FFFF000070
              000DD0000000D4F88F80088F00DDD0000000D4FFFFF00FFF00DDD0000000D4F8
              8F80088F00DDD0000000D4FFFFFFFFFF4DDDD0000000D444444444444DDDD000
              0000D474474474474DDDD0000000D444444444444DDDD0000000DDDDDDDDDDDD
              DDDDD0000000}
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            OnClick = spbMotoristaClick
          end
          object spbTipoVeiculo: TSpeedButton
            Tag = 16
            Left = 77
            Top = 68
            Width = 23
            Height = 21
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            Glyph.Data = {
              42010000424D4201000000000000760000002800000011000000110000000100
              040000000000CC00000000000000000000001000000010000000000000000000
              BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
              DDDDD0000000DDDDD000DDDDD000D0000000DDDDD070DDDDD070D0000000DDDD
              D0008DDD8000D0000000DDDDD00000000000D0000000D444407000070000D000
              0000D4FFF07000070000D0000000D4F8800000000000D0000000D4FFFF000070
              000DD0000000D4F88F80088F00DDD0000000D4FFFFF00FFF00DDD0000000D4F8
              8F80088F00DDD0000000D4FFFFFFFFFF4DDDD0000000D444444444444DDDD000
              0000D474474474474DDDD0000000D444444444444DDDD0000000DDDDDDDDDDDD
              DDDDD0000000}
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            OnClick = spbMotoristaClick
          end
          object Label16: TLabel
            Left = 6
            Top = 55
            Width = 73
            Height = 13
            Caption = 'Tipo ve'#237'culo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label17: TLabel
            Left = 2
            Top = 2
            Width = 766
            Height = 13
            Align = alTop
            Caption = ' ( F8 - para sair )'
          end
          object edtCodMotorista: TDBEdit
            Tag = 14
            Left = 6
            Top = 30
            Width = 70
            Height = 21
            DataField = 'CODIGO_MOTORISTA'
            DataSource = dsCabecalho
            MaxLength = 6
            TabOrder = 0
            OnChange = edtCodMotoristaChange
            OnEnter = edtCodMotoristaChange
            OnExit = edtCodMotoristaExit
            OnKeyDown = edtCodMotoristaKeyDown
          end
          object edtDesMotorista: TDBEdit
            Tag = -1
            Left = 101
            Top = 30
            Width = 372
            Height = 21
            Color = clBtnFace
            DataField = 'NOME_MOTORISTA'
            DataSource = dsCabecalho
            Enabled = False
            TabOrder = 1
          end
          object edtVeiculo: TDBEdit
            Tag = 15
            Left = 476
            Top = 30
            Width = 70
            Height = 21
            CharCase = ecUpperCase
            DataField = 'PREFIXO_VEICULO'
            DataSource = dsCabecalho
            MaxLength = 7
            TabOrder = 2
            OnChange = edtVeiculoChange
            OnEnter = edtVeiculoChange
            OnExit = edtVeiculoExit
            OnKeyDown = edtCodMotoristaKeyDown
          end
          object edtCarreta1: TDBEdit
            Tag = 17
            Left = 572
            Top = 30
            Width = 70
            Height = 21
            CharCase = ecUpperCase
            DataField = 'PREFIXO_CARRETA'
            DataSource = dsCabecalho
            MaxLength = 7
            TabOrder = 3
            OnChange = edtCarreta1Change
            OnEnter = edtCarreta1Change
            OnExit = edtCarreta1Exit
            OnKeyDown = edtCodMotoristaKeyDown
          end
          object edtCarreta2: TDBEdit
            Tag = 20
            Left = 669
            Top = 30
            Width = 70
            Height = 21
            CharCase = ecUpperCase
            DataField = 'PREFIXO_CARRETA_2'
            DataSource = dsCabecalho
            MaxLength = 7
            TabOrder = 4
            OnChange = edtCarreta2Change
            OnEnter = edtCarreta2Change
            OnExit = edtCarreta2Exit
            OnKeyDown = edtCodMotoristaKeyDown
          end
          object edtCodTipodeVeiculo: TDBEdit
            Tag = 16
            Left = 6
            Top = 68
            Width = 70
            Height = 21
            DataField = 'TIPO_VEICULO'
            DataSource = dsCabecalho
            MaxLength = 6
            TabOrder = 5
            OnEnter = edtCodTipodeVeiculoEnter
            OnExit = edtCodTipodeVeiculoExit
            OnKeyDown = edtCodMotoristaKeyDown
          end
          object edtDesTipoDeVeiculo: TDBEdit
            Tag = -1
            Left = 101
            Top = 68
            Width = 173
            Height = 21
            Color = clBtnFace
            DataField = 'DESCRICAO_TIPO_VEICULO'
            DataSource = dsCabecalho
            Enabled = False
            TabOrder = 6
          end
          object BtnMaisEsc: TBitBtn
            Left = 741
            Top = 68
            Width = 21
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 9
            OnClick = BtnMaisEscClick
            Glyph.Data = {
              DE000000424DDE0000000000000076000000280000000D0000000D0000000100
              0400000000006800000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
              800088888888888880008888800088888000888880C088888000888880C08888
              8000880000C000088000880CCCCCCC088000880000C000088000888880C08888
              8000888880C08888800088888000888880008888888888888000888888888888
              8000}
          end
          object GBoxParamServ: TGroupBox
            Left = 476
            Top = 51
            Width = 261
            Height = 41
            Caption = ' Par'#226'metros do servi'#231'o '
            TabOrder = 8
            object CBoxDBBaixaAuto: TDBCheckBox
              Left = 12
              Top = 17
              Width = 103
              Height = 17
              Caption = 'Baixa autom'#225'tica'
              DataField = 'BAIXAAUTO'
              DataSource = DSProg
              Enabled = False
              TabOrder = 0
              ValueChecked = 'S'
              ValueUnchecked = 'N'
              OnExit = CBoxDBBaixaAutoExit
              OnKeyDown = edtCodMotoristaKeyDown
            end
            object CBoxDBImpServ: TDBCheckBox
              Left = 154
              Top = 16
              Width = 85
              Height = 17
              Caption = 'Imprime'
              DataField = 'BAIXAAUTO'
              DataSource = DSProg
              Enabled = False
              TabOrder = 1
              ValueChecked = 'S'
              ValueUnchecked = 'N'
              OnExit = CBoxDBBaixaAutoExit
              OnKeyDown = edtCodMotoristaKeyDown
            end
          end
          object GBoxSaiGar_CheEnt: TGroupBox
            Left = 278
            Top = 51
            Width = 195
            Height = 41
            Caption = ' Sa'#237'da '
            TabOrder = 7
            object Label36: TLabel
              Left = 6
              Top = 20
              Width = 23
              Height = 13
              Caption = 'Data'
            end
            object Label37: TLabel
              Left = 125
              Top = 20
              Width = 23
              Height = 13
              Caption = 'Hora'
            end
            object DEdtSaiGar_CheEnt: TDBDateEdit
              Left = 32
              Top = 14
              Width = 90
              Height = 21
              DataField = 'DH_SAIGAR_CHEENT'
              DataSource = DSProg
              CheckOnExit = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'MS Sans Serif'
              Font.Style = []
              NumGlyphs = 2
              ParentFont = False
              TabOrder = 0
              OnEnter = DEdtSaiGar_CheEntEnter
              OnExit = DEdtSaiGar_CheEntExit
              OnKeyDown = edtCodMotoristaKeyDown
            end
            object TEdtSaiGar_CheEnt: TTimeEdit
              Left = 152
              Top = 14
              Width = 35
              Height = 21
              Alignment = taLeftJustify
              BaseChar = '_'
              TimeText = '00:00'
              ShowSeconds = False
              NaoDigitaZero = False
              TabOrder = 1
              OnEnter = DEdtSaiGar_CheEntEnter
              OnExit = DEdtSaiGar_CheEntExit
              OnKeyDown = edtCodMotoristaKeyDown
            end
          end
        end
        object PnlLocalid: TPanel
          Left = 0
          Top = 97
          Width = 770
          Height = 58
          Align = alTop
          BevelInner = bvLowered
          TabOrder = 1
          object Carga: TLabel
            Left = 6
            Top = 16
            Width = 103
            Height = 13
            Caption = 'Terminal de carga'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object SButLocOrige: TSpeedButton
            Tag = 10
            Left = 80
            Top = 29
            Width = 23
            Height = 21
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            Glyph.Data = {
              42010000424D4201000000000000760000002800000011000000110000000100
              040000000000CC00000000000000000000001000000010000000000000000000
              BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
              DDDDD0000000DDDDD000DDDDD000D0000000DDDDD070DDDDD070D0000000DDDD
              D0008DDD8000D0000000DDDDD00000000000D0000000D444407000070000D000
              0000D4FFF07000070000D0000000D4F8800000000000D0000000D4FFFF000070
              000DD0000000D4F88F80088F00DDD0000000D4FFFFF00FFF00DDD0000000D4F8
              8F80088F00DDD0000000D4FFFFFFFFFF4DDDD0000000D444444444444DDDD000
              0000D474474474474DDDD0000000D444444444444DDDD0000000DDDDDDDDDDDD
              DDDDD0000000}
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            OnClick = spbMotoristaClick
          end
          object Descarga: TLabel
            Left = 374
            Top = 16
            Width = 106
            Height = 13
            Caption = 'Local de descarga'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object SButLocDeste: TSpeedButton
            Tag = 11
            Left = 448
            Top = 29
            Width = 23
            Height = 21
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            Glyph.Data = {
              42010000424D4201000000000000760000002800000011000000110000000100
              040000000000CC00000000000000000000001000000010000000000000000000
              BF0000BF000000BFBF00BF000000BF00BF00BFBF0000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DDDDDDDDDDDD
              DDDDD0000000DDDDD000DDDDD000D0000000DDDDD070DDDDD070D0000000DDDD
              D0008DDD8000D0000000DDDDD00000000000D0000000D444407000070000D000
              0000D4FFF07000070000D0000000D4F8800000000000D0000000D4FFFF000070
              000DD0000000D4F88F80088F00DDD0000000D4FFFFF00FFF00DDD0000000D4F8
              8F80088F00DDD0000000D4FFFFFFFFFF4DDDD0000000D444444444444DDDD000
              0000D474474474474DDDD0000000D444444444444DDDD0000000DDDDDDDDDDDD
              DDDDD0000000}
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            OnClick = spbMotoristaClick
          end
          object Label18: TLabel
            Left = 2
            Top = 2
            Width = 76
            Height = 13
            Align = alTop
            Caption = ' ( F8 - para sair )'
          end
          object MEdtLocOrige: TMaskEdit
            Left = 6
            Top = 29
            Width = 72
            Height = 21
            MaxLength = 8
            TabOrder = 0
            Text = 'MEdtLocOrige'
            OnChange = MEdtLocOrigeChange
            OnEnter = MEdtLocOrigeEnter
            OnExit = MEdtLocOrigeExit
            OnKeyDown = edtCodMotoristaKeyDown
          end
          object EdtDescrLocOrige: TDBEdit
            Left = 104
            Top = 29
            Width = 230
            Height = 21
            Color = clBtnFace
            DataField = 'DESC_LOCALIDADE_COLETA'
            Enabled = False
            TabOrder = 1
          end
          object EdtUFLocOrige: TDBEdit
            Left = 336
            Top = 29
            Width = 35
            Height = 21
            Color = clBtnFace
            DataField = 'COD_UF_COLETA'
            Enabled = False
            TabOrder = 2
          end
          object MEdtLocDeste: TMaskEdit
            Left = 374
            Top = 29
            Width = 72
            Height = 21
            MaxLength = 8
            TabOrder = 3
            Text = 'MEdtLocDeste'
            OnChange = MEdtLocOrigeChange
            OnEnter = MEdtLocOrigeEnter
            OnExit = MEdtLocOrigeExit
            OnKeyDown = edtCodMotoristaKeyDown
          end
          object EdtDescrLocDeste: TDBEdit
            Left = 472
            Top = 29
            Width = 230
            Height = 21
            Color = clBtnFace
            DataField = 'DESC_LOCALIDADE_ENTREGA'
            Enabled = False
            TabOrder = 4
          end
          object EdtUFLocDeste: TDBEdit
            Left = 705
            Top = 29
            Width = 35
            Height = 21
            Color = clBtnFace
            DataField = 'COD_UF_ENTREGA'
            Enabled = False
            TabOrder = 5
          end
          object BtnMaisLoc: TBitBtn
            Left = 741
            Top = 29
            Width = 21
            Height = 21
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            ParentShowHint = False
            ShowHint = True
            TabOrder = 6
            OnClick = BtnMaisEscClick
            Glyph.Data = {
              DE000000424DDE0000000000000076000000280000000D0000000D0000000100
              0400000000006800000000000000000000001000000010000000000000000000
              8000008000000080800080000000800080008080000080808000C0C0C0000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
              800088888888888880008888800088888000888880C088888000888880C08888
              8000880000C000088000880CCCCCCC088000880000C000088000888880C08888
              8000888880C08888800088888000888880008888888888888000888888888888
              8000}
          end
        end
      end
    end
  end
  object PnlBotoes: TPanel
    Left = 0
    Top = 529
    Width = 778
    Height = 55
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 2
    object Gravar1: TConfirma
      Left = 17
      Top = 11
      Width = 80
      Height = 30
      Caption = '&Gravar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = Gravar1Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000010000000000000000000
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
    object Limpar1: TLimpar
      Left = 96
      Top = 11
      Width = 80
      Height = 30
      Caption = '&Limpar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = Limpar1Click
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
        5555000000005550555500550005505555550055500555555555500550050055
        5555550050501105555555550509991055555005550999910555500505509990
        305555005055090B03055555555550B0B03055550555550B0B33555555555550
        BBB35550555555550BBB55555555555550BB555555555555550B}
    end
  end
  object SBarInfo: TStatusBar
    Left = 0
    Top = 510
    Width = 778
    Height = 19
    Panels = <
      item
        Width = 350
      end
      item
        Text = 'Pendente: 9999'
        Width = 85
      end
      item
        Text = 'Escalada: 9999'
        Width = 85
      end
      item
        Text = 'Programado: 9999 '
        Width = 100
      end
      item
        Text = 'Realizado: 9999'
        Width = 90
      end
      item
        Text = 'Total: 9999'
        Width = 100
      end>
  end
  object MainMenu1: TMainMenu
    Left = 177
    Top = 541
    object Sada1: TMenuItem
      Caption = '&Sa'#237'da'
      OnClick = Sada1Click
    end
    object ContTrocadeFormulrios: TMenuItem
      Caption = '&Troca de formul'#225'rios'
      OnClick = ContTrocadeFormulriosClick
    end
    object Pedidodecliente1: TMenuItem
      Caption = '&Pedido de cliente'
      OnClick = ContTrocadeFormulriosClick
    end
  end
  object QryPesquisa: TQuery
    DatabaseName = 'DbBGM'
    Left = 205
    Top = 541
  end
  object DSProg: TDataSource
    DataSet = MDProg
    Left = 233
    Top = 541
  end
  object MDProg: TRxMemoryData
    FieldDefs = <>
    AfterOpen = MDProgAfterOpen
    AfterPost = MDProgAfterScroll
    AfterScroll = MDProgAfterScroll
    Left = 261
    Top = 541
  end
  object FormatParam: TFormatParam
    Query = QryPesquisa
    Parametros = <
      item
        NomeCampo = 'B.SOL_CGC'
        CampoFin = MEdtClienteFin
        CampoIni = MEdtClienteIni
      end
      item
        NomeCampo = 'B.NUMBOOKING'
        CampoFin = MEdtBookingFin
        CampoIni = MEdtBookingIni
      end
      item
        NomeCampo = 'A.NUMCONTAINER'
        CampoFin = MEdtContainerFin
        CampoIni = MEdtContainerIni
      end
      item
        NomeCampo = 'E.PREFIXOVEIC'
        CampoFin = MEdtVeiculoFin
        CampoIni = MEdtVeiculoIni
      end
      item
        NomeCampo = 'A.TIPO_CONTAINER'
        CampoFin = MEdtTpContainerFin
        CampoIni = MEdtTpContainerIni
      end
      item
        NomeCampo = 'A.TERMINAL'
        CampoFin = MEdtTerminalFin
        CampoIni = MEdtTerminalIni
      end>
    RefGetSql = 'PesqFrmCGSContProgramacaoDeContainer'
    MsgQdoEmpty = 'N'#227'o foram encontrados dados com os filtros selecionados.'
    MsgBarraStatus = 'Consultando ...'
    Left = 317
    Top = 541
  end
  object ImageList1: TImageList
    Left = 346
    Top = 541
    Bitmap = {
      494C010106000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000FF000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      000000000000000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00000000000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000000000000000FFFFFF00000000000000
      0000FFFFFF00000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00000000000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000FFFFFF00000000000000FF000000FF000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000FF000000
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000FF000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000000000BFBF
      BF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000000000BFBF
      BF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      0000840000008400000000000000000000000000000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      0000840000008400000000000000000000000000000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      0000840000008400000000000000000000000000000084000000840000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000840000000000000000000000000000008400000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000000000000000000000008400000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000000000000000000000008400000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000000000000000000000008400000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000000000000000000000008400000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      0000000000000000000000FF000000FF00000000000000000000000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      000000000000000000000000FF000000FF000000000000000000000000000000
      FF000000FF0000FFFF000000000000000000000000008400000000FFFF000000
      0000000000000000000000FF000000FF00000000000000000000000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      0000000000000000000000FF000000FF000000FF000000000000000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      00000000000000000000000000000000FF000000FF00000000000000FF000000
      FF008400000000FFFF000000000000000000000000008400000000FFFF000000
      0000000000000000000000FF000000FF000000FF000000000000000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      00000000000000FF000000FF00000000000000FF000000000000000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      00000000000000FF000000FF00000000000000FF000000000000000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      00000000000000FF0000000000000000000000FF000000FF0000000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      0000000000000000000000000000000000000000FF000000FF00000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      00000000000000FF000000FF00000000000000FF000000FF0000000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      000000FF000000FF000000000000000000000000000000FF000000FF00000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      00000000000000000000000000000000FF000000FF000000FF000000FF000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      000000FF000000FF000000000000000000000000000000FF000000FF00000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF0000FF
      000000FF0000000000000000000000000000000000000000000000FF00000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      000000000000000000000000FF000000FF00000000000000FF000000FF000000
      00008400000000FFFF000000000000000000000000008400000000FFFF0000FF
      000000FF00000000000000000000000000000000000000FF000000FF00000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      0000000000000000FF000000FF000000000000000000000000000000FF000000
      FF008400000000FFFF000000000000000000000000008400000000FFFF000000
      000000000000000000000000000000000000000000000000000000FF000000FF
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      00000000000000000000000000000000000000000000000000000000000000FF
      000000FF000000FFFF000000000000000000000000008400000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF0000FFFF000000000000000000000000008400000000FFFF000000
      00000000000000000000000000000000000000000000000000000000000000FF
      000000FF000000FF00000000000000000000000000008400000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF00000000000000000000000000008400000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000FF000000FF000000000000000000000000008400000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FF000000FF00000000000000000000000000008400000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008400000000FFFF000000000000000000000000008400000000FFFF008400
      0000840000008400000084000000840000008400000084000000840000008400
      00008400000000FFFF000000000000000000000000008400000000FFFF008400
      0000840000008400000084000000840000008400000084000000840000008400
      00008400000000FFFF000000000000000000000000008400000000FFFF008400
      0000840000008400000084000000840000008400000084000000840000008400
      00008400000000FFFF000000000000000000000000008400000000FFFF008400
      0000840000008400000084000000840000008400000084000000840000008400
      00008400000000FFFF000000000000000000000000008400000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000000000000000000000008400000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000000000000000000000008400000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000000000000000000000008400000000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFDFFFDF00000000FF9FFFCF00000000
      FF1FFFC700000000000000030000000000000001000000000000000000000000
      00000001000000000000000300000000001F000700000000001F000F00000000
      001F001F00000000007F007F0000000000FF00FF0000000001FF01FF00000000
      03FF03FF00000000FFFFFFFF00000000FFFFFFFFFFFFFFFF8003800380038003
      80038003800380039FF39CF39CE39CF39FF39C739E439C739FF399739E139973
      9FF39B339F3399339FF393939E1393939FF387D39C9387939FF39FC399C39FC3
      9FF39FE39FE39FE39FF39FF39FF39FF39FF39FF39FF39FF38003800380038003
      8003800380038003FFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object dsCabecalho: TDataSource
    DataSet = dmCGSDoc.rxCabecalho
    Left = 374
    Top = 541
  end
  object dsCompara: TDataSource
    AutoEdit = False
    DataSet = dmCGSDoc.RxCompara
    Enabled = False
    Left = 402
    Top = 541
  end
  object MDProgUltDoc: TRxMemoryData
    FieldDefs = <>
    AfterOpen = MDProgAfterOpen
    OnFilterRecord = MDProgUltDocFilterRecord
    Left = 430
    Top = 541
  end
  object RDprint1: TRDprint
    ImpressoraPersonalizada.NomeImpressora = 'Modelo Personalizado - (Epson)'
    ImpressoraPersonalizada.AvancaOitavos = '27 48'
    ImpressoraPersonalizada.AvancaSextos = '27 50'
    ImpressoraPersonalizada.SaltoPagina = '12'
    ImpressoraPersonalizada.TamanhoPagina = '27 67 66'
    ImpressoraPersonalizada.Negrito = '27 69'
    ImpressoraPersonalizada.Italico = '27 52'
    ImpressoraPersonalizada.Sublinhado = '27 45 49'
    ImpressoraPersonalizada.Expandido = '27 14'
    ImpressoraPersonalizada.Normal10 = '18 27 80'
    ImpressoraPersonalizada.Comprimir12 = '18 27 77'
    ImpressoraPersonalizada.Comprimir17 = '27 80 27 15'
    ImpressoraPersonalizada.Comprimir20 = '27 77 27 15'
    ImpressoraPersonalizada.Reset = '27 80 18 20 27 53 27 70 27 45 48'
    ImpressoraPersonalizada.Inicializar = '27 64'
    OpcoesPreview.PaginaZebrada = False
    OpcoesPreview.Remalina = False
    OpcoesPreview.CaptionPreview = 'Rdprint Preview'
    OpcoesPreview.PreviewZoom = 100
    OpcoesPreview.CorPapelPreview = clWhite
    OpcoesPreview.CorLetraPreview = clBlack
    OpcoesPreview.Preview = False
    OpcoesPreview.BotaoSetup = Ativo
    OpcoesPreview.BotaoImprimir = Ativo
    OpcoesPreview.BotaoGravar = Ativo
    OpcoesPreview.BotaoLer = Ativo
    Autor = Deltress
    About = 'RDprint 3.0h - Registrado'
    Acentuacao = Transliterate
    CaptionSetup = 'Rdprint Setup'
    UsaGerenciadorImpr = False
    CorForm = clBtnFace
    CorFonte = clBlack
    Impressora = Epson
    PortaComunicacao = 'LPT1'
    TestarPorta = True
    TamanhoQteLinhas = 66
    TamanhoQteColunas = 80
    TamanhoQteLPP = Seis
    NumeroPaginaInicial = 1
    PaginaInicial = 1
    PaginaFinal = 9999
    NumerodeCopias = 1
    FonteTamanhoPadrao = S10cpp
    FonteEstiloPadrao = []
    Orientacao = poPortrait
    OnNewPage = RDprint1NewPage
    Left = 458
    Top = 541
  end
  object QryCab: TQuery
    DatabaseName = 'DbBGM'
    Left = 486
    Top = 541
  end
  object QryItens: TQuery
    DatabaseName = 'DbBGM'
    Left = 514
    Top = 541
  end
  object DSProgUltDoc: TDataSource
    DataSet = MDProgUltDoc
    Left = 542
    Top = 541
  end
  object PMenuGeral: TPopupMenu
    OnPopup = PMenuGeralPopup
    Left = 289
    Top = 541
    object IMenuProgramacao: TMenuItem
      Caption = 'Escalar\Programar'
      ShortCut = 16464
      OnClick = IMenuProgramacaoClick
    end
    object IMenuProgUltDoc: TMenuItem
      Caption = 'Escala com os dados do '#250'ltimo docto'
      ShortCut = 16469
      OnClick = IMenuProgramacaoClick
    end
    object IMenuAltLocalid: TMenuItem
      Caption = 'Altera localidades'
      ShortCut = 16460
      OnClick = IMenuProgramacaoClick
    end
    object IMenuVisualizaPedido: TMenuItem
      Caption = 'Visualiza pedido'
      ShortCut = 16470
      OnClick = IMenuProgramacaoClick
    end
    object IMenuCanRea: TMenuItem
      Caption = '---- Definido em tempo de execucao ----'
      OnClick = IMenuProgramacaoClick
    end
    object IMenuMarDes: TMenuItem
      Caption = '---- Definido em tempo de execucao ----'
      OnClick = IMenuProgramacaoClick
    end
    object IMenuImprimirDocto: TMenuItem
      Caption = 'Imprimir docto(s) marcado(s)'
      ShortCut = 16457
      OnClick = IMenuProgramacaoClick
    end
    object IMenuReimprimir: TMenuItem
      Caption = 'Reimprimir'
      ShortCut = 16453
      OnClick = IMenuProgramacaoClick
    end
  end
  object QryAuxiliar: TQuery
    DatabaseName = 'DbBGM'
    Left = 570
    Top = 541
  end
  object dsItens: TDataSource
    AutoEdit = False
    DataSet = dmCGSDoc.rxItens
    Enabled = False
    Left = 598
    Top = 541
  end
end
