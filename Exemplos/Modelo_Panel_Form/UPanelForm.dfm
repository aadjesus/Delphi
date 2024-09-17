object Form1: TForm1
  Left = 184
  Top = 103
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 453
  ClientWidth = 688
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 88
    Top = 112
    Width = 185
    Height = 177
    BevelOuter = bvNone
    Caption = 'Teste'
    DragKind = dkDock
    Locked = True
    TabOrder = 0
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 185
      Height = 136
      Align = alClient
      BevelInner = bvLowered
      Caption = 'Panel2'
      TabOrder = 0
    end
    object Panel3: TPanel
      Left = 0
      Top = 136
      Width = 185
      Height = 41
      Align = alBottom
      BevelInner = bvLowered
      Caption = 'Panel3'
      TabOrder = 1
    end
  end
  object Button1: TButton
    Left = 368
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
end
