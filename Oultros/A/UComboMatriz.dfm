object Form1: TForm1
  Left = 196
  Top = 220
  Width = 696
  Height = 480
  Caption = 'Form1'
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
  object Label1: TLabel
    Left = 125
    Top = 65
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 125
    Top = 130
    Width = 32
    Height = 13
    Caption = 'Label2'
  end
  object Button1: TButton
    Left = 30
    Top = 90
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit3: TEdit
    Left = 205
    Top = 190
    Width = 121
    Height = 21
    Anchors = [akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 1
  end
  object ComboBox1: TComboBox
    Left = 195
    Top = 60
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 2
  end
  object ComboBox2: TComboBox
    Left = 195
    Top = 130
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 3
  end
end
