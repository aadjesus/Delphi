object Form1: TForm1
  Left = 192
  Top = 114
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cria HTML com todas URLs do Favoritos'
  ClientHeight = 364
  ClientWidth = 724
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnMouseMove = LblArqHtmlMouseMove
  PixelsPerInch = 96
  TextHeight = 13
  object LblArqHtml: TLabel
    Left = 87
    Top = 341
    Width = 36
    Height = 13
    Caption = 'Arquivo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = LblArqHtmlClick
    OnMouseMove = LblArqHtmlMouseMove
  end
  object Button1: TButton
    Left = 3
    Top = 336
    Width = 75
    Height = 25
    Caption = 'Executar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Panel10: TPanel
    Left = 0
    Top = 0
    Width = 724
    Height = 334
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel9'
    TabOrder = 1
    object Panel11: TPanel
      Left = 0
      Top = 0
      Width = 724
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel10'
      TabOrder = 0
      object DriveComboBox: TDriveComboBox
        Left = 3
        Top = 1
        Width = 718
        Height = 19
        Cursor = crHandPoint
        DirList = DirectoryListBox
        TabOrder = 0
      end
    end
    object DirectoryListBox: TDirectoryListBox
      Left = 0
      Top = 25
      Width = 724
      Height = 309
      Cursor = crHandPoint
      Align = alClient
      ItemHeight = 16
      TabOrder = 1
      OnMouseMove = LblArqHtmlMouseMove
    end
  end
end
