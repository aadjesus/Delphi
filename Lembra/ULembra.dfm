object Form1: TForm1
  Left = 314
  Top = 222
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 606
  ClientWidth = 455
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 455
    Height = 606
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 453
      Height = 224
      Align = alTop
      BevelInner = bvRaised
      BevelOuter = bvNone
      BevelWidth = 2
      BorderWidth = 2
      BorderStyle = bsSingle
      TabOrder = 0
      object DBGridItens: TDBGrid
        Left = 4
        Top = 4
        Width = 441
        Height = 212
        Align = alClient
        DataSource = DSItens
        Options = [dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect]
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
            FieldName = 'ITEM'
            Title.Caption = 'O que'
            Visible = True
          end>
      end
      object PnlItens: TPanel
        Left = 29
        Top = 4
        Width = 441
        Height = 212
        BevelOuter = bvNone
        Caption = 'Itens'
        DragKind = dkDock
        TabOrder = 1
        Visible = False
        object Panel6: TPanel
          Left = 0
          Top = 0
          Width = 441
          Height = 161
          Align = alClient
          BevelInner = bvLowered
          Caption = 'Incluir'
          TabOrder = 0
          object EdtItem: TEdit
            Left = 8
            Top = 7
            Width = 209
            Height = 21
            MaxLength = 50
            TabOrder = 0
          end
          object EdtDescricao: TEdit
            Left = 222
            Top = 7
            Width = 208
            Height = 21
            MaxLength = 50
            TabOrder = 1
          end
          object MemoDetanhe: TMemo
            Left = 8
            Top = 35
            Width = 421
            Height = 115
            MaxLength = 250
            TabOrder = 2
          end
        end
        object Panel7: TPanel
          Left = 0
          Top = 161
          Width = 441
          Height = 51
          Align = alBottom
          BevelInner = bvLowered
          TabOrder = 1
          object BitBtn1: TBitBtn
            Left = 176
            Top = 16
            Width = 75
            Height = 25
            Caption = 'OK'
            ModalResult = 1
            TabOrder = 0
            OnClick = BitBtn1Click
            Glyph.Data = {
              DE010000424DDE01000000000000760000002800000024000000120000000100
              0400000000006801000000000000000000001000000000000000000000000000
              80000080000000808000800000008000800080800000C0C0C000808080000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              3333333333333333333333330000333333333333333333333333F33333333333
              00003333344333333333333333388F3333333333000033334224333333333333
              338338F3333333330000333422224333333333333833338F3333333300003342
              222224333333333383333338F3333333000034222A22224333333338F338F333
              8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
              33333338F83338F338F33333000033A33333A222433333338333338F338F3333
              0000333333333A222433333333333338F338F33300003333333333A222433333
              333333338F338F33000033333333333A222433333333333338F338F300003333
              33333333A222433333333333338F338F00003333333333333A22433333333333
              3338F38F000033333333333333A223333333333333338F830000333333333333
              333A333333333333333338330000333333333333333333333333333333333333
              0000}
            NumGlyphs = 2
          end
        end
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 225
      Width = 453
      Height = 187
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvNone
      BevelWidth = 2
      BorderWidth = 2
      BorderStyle = bsSingle
      TabOrder = 1
      object DBGridDescricao: TDBGrid
        Left = 4
        Top = 4
        Width = 441
        Height = 175
        Align = alClient
        DataSource = DSDescricao
        Options = [dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect]
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
            FieldName = 'DESCRICAO'
            Visible = True
          end>
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 412
      Width = 453
      Height = 193
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvNone
      BevelWidth = 2
      BorderWidth = 2
      BorderStyle = bsSingle
      TabOrder = 2
      object MemoDetalhe: TMemo
        Left = 4
        Top = 4
        Width = 441
        Height = 181
        Align = alClient
        Lines.Strings = (
          'MemoDetalhe')
        TabOrder = 0
      end
    end
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 121
    Top = 452
    object IMenuIncluir: TMenuItem
      Caption = 'Incluir'
      OnClick = IMenuIncluirClick
    end
    object IMenuAlterar: TMenuItem
      Caption = 'Alterar'
      OnClick = IMenuIncluirClick
    end
    object IMenuExcluir: TMenuItem
      Caption = 'Excluir'
      OnClick = IMenuIncluirClick
    end
  end
  object MDItens: TRxMemoryData
    FieldDefs = <>
    AfterScroll = MDItensAfterScroll
    Left = 49
    Top = 441
    object MDItensATUALIZA: TStringField
      FieldName = 'ATUALIZA'
      Size = 1
    end
    object MDItensITEM: TStringField
      FieldName = 'ITEM'
      Size = 50
    end
    object MDItensCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
  end
  object MDDescricao: TRxMemoryData
    FieldDefs = <>
    AfterScroll = MDDescricaoAfterScroll
    OnFilterRecord = MDDescricaoFilterRecord
    Left = 89
    Top = 444
    object MDDescricaoDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 50
    end
    object MDDescricaoDETALHE: TStringField
      FieldName = 'DETALHE'
      Size = 250
    end
    object MDDescricaoCODIGO: TIntegerField
      FieldName = 'CODIGO'
    end
  end
  object DSItens: TDataSource
    DataSet = MDItens
    Left = 41
    Top = 484
  end
  object DSDescricao: TDataSource
    DataSet = MDDescricao
    Left = 97
    Top = 492
  end
end
