object Form1: TForm1
  Left = 193
  Top = 178
  Width = 1061
  Height = 738
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
    Width = 497
    Height = 704
    Align = alLeft
    Caption = 'Panel1'
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 1
      Top = 488
      Width = 495
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object Splitter2: TSplitter
      Left = 1
      Top = 110
      Width = 495
      Height = 2
      Cursor = crVSplit
      Align = alTop
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 112
      Width = 495
      Height = 376
      Align = alClient
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'GRUPO'
          Title.Caption = 'Grupos'
          Width = 287
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QTDEM'
          Title.Caption = 'Qtde m'#250'sicas'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QTDEA'
          Title.Caption = 'Qtde albuns'
          Width = 70
          Visible = True
        end>
    end
    object DBGrid2: TDBGrid
      Left = 1
      Top = 491
      Width = 495
      Height = 193
      Align = alBottom
      DataSource = DataSource2
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ALBUM'
          Title.Caption = 'Albuns'
          Width = 377
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'QTDEM'
          Title.Caption = 'Qtde m'#250'sicas'
          Width = 73
          Visible = True
        end>
    end
    object Panel10: TPanel
      Left = 1
      Top = 1
      Width = 495
      Height = 109
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel9'
      TabOrder = 2
      object Panel11: TPanel
        Left = 0
        Top = 0
        Width = 495
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel10'
        TabOrder = 0
        object DriveComboBox: TDriveComboBox
          Left = 3
          Top = 1
          Width = 438
          Height = 19
          Cursor = crHandPoint
          DirList = DirectoryListBox
          TabOrder = 0
        end
        object Button1: TButton
          Left = 444
          Top = 2
          Width = 49
          Height = 18
          Caption = 'Executar'
          TabOrder = 1
          OnClick = Button1Click
        end
      end
      object DirectoryListBox: TDirectoryListBox
        Left = 0
        Top = 25
        Width = 495
        Height = 84
        Cursor = crHandPoint
        Align = alClient
        ItemHeight = 16
        TabOrder = 1
      end
    end
    object StatusBar1: TStatusBar
      Left = 1
      Top = 684
      Width = 495
      Height = 19
      Panels = <
        item
          Width = 160
        end
        item
          Width = 160
        end
        item
          Width = 160
        end>
    end
    object EdtGrupo: TEdit
      Left = 16
      Top = 448
      Width = 121
      Height = 21
      TabOrder = 4
      Text = 'EdtGrupo'
      Visible = False
    end
  end
  object MediaPlayer1: TMediaPlayer
    Left = 536
    Top = 710
    Width = 253
    Height = 30
    AutoEnable = False
    Visible = False
    TabOrder = 1
  end
  object Panel2: TPanel
    Left = 497
    Top = 0
    Width = 556
    Height = 704
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel2'
    TabOrder = 2
    object DBGrid3: TDBGrid
      Left = 0
      Top = 0
      Width = 556
      Height = 684
      Align = alClient
      DataSource = DataSource3
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection]
      PopupMenu = PopupMenu1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'MUSICA'
          Title.Caption = 'M'#250'sicas'
          Width = 500
          Visible = True
        end>
    end
    object StatusBar2: TStatusBar
      Left = 0
      Top = 684
      Width = 556
      Height = 20
      Panels = <
        item
          Text = 'Path:'
          Width = 50
        end>
    end
  end
  object RxMemoryData1: TRxMemoryData
    FieldDefs = <>
    AfterScroll = RxMemoryData1AfterScroll
    Left = 216
    Top = 200
    object RxMemoryData1GRUPO: TStringField
      FieldName = 'GRUPO'
      Size = 100
    end
    object RxMemoryData1QTDE: TIntegerField
      FieldName = 'QTDEA'
    end
    object RxMemoryData1QTDEM: TIntegerField
      FieldName = 'QTDEM'
    end
  end
  object DataSource1: TDataSource
    DataSet = RxMemoryData1
    Left = 224
    Top = 232
  end
  object RxMemoryData2: TRxMemoryData
    FieldDefs = <>
    AfterScroll = RxMemoryData2AfterScroll
    OnFilterRecord = RxMemoryData2FilterRecord
    Left = 112
    Top = 584
    object StringField1: TStringField
      FieldName = 'GRUPO'
      Size = 100
    end
    object StringField2: TStringField
      FieldName = 'ALBUM'
      Size = 100
    end
    object RxMemoryData2QTDE: TIntegerField
      FieldName = 'QTDEM'
    end
  end
  object DataSource2: TDataSource
    DataSet = RxMemoryData2
    Left = 120
    Top = 616
  end
  object RxMemoryData3: TRxMemoryData
    FieldDefs = <>
    AfterScroll = RxMemoryData3AfterScroll
    OnFilterRecord = RxMemoryData3FilterRecord
    Left = 720
    Top = 104
    object StringField4: TStringField
      FieldName = 'GRUPO'
      Size = 100
    end
    object StringField5: TStringField
      FieldName = 'ALBUM'
      Size = 100
    end
    object StringField6: TStringField
      FieldName = 'MUSICA'
      Size = 100
    end
    object RxMemoryData3PATH: TStringField
      FieldName = 'PATH'
      Size = 300
    end
  end
  object DataSource3: TDataSource
    DataSet = RxMemoryData3
    Left = 728
    Top = 136
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 640
    Top = 496
    object Play1: TMenuItem
      Caption = 'Play'
      ShortCut = 16464
      OnClick = Play1Click
    end
    object Pause1: TMenuItem
      Caption = 'Pause'
      ShortCut = 16449
      OnClick = Play1Click
    end
    object Stop1: TMenuItem
      Caption = 'Stop'
      ShortCut = 16467
      OnClick = Play1Click
    end
  end
end
