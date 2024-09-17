object Form1: TForm1
  Left = 209
  Top = 118
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Criando Botões'
  ClientHeight = 355
  ClientWidth = 532
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
    Left = 224
    Top = 72
    Width = 81
    Height = 25
    Cursor = crHandPoint
    Caption = 'Criar Botão'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object Panel1: TPanel
    Left = 16
    Top = 16
    Width = 497
    Height = 49
    BevelInner = bvLowered
    TabOrder = 1
    object Label1: TLabel
      Left = 40
      Top = 3
      Width = 23
      Height = 16
      Caption = 'Top'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Century Gothic'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 136
      Top = 3
      Width = 22
      Height = 16
      Caption = 'Left'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Century Gothic'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 224
      Top = 3
      Width = 38
      Height = 16
      Caption = 'Hegth'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Century Gothic'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 328
      Top = 3
      Width = 37
      Height = 16
      Caption = 'Width'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Century Gothic'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 408
      Top = 3
      Width = 52
      Height = 16
      Caption = 'Caption'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Century Gothic'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 16
      Top = 21
      Width = 81
      Height = 21
      TabOrder = 0
      Text = '88'
    end
    object Edit2: TEdit
      Left = 112
      Top = 21
      Width = 81
      Height = 21
      TabOrder = 1
      Text = '24'
    end
    object Edit3: TEdit
      Left = 208
      Top = 21
      Width = 81
      Height = 21
      TabOrder = 2
      Text = '25'
    end
    object Edit4: TEdit
      Left = 304
      Top = 21
      Width = 81
      Height = 21
      TabOrder = 3
      Text = '75'
    end
    object Edit5: TEdit
      Left = 400
      Top = 21
      Width = 81
      Height = 21
      TabOrder = 4
      Text = 'Click'
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 336
    Width = 532
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Text = 'DeMolItoR'
        Width = 90
      end
      item
        Alignment = taCenter
        Bevel = pbNone
        Width = 50
      end
      item
        Alignment = taCenter
        Bevel = pbRaised
        Text = 'ckiller23@hotmail.com'
        Width = 250
      end
      item
        Alignment = taCenter
        Bevel = pbNone
        Width = 50
      end
      item
        Alignment = taCenter
        Text = '26/05/2003'
        Width = 50
      end>
    SimplePanel = False
  end
end
