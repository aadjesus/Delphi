object Form1: TForm1
  Left = 227
  Top = 106
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 503
  ClientWidth = 506
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Empresa: TComboBoxEmpFilGar
    Left = 4
    Top = 4
    Width = 500
    Height = 21
    TabOrder = 0
    Propriedades.Codigo = 0
    Propriedades.DataBase = db1
  end
  object Filial: TComboBoxEmpFilGar
    Left = 4
    Top = 28
    Width = 500
    Height = 21
    TabOrder = 1
    Propriedades.TipoCampo = tpFilial
    Propriedades.Codigo = 0
    Propriedades.CampoAnt = Empresa
    Propriedades.DataBase = db1
  end
  object Garagem: TComboBoxEmpFilGar
    Left = 4
    Top = 52
    Width = 500
    Height = 21
    TabOrder = 2
    Propriedades.TipoCampo = tpGaragem
    Propriedades.Codigo = 0
    Propriedades.LayOut = loNGaragem
    Propriedades.CampoAnt = Filial
    Propriedades.DataBase = db1
  end
  object Panel1: TPanel
    Left = 0
    Top = 113
    Width = 506
    Height = 130
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 3
    object Label1: TLabel
      Left = 2
      Top = 2
      Width = 502
      Height = 13
      Align = alTop
      Caption = 'Empresa'
    end
    object MemoEmpresa: TMemo
      Left = 2
      Top = 15
      Width = 502
      Height = 113
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 243
    Width = 506
    Height = 130
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 4
    object Label2: TLabel
      Left = 2
      Top = 2
      Width = 502
      Height = 13
      Align = alTop
      Caption = 'Filial'
    end
    object MemoFilial: TMemo
      Left = 2
      Top = 15
      Width = 502
      Height = 113
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 373
    Width = 506
    Height = 130
    Align = alBottom
    BevelInner = bvLowered
    TabOrder = 5
    object Label3: TLabel
      Left = 2
      Top = 2
      Width = 502
      Height = 13
      Align = alTop
      Caption = 'Garagem'
    end
    object MemoGaragem: TMemo
      Left = 2
      Top = 15
      Width = 502
      Height = 113
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object Button1: TButton
    Left = 118
    Top = 82
    Width = 281
    Height = 25
    Caption = 'Mostra os dados da empresa, filial e garagem'
    TabOrder = 6
    OnClick = Button1Click
  end
  object db1: TDatabase
    AliasName = 'opr'
    DatabaseName = 'DB1'
    KeepConnection = False
    LoginPrompt = False
    Params.Strings = (
      'USER NAME=BBTT060220'
      'PASSWORD=BBTT060220')
    SessionName = 'Default'
    Left = 425
    Top = 76
  end
end
