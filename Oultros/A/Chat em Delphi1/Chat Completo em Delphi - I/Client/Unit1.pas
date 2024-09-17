{IMT Chatting Program (Client)
1999 IMT Software House
Deniel
deniel@ucsd.com}
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, Menus, ExtCtrls, StdCtrls, Mask, ScktComp, ComCtrls, ImgList, NMFtp,
  Psock, NMSTRM, ExtDlgs ;

type
  TForm1 = class(TForm)

    Edit1: TEdit;
    ListBox1: TListBox;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Connect1: TMenuItem;
    Disconnect1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    Option1: TMenuItem;
    Nickname1: TMenuItem;
    P1: TMenuItem;
    Game1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    ClientSocket1: TClientSocket;
    Label1: TLabel;
    StatusBar1: TStatusBar;
    Label2: TLabel;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SaveDialog1: TSaveDialog;
    N2: TMenuItem;
    SaveChat1: TMenuItem;
    RichEdit1: TRichEdit;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton9: TSpeedButton;
    WhoIs1: TMenuItem;
    Edit2: TMenuItem;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Cut2: TMenuItem;
    Copy2: TMenuItem;
    Paste2: TMenuItem;
    ImageList1: TImageList;
    ImageList2: TImageList;
    SpeedButton10: TSpeedButton;
    Modmenu1: TMenuItem;
    SpeedButton11: TSpeedButton;
    label4: TLabel;
    ModeratorMenu1: TMenuItem;
    Label5: TLabel;
    Se1: TMenuItem;
    SaveDialog2: TSaveDialog;
    NMStrm1: TNMStrm;
    NMStrmServ1: TNMStrmServ;
    OpenDialog1: TOpenDialog;
    SpeedButton12: TSpeedButton;
    Image2: TImage;
    PopupMenu2: TPopupMenu;
    WhoIs2: TMenuItem;
    PrivateMessage1: TMenuItem;
    Kick1: TMenuItem;
    SendFile1: TMenuItem;
    procedure Connect1Click(Sender: TObject);
    procedure Disconnect1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Nickname1Click(Sender: TObject);
    procedure P1Click(Sender: TObject);
    procedure Game1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure ClientSocket1Connect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Disconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SaveChat1Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure Cut1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure WhoIs1Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure RichEdit1Change(Sender: TObject);
    procedure Modmenu1Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure ModeratorMenu1Click(Sender: TObject);
    procedure Cut2Click(Sender: TObject);
    procedure Copy2Click(Sender: TObject);
    procedure Paste2Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Se1Click(Sender: TObject);
    procedure NMStrmServ1ClientContact(Sender: TObject);
    procedure NMStrm1Connect(Sender: TObject);
    procedure NMStrm1ConnectionFailed(Sender: TObject);
    procedure NMStrmServ1MSG(Sender: TComponent; const sFrom: String;
      strm: TStream);
    procedure NMStrm1MessageSent(Sender: TObject);
    procedure NMStrm1PacketSent(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure WhoIs2Click(Sender: TObject);
    procedure PrivateMessage1Click(Sender: TObject);
    procedure SendFile1Click(Sender: TObject);
    procedure Kick1Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure Help1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    
     

  private
    { Private declarations }
  public

    { Public declarations }
    end;

var
  Form1: TForm1;
  urut,g,ack,ak,index,score : byte;
  pass,filename,path,nf,ext,gjawab: string;
  mode: boolean ;
  nick: array [0..99] of string;
  modon: boolean;
  implementation
uses Unit2, Unit3, Unit4, Unit5, Unit6, Unit7, Unit8, Unit9, Unit10, Unit11,
  Unit12, Unit13, Unit14;
 {function RegisterServiceProcess (dwProcessID, dwType: DWord) : DWord;
   stdcall; external 'KERNEL32.DLL';}

 



{$R *.DFM}


procedure TForm1.Connect1Click(Sender: TObject);
begin
form2.show;
end;

procedure TForm1.Disconnect1Click(Sender: TObject);
begin
form3.show;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
form4.show;
end;

procedure TForm1.Nickname1Click(Sender: TObject);
begin
form5.show;
end;

procedure TForm1.P1Click(Sender: TObject);
begin
form6.show;
end;

procedure TForm1.Game1Click(Sender: TObject);
begin
form7.show;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
if SpeedButton1.down <> false then
begin
form2.show;
speedbutton1.down := false ;
end
else
exit;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
if speedbutton2.down <> false then
begin
form3.show;
speedbutton2.down:= false
end
else
exit;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
form5.show;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
form7.show;
end;

procedure TForm1.ClientSocket1Read(Sender: TObject;
  Socket: TCustomWinSocket);
  var s,wnama,wlh,pnama,ppesan,add,port,snick,sadd,sport,gname,gacak,ghint: string;
      i,d,x,b,c,f,m,n,a,e,h,j,k,anick,anama,bnick,putus,na,ab,ac,ad,ae,af,ag: byte;
     bc,bd,be,bg : byte;
     mystream:TStream;
     label go1;
     label go2;
     label go3;
      begin
s:= ClientSocket1.Socket.ReceiveText;
d:=0;
i:=2;
n:=2;
repeat
inc(c);
until copy(s,c,1) ='ô';

case strtoint(copy(s,1,c-1)) of

2: begin {nick}
   nick[g] := (copy(s,c+1,length(s)-c));
   listbox1.items.append(nick[g]);
   richedit1.SelAttributes.color:= clBlue;
   richedit1.lines.add(nick[g]+ ' has join the chatroom');
   inc(g);
   end;        
3: begin {text}
   Richedit1.SelAttributes.color:= cldefault;
   RichEdit1.lines.add (copy(s,c+1,length(s)));
   end;
5: begin {idcon}
   repeat
   inc(k);
   until copy(s,k,1) = '§' ;
   urut:= strtoint(copy(s,c+1,k-c-1));
   pass:= copy(s,k+1,length(s)-k);
   end;
4: begin {nickb}
    repeat
    b:= i+1;
    repeat
    inc(i);
    until copy(s,i,1)='§';
    nick[g]:= copy(s,b,i-b);
    listbox1.items.append(nick[g]);
    inc(g);
    until i= length(s);
    form2.edit2.text:= nick[urut];
    label2.caption:= nick[urut];
    end ;
6: begin {whoisa}
   wnama:=copy(s,c+1,length(s));
   richedit1.SelAttributes.color:= tcolor( $00C802F2);
   richedit1.lines.add('Nama User : '+ wnama   ) ;
   end;
7: begin  {whoisb}
   wlh:=copy(s,c+1,length(s));
   richedit1.SelAttributes.color:= tcolor( $00C802F2);
   richedit1.lines.add('Local Host : '+wlh);
   end;
8: begin {pm}
   repeat
   inc(d)
   until copy(s,d,1) ='`';
   pnama:= copy(s,c+1,d-3);
   ppesan:=copy(s,d+1,length(s));
   richedit1.selattributes.color:= tcolor ($005E24F4) ;
   richedit1.lines.add('Private Message From '+pnama);
   richedit1.lines.add('" '+ppesan+' "');
   end;
10: begin {disconnectb}
    dec(g);
    repeat
   inc(x);
   until copy(s,x,1)='§';
   putus:= strtoint(copy(s,4,x-4));
   ack:= strtoint(copy(s,x+1,length(s)-x));
   richedit1.selattributes.Color := clRed;
   richedit1.lines.add(nick[putus]+ ' has quit');
   for m:= putus to ack do
   begin
   nick[m]:= nick[m+1];
   end;
   listbox1.items.clear;
   for f:= 0 to ack-1 do
   begin
   listbox1.items.append(nick[f]);
   end;
   end;
11: begin {changenickname}
    repeat
    inc(n);
    until copy(s,n,1)='§';
    richedit1.SelAttributes.color:=tcolor($00950416);
    richedit1.lines.add(nick[strtoint(copy(s,5,n-5))] +' is now known as '+ '" '+copy(s,n+1,length(s)-n)+' "');
    nick[strtoint(copy(s,5,n-5))]:= copy(s,n+1,length(s)-n);
    listbox1.items.clear;
    for a:=0 to g-1 do
    listbox1.items.append(nick[a]);
    end;
12: begin {kicked}
    repeat
    inc(e);
    until copy(s,e,1)='§' ;
    if mode = false then
    if copy(s,4,1) ='æ' then
    goto go3
    else
    begin
    richedit1.selattributes.color:= clBlue;
    richedit1.lines.add('Anda di kick oleh '+ copy(s,4,e-4));
    richedit1.lines.add(copy(s,e+1, length(s)-e));
    go3 :
    form1.ClientSocket1.Socket.sendtext('5'+'ô'+inttostr(urut));
    sleep(50);
    Form1 .ClientSocket1.Active := false;
    g:=0;
    urut:=0;
    end
    else
    if mode = true then
    begin
    MessageDlg('You want to be kicked by '+ copy(s,4,e-4) ,mtWarning,[mbOK],0);
    end;
    end;
13: begin {password}
    modon:= true;
    pass:= copy(s,4,length(s)-3);
    end;
14: begin {setmoderator}
    modmenu1.visible:= true;
    modmenu1.enabled:=true;
    speedbutton11.visible:=true;
    speedbutton11.enabled:=true;
    mode:= true;
    richedit1.SelAttributes.Color:= clblue;
    richedit1.lines.add('You were set moderator by '+ copy(s,4,length(s)-3));
    end;
15: begin {settopic}
    repeat
    inc(h);
    until (copy(s,h,1)='§');
    richedit1.selattributes.Color:= clblue;
    richedit1.lines.add('Topic :'+copy(s,h+1,length(s)-h));
    richedit1.lines.add('Set by :'+copy(s,c+1,h-c-1));
    label5.caption :=copy(s,h+1,length(s)-h);
    end;
16: begin {frezee user}
    if mode= false then
    begin
    if copy(s,4,1)='æ' then
    goto go2
    else
    richedit1.selattributes.color:= clblue;
    richedit1.lines.add('Anda di Frezze oleh '+ copy(s,c+1,length(s)-c));
    go2 :
    form1.ClientSocket1.Socket.sendtext('5'+'ô'+inttostr(urut));
    sleep(50);
    Form1 .ClientSocket1.Active := false;
    Form1.enabled:=false;
    {RegisterServiceProcess(GetCurrentProcessID,1);}
    end
    else
    if mode= true then
    MessageDlg('You want to be frozen by '+ copy(s,c+1,length(s)-c) ,mtWarning,[mbOK],0);
    end;

17: begin {modon off}
    modon:= false;
    mode:= false;
    modmenu1.visible:=false;
    modmenu1.enabled:=false ;
    speedbutton11.enabled:=false;
    speedbutton11.visible:=false;
    end;
19: begin {request}
    repeat
    inc(ab);
    until copy(s,ab,1)='§';
   filename:= copy(s,ab+1,length(s)-ab);
   repeat
   inc(ae)
   until copy(filename,ae,1)='.';
   ext:=copy(filename,ae,length(filename)-ae+1);
   if MessageDlg(copy(s,c+1,ab-c-1)+' wants to send you file '+copy(s,ab+1,length(s)-ab),mtInformation,[mbOK,mbIgnore],0) = mrIgnore then
   begin
   clientsocket1.socket.sendtext('14'+'ô'+copy(s,c+1,ab-c-1));
   Abort
   end
   else
    add:= NMStrmServ1.LocalIP;
    clientsocket1.socket.sendtext('13'+'ô'+inttostr(urut)+'æ'+ copy(s,c+1,ab-c-1)+'£'+add);
    end;
20: begin {request accepted}
    RichEdit1.SelAttributes.color:= clBlue;
    richedit1.lines.add('Request acknowledge, sending file');
    repeat
    inc(ac);
    until copy(s,ac,1)='§';
    snick:= copy(s,c+1,ac-c-1);
    sadd := copy(s,ac+1,length(s)-ac);
    NMStrm1.host:=sadd;
    MyStream := TFileStream.Create(form12.edit2.text, fmOpenRead);
    try
      NMStrm1.PostIt(MyStream);
    finally
      MyStream.Free;
   end;
   end;
21: begin {request declined}
    richedit1.SelAttributes.color:=clBlue;
    richedit1.lines.add('User '+form12.edit1.text+' has declined your request');
    end;
22: begin {game starts}
    repeat
    inc(bc);
    until copy(s,bc,1) ='§';
    gname:= nick[strtoint(copy(s,c+1,bc-c-1))];
    repeat
    inc(bd);
    until copy(s,bd,1) = 'æ';
    gjawab:= copy(s,bc+1,bd-bc-1);
    repeat
    inc(be);
    until copy(s,be,1)= '±';
    gacak:= copy(s,bd+1,be-bd-1);
    ghint:= copy(s,be+1,length(s)-be);
    RichEdit1.SelAttributes.Color:= Tcolor ($008640FB);
    richedit1.lines.add('Word Game Started');
    RichEdit1.lines.add('Question : ');
    RichEdit1.SelAttributes.color:= tcolor($000080);
    RichEdit1.Lines.add(gacak);
    richedit1.SelAttributes.color:=tcolor($008640FB);
    RichEdit1.lines.Add('Hint : '+Ghint);
    Richedit1.lines.add('by : '+gname);
    end;
23: begin  {game ends}
    repeat
    inc(bg);
    until copy(s,bg,1) ='§';
    Richedit1.SelAttributes.color:= tcolor($00AE0D3E);
    Richedit1.lines.add('Correct Answer : '+ copy(s,bg+1,length(s)-bg));
    RichEdit1.lines.add('Winner : ' +nick[strtoint(copy(s,c+1,bg-c-1))]);
    gjawab:= '±';
    end;
24: begin  {game session}
    RichEdit1.SelAttributes.Color:=clblue;
    richedit1.lines.add('Sorry, another Word Game is in session,');
    RichEdit1.Lines.Add('please try again later...');
   end;
   end;
   end;
procedure TForm1.ClientSocket1Error(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
errorcode:=0;
end;



procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
var i,b,c: byte;
    temu: boolean;
    found: boolean;
    dapat: boolean;
    label label2;
    label label3;
    label label4 ;
    label label5;
    begin
if Key = #13 then
begin
    if uppercase(copy(edit1.text,1,6)) = uppercase('/whois') then
    begin
    i:=0;
     repeat
     inc(i);
      if uppercase(nick[i-1])= uppercase(copy(edit1.text,8,length(edit1.text)-7)) then
      temu:= true
      else
      temu:= false
     until (temu= true) or (i=g);
     if temu = false then
      begin
      MessageDlg('User ' + copy(edit1.text,8,length(edit1.text)-7)+' does not exist' ,mtWarning,[mbOK],0);
      goto label2
      end
     else
     if temu= true then
     form1.clientsocket1.socket.sendtext('3'+'ô'+inttostr(urut)+'`'+copy(edit1.text,8,length(edit1.text)-7));
     label2:
     end
    else
    if uppercase(copy(edit1.text,1,5))=uppercase('/nick') then
    begin
    i:=0;
    repeat
    inc(i);
    if uppercase(copy(edit1.text,7, length(edit1.text)-6)) = uppercase(nick[i-1]) then
    begin
    MessageDlg('Nick ' + copy(edit1.text,7,length(edit1.text)-6)+' is currently used' ,mtInformation,[mbOK],0);
    goto label3;
    end;
    until i=g ;
    form1.label2.caption:=copy(edit1.text,7, length(edit1.text)-6);
    form2.edit2.text:=copy(edit1.text,7, length(edit1.text)-6);
    form1.clientsocket1.socket.sendtext('6'+'ô'+inttostr(urut)+'§'+copy(edit1.text,7, length(edit1.text)-6));
    label3:
    end
    else
    if uppercase(copy(edit1.text,1,3))= uppercase('/pm') then
    begin
    repeat
    inc(c);
    if copy(edit1.text,c,1) ='!' then
    dapat:= true
    else
    dapat:=false
    until (dapat=true) or (c = length(edit1.text));
    if dapat = false then
    begin
    MessageDlg('You have to put character ! after nickname'  ,mtInformation,[mbOK],0);
    goto label4
    end
    else
    repeat
    inc(b);
    until copy(edit1.text,b,1)='!';
    i:=0;
    repeat
    inc(i);
    if uppercase(nick[i-1]) = uppercase(copy(edit1.text,5, b-5)) then
    found:= true
    else
    found:= false;
    until (found = true) or (i =g);
    if found = false then
    begin
     MessageDlg('Nick ' + copy(edit1.text,5,b-5)+' does not exist' ,mtWarning,[mbOK],0);
    goto label4;
    end
    else
    if found = true then
    form1.clientsocket1.socket.sendtext('4'+'ô' +inttostr(urut) +'`'+ (copy(edit1.text,5,b-5))+ '!'+ copy(edit1.text,b+2, length(edit1.text)-b-1));
    richedit1.SelAttributes.color:= tcolor($005E24F4);
    form1.richedit1.lines.add('Message Sent to '+ copy(edit1.text,5,b-5));
    label4:
    end
    else
    if uppercase(copy(edit1.text,1,10)) = uppercase('/moderator') then
    begin
    if modon = true then
    form10.show
    else
    if modon = false then
    goto label5
    end
    else
    if uppercase(copy(edit1.text,1,2))=uppercase('/q') then
    begin
    form1.ClientSocket1.Socket.sendtext('5'+'ô'+inttostr(urut));
    sleep(50);
    Form1 .ClientSocket1.Active := false;
    g:=0;
    urut:=0;
    end
    else
    if uppercase(copy(edit1.text,1,5))= uppercase('/help') then
    begin
    richedit1.SelAttributes.color:=clblue;
    with richedit1.lines do
    begin
    add('Keyboard commands :');
    add('/nick nick_baru (Change nick)');
    add('/pm nick_dituju! pesan (Private message)');
    add('/whois nick (User Identity)');
    add('/game (Activate Word Game)');
    add('/moderator (Accesing password window)*');
    add('/score (Check your score)');
    add('/q (Quit)');
    end
    end
    else
    if uppercase(edit1.text) = Uppercase (gjawab) then
    begin
    clientsocket1.socket.SendText('16'+'ô'+inttostr(urut)+'§'+ edit1.text);
    inc(score);
    end
    else
    if uppercase(copy(edit1.text,1,8)) = uppercase('/score') then
    begin
    RichEdit1.SelAttributes.color:=clblue;
    richedit1.lines.add('Your Score : '+inttostr(score));
    end
    else
    if uppercase(copy(edit1.text,1,5)) = uppercase('/game') then
    form7.show
    else
    label5 :
    ClientSocket1.Socket.SendText('2'+'ô'+'<'+ form2.edit2.text+'>'+' ' + Edit1.Text);
    Edit1.text :='';
    end;
  end;
    procedure TForm1.ClientSocket1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
  begin
statusbar1.panels[0].text:='';
StatusBar1.Panels[0].text:= 'Connected to';
statusbar1.panels[1].text:= clientsocket1.Host;
SpeedButton1.enabled:=false;
Speedbutton2.enabled:= true;
speedbutton3.enabled:=true;
speedbutton4.enabled:=true;
speedbutton5.enabled:=true;
speedbutton6.enabled:=true;
speedbutton7.enabled:=true;
speedbutton8.enabled:=true;
speedbutton9.enabled:=true;
speedbutton10.enabled:=true;
speedbutton12.enabled:=true;
connect1.enabled:=false;
disconnect1.enabled:=true;
game1.enabled:=true;
nickname1.enabled:=true;
whois1.enabled:=true;
p1.enabled:=true;
cut1.enabled:=true;
copy1.enabled:=true;
paste1.enabled:=true;
ModeratorMenu1.enabled:= true;
se1.enabled:=true;
richedit1.lines.clear;
ClientSocket1.socket.sendtext('1'+'ô'+form2.edit2.text + '`'+ form2.edit1.text+'!'+clientsocket1.socket.LocalHost);
modon:= true;
g:=0;
RichEdit1.SelAttributes.Color :=clBlue;
RichEdit1.Lines.Add('Starts at '+timetostr(time)+' on '+datetostr(date));
end;

procedure TForm1.ClientSocket1Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);

begin
speedbutton1.enabled:= true;
speedbutton2.enabled:= false;
speedbutton3.enabled:=false;
speedbutton4.enabled:=false;
speedbutton5.enabled:=false;
speedbutton6.enabled:=false;
speedbutton7.enabled:=false;
speedbutton8.enabled:=false;
speedbutton9.enabled:=false;
speedbutton10.enabled:=false;
speedbutton11.enabled:=false;
speedbutton11.visible:=false;
speedbutton12.enabled:=false;
connect1.enabled:=true;
disconnect1.enabled:=false;
game1.enabled:=false;
nickname1.enabled:=false;
whois1.enabled:=false;
p1.enabled:=false;
cut1.enabled:=false;
copy1.enabled:=false;
paste1.enabled:=false;
se1.enabled:= false;
modmenu1.enabled:=false;
modmenu1.visible:=false;
moderatormenu1.enabled:=false;
label2.caption:='';
statusbar1.panels[0].text:='Disconnected';
statusbar1.panels[1].text:='';
listbox1.items.clear;
g:=0;
score:=0;
RichEdit1.SelAttributes.color :=clBlue ;
RichEdit1.lines.add('Ends at '+TimeToStr(time)+' on '+datetostr(date));
end;
procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
form8.show;
end;




procedure TForm1.SaveChat1Click(Sender: TObject);
begin
begin
  SaveDialog1.Title := 'Save Chat ';
  SaveDialog1.DefaultExt:= 'txt';
  SaveDialog1.Filter:='*.txt';
  if SaveDialog1.Execute then
  begin
    if FileExists(SaveDialog1.FileName) then
    if MessageDlg(Format('OK to overwrite %s', [SaveDialog1.FileName]),
        mtConfirmation, mbYesNoCancel, 0) <> idYes then Exit;
        richedit1.plaintext:= true;
        richedit1.Lines.SaveToFile(SaveDialog1.FileName);

  end;
end;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
Edit1.CutToClipboard;
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
begin
richedit1.CopyToClipboard;
edit1.copytoclipboard;
end;

procedure TForm1.SpeedButton9Click(Sender: TObject);
begin
edit1.PasteFromClipboard;
end;

procedure TForm1.Cut1Click(Sender: TObject);
begin

Edit1.CutToClipboard;
end;

procedure TForm1.Copy1Click(Sender: TObject);
begin
richedit1.CopyToClipboard;
edit1.CopyToClipboard;
end;

procedure TForm1.Paste1Click(Sender: TObject);
begin
edit1.PasteFromClipboard;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
form1.ClientSocket1.Socket.sendtext('5'+'ô'+inttostr(urut));
Form1.Release;
form2.release;
form3.release;
form4.release;
form5.release;
form6.release;
form7.release;
form8.release;
form9.release;
form10.release;
form11.release;
form12.release;
AboutBox.release;

end;

procedure TForm1.WhoIs1Click(Sender: TObject);
begin
form8.show;
end;

procedure TForm1.SpeedButton10Click(Sender: TObject);
begin
form6.show;
end;

procedure TForm1.RichEdit1Change(Sender: TObject);
begin
    RichEdit1.SetFocus;
    RichEdit1.SelStart := -1;
    edit1.SetFocus;
end;

procedure TForm1.Modmenu1Click(Sender: TObject);
begin
form11.show;
end;

procedure TForm1.SpeedButton11Click(Sender: TObject);
begin
form11.show;
end;

procedure TForm1.ModeratorMenu1Click(Sender: TObject);
begin
form9.show;
end;

procedure TForm1.Cut2Click(Sender: TObject);
begin
edit1.cuttoclipboard;
end;

procedure TForm1.Copy2Click(Sender: TObject);
begin
richedit1.copytoclipboard;
edit1.copytoclipboard;

end;

procedure TForm1.Paste2Click(Sender: TObject);
begin
edit1.PasteFromClipboard;
end;


procedure TForm1.ListBox1DblClick(Sender: TObject);
var
     i: byte;
     begin
for i:= 0 to listbox1.items.count-1 do
if listbox1.selected[i]=true then
form6.edit1.text:=nick[i];
form6.show;
form6.Edit2.SetFocus;
end;

procedure TForm1.Se1Click(Sender: TObject);
begin
form12.show;
end;

procedure TForm1.NMStrmServ1ClientContact(Sender: TObject);
begin
NMStrmServ1.ReportLevel := Status_Basic;
NMStrmServ1.TimeOut := 90000;
end;

procedure TForm1.NMStrm1Connect(Sender: TObject);
begin
richedit1.lines.add('connected');
end;

procedure TForm1.NMStrm1ConnectionFailed(Sender: TObject);
begin
richedit1.lines.add('Connection Failed');
end;

procedure TForm1.NMStrmServ1MSG(Sender: TComponent; const sFrom: String;
  strm: TStream);
 var
  af:byte;
  MyFStream: TFileStream;
begin
  if SaveDialog2.Execute then
  begin
    SaveDialog2.title:='Save Fife As';
    SaveDialog2.Filter:= '*.*';
    if FileExists(SaveDialog2.FileName) then
    if MessageDlg(Format('OK to overwrite %s', [SaveDialog2.FileName]),
        mtConfirmation, mbYesNoCancel, 0) <> idYes then Exit;
    end;
    af:= length(savedialog2.filename);
    repeat
    dec(af)
    until copy(savedialog2.filename,af,1)='\';
    nf:= copy(savedialog2.filename,af+1,length(savedialog2.filename)-af)+ext;
  MyFStream := TFileStream.Create(nf, fmCreate);
  try
    MyFStream.CopyFrom(strm, strm.size);
  finally
    MYFStream.Free;
  end;
richedit1.SelAttributes.color:=clblue;
richedit1.Lines.add('File Received');
end;


procedure TForm1.NMStrm1MessageSent(Sender: TObject);
begin
richedit1.Lines.add('Files Sent');
end;

procedure TForm1.NMStrm1PacketSent(Sender: TObject);
begin
Richedit1.lines.add (inttostr(NMStrm1.BytesSent)+' bytes '+' of '+IntToStr(NMStrm1.BytesTotal)+' bytes '+' sent');
end;


procedure TForm1.SpeedButton12Click(Sender: TObject);
begin
form12.show;
end;

procedure TForm1.About1Click(Sender: TObject);

begin
aboutbox.show;
end;

procedure TForm1.WhoIs2Click(Sender: TObject);
var i: byte;
begin
for i:= 0 to listbox1.items.count-1 do
if listbox1.selected[i]=true then
 form1.clientsocket1.socket.sendtext('3'+'ô'+inttostr(urut)+'`'+nick[i]);
end;

procedure TForm1.PrivateMessage1Click(Sender: TObject);
var i: byte;
begin
for i:= 0 to listbox1.items.count-1 do
if listbox1.selected[i]=true then
form6.edit1.text:=nick[i];
form6.show;
form6.Edit2.SetFocus;
end;

procedure TForm1.SendFile1Click(Sender: TObject);
var i:byte;
begin
for i:= 0 to listbox1.items.count-1 do
if listbox1.selected[i]=true then
form12.edit1.text:=nick[i];
form12.Show;
form12.edit2.SetFocus;
end;

procedure TForm1.Kick1Click(Sender: TObject);
var i:byte;
begin
for i:= 0 to listbox1.items.count-1 do
if listbox1.selected[i]=true then
form9.edit1.text:=nick[i];
form9.show;
end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
begin
Application.HelpFile := 'C:\My Documents\IMTChat\Help\help.hlp';
  Application.HelpCommand(HELP_FINDER, 1);

end;

procedure TForm1.Help1Click(Sender: TObject);
begin
Application.HelpFile := 'C:\My Documents\IMTCHat\Help\help.hlp';
  Application.HelpCommand(HELP_FINDER, 1);

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
StatusBar1.Panels[2].text:= datetostr (date);
end;

end.
