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
  object Button1: TButton
    Left = 80
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Decompacta'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 104
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Compacta'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 96
    Top = 296
    Width = 75
    Height = 25
    Caption = 'Button3'
    TabOrder = 2
    OnClick = Button3Click
  end
  object ZipMaster1: TZipMaster
    Verbose = False
    Trace = False
    AddCompLevel = 9
    AddOptions = [AddDirNames, AddSeparateDirs]
    ExtrOptions = [ExtrDirNames, ExtrOverWrite]
    Unattended = False
    MinZipDllVers = 170
    MinUnzDllVers = 170
    VersionInfo = '1.70'
    AddStoreSuffixes = [assGIF, assPNG, assZ, assZIP, assZOO, assARC, assLZH, assARJ, assTAZ, assTGZ, assLHA, assRAR, assACE, assCAB, assGZ, assGZIP, assJAR]
    OnProgress = ZipMaster1Progress
    KeepFreeOnDisk1 = 0
    SFXCaption = 'Self-extracting Archive'
    SFXOverWriteMode = OvrConfirm
    SFXPath = 'ZipSFX.bin'
    Left = 291
    Top = 257
  end
end
