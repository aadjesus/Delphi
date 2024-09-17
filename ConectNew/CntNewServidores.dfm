object FrmCntNewServidores: TFrmCntNewServidores
  Left = 244
  Top = 418
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'FrmCntNewServidores'
  ClientHeight = 213
  ClientWidth = 214
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
    Width = 214
    Height = 213
    Align = alClient
    BevelInner = bvLowered
    Caption = 'Panel1'
    TabOrder = 0
    object Label2: TLabel
      Left = 6
      Top = 172
      Width = 32
      Height = 13
      Caption = 'Label2'
    end
    object DBGridAlias: TDBGrid
      Left = 6
      Top = 8
      Width = 204
      Height = 161
      Options = [dgEditing, dgTitles, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ALIAS'
          Width = 142
          Visible = True
        end>
    end
    object DriveTrab: TDriveComboBox
      Left = 6
      Top = 188
      Width = 204
      Height = 19
      TabOrder = 1
    end
  end
end
