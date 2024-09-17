object Form1: TForm1
  Left = 254
  Top = 192
  Width = 210
  Height = 640
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
  object DBGrid1: TDBGrid
    Left = 0
    Top = 481
    Width = 202
    Height = 132
    Align = alBottom
    DataSource = DataSource3
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnTitleClick = DBGrid2TitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'Dezena'
        Visible = True
      end>
  end
  object DBGrid2: TDBGrid
    Left = 0
    Top = 314
    Width = 202
    Height = 167
    Align = alClient
    DataSource = DataSource2
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnTitleClick = DBGrid2TitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'Dezena'
        Width = 51
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Qtde'
        Width = 39
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 202
    Height = 129
    Align = alTop
    TabOrder = 2
    object Label1: TLabel
      Left = 10
      Top = 48
      Width = 50
      Height = 13
      Caption = 'Dezenas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 8
      Top = 8
      Width = 54
      Height = 13
      Caption = 'Concurso'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object BitBtn1: TBitBtn
      Left = 198
      Top = 112
      Width = 75
      Height = 25
      Caption = 'Mostrar'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object RxSpinEdit1: TRxSpinEdit
      Left = 10
      Top = 64
      Width = 39
      Height = 21
      MaxValue = 59.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 1
    end
    object BitBtn2: TBitBtn
      Left = 127
      Top = 101
      Width = 68
      Height = 25
      Caption = 'Confirma'
      TabOrder = 2
      OnClick = BitBtn2Click
    end
    object RxSpinEdit2: TRxSpinEdit
      Left = 8
      Top = 24
      Width = 57
      Height = 21
      MaxValue = 9999.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 3
    end
    object RxSpinEdit3: TRxSpinEdit
      Left = 50
      Top = 64
      Width = 39
      Height = 21
      MaxValue = 59.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 4
    end
    object RxSpinEdit4: TRxSpinEdit
      Left = 90
      Top = 64
      Width = 39
      Height = 21
      MaxValue = 59.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 5
    end
    object RxSpinEdit5: TRxSpinEdit
      Left = 130
      Top = 64
      Width = 39
      Height = 21
      MaxValue = 59.000000000000000000
      MinValue = 1.000000000000000000
      Value = 1.000000000000000000
      TabOrder = 6
    end
  end
  object DBGrid3: TDBGrid
    Left = 0
    Top = 129
    Width = 202
    Height = 185
    Align = alTop
    DataSource = DataSource1
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        Visible = True
      end>
  end
  object DataSource2: TDataSource
    DataSet = RxMemoryData2
    Left = 32
    Top = 352
  end
  object RxMemoryData2: TRxMemoryData
    FieldDefs = <>
    Left = 64
    Top = 368
    object RxMemoryData2Dezena: TStringField
      FieldName = 'Dezena'
      Size = 2
    end
    object RxMemoryData2Qtde: TIntegerField
      FieldName = 'Qtde'
    end
  end
  object DataSource3: TDataSource
    DataSet = RxMemoryData3
    Left = 96
    Top = 528
  end
  object RxMemoryData3: TRxMemoryData
    FieldDefs = <>
    Left = 128
    Top = 544
    object RxMemoryData3Dezena: TStringField
      FieldName = 'Dezena'
      Size = 2
    end
  end
  object DataSource1: TDataSource
    DataSet = RxMemoryData1
    Left = 64
    Top = 152
  end
  object RxMemoryData1: TRxMemoryData
    FieldDefs = <>
    Left = 96
    Top = 168
    object StringField1: TStringField
      FieldName = 'Dezena'
      Size = 2
    end
    object IntegerField1: TIntegerField
      FieldName = 'Qtde'
    end
  end
end
