object Form1: TForm1
  Left = 461
  Top = 185
  Hint = 'Abre ou fecha a drive de CD'
  BorderStyle = bsNone
  Caption = 'Form1'
  ClientHeight = 143
  ClientWidth = 292
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PopupMenu = PopupMenu1
  ShowHint = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 8
    Top = 4
    object IMenuOpen: TMenuItem
      Caption = 'Abrir Drive CD ROM'
      OnClick = IMenuOpenClick
    end
    object IMenuClosed: TMenuItem
      Caption = 'Fechar Drive CD ROM'
      Visible = False
      OnClick = IMenuOpenClick
    end
    object IMenuSair: TMenuItem
      Caption = 'Sair'
      OnClick = IMenuSairClick
    end
  end
end
