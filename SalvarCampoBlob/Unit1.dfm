object Form1: TForm1
  Left = 201
  Top = 124
  Width = 334
  Height = 189
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
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button2Click
  end
  object OpenDialog1: TOpenDialog
    Left = 80
    Top = 16
  end
  object DB: TDatabase
    AliasName = 'ORA11G'
    DatabaseName = 'db'
    Params.Strings = (
      'USER NAME=COMPORTE110823'
      'PASSWORD=COMPORTE110823')
    SessionName = 'Default'
    Left = 144
    Top = 16
  end
  object Query1: TQuery
    DatabaseName = 'db'
    SQL.Strings = (
      
        'Insert Into TABELA_TAL   (CAMPO_BLOB,CAMPO_CHAVE) ) Values ( :p_' +
        'CAMPO_BLOB,1)')
    Left = 184
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'p_CAMPO_BLOB'
        ParamType = ptUnknown
      end>
  end
end
