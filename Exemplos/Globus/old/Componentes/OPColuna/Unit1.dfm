object Form1: TForm1
  Left = 283
  Top = 103
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
  object PnlPesq: TPanel
    Left = 124
    Top = 196
    Width = 344
    Height = 68
    Caption = 'PnlPesq'
    TabOrder = 0
    object PnlPesqTitulo: TPanel
      Left = 1
      Top = 1
      Width = 342
      Height = 19
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Caption = '     Pesquisa'
      Color = clNavy
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object ImageGlobus: TImage
        Left = 0
        Top = 0
        Width = 17
        Height = 19
        Align = alLeft
        Picture.Data = {
          07544269746D617076020000424D760200000000000076000000280000002000
          0000200000000100040000000000000200000000000000000000100000001000
          0000000000000000800000800000008080008000000080008000808000008080
          8000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFF
          FF00000000000000000000000000000000000000000000000000000000000000
          000000000000000088888888800000000000000000000008444C444888800000
          0000000000000044444444444888800000000000000044444C4C4C4C4C488800
          0000000000044444443444444444888000000000004C444C433C4C4C4C4C4888
          0000000004444444C334C444C444C48880000000044C4C4C433C4C4C4C4C4C88
          80000000444444C43334CCC4C4C4C44888000000444C4C43333C4C4C4C4C4C38
          880000044444C4433333CCCCC4CCC433880000044C4C4C4333333C4C4C4C4C33
          880000044444C43333333CCCCCCCC43388000004444C4C333333CC4CCC4C4C33
          880000044444C433333CCCCCCCC33333880000044C4C4C334C4C4CCCCCC33333
          8800000444444433CCCC3CCCCCC3333388000000444C4C433C433C4CCC4C3338
          800000004444343333333CCCCCCCC4C880000000044C333333333C4C4C433C88
          000000000444333333333CCCCCC3348000000000004C333333333C4C3C433000
          000000000004333333C333CC343300000000000000004333334C333C4C300000
          0000000000000044433444C44000000000000000000000004C4C4C4000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000}
        Stretch = True
        Transparent = True
      end
    end
    object PnlPesqTela: TPanel
      Left = 1
      Top = 20
      Width = 342
      Height = 47
      Align = alClient
      BevelInner = bvLowered
      Caption = 'PnlPesqTela'
      TabOrder = 1
      object LblPesquisa: TLabel
        Left = 6
        Top = 4
        Width = 78
        Height = 13
        Caption = 'Nome do campo'
      end
      object EdtPesquisa: TEdit
        Left = 6
        Top = 18
        Width = 330
        Height = 21
        TabOrder = 0
        Text = 'EdtPesquisa'
      end
    end
  end
  object DBGrid1: TDBGrid
    Left = 156
    Top = 68
    Width = 320
    Height = 120
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnTitleClick = DBGrid1TitleClick
  end
  object OPColuna1: TOPColuna
    DBGrid = DBGrid1
    Left = 524
    Top = 84
  end
  object RxMemoryData1: TRxMemoryData
    FieldDefs = <>
    Left = 64
    Top = 64
  end
  object DataSource1: TDataSource
    DataSet = Query1
    Left = 152
    Top = 24
  end
  object RxMemoryData2: TRxMemoryData
    FieldDefs = <>
    Left = 224
    Top = 16
  end
  object Query1: TQuery
    Left = 296
    Top = 24
  end
end
