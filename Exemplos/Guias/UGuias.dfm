object Form1: TForm1
  Left = 345
  Top = 261
  Width = 390
  Height = 220
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 382
    Height = 193
    Align = alClient
    TabOrder = 0
    object Label20: TLabel
      Left = 6
      Top = 112
      Width = 31
      Height = 13
      Caption = 'Linhas'
    end
    object Label1: TLabel
      Left = 52
      Top = 112
      Width = 38
      Height = 13
      Caption = 'Colunas'
    end
    object RGroupFont: TRadioGroup
      Left = 5
      Top = 64
      Width = 372
      Height = 40
      Caption = ' Tamanho da Letra (Caracteres/Polegada) '
      Columns = 5
      ItemIndex = 0
      Items.Strings = (
        '05 cpp'
        '10 cpp'
        '12 cpp'
        '17 cpp'
        '20 cpp')
      TabOrder = 0
      OnClick = RGroupFontClick
    end
    object RadioGroup2: TRadioGroup
      Left = 5
      Top = 21
      Width = 244
      Height = 40
      Caption = ' Espa'#231'amento entre linhas (Linhas/Polegada) '
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        '6 Linhas/Pol'
        '8 Linhas/Pol')
      TabOrder = 1
    end
    object Button1: TButton
      Left = 144
      Top = 160
      Width = 75
      Height = 25
      Caption = 'Imprimir'
      TabOrder = 2
      OnClick = Button1Click
    end
    object SpEQtdLinhas: TSpinEdit
      Left = 6
      Top = 127
      Width = 42
      Height = 22
      Hint = 'Quantidade de linhas do relat'#243'rio (Tamanho da P'#225'gina)'
      MaxValue = 400
      MinValue = 1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      Value = 66
    end
    object RGroupImp: TRadioGroup
      Left = 256
      Top = 21
      Width = 120
      Height = 40
      Caption = ' Impressora (Colunas)'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        '80'
        '132')
      TabOrder = 4
      OnClick = RGroupFontClick
    end
    object NEdtColunas: TNumEdit
      Left = 52
      Top = 128
      Width = 61
      Height = 21
      Alignment = taRightJustify
      Color = cl3DLight
      Decimals = 0
      Enabled = False
      TabOrder = 5
      Value = 40.000000000000000000
    end
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
    OpcoesPreview.Preview = True
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
    FonteTamanhoPadrao = S12cpp
    FonteEstiloPadrao = []
    Orientacao = poPortrait
    Left = 240
    Top = 160
  end
end
