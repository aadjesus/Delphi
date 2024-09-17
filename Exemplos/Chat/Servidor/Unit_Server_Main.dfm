object Form_Server_Main: TForm_Server_Main
  Left = 105
  Top = 124
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = 'LMChat Vers'#227'o Servidor'
  ClientHeight = 357
  ClientWidth = 649
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    649
    357)
  PixelsPerInch = 96
  TextHeight = 13
  object pcLearnSockets: TPageControl
    Left = 4
    Top = 8
    Width = 641
    Height = 347
    ActivePage = tsServer
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 0
    object tsServer: TTabSheet
      Caption = 'Servidor'
      ImageIndex = 1
      DesignSize = (
        633
        319)
      object lblServerAddress: TLabel
        Left = 168
        Top = 4
        Width = 253
        Height = 17
        AutoSize = False
        Caption = 'Server Address'
        Color = clBtnFace
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
      end
      object gbServerSettings: TGroupBox
        Left = 0
        Top = 0
        Width = 161
        Height = 318
        Anchors = [akLeft, akTop, akBottom]
        Caption = 'Servidor Parametros'
        TabOrder = 0
        DesignSize = (
          161
          318)
        object lblServerPort: TLabel
          Left = 123
          Top = 12
          Width = 25
          Height = 13
          Caption = 'Porta'
        end
        object edServerPort: TEdit
          Left = 120
          Top = 24
          Width = 33
          Height = 21
          TabOrder = 0
          Text = '4123'
        end
        object gbUserDefinedServerSettings: TGroupBox
          Left = 3
          Top = 120
          Width = 155
          Height = 195
          Anchors = [akLeft, akTop, akBottom]
          Caption = 'Defini'#231#245'es de usu'#225'rio'
          TabOrder = 1
          object cbBroadcastAsAlert: TCheckBox
            Left = 4
            Top = 88
            Width = 117
            Height = 17
            Caption = 'Broadcast as alert!'
            TabOrder = 0
            Visible = False
          end
          object cbSpaceMessages: TCheckBox
            Left = 4
            Top = 112
            Width = 105
            Height = 17
            Caption = 'Space messages'
            TabOrder = 1
            Visible = False
          end
          object cbRecordSentMessages: TCheckBox
            Left = 4
            Top = 136
            Width = 133
            Height = 17
            Caption = 'Record Sent Messages'
            Checked = True
            State = cbChecked
            TabOrder = 2
            Visible = False
          end
          object cbShowAdminMsgs: TCheckBox
            Left = 4
            Top = 160
            Width = 137
            Height = 17
            Caption = 'Admin Online'
            TabOrder = 3
            Visible = False
            OnClick = cbShowAdminMsgsClick
          end
        end
        object btnStartStopServer: TButton
          Left = 36
          Top = 86
          Width = 45
          Height = 19
          Caption = 'Iniciar'
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -8
          Font.Name = 'Small Fonts'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = btnStartStopServerClick
        end
        object fr_senha: TEdit
          Left = 16
          Top = 56
          Width = 73
          Height = 21
          TabOrder = 3
          OnExit = fr_senhaExit
        end
      end
      object memLog: TMemo
        Left = 168
        Top = 28
        Width = 461
        Height = 286
        Hint = 'To clear this box click it and press the DEL key.'
        Anchors = [akLeft, akTop, akRight, akBottom]
        ParentShowHint = False
        ScrollBars = ssBoth
        ShowHint = True
        TabOrder = 1
        WordWrap = False
        OnKeyDown = memLogKeyDown
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Conex'#245'es'
      ImageIndex = 2
      DesignSize = (
        633
        319)
      object sgServerConnections: TStringGrid
        Left = 0
        Top = 36
        Width = 633
        Height = 283
        Anchors = [akLeft, akTop, akRight, akBottom]
        ColCount = 25
        DefaultRowHeight = 16
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goColSizing, goRowSelect]
        TabOrder = 0
        OnKeyDown = sgServerConnectionsKeyDown
      end
      object btnDisconnect: TButton
        Left = 4
        Top = 4
        Width = 77
        Height = 25
        Caption = 'Desconectar'
        TabOrder = 1
        OnClick = btnDisconnectClick
      end
      object btnDisconnectAll: TButton
        Left = 84
        Top = 4
        Width = 97
        Height = 25
        Caption = 'Desconectar Todos'
        Enabled = False
        TabOrder = 2
        OnClick = btnDisconnectAllClick
      end
      object cbSendCloseToClient: TCheckBox
        Left = 188
        Top = 8
        Width = 205
        Height = 17
        Caption = 'Enviar finaliza'#231#227'o para usu'#225'rio'
        TabOrder = 3
      end
    end
    object tsAdminMsg: TTabSheet
      Caption = 'Admin. Mensagens'
      ImageIndex = 1
      DesignSize = (
        633
        319)
      object memMessageBox: TMemo
        Left = 4
        Top = 4
        Width = 617
        Height = 278
        Hint = 'To clear this box click it and press the DEL key.'
        Anchors = [akLeft, akTop, akRight, akBottom]
        Color = clBackground
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clLime
        Font.Height = -13
        Font.Name = 'Terminal'
        Font.Style = []
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ReadOnly = True
        ScrollBars = ssBoth
        ShowHint = True
        TabOrder = 0
        WantReturns = False
        OnKeyDown = memMessageBoxKeyDown
      end
      object edSend: TEdit
        Left = 4
        Top = 291
        Width = 621
        Height = 21
        Hint = 'Type message and press ENTER to send message.'
        Anchors = [akLeft, akRight, akBottom]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnKeyDown = edSendKeyDown
      end
    end
  end
  object Button1: TButton
    Left = 526
    Top = 0
    Width = 59
    Height = 25
    Caption = 'Minimizar'
    TabOrder = 1
    OnClick = Button1Click
  end
  object ChatServerSocket: TIdTCPServer
    OnStatus = ChatServerSocketStatus
    Bindings = <>
    CommandHandlers = <>
    DefaultPort = 0
    Greeting.NumericCode = 0
    MaxConnectionReply.NumericCode = 0
    MaxConnections = 80
    OnAfterCommandHandler = ChatServerSocketAfterCommandHandler
    OnBeforeCommandHandler = ChatServerSocketBeforeCommandHandler
    OnConnect = ChatServerSocketConnect
    OnExecute = ChatServerSocketExecute
    OnDisconnect = ChatServerSocketDisconnect
    OnException = ChatServerSocketException
    OnListenException = ChatServerSocketListenException
    OnNoCommandHandler = ChatServerSocketNoCommandHandler
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 0
    ThreadMgr = IdThreadMgrDefault1
    Left = 44
    Top = 296
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 100
    Top = 296
  end
  object IdThreadMgrDefault1: TIdThreadMgrDefault
    Left = 72
    Top = 296
  end
  object VrTrayIcon1: TVrTrayIcon
    Icon.Data = {
      0000010001002020100000000000E80200001600000028000000200000004000
      0000010004000000000080020000000000000000000000000000000000000000
      000000008000008000000080800080000000800080008080000080808000C0C0
      C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFF
      FFFFFFFF88888888888FFFFFFFFFFFFFFFFFF88888888888888888FFFFFFFFFF
      FFFF8888888888888888888FFFFFFFFFFFF888888888888888888888FFFFFF00
      00000000000000088888888888FFFF0000000000000000088888888888FFFF00
      000000000000000888888888888FFF00888888888888000888888888888FFF00
      888888888880000888888888888FFF008888888800000008888888888888FF00
      8888888000000008888888888888FF008888880000880008888888888888FF00
      8888800008880008888888888888FF008888880008880000000888888888FF00
      8888888888880000000888888888FF008888888888880000000888888888FF00
      8888888880088888000888888888FF008888880000000000000000888888FF00
      888880000000000000000088888FFF00888880000FF000000FF00008888FFF00
      F8888000FFFF0000FFFF0008888FFF00FF88800FF00F0000F00FF00888FFFF00
      FFF88000FFFF0000FF0F000888FFFF00FFF880000FF000000FF000088FFFFF00
      FFFF8000000000000000008FFFFFFF00FFFFF80000000000000000FFFFFFFF00
      FFFFF80000000080000008FFFFFFFF000000FF000000888888FFFFFFFFFFFF00
      0000FF000FF888888FFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      000FFFFFFFFFFFFFFFFFFFFFFFFFF888000000888FFFFFFFFFFFFFFFFFFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000}
    Visible = True
    Hint = 'DeChat Servidor - Ativado'
    ShowHint = True
    PopupMenu = PopupMenu1
    HideTaskBtn = True
    LeftBtnPopup = True
    OnDblClick = VrTrayIcon1DblClick
    Left = 448
  end
  object PopupMenu1: TPopupMenu
    Left = 416
    object AbrirPrograma1: TMenuItem
      Caption = '&Abrir Programa'
      OnClick = AbrirPrograma1Click
    end
    object FecharPrograma1: TMenuItem
      Caption = '&Fechar Programa'
      OnClick = FecharPrograma1Click
    end
  end
  object Timer1: TTimer
    Interval = 30000
    OnTimer = Timer1Timer
    Left = 320
  end
end
