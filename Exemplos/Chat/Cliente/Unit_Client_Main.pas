unit Unit_Client_Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ScktComp, ExtCtrls, IdAntiFreezeBase, IdAntiFreeze,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdIOHandler,
  IdIOHandlerSocket, IdSocks, IdIntercept, IdLogBase, IdLogEvent, IdException,
  WinSkinData, VrControls, VrSystem, Menus,registry, Buttons,DBITypes,DB,DBIErrs,
  VrMatrix, jpeg, VrLabel, Animate, GIFCtrl, RxRichEd;

resourcestring
  StatusDateTimeFormat = 'mm/dd/yyyy" - "hh:nn:ss:zzz AM/PM';

type

  TForm_Client_Main = class(TForm)
    pcClientTab: TPageControl;
    tsClient: TTabSheet;
    gbBasicClientSettings: TGroupBox;
    gbConnectionAddressOrHost: TGroupBox;
    edConnectionAddress: TEdit;
    gbConnectionport: TGroupBox;
    edConnectionPort: TEdit;
    tsTextChat: TTabSheet;
    memSend: TMemo;
    lbUsers: TListBox;
    ChatClientSocket: TIdTCPClient;
    IdAntiFreeze1: TIdAntiFreeze;
    memLog: TMemo;
    IdLogEvent1: TIdLogEvent;
    IndicatorResetTimer: TTimer;
    GroupBox1: TGroupBox;
    edScreenName: TEdit;
    Label6: TLabel;
    cbAutoLogin: TCheckBox;
    cbSpaceMessages: TCheckBox;
    cbRecordSentMessages: TCheckBox;
    Label1: TLabel;
    SkinData1: TSkinData;
    Label3: TLabel;
    Edit1: TEdit;
    VrTrayIcon1: TVrTrayIcon;
    PopupMenu1: TPopupMenu;
    Abrir1: TMenuItem;
    Fechar1: TMenuItem;
    Image2: TImage;
    BitBtn1: TBitBtn;
    Image1: TImage;
    Image4: TImage;
    Memo1: TMemo;
    BitBtn2: TBitBtn;
    tempo: TTimer;
    Memo2: TMemo;
    VrLabel1: TVrLabel;
    Image3: TImage;
    BitBtn3: TBitBtn;
    ff: TGroupBox;
    log: TRichEdit;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    editor: TRxRichEdit;
    historico: TGroupBox;
    Button2: TButton;
    Memo3: TMemo;
    BitBtn6: TBitBtn;
    procedure btnConnectDisconnectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ChatClientSocketConnected(Sender: TObject);
    procedure ChatClientSocketDisconnected(Sender: TObject);
    procedure memSendKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure IdLogEvent1Connect(ASender: TIdConnectionIntercept);
    procedure IdLogEvent1Disconnect(ASender: TIdConnectionIntercept);
    procedure IdLogEvent1Receive(ASender: TIdConnectionIntercept; AStream: TStream);
    procedure IdLogEvent1Send(ASender: TIdConnectionIntercept; AStream: TStream);
    procedure IdLogEvent1Status(ASender: TComponent; const AText: String);
    procedure memChatTextKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ChatClientSocketStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);
    procedure IndicatorResetTimerTimer(Sender: TObject);
    procedure Fechar1Click(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure memChatTextChange(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure tempoTimer(Sender: TObject);
    procedure RichEdit1Change(Sender: TObject);
    procedure RichEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editorChange(Sender: TObject);
    procedure editorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure RxRichEdit1Change(Sender: TObject);
    procedure RxRichEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TStatusThread = class(TThread)
  private
    FClientConnected: Boolean;
    FClientThreadTerminated: Boolean;
    FClientThreadSuspended: Boolean;
    procedure UpdateClientThreadStatus;
  protected
    procedure Execute; override;
  end;

  TClientThread = class(TThread)
  private
    Msg: string;
    procedure ReceivedLine;
    procedure MessageToLog;
  protected
    procedure Execute; override;
  end;

  TScrollingTextInfoThread = class(TThread)
  private
    FReset: Boolean;
    FAlert: Boolean;
    FAlertMsg: string;
    FAlertCount: Integer;
    procedure SetCaption;
    procedure UpdateInfoAndScroll;
  protected
    procedure Execute; override;
  published
    property Reset: Boolean read FReset write FReset;
    property Alert: Boolean read FAlert write FAlert;
    property AlertMsg: string read FAlertMsg write FAlertMsg;
  end;


var
  Form_Client_Main: TForm_Client_Main;
  ClientThread: TClientThread;
  StatusThread: TStatusThread;
  ScrollingTextInfoThread: TScrollingTextInfoThread;
  WindowsDir: string;

implementation

uses Unit2, Unit3;

{$R *.DFM}

Function NomeComputador : String;
var
 lpBuffer : PChar;
 nSize : DWord;
const
 Buff_Size = MAX_COMPUTERNAME_LENGTH + 1;
begin
 nSize := Buff_Size;
 lpBuffer := StrAlloc(Buff_Size);
 GetComputerName(lpBuffer,nSize);
 Result := String(lpBuffer);
 StrDispose(lpBuffer);
end;


function UserName : String;
var
 lpBuffer : Array[0..20] of Char;
 nSize    : dWord;
 Achou    : boolean;
 erro     : dWord;
begin
 nSize      := 120;
 Achou      := GetUserName(lpBuffer,nSize);
if (Achou) then
 begin
   result   := lpBuffer
 end
else
 begin
  result :='Anonymous';
 end;
end;

procedure Crialog(texto_log:string);
var
  log: textfile;
begin
  try
  AssignFile(log, 'c:\windows\chat.log');
  if not FileExists('c:\windows\chat.log') then Rewrite(log,'c:\windows\chat.log');
   Append(log);
   WriteLn(log, texto_log);
  finally
   CloseFile(log);
  end;
end;

procedure TForm_Client_Main.FormCreate(Sender: TObject);
begin

  vrtrayicon1.Hint:=application.title;

  ClientThread := TClientThread.Create(True);
  StatusThread := TStatusThread.Create(False);
  StatusThread.FreeOnTerminate := True;

end;

procedure TForm_Client_Main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ScrollingTextInfoThread.Terminate;
  repeat
    Application.ProcessMessages;
  until ScrollingTextInfoThread.Terminated;

  StatusThread.Terminate;
  repeat
    Application.ProcessMessages;
  until StatusThread.Terminated;

  ClientThread.FreeOnTerminate := True;
  ClientThread.Terminate;
  repeat
    Application.ProcessMessages;
  until ClientThread.Terminated;

  if ChatClientSocket.Connected then
  begin
    ChatClientSocket.Disconnect;
  end;
  repeat
    Application.ProcessMessages;
  until not ChatClientSocket.Connected;

  Action := caFree;
end;

procedure TForm_Client_Main.btnConnectDisconnectClick(Sender: TObject);
begin
end;

////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TForm_Client_Main.ChatClientSocketConnected(Sender: TObject);
begin
  if ClientThread.Suspended then
  begin
    ClientThread.Resume;
  end;

  if cbAutoLogin.Checked then
  begin
    memLog.Lines.Add('Usuario (' + FormatDateTime(StatusDateTimeFormat, Now) + ')');
    ChatClientSocket.WriteLn(edScreenName.Text);
    memLog.Lines.Add('Bem vindo ao Chat (' + FormatDateTime(StatusDateTimeFormat, Now) + ')');
    ChatClientSocket.WriteLn('@' + edScreenName.Text);
  end;
end;

procedure TForm_Client_Main.ChatClientSocketDisconnected(Sender: TObject);
begin

  if not ClientThread.Suspended then
  begin
    ClientThread.Suspend;
  end;
  memLog.Lines.Add('Desconectado (' + FormatDateTime(StatusDateTimeFormat, Now) + ')');
end;

procedure TForm_Client_Main.ChatClientSocketStatus(ASender: TObject; const AStatus: TIdStatus; const AStatusText: String);
begin
  memLog.Lines.Add('Situação (' + FormatDateTime(StatusDateTimeFormat, Now) + ') ' + AStatusText);
end;

////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TForm_Client_Main.IdLogEvent1Connect(ASender: TIdConnectionIntercept);
begin
  memLog.Lines.Add('Log (' + FormatDateTime(StatusDateTimeFormat, Now) + ') Conectou');
end;

procedure TForm_Client_Main.IdLogEvent1Disconnect(ASender: TIdConnectionIntercept);
begin
  memLog.Lines.Add('Log (' + FormatDateTime(StatusDateTimeFormat, Now) + ') Desconectou');
end;

procedure TForm_Client_Main.IdLogEvent1Receive(ASender: TIdConnectionIntercept; AStream: TStream);
begin

  memLog.Lines.Add(FormatDateTime(StatusDateTimeFormat, Now) + ') Recebeu'+memSend.Text);

end;

procedure TForm_Client_Main.IdLogEvent1Send(ASender: TIdConnectionIntercept; AStream: TStream);
begin
  memLog.Lines.Add(FormatDateTime(StatusDateTimeFormat, Now) + ') Enviou :'+memSend.Text);
end;

procedure TForm_Client_Main.IdLogEvent1Status(ASender: TComponent; const AText: String);
begin
end;

////////////////////////////////////////////////////////////////////////////////////////////////////

{ TClientThread }

procedure TClientThread.Execute;
begin
  while not Terminated do
  begin
    try
      if Form_Client_Main.ChatClientSocket.Connected then
      begin
        Msg := Form_Client_Main.ChatClientSocket.ReadLn;
        Synchronize(ReceivedLine);
      end;
    except
      on E: EIdConnClosedGracefully do
      begin
        Msg := 'Erro Ocorrido: [' + E.ClassName + ']: ' + E.Message;
        Synchronize(MessageToLog);
      end;
      on E: EIdSocketError do
      begin
        Msg := 'Erro Ocorrido: [' + E.ClassName + ']: ' + E.Message;
        Synchronize(MessageToLog);
        Suspend;
      end;
      on E: Exception do
      begin
        Msg := 'Erro Ocorrido: [' + E.ClassName + ']: ' + E.Message;
        Synchronize(MessageToLog);
        Terminate;
      end;
    end;
  end;
end;

procedure TClientThread.MessageToLog;
begin
  Form_Client_Main.memLog.Lines.Add(Msg);
end;                                

procedure TClientThread.ReceivedLine;
var
  usuario,Cmd: string;
  I,x: Integer;

begin
  Cmd := Copy(Msg,1,1);
  with Form_Client_Main do
  begin
    if Cmd = '@' then
    begin
      I := lbUsers.Items.IndexOf(Copy(Msg,2,Length(Msg)-1));
      if I <= -1 then
      begin
        I := lbUsers.Items.IndexOf('-----');
        if I <= -1 then
        begin
          lbUsers.Items.Add(Copy(Msg,2,Length(Msg)-1));
        end
        else
        begin
          lbUsers.Items[I] := Copy(Msg,2,Length(Msg)-1);
        end;
      end;
    end
    else if (Cmd = '-') and (Copy(Msg,1,2) <> '--') then
    begin
      I := lbUsers.Items.IndexOf(Copy(Msg,2,Length(Msg)-1));

      if I > -1 then  //bloco alterado luciano
      begin
        lbUsers.Items[I] := '-----';
      end;
    end
    else if Cmd = '~' then
    begin
     lbUsers.Items.CommaText := Copy(Msg,2,Length(Msg)-1);
     lbUsers.Items[0] := 'Administrator';
    end
    else if Cmd = '#' then
    begin
      Form_Client_Main.Close;
    end
//    else if Cmd = '!' then
//    begin
//      ScrollingTextInfoThread.Suspend;
//      ScrollingTextInfoThread.Reset := True;
//      ScrollingTextInfoThread.Alert := True;
//      ScrollingTextInfoThread.AlertMsg := 'Administrador Alerta!.....' + Copy(Msg,2,Length(Msg)-1);
//      ScrollingTextInfoThread.Resume;
//    end
    else if Cmd = '&' then //Welcome message or part of welcome message
    begin
//      editor.Lines.Add(Copy(Msg,2,Length(Msg)-1)); Mensagem de Boas Vindas.
    end
    else
    begin
       //--------------------------
      // Recebeu texto e insere.

    if (copy(Msg,1,3)<>'001') and (copy(Msg,1,3)<>'002') then
     begin
      usuario:='';
      for x:=1 to length(Msg)-1 do
       begin
        if copy(Msg,x,1)<>'>' then
         usuario:=usuario+copy(Msg,x,1)
        else if copy(Msg,x,1)='>' then
         break    // ou exit
       end;

        editor.SelAttributes.BackColor:=$008C8CFF;  // vermelho
        editor.SelAttributes.color:=clblack;
        editor.SelAttributes.Size:=10;
        editor.Lines.Add('Recebeu de : ' + usuario +'    As '+timetostr(now()) +
                         '                                                  '+
                         '                                                  '+
                         '                                                  ');
        editor.SelAttributes.Size:=8;
        editor.SelAttributes.BackColor:=$00CEFFFF;
        editor.SelAttributes.color:=clred;
        editor.Lines.Add(copy(Msg,length(usuario)+12,300));

        crialog('De '+usuario+ ' em '+datetostr(date())+'-'+timetostr(now())+' '+copy(Msg,length(usuario)+12,300)); // Vamos criar log de Recepção

      if cbSpaceMessages.Checked then
      begin
        editor.Lines.Add('');
      end;
     end
    else if copy(Msg,1,3)='002' then
     begin
      editor.lines.add('Atenção ! Ligue para Informatica )');
      editor.lines.add('Peça para desconectar você do Chat');
      editor.lines.add('');
      editor.lines.add('Em seguida feche e abra novamente este programa !');
     end;
    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////

{ TStatusThread }

procedure TStatusThread.Execute;
begin
  while not Terminated do
  begin
    try
      Sleep(250);
      FClientConnected := Form_Client_Main.ChatClientSocket.Connected;
      FClientThreadTerminated := ClientThread.Terminated;
      FClientThreadSuspended := ClientThread.Suspended;
      Synchronize(UpdateClientThreadStatus);
    except
      Terminate;
    end;
  end;
end;

procedure TStatusThread.UpdateClientThreadStatus;
begin
  with Form_Client_Main do
  begin
    if FClientConnected then
    begin
    end
    else
    begin
      if lbUsers.Count > 0 then
      begin
        lbUsers.Clear;
      end;
    end;

    if not FClientThreadTerminated then
    begin
    end
    else
    begin
    end;

    if FClientThreadSuspended then
    begin
    end
    else
    begin
    end;
  end; //with
end;

////////////////////////////////////////////////////////////////////////////////////////////////////

{ TScrollingTextInfoThread }

procedure TScrollingTextInfoThread.Execute;
begin
  FReset := False;
  Synchronize(SetCaption);
  while not Terminated do
  begin
    try
      Sleep(15);
      if FReset then
      begin
        Synchronize(SetCaption);
        FReset := False;
      end;

      if FAlert then
      begin
        if FAlertCount <= -1 then
        begin
          FAlert := False;
          FReset := True;
        end;
      end;

      Synchronize(UpdateInfoAndScroll);
    except
      Terminate;
    end;
  end;
end;

procedure TScrollingTextInfoThread.SetCaption;
begin
  with Form_Client_Main do
  begin
    if ChatClientSocket.Connected then
    begin
      if not FAlert then
      begin
      end
      else
      begin
        FAlertCount := 3;
//        lblInfo.text := FAlertMsg;
      end;
    end
    else
    begin
//      lblInfo.text := '    ' + ChatClientSocket.LocalName + '.....' ;
    end;
  end;
end;

procedure TScrollingTextInfoThread.UpdateInfoAndScroll;
begin
  with Form_Client_Main do
  begin
    //lblInfo.Invalidate;
//    if (lblInfo.Left + editor.Width) <= editor.Left then
//    begin
//      lblInfo.Left := tsTextChat.Width;
//      Dec(FAlertCount);
//    end;
  end;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TForm_Client_Main.memSendKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  SendData,destinatarios: string;
  Receivers: TStrings;
  I: Integer;
begin
  if Key = VK_Return then

  begin
    if ChatClientSocket.Connected then
    begin
     Receivers := TStringList.Create;

        for I := 0 to lbUsers.Items.Count - 1 do
        begin
          if lbUsers.Selected[I] then Receivers.Add(lbUsers.Items[I]);
        end;

        if Receivers.Text <> '' then                //aqui..
        begin
          SendData := '"' + edScreenName.Text + '",' +   //Sender
                      '"' + Receivers.CommaText + '",' + //Receiver(s)
                      '"' +timetostr(now())+' '+memSend.Text + '"';          //Message

      editor.SelAttributes.BackColor:=$00EEC0A2;  //Azul
      editor.SelAttributes.color:=clblack;
      editor.SelAttributes.Size:=10;
      destinatarios:=Receivers.CommaText;
      editor.Lines.Add('Enviou as : '+timetostr(now())+'        Para : '+Receivers.CommaText+
                       '                                                  '+
                       '                                                  '+
                       '                                        ');

      editor.SelAttributes.Size:=8;
      editor.SelAttributes.BackColor:=$00CEFFFF;
      editor.SelAttributes.color:=clblue;

      ChatClientSocket.WriteLn(SendData);
        end;

        Receivers.Free;
    end;
    if cbRecordSentMessages.Checked then
    begin
      // Envio de Texto do Chat

//      editor.SelAttributes.BackColor:=$00EEC0A2;  //Azul
//      editor.SelAttributes.color:=clblack;
//      editor.SelAttributes.Size:=12;
//      editor.Lines.Add('Enviou para : '  +  '       as '+timetostr(now())+'      '+
//                       '                                                  '+
//                       '                                                  '+
//                       '                                        ');
      editor.SelAttributes.Size:=8;
      editor.SelAttributes.BackColor:=$00CEFFFF;
      editor.SelAttributes.color:=clblue;
      editor.Lines.Add(memSend.Text);

      crialog('Enviou : '+datetostr(date())+'-'+timetostr(now())+' Para : '+destinatarios+' '+memSend.Text); //Vamos criar logo de Envio

      if cbSpaceMessages.Checked then
      begin
        editor.Lines.Add('');
      end;
    end;
    memSend.Text := '';
  end;
end;

procedure TForm_Client_Main.memChatTextKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_Delete then
  begin
    editor.Text := '';
  end;
end;

procedure TForm_Client_Main.IndicatorResetTimerTimer(Sender: TObject);
begin
//  Form_Client_Main.Ind04.Brush.Color := clBlack;
//  Form_Client_Main.Ind05.Brush.Color := clBlack;
end;

////////////////////////////////////////////////////////////////////////////////////////////////////

procedure TForm_Client_Main.Fechar1Click(Sender: TObject);
begin
 application.terminate;
end;

procedure TForm_Client_Main.Abrir1Click(Sender: TObject);
begin
 vrtrayicon1.ShowMainForm;
end;

procedure TForm_Client_Main.FormShow(Sender: TObject);
begin

 memo1.lines.loadfromfile('c:\chat\lmchatcliente.ini');

// ==========================================
// Dados para Conexão
// ==========================================

 begin
  if FileExists('c:\chat\nome.dat') then
   begin
    memo2.lines.loadfromfile('c:\chat\nome.dat');
    edScreenName.text:=trim(memo2.Text);
   end
  else
   begin
    edScreenName.text:=nomecomputador
   end;
 end;

 edConnectionAddress.Text:=trim(memo1.Text);
 ChatClientSocket.Port := 4123; //StrToInt(edConnectionPort.Text); porta

 memsend.SetFocus;

//-- Inicio da Conexão

  try
    if not ChatClientSocket.Connected then
    begin
      if (edConnectionAddress.Text <> '') and
         (edConnectionPort.Text <> '') then
      begin
        ChatClientSocket.Host := edConnectionAddress.Text;

        ChatClientSocket.Connect;

        editor.Text := '';
        memSend.Text := '';
        pcClientTab.ActivePage := tsTextChat;

      end
      else
      begin
        ShowMessage('Informe os dados corretamente para entrar no Chat.');
      end;
    end
    else
    begin
      ChatClientSocket.WriteLn('-' + edScreenName.Text);
      ChatClientSocket.Disconnect;
    end;
  finally
  end;

//-- Final da Conexão

// vrtrayicon1.HideMainForm; // Vamos minimizar

end;

procedure TForm_Client_Main.Button1Click(Sender: TObject);
begin
  try
    if not ChatClientSocket.Connected then
    begin
      if (edConnectionAddress.Text <> '') and
         (edConnectionPort.Text <> '') then
      begin
        ChatClientSocket.Host := edConnectionAddress.Text;
        ChatClientSocket.Port := StrToInt(edConnectionPort.Text);

        ChatClientSocket.Connect;

        editor.Text := '';
        memSend.Text := '';
        pcClientTab.ActivePage := tsTextChat;
      end
      else
      begin
        ShowMessage('Informe os dados corretamente para entrar no Chat.');
      end;
    end
    else
    begin
      ChatClientSocket.WriteLn('-' + edScreenName.Text);
      ChatClientSocket.Disconnect;
    end;
  finally
//    ScrollingTextInfoThread.Resume;
  end;

end;

procedure TForm_Client_Main.BitBtn1Click(Sender: TObject);
begin
  ChatClientSocket.WriteLn('~');
end;

procedure TForm_Client_Main.memChatTextChange(Sender: TObject);
begin

  vrtrayicon1.ShowMainForm;
  Form_Client_Main.Show;
//  tempo.Enabled:=true;

end;

procedure TForm_Client_Main.BitBtn2Click(Sender: TObject);
begin
 vrtrayicon1.HideMainForm;
end;

procedure TForm_Client_Main.tempoTimer(Sender: TObject);
var
  SendData: string;
  Receivers: TStrings;
  I: Integer;

begin

 editor.Lines.Add(edScreenName.Text +' '+timetostr(now())+'> '+ 'Desculpe não estou no momento..');
 tempo.enabled:=false;

    if ChatClientSocket.Connected then
    begin
        Receivers := TStringList.Create;

        for I := 0 to lbUsers.Items.Count - 1 do
        begin
          if lbUsers.Selected[I] then Receivers.Add(lbUsers.Items[I]);
        end;

        if Receivers.Text <> '' then
        begin
          SendData := '"' + edScreenName.Text + '",' +   //Sender
                      '"' + Receivers.CommaText + '",' + //Receiver(s)
                      '"' +timetostr(now())+' '+memSend.Text + '"';          //Message

          ChatClientSocket.WriteLn(SendData);
        end;

        Receivers.Free;
    end;
    if cbRecordSentMessages.Checked then
    begin
   //aqui2

      editor.SelAttributes.Size:=8;
      editor.SelAttributes.BackColor:=$00CEFFFF;
      editor.SelAttributes.color:=clblue;

      editor.Lines.Add(edScreenName.Text +' '+timetostr(now())+'> '+ memSend.Text);

      
      if cbSpaceMessages.Checked then
      begin
        editor.Lines.Add('');
      end;
    end;
    memSend.Text := '';

end;
procedure TForm_Client_Main.RichEdit1Change(Sender: TObject);
begin

  vrtrayicon1.ShowMainForm;
  Form_Client_Main.Show;
//  tempo.Enabled:=true;

end;

procedure TForm_Client_Main.RichEdit1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  if Key = VK_Delete then
  begin
    editor.Text := '';
  end;

end;

procedure TForm_Client_Main.editorChange(Sender: TObject);
begin

  vrtrayicon1.ShowMainForm;
  Form_Client_Main.Show;

end;

procedure TForm_Client_Main.editorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_Delete then
  begin
    editor.Text := '';
  end;

end;

procedure TForm_Client_Main.BitBtn3Click(Sender: TObject);
begin
 historico.visible:=true;
end;

procedure TForm_Client_Main.BitBtn4Click(Sender: TObject);
begin
 log.lines.loadfromfile('c:\windows\chat.log');
end;

procedure TForm_Client_Main.BitBtn5Click(Sender: TObject);
begin
 ff.visible:=false;
end;

procedure TForm_Client_Main.RxRichEdit1Change(Sender: TObject);
begin

  vrtrayicon1.ShowMainForm;
  Form_Client_Main.Show;
//  tempo.Enabled:=true;

end;

procedure TForm_Client_Main.RxRichEdit1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin

  if Key = VK_Delete then
  begin
    editor.Text := '';
  end;


end;

procedure TForm_Client_Main.Button2Click(Sender: TObject);
begin
 historico.Visible:=false;
end;

procedure TForm_Client_Main.BitBtn6Click(Sender: TObject);
begin
 memo3.Lines.LoadFromFile('c:\windows\chat.log');
end;

end.


