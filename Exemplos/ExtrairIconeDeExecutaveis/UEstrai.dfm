object Form1: TForm1
  Left = 384
  Top = 335
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 339
  ClientWidth = 597
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel10: TPanel
    Left = 0
    Top = 0
    Width = 282
    Height = 339
    Align = alLeft
    BevelInner = bvLowered
    Caption = 'Panel9'
    TabOrder = 0
    object Panel11: TPanel
      Left = 2
      Top = 21
      Width = 278
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel10'
      TabOrder = 0
      object DriveComboBox: TDriveComboBox
        Left = 3
        Top = 1
        Width = 273
        Height = 19
        Cursor = crHandPoint
        DirList = DirectoryListBox
        TabOrder = 0
      end
    end
    object DirectoryListBox: TDirectoryListBox
      Left = 2
      Top = 46
      Width = 278
      Height = 291
      Cursor = crHandPoint
      Align = alClient
      FileList = FListBoxArquivos
      ItemHeight = 16
      TabOrder = 1
      OnChange = DirectoryListBoxChange
    end
    object Panel8: TPanel
      Left = 2
      Top = 2
      Width = 278
      Height = 19
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Diret'#243'rios'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
  end
  object Panel6: TPanel
    Left = 282
    Top = 0
    Width = 315
    Height = 339
    Align = alClient
    BevelInner = bvLowered
    Caption = 'Panel6'
    TabOrder = 1
    object Panel7: TPanel
      Left = 2
      Top = 2
      Width = 311
      Height = 19
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Arquivos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object FListBoxArquivos: TFileListBox
      Left = 2
      Top = 21
      Width = 311
      Height = 279
      Cursor = crHandPoint
      Align = alClient
      FileType = [ftReadOnly, ftHidden, ftSystem, ftVolumeID, ftNormal]
      ItemHeight = 16
      Mask = '*.exe'
      ParentShowHint = False
      PopupMenu = PopupMenu1
      ShowGlyphs = True
      ShowHint = True
      TabOrder = 1
      OnChange = FListBoxArquivosChange
    end
    object Panel2: TPanel
      Left = 2
      Top = 300
      Width = 311
      Height = 37
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object Image1: TImage
        Left = 0
        Top = 0
        Width = 37
        Height = 37
        Align = alLeft
      end
    end
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 404
    Top = 308
    object IMenuSalvarIcone: TMenuItem
      Caption = 'Salvar icone'
      ShortCut = 16467
      OnClick = IMenuSalvarIconeClick
    end
  end
end
