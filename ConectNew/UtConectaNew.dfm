object FrmConectaNew: TFrmConectaNew
  Left = 425
  Top = 459
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'FrmConectaNew'
  ClientHeight = 213
  ClientWidth = 215
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MDAlias: TRxMemoryData
    FieldDefs = <>
    Left = 120
    Top = 168
    object MDAliasALIAS: TStringField
      FieldName = 'ALIAS'
    end
  end
  object DSAlias: TDataSource
    DataSet = MDAlias
    Left = 149
    Top = 169
  end
  object PopupMenu1: TPopupMenu
    Left = 92
    Top = 170
    object a1: TMenuItem
      Caption = 'Servidores'
    end
    object N21: TMenuItem
      Caption = '-'
    end
  end
end
