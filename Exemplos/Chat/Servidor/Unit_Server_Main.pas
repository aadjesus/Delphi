unit Unit_Server_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ScktComp, WinSock, Grids, ComCtrls, StdCtrls, ExtCtrls, IdBaseComponent,
  IdComponent, IdTCPServer, IdAntiFreezeBase, IdAntiFreeze, IdThreadMgr,
  IdThreadMgrDefault, IdServerIOHandler, IdServerIOHandlerSocket, IdException,
  IdIntercept, IdLogBase, IdLogEvent, SyncObjs, WinSkinData, VrControls,
  VrSystem, Menus, ImgList, Buttons, DB, DBTables;

resourcestring
  StatusDateTimeFormat = 'mm/dd/yyyy" - "hh:nn:ss:zzz AM/PM';

type
  TSCSClientInfo = class(TObject)
    ScreenName : string;
    LocalName  : string;
    IP         : string;
    Port       : string;
    PeerIP     : string;
    PeerPort   : string;
    Index      : Integer;
    Thread     : Pointer;
  end;

  TForm_Server_Main = class(TForm)
    ChatServerSocket: TIdTCPServer;
    pcLearnSockets: TPageControl;
    tsServer: TTabSheet;
    gbServerSettings: TGroupBox;
    lblServerPort: TLabel;
    edServerPort: TEdit;
    gbUserDefinedServerSettings: TGroupBox;
    tsAdminMsg: TTabSheet;
    TabSheet2: TTabSheet;
    sgServerConnections: TStringGrid;
    cbBroadcastAsAlert: TCheckBox;
    btnStartStopServer: TButton;
    IdAntiFreeze1: TIdAntiFreeze;
    IdThreadMgrDefault1: TIdThreadMgrDefault;
    lblServerAddress: TLabel;
    btnDisconnect: TButton;
    btnDisconnectAll: TButton;
    cbSendCloseToClient: TCheckBox;
    cbSpaceMessages: TCheckBox;
    cbRecordSentMessages: TCheckBox;
    memMessageBox: TMemo;
    edSend: TEdit;
    memLog: TMemo;
    cbShowAdminMsgs: TCheckBox;
    VrTrayIcon1: TVrTrayIcon;
    Button1: TButton;
    PopupMenu1: TPopupMenu;
    AbrirPrograma1: TMenuItem;
    FecharPrograma1: TMenuItem;
    Timer1: TTimer;
    fr_senha: TEdit;
    procedure edSendKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure sgServerConnectionsKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure memMessageBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ChatServerSocketConnect(AThread: TIdPeerThread);
    procedure ChatServerSocketExecute(AThread: TIdPeerThread);
    procedure ChatServerSocketListenException(AThread: TIdListenerThread; AException: Exception);
    procedure ChatServerSocketNoCommandHandler(ASender: TIdTCPServer; const AData: String; AThread: TIdPeerThread);
    procedure ChatServerSocketStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);
    procedure btnStartStopServerClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnDisconnectClick(Sender: TObject);
    procedure ChatServerSocketAfterCommandHandler(ASender: TIdTCPServer; AThread: TIdPeerThread);
    procedure ChatServerSocketBeforeCommandHandler(ASender: TIdTCPServer; const AData: String; AThread: TIdPeerThread);
    procedure ChatServerSocketDisconnect(AThread: TIdPeerThread);
    procedure ChatServerSocketException(AThread: TIdPeerThread; AException: Exception);
    procedure btnDisconnectAllClick(Sender: TObject);
    procedure memLogKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure cbShowAdminMsgsClick(Sender: TObject);
    procedure FecharPrograma1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure VrTrayIcon1DblClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure AbrirPrograma1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure fr_senhaExit(Sender: TObject);
    //
  private
    { Private declarations }
    ClientList: TList;
    procedure AddToClientList(AScreenName: string; AThread: TIdPeerThread);
    procedure RemoveFromClientList(ClientInfo: TSCSClientInfo);
    //Protocol
    procedure BrodcastMessage(Msg: string; AThread: TIdPeerThread);
    procedure ProxyMessage(Msg: string; AThread: TIdPeerThread);
    function GetLoginList: string;
    procedure AppMinimize(Sender: TObject);
    procedure ManipulaExcecoes(Sender: TObject; E: Exception);

  public
    { Public declarations }
  end;

var
  Form_Server_Main: TForm_Server_Main;

implementation

uses IdTCPConnection, IdThread;

{$R *.DFM}

procedure TForm_Server_Main.AppMinimize(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TForm_Server_Main.FormCreate(Sender: TObject);
begin

  ShortDateFormat := 'dd/mm/yyyy';
  DecimalSeparator := '.';
  ThousandSeparator := ',';

//  Application.OnException := ManipulaExcecoes;


  vrtrayicon1.hint:=application.Title;

  tsAdminMsg.TabVisible := False;
  ClientList := TList.Create;

  sgServerConnections.RowCount := 2;
  sgServerConnections.FixedRows := 1;
  sgServerConnections.ColCount := 13;
  //Setup Columns
  with sgServerConnections do
  begin
    Cells[0,0] := 'Mem. Addr.';
    ColWidths[1] := 25;
    Cells[2,0] := 'Nome';
    ColWidths[2] := 100;
    Cells[3,0] := 'Host Local';
    ColWidths[3] := 100;
    Cells[4,0] := 'Endereco Local';
    ColWidths[4] := 100;
    Cells[5,0] := 'Porta Local';
    ColWidths[5] := 75;
    Cells[6,0] := 'Host Remoto';
    ColWidths[6] := 100;
    Cells[7,0] := 'Endereco Remoto';
    ColWidths[7] := 100;
    Cells[8,0] := 'Porta Remota';
    ColWidths[8] := 75;
  end;
end;

procedure TForm_Server_Main.ManipulaExcecoes(Sender: TObject; E: Exception);
begin
    MessageBox(0,'Falha em estabelecer conexão com o Servidor.'+chr(13)+
                 'Contacte o Administrador do Sistema.', 'Aviso de Alerta do Sistema !', MB_OK);

    application.terminate;

end;

procedure TForm_Server_Main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TForm_Server_Main.FormDestroy(Sender: TObject);
begin
  if ChatServerSocket.Active then
  begin
    btnDisconnectAllClick(Self);
    try
      ChatServerSocket.Active := False;
    except
      on E: Exception do
      begin
        memLog.Lines.Add('Erro Ocorrido (' + FormatDateTime(StatusDateTimeFormat, Now) + ') [' + E.ClassName + ']: ' + E.Message);
      end; //on
    end;
  end;
  ClientList.Free;
end;

procedure TForm_Server_Main.edSendKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_Return then
  begin

    if cbBroadcastAsAlert.Checked then
    begin
      BrodcastMessage('!' + edSend.Text, nil);
    end
    else
    begin
      BrodcastMessage('Admin.> ' + edSend.Text, nil);
    end;

    if cbRecordSentMessages.Checked then
    begin
      memMessageBox.Lines.Add('Admin.> ' + edSend.Text);
      if cbSpaceMessages.Checked then
      begin
        memMessageBox.Lines.Add('');
      end;
    end;
    edSend.Text := '';
  end;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TForm_Server_Main.BrodcastMessage(Msg: string; AThread: TIdPeerThread);
var
  List: TList;
  I: Integer;
begin
  List := ChatServerSocket.Threads.LockList;
  try
    for I := 0 to List.Count - 1 do
    begin
      try
        if AThread <> TIdPeerThread(List.Items[I]) then
        begin
          TIdPeerThread(List.Items[I]).Connection.WriteLn(Msg);
        end;
      except
        on E: Exception do
        begin
          memLog.Lines.Add('Erro Ocorrido (' + FormatDateTime(StatusDateTimeFormat, Now) + ') [' + E.ClassName + ']: ' + E.Message);
          memLog.Lines.Add('Os processos foram finalizados');
          TIdPeerThread(List.Items[I]).Stop;
        end; //on
      end; //try
    end; //for
  finally
    ChatServerSocket.Threads.UnlockList;
  end;
end;

procedure TForm_Server_Main.ProxyMessage(Msg: string; AThread: TIdPeerThread);
var
  List: TList;
  Data: TStrings;
  Sender: string;
  Receivers: TStrings;
  ChatMsg: string;
  I, J: Integer;
begin
  Data := TStringList.Create;
  Receivers := TStringList.Create;
  try
    Data.CommaText := Msg;
    Sender := TSCSClientInfo(AThread.Data).ScreenName; //Also should = Data.Strings[0];
    Receivers.CommaText := Data.Strings[1];
    ChatMsg := Sender + '> ' + Data.Strings[2];

    J := Receivers.IndexOf('Administrator');
    if J > -1 then
    begin
      if cbShowAdminMsgs.Checked then
      begin
        memMessageBox.Lines.Add(ChatMsg);
      end
      else
      begin
        I := sgServerConnections.Cols[2].IndexOf('Administrator');
        if I <= -1 then
        begin
          TIdPeerThread(AThread).Connection.WriteLn('Admin. não esta no ar.');
        end;
      end;
    end;

    List := ChatServerSocket.Threads.LockList;
    try
      for I := 0 to List.Count - 1 do
      begin
        try
          J := Receivers.IndexOf(TSCSClientInfo(TIdPeerThread(List.Items[I]).Data).ScreenName);
          if (J > -1) and (AThread <> TIdPeerThread(List.Items[I])) then
          begin
            TIdPeerThread(List.Items[I]).Connection.WriteLn(ChatMsg);
          end;
        except
          on E: Exception do
          begin
            memLog.Lines.Add('Erro Ocorrido (' + FormatDateTime(StatusDateTimeFormat, Now) + ') [' + E.ClassName + ']: ' + E.Message);
            memLog.Lines.Add('Os processos foram finalizados');
            TIdPeerThread(List.Items[I]).Stop;
          end; //on
        end; //try
      end; //for
    finally
      ChatServerSocket.Threads.UnlockList;
    end;
  finally
    Receivers.Free;
    Data.Free;
    List := nil;
  end;
end;

procedure TForm_Server_Main.sgServerConnectionsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_DELETE) and (sgServerConnections.Row <> 0) then
  begin
    btnDisconnectClick(Self);
  end;
end;

procedure TForm_Server_Main.memMessageBoxKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then memMessageBox.Clear;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TForm_Server_Main.AddToClientList(AScreenName: string; AThread: TIdPeerThread);
var
  ClientInfo: TSCSClientInfo;
  I: Integer;
begin

  ClientInfo := TSCSClientInfo.Create;
  ClientInfo.ScreenName := AScreenName;
  ClientInfo.LocalName := AThread.Connection.LocalName;
  ClientInfo.PeerIP := AThread.Connection.Socket.Binding.PeerIP;
  ClientInfo.PeerPort := IntToStr(AThread.Connection.Socket.Binding.PeerPort);
  ClientInfo.IP := AThread.Connection.Socket.Binding.IP;
  ClientInfo.Port := IntToStr(AThread.Connection.Socket.Binding.Port);
  ClientInfo.Thread := AThread;
  AThread.Data := ClientInfo;
  //
  ClientList.Add(ClientInfo);
  I := sgServerConnections.Cols[2].IndexOf('-----');
  if I <= -1 then
  begin
    sgServerConnections.RowCount := sgServerConnections.RowCount + 1;
    I := ClientList.Count;
    sgServerConnections.Cells[1 ,I] := IntToStr(-1);
    sgServerConnections.Cells[2 ,I] := '-----';
  end;
  //Add data
  with sgServerConnections do
  begin
    Cells[0 ,I] := IntToStr(Integer(ClientInfo));
    Cells[1 ,I] := IntToStr(ClientList.Count);
    Cells[2 ,I] := ClientInfo.ScreenName;
    Cells[3 ,I] := ClientInfo.LocalName;
    Cells[4 ,I] := TIdPeerThread(ClientInfo.Thread).Connection.Socket.Binding.IP;
    Cells[5 ,I] := IntToStr(TIdPeerThread(ClientInfo.Thread).Connection.Socket.Binding.Port);
    Cells[6 ,I] := 'N/A';
    Cells[7 ,I] := TIdPeerThread(ClientInfo.Thread).Connection.Socket.Binding.PeerIP;
    Cells[8 ,I] := IntToStr(TIdPeerThread(ClientInfo.Thread).Connection.Socket.Binding.PeerPort);
  end;
end;

procedure TForm_Server_Main.RemoveFromClientList(ClientInfo: TSCSClientInfo);
var
  I: Integer;
begin
  I := sgServerConnections.Cols[0].IndexOf(IntToStr(Integer(ClientInfo)));
  if I > -1 then
  begin
    with sgServerConnections do
    begin
      Cells[0 ,I] := '';
      Cells[1 ,I] := IntToStr(-1);
      Cells[2 ,I] := '-----';
      Cells[3 ,I] := '';
      Cells[4 ,I] := '';
      Cells[5 ,I] := '';
      Cells[6 ,I] := '';
      Cells[7 ,I] := '';
      Cells[8 ,I] := '';
    end;
  end;
end;

function TForm_Server_Main.GetLoginList: string;
begin
  Result := Copy(sgServerConnections.Cols[2].CommaText, 1, Length(sgServerConnections.Cols[2].CommaText)-1);
end;

////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TForm_Server_Main.ChatServerSocketConnect(AThread: TIdPeerThread);
var
  Data: string;
  I: Integer;
begin
  memLog.Lines.Add('Enviando Menssagem Conexão (' + FormatDateTime(StatusDateTimeFormat, Now) + ')');

//  Apresenta mensagens de boas vindas
//  AThread.Connection.WriteLn('&' + WelcomeMessage);
//  AThread.Connection.WriteLn('&' + 'Date/Time: ' + FormatDateTime(StatusDateTimeFormat, Now));
//  AThread.Connection.WriteLn('&' + ConnectHelpMsg);

  try
    AThread.Connection.ReadTimeout := 5000; //If they don't send it in 5 sec. then drop the connection.
    try
      Data := AThread.Connection.ReadLn;
    finally
      AThread.Connection.ReadTimeout := 5000; //Restore default
    end;

    if Data <> 'Anonymous' then
    begin
      I := sgServerConnections.Cols[2].IndexOf(Data);
      if I <= -1 then
      begin
        memLog.Lines.Add('Autorizado (' + FormatDateTime(StatusDateTimeFormat, Now) + ') ' + Data);
        AThread.Connection.WriteLn('001 -Você entrou no Chat ' + Data + ' Em :'+FormatDateTime(StatusDateTimeFormat, Now));
        AddToClientList(Data, AThread);
      end
      else
      begin
        memLog.Lines.Add('Não autorizado (' + FormatDateTime(StatusDateTimeFormat, Now) + ') ' + Data);
        AThread.Connection.WriteLn('002 -Acesso Negado. Usuário já em uso no servidor.');
        Sleep(1000);
        AThread.Connection.Disconnect;
      end;
    end
    else
    begin
      memLog.Lines.Add('Não autenticado (' + FormatDateTime(StatusDateTimeFormat, Now) + ') ' + Data);
      AThread.Connection.WriteLn('Não Autorizado. Servidor não permite usuários anônimos.');
      Sleep(1000);
      AThread.Connection.Disconnect;
    end;
  except
    on E: Exception do
    begin
      memLog.Lines.Add('Erro ocorrido (' + FormatDateTime(StatusDateTimeFormat, Now) + ') [' + E.ClassName + ']: ' + E.Message);
      AThread.Connection.WriteLn('Erro ocorrido (' + FormatDateTime(StatusDateTimeFormat, Now) + ') [' + E.ClassName + ']: ' + E.Message);
      Sleep(1000);
      AThread.Connection.Disconnect;
    end;
  end;
end;

procedure TForm_Server_Main.ChatServerSocketDisconnect(AThread: TIdPeerThread);
var
  ClientInfo: TSCSClientInfo;
begin
  ClientInfo := TSCSClientInfo(AThread.Data);
  AThread.Data := nil;
  ClientList.Delete(ClientList.IndexOf(ClientInfo));
  ClientInfo.Thread := nil;
  RemoveFromClientList(ClientInfo);
  ClientInfo.Free;
  //
  memLog.Lines.Add('Desconectado (' + FormatDateTime(StatusDateTimeFormat, Now) + ')');
end;

procedure TForm_Server_Main.ChatServerSocketException(AThread: TIdPeerThread; AException: Exception);
begin
  memLog.Lines.Add('Erro ocorrido (' + FormatDateTime(StatusDateTimeFormat, Now) + ') [' + AException.ClassName + ']: ' + AException.Message);
end;

procedure TForm_Server_Main.ChatServerSocketExecute(AThread: TIdPeerThread);
var
  Cmd: string;
  Data: string;
begin  try
    while AThread.Connection.Connected do
    begin
      if memLog.Lines.Count > 500 then memLog.Clear;

      Data := AThread.Connection.ReadLn;
      Cmd := Copy(Data,1,1);
      if Cmd = '@' then
      begin
        BrodcastMessage(Data, AThread);
        AThread.Connection.WriteLn('~' + GetLoginList);
      end
      else if Cmd = '~' then
      begin
        AThread.Connection.WriteLn('~' + GetLoginList);
      end
      else if Cmd = '!' then
      begin
        BrodcastMessage(Copy(Data,2,Length(Data)-1), nil);
        AThread.Connection.WriteLn('+OK "' + Data + '"');
      end
      else if Cmd = '"' then
      begin
        ProxyMessage(Data, AThread);
      end
      else if Cmd = '-' then
      begin
        BrodcastMessage('-' + TSCSClientInfo(AThread.Data).ScreenName, nil);
        AThread.Connection.Disconnect;
      end
      else
      begin
        BrodcastMessage('-' + TSCSClientInfo(AThread.Data).ScreenName, nil);
        AThread.Connection.WriteLn('Acesso Negado.  O Servidor esta desconectado !');
        AThread.Connection.Disconnect;
      end;
    end;
  except
    on E: Exception do
    begin          //aqui...
   //   memLog.Lines.Add('OnExecute erro (' + FormatDateTime(StatusDateTimeFormat, Now) + ') [' + E.ClassName + ']: ' + E.Message);
    end; //on
  end;
end;

procedure TForm_Server_Main.ChatServerSocketListenException(AThread: TIdListenerThread; AException: Exception);
begin
  memLog.Lines.Add('Listando erro (' + FormatDateTime(StatusDateTimeFormat, Now) + ')');
end;

procedure TForm_Server_Main.ChatServerSocketAfterCommandHandler(ASender: TIdTCPServer; AThread: TIdPeerThread);
begin
  memLog.Lines.Add('AfterCommandHandler (' + FormatDateTime(StatusDateTimeFormat, Now) + ')');
end;

procedure TForm_Server_Main.ChatServerSocketBeforeCommandHandler(ASender: TIdTCPServer; const AData: String; AThread: TIdPeerThread);
begin
  memLog.Lines.Add('BeforeCommandHandler (' + FormatDateTime(StatusDateTimeFormat, Now) + ')');
end;

procedure TForm_Server_Main.ChatServerSocketNoCommandHandler(ASender: TIdTCPServer; const AData: String; AThread: TIdPeerThread);
begin
  memLog.Lines.Add('NoCommandHandler (' + FormatDateTime(StatusDateTimeFormat, Now) + ')');
end;

procedure TForm_Server_Main.ChatServerSocketStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);
begin
  memLog.Lines.Add('Situação (' + FormatDateTime(StatusDateTimeFormat, Now) + ') ' + AStatusText);
end;

procedure TForm_Server_Main.btnStartStopServerClick(Sender: TObject);
begin
  if ChatServerSocket.Active then
  begin
    memLog.Lines.Add('Finalizando...'+timetostr(time()));
    btnDisconnectAllClick(Self);
    try
      ChatServerSocket.Active := False;
    except
      on E: Exception do
      begin
        memLog.Lines.Add('Erro ocorrido (' + FormatDateTime(StatusDateTimeFormat, Now) + ') [' + E.ClassName + ']: ' + E.Message);
      end; //on
    end;
    memLog.Lines.Add('...finalizado'+timetostr(time()));
    btnStartStopServer.Caption := 'Iniciar';
  end
  else
  begin
    memLog.Lines.Add('Iniciando...'+timetostr(time()));
    ChatServerSocket.DefaultPort := StrToInt(edServerPort.Text);
    ChatServerSocket.Bindings.Clear;
    ChatServerSocket.Active := True;
    memLog.Lines.Add('...Iniciado'+timetostr(time()));
    memLog.Lines.Add('Listando...+timetostr(time())');
    btnStartStopServer.Caption := 'Parar';
    lblServerAddress.Caption := 'Servidor: ' + ChatServerSocket.LocalName;
  end;
end;

procedure TForm_Server_Main.btnDisconnectClick(Sender: TObject);
var
  I, X: Integer;
  ClientInfo: TSCSClientInfo;
begin
  X := sgServerConnections.Row;
  I := StrToInt(sgServerConnections.Cells[0,X]);
  ClientInfo := Pointer(I);

  BrodcastMessage('-' + ClientInfo.ScreenName, nil);
  TIdPeerThread(ClientInfo.Thread).Connection.WriteLn('Desconetado pelo servidor');
  if cbSendCloseToClient.Checked then
  begin
    TIdPeerThread(ClientInfo.Thread).Connection.WriteLn('#');
  end;
  try
    TIdPeerThread(ClientInfo.Thread).Connection.Disconnect;
  except
    on E: Exception do
    begin
      memLog.Lines.Add('Erro ocorrido (' + FormatDateTime(StatusDateTimeFormat, Now) + ') [' + E.ClassName + ']: ' + E.Message);
      memLog.Lines.Add('Os processos foram finalizados');
      TIdPeerThread(ClientInfo.Thread).Stop;
    end;
  end;

end;

procedure TForm_Server_Main.btnDisconnectAllClick(Sender: TObject);
var
  List: TList;
  I: Integer;
begin
  List := ChatServerSocket.Threads.LockList;
  try
    for I := 0 to List.Count - 1 do
    begin
      try
        if cbSendCloseToClient.Checked then
        begin
          TIdPeerThread(List.Items[I]).Connection.WriteLn('#');
        end;
        TIdPeerThread(List.Items[I]).Connection.Disconnect;
      except
        //on E: EIdNotConnected do
        //begin
        //  //Dont worry about this error
        //end;
        on E: Exception do
        begin
          memLog.Lines.Add('Erro ocorrido (' + FormatDateTime(StatusDateTimeFormat, Now) + ') [' + E.ClassName + ']: ' + E.Message);
          memLog.Lines.Add('Os processos foram finalizados');
          TIdPeerThread(List.Items[I]).Stop;
        end; //on
      end; //try
    end; //for
  finally
    ChatServerSocket.Threads.UnlockList;
  end;
end;

procedure TForm_Server_Main.memLogKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then memMessageBox.Clear;
end;

procedure TForm_Server_Main.FormActivate(Sender: TObject);
begin
  pcLearnSockets.ActivePage := tsServer;
end;

procedure TForm_Server_Main.cbShowAdminMsgsClick(Sender: TObject);
begin
  if cbShowAdminMsgs.Checked then
  begin
    tsAdminMsg.TabVisible := True;
    pcLearnSockets.ActivePage := tsAdminMsg;
  end
  else
  begin
    tsAdminMsg.TabVisible := False;
  end;
end;

procedure TForm_Server_Main.FecharPrograma1Click(Sender: TObject);
begin

    application.terminate

end;

procedure TForm_Server_Main.Button1Click(Sender: TObject);
begin

 vrtrayicon1.HideMainForm;

end;

procedure TForm_Server_Main.VrTrayIcon1DblClick(Sender: TObject);
begin

 Form_Server_Main.show;

end;

procedure TForm_Server_Main.BitBtn1Click(Sender: TObject);
begin
 application.terminate;
end;

procedure TForm_Server_Main.AbrirPrograma1Click(Sender: TObject);
begin
 vrtrayicon1.ShowMainForm;
end;

procedure TForm_Server_Main.Timer1Timer(Sender: TObject);
begin
 if copy(timetostr(now()),1,2)='22' then
  begin
    memLog.Lines.Add('Finalizando...');
    btnDisconnectAllClick(Self);
    try
      ChatServerSocket.Active := False;
    except
      on E: Exception do
      begin
        memLog.Lines.Add('Erro ocorrido (' + FormatDateTime(StatusDateTimeFormat, Now) + ') [' + E.ClassName + ']: ' + E.Message);
        application.terminate;
       end; //on
    end;
    memLog.Lines.Add('...finalizado');
    application.terminate;

  end

end;

procedure TForm_Server_Main.FormShow(Sender: TObject);
begin


  if ChatServerSocket.Active then
  begin
    memLog.Lines.Add('Finalizando...');
    btnDisconnectAllClick(Self);
    try
      ChatServerSocket.Active := False;
    except
      on E: Exception do
      begin
        memLog.Lines.Add('Erro ocorrido (' + FormatDateTime(StatusDateTimeFormat, Now) + ') [' + E.ClassName + ']: ' + E.Message);
      end; //on
    end;
    memLog.Lines.Add('...finalizado');
    btnStartStopServer.Caption := 'Iniciar';
  end
  else
  begin
    memLog.Lines.Add('Iniciando...');
    ChatServerSocket.DefaultPort := StrToInt(edServerPort.Text);
    ChatServerSocket.Bindings.Clear;
    ChatServerSocket.Active := True;
    memLog.Lines.Add('...Iniciado');
    memLog.Lines.Add('Listando...');
    btnStartStopServer.Caption := 'Parar';
    lblServerAddress.Caption := 'Servidor: ' + ChatServerSocket.LocalName;
  end;

end;

procedure TForm_Server_Main.fr_senhaExit(Sender: TObject);
begin

 if fr_senha.text='senha' then
  btnStartStopServer.Enabled:=true
 else
  btnStartStopServer.Enabled:=false

end;

end.
