object Form1: TForm1
  Left = 192
  Top = 113
  Width = 870
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
  object Button2: TButton
    Left = 64
    Top = 272
    Width = 75
    Height = 25
    Caption = 'compacta'
    TabOrder = 0
    OnClick = Button2Click
  end
  object Button5: TButton
    Left = 72
    Top = 304
    Width = 75
    Height = 25
    Caption = 'abre controle'
    TabOrder = 1
    OnClick = Button5Click
  end
  object Button1: TButton
    Left = 80
    Top = 336
    Width = 75
    Height = 25
    Caption = 'veri arq zip'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 224
    Top = 496
    Width = 75
    Height = 25
    Caption = 'cripto'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 328
    Top = 496
    Width = 75
    Height = 25
    Caption = 'descripto'
    TabOrder = 4
    OnClick = Button4Click
  end
  object Button6: TButton
    Left = 408
    Top = 424
    Width = 75
    Height = 25
    Caption = 'Button6'
    TabOrder = 5
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 576
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Compacta'
    TabOrder = 6
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 664
    Top = 384
    Width = 75
    Height = 25
    Caption = 'Descompacta'
    TabOrder = 7
    OnClick = Button8Click
  end
  object ZipMaster1: TZipMaster
    Verbose = False
    Trace = False
    AddCompLevel = 9
    AddOptions = [AddDirNames, AddSeparateDirs]
    ExtrOptions = [ExtrDirNames]
    Unattended = True
    MinZipDllVers = 170
    MinUnzDllVers = 170
    VersionInfo = '1.70'
    AddStoreSuffixes = [assGIF, assPNG, assZ, assZIP, assZOO, assARC, assLZH, assARJ, assTAZ, assTGZ, assLHA, assRAR, assACE, assCAB, assGZ, assGZIP, assJAR]
    KeepFreeOnDisk1 = 0
    SFXCaption = 'Self-extracting Archive'
    SFXOverWriteMode = OvrConfirm
    SFXPath = 'ZipSFX.bin'
    Left = 267
    Top = 257
  end
end
