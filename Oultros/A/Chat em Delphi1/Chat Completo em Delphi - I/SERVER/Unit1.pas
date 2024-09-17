unit Unit1;  {a}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ScktComp;

type
  TForm1 = class(TForm)
    ServerSocket1: TServerSocket;
    Label1: TLabel;
    ListBox1: TListBox;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Button3: TButton;
    Label4: TLabel;
    ListBox2: TListBox;
    Label5: TLabel;
    Label6: TLabel;
    ListBox3: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocket1ClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure Button3Click(Sender: TObject);
    procedure ServerSocket1ClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);

    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    
    procedure Label5DblClick(Sender: TObject);

    procedure Label4DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
 


  private
    { Private declarations }
  public
    { Public declarations }
  end;
  var
   Form1: TForm1;
   pass: string;
  implementation

uses Unit2, Unit3;

{$R *.DFM}

  var
  a,ak,putus: byte;
  y:integer;
  nama: array [0..99] of string;
  nick: array [0..99] of string ;
  lh: array[0..99] of string;
  con: integer;
   allnick: string;
   gon: boolean;
procedure TForm1.Button1Click(Sender: TObject);
begin
ServerSocket1.Port := 200;
serversocket1.active:= true;
edit1.text:=serversocket1.Socket.localhost;
gon:=false;
y:=0;
a:=0;
pass:='deniel';
con:=0;

end;

procedure TForm1.Button2Click(Sender: TObject);
var i: byte;
begin
serversocket1.active:= false;
edit1.text:= '';
listbox1.items.clear;
listbox2.items.clear;
label3.caption:='';
listbox3.items.clear;
ak:=0;
for i:=0 to 2 do
begin
nick[i]:='';
nama[i]:='';
lh[i]:='';
end;
gon:=false;
end;

procedure TForm1.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
 var i,z,c,d,e,f,g,h,j,k,l,m,n,o,q,r,t,u,v,ab,ac,ad,ki,id : byte;
      ae,af,ag,ah,al,am,ao,ap,aq,ar,au,at,av,aw,ay,ba,bi:byte;
     x,b,an:integer;
     sama:boolean;
     found:boolean;
     nape,knama,kpesan,akal,s,pnama,ppesan,naki,nato,nakil,fnick,snick: string;
     snick2,fnick2,fadd,fport: string;
     label start1;
     label label2;
     label label3 ;
     label label4;
     label label5;
     label label6;
     label label7 ;
     label label8;
 begin
sama:= false;
t:=1;
b:=-1;
h:=1;
g:=1;
c:=0;
f:=0;
x:=-1;
an:=-1;
s:= socket.receivetext;

repeat
inc(id);
until copy(s,id,1) ='ô';

case strtoint(copy(s,1,id-1)) of

5: begin {disconnect}
   if ak=1 then
   begin
   listbox1.items.clear;
   listbox2.items.clear;
   listbox3.items.clear;
   for ay:= 0 to 2 do
   begin
   nick[ay]:='';
   nama[ay]:='';
   lh[ay]:='';
   end;
   gon:=false;
   goto label8
   end
   else
   putus:= strtoint(copy(s,id+1,length(s)-id));
   for m:= putus to ak-2 do
   begin
   nama[m]:=nama[m+1];
   nick[m]:= nick[m+1];
   lh[m]:= lh[m+1];
   serversocket1.socket.Connections[m+1].sendtext('5'+'ô'+inttostr(m)+'§'+pass);
   end;
   listbox1.items.clear;
   listbox2.items.clear;
   listbox3.items.clear;
   for n:=0 to ak-2 do
   begin
   listbox1.items.append(nama[n]);
   listbox2.items.append(nick[n]);
   listbox3.items.append(lh[n]);
   end;
   label8:
   end ;
1:  begin {nick,nama,localhost}
    repeat
    inc(c);
    until copy(s,c,1)='`';
    repeat
    inc(an);
    if uppercase(nick[an]) = uppercase (copy(s,id+1,c-id-1)) then
    found:= true
    else
    found:=false
    until (found=true) or (an= serversocket1.socket.activeconnections);
    if found= true then
    begin
    nick[y]:='Guest'+ inttostr(y);
    goto label7 ;
    end
    else
    if found=false then
    nick[y]:= copy(s,id+1,c-id-1);
    label7:
    repeat
    inc(f);
    until copy(s,f,1)='!';
    nama[y]:= copy(s,c+1,f-c-1);
    lh[y]:= copy(s,f+1,length(s)-f);
    listbox1.items.append(nama[y]);
    listbox2.items.append(nick[y]);
    listbox3.items.append(lh[y]);
    for z:= 1 to serversocket1.socket.activeconnections-1 do
    serversocket1.socket.connections[z-1].sendtext('2'+'ô'+nick[y]);
    sleep (100);
    for i:= ak-1 downto 0 do
    allnick:=nick[i]+'§'+allnick;
    serversocket1.socket.connections[serversocket1.Socket.ActiveConnections -1].sendtext('4'+'ô'+ allnick);
    allnick:='';
    inc(y);
    end;
2: begin  {sendtext}
    for i:= 0 to serversocket1.socket.activeconnections-1 do
     ServerSocket1.Socket.Connections[i].SendText('3'+'ô'+ copy(s,id+1,length(s)));
    end;

3: begin   {whois}
   repeat
   inc(g);
   until copy(s,g,1) = '`';
   e:= strtoint(copy(s,id+1,g-id-1));
   repeat
   inc(x)
   until uppercase(nick[x]) = uppercase(copy(s,g+1,length(s))) ;
   serversocket1.socket.connections[e].sendtext('6'+'ô'+ nama[x]);
   sleep(10);
   serversocket1.socket.connections[e].sendtext('7'+'ô'+ lh[x]);
   end;
4: begin       {private message}
   repeat
   inc(h);
   until copy(s,h,1) ='`';
   j:= strtoint(copy(s,id+1,h-id-1));
   repeat
   inc(k)
   until copy(s,k,1)='!';
   pnama:= copy(s,h+1,k-h-1);
   ppesan:= copy(s,k+1,length(s));
   repeat
   inc(b);
   until uppercase(nick[b]) = uppercase(pnama);
   serversocket1.socket.Connections[b].sendtext('8'+'ô'+nick[j] +'`' +ppesan);
   end;

6: begin {change nickname}
   repeat
   inc(t);
   until(copy(s,t,1)) = '§' ;
   nick[strtoint(copy(s,id+1,t-id-1))]:= copy(s,t+1,length(s)-t);
   listbox2.items.clear;
   for u:=0 to serversocket1.socket.activeconnections-1  do
   begin
   listbox2.items.append(nick[u]);
   serversocket1.socket.connections[u].sendtext('11'+'ô'+(copy(s,2,t-2))+'§'+copy(s,t+1,length(s)-t));
   end;

   end;
7: begin{kick user}
   repeat
   inc(ab);
   until copy(s,ab,1)='§';
   repeat
   inc(ac);
   until copy(s,ac,1) ='æ';
   knama:= copy(s,ab+1,ac-ab-1);
   if copy(s,id+1,1)='?' then
   begin
   naki:='????';
   goto label2 ;
   end
   else
   if copy(s,id+1,1)='`' then
   begin
   naki:='æ';
   kpesan:='æ';
   goto label6 ;
   end
   else
   ki:= strtoint(copy(s,id+1,ab-id-1));
   naki:= nick[ki];
   label2:
   kpesan:= copy(s,ac+1,length(s)-ac);
   label6 :
   repeat
   inc(ad);
   until uppercase(nick[ad-1]) = uppercase(knama);
   serversocket1.socket.Connections[ad-1].sendtext('12'+'ô'+ naki+'§'+kpesan);
   end;
8: begin {setmoderator}
   ae:=0;
   repeat
   inc(ae);
   until copy(s,ae,1)= '§' ;
   if copy(s,ae-1,1)='?' then
   begin
   nape:='???';
   goto label4
   end
   else
   nape:= nick[strtoint(copy(s,ae-1,ae-id-1))];
   label4:
   repeat
   inc(af);
   until uppercase(nick[af-1]) = uppercase(copy(s,ae+1,length(s)-ae));
   serversocket1.socket.Connections[af-1].sendtext('14'+'ô'+ nape);
   end ;
9: begin  {settopic}
   ae:=0;
   repeat
   inc(ae);
   until copy(s,ae,1)= '§' ;
   if copy(s,ae-1,1)='?' then
   begin
   nato:='???';
   goto label3
   end
   else
   nato:= nick[strtoint(copy(s,ae-1,ae-id-1))];
   label3:
   for i:= 0 to serversocket1.socket.activeconnections-1 do
   serversocket1.socket.connections[i].sendtext('15'+'ô'+ nato+'§'+ copy(s,ae+1, length(s)-ae));
   end;
10: begin    {frezee user}
    ae:=0;
    repeat
    inc(ae);
    until copy(s,ae,1)= '§' ;
    if copy(s,ae-1,1)='?' then
    begin
    nakil:='???';
    goto label5
    end
    else
    if copy(s,ae-1,1)='`' then
    begin
    nakil:='æ';
    goto label5;
    end
    else
    nakil:= nick[strtoint(copy(s,ae-1,ae-id-1))];
    label5:
    repeat
    inc(ag);
    until uppercase(nick[ag-1]) = uppercase(copy(s,ae+1,length(s)-ae));
    serversocket1.socket.Connections[ag-1].sendtext('16'+'ô'+ nakil);
   end;
12: begin {request}
    repeat
    inc(ao);
    until copy(s,ao,1)='æ';
    snick:= copy(s,id+1,ao-id-1);
    repeat
    inc(ap);
    until copy(s,ap,1) ='§';
    fnick:= copy(s,ao+1,ap-ao-1);
    repeat
    inc(aq);
    until uppercase(nick[aq-1]) = uppercase (fnick);
    serversocket1.socket.Connections[aq-1].sendtext('19'+'ô'+ nick[strtoint(snick)]+'§' + copy(s,ap+1,length(s)-ap));
   end;
13: begin {accepted}
    repeat
    inc(ar);
    until copy(s,ar,1)='æ';
    snick2:= nick[strtoint(copy(s,id+1,ar-id-1))];
    repeat
    inc(at);
    until copy(s,at,1)='£';
    fnick2:= copy(s,ar+1,at-ar-1);
    fadd := copy(s,at+1,length(s)-at);
    repeat
    inc(av);
    until uppercase(nick[av-1]) = uppercase(fnick2);
    serversocket1.socket.connections[av-1].sendtext('20'+'ô'+ snick2+'§'+fadd);
    end;
14: begin {request denied}
    repeat
    inc(ba);
    until uppercase(nick[ba-1]) = uppercase(copy(s,id+1,length(s)-id));
    serversocket1.socket.connections[ba-1].sendtext('21'+'ô');
    end ;
15: begin {game }
    if gon = true then
    begin
    repeat
    inc(bi);
    until copy(s,bi,1)='§';
    serversocket1.socket.connections[strtoint(copy(s,id+1,bi-id-1))].sendtext('24'+'ô')
    end
    else
    for i:=0 to serversocket1.socket.ActiveConnections-1 do
    ServerSocket1.Socket.Connections[i].SendText('22'+'ô'+ copy(s,id+1,length(s)-id));
    gon:= true;
    end;
16: begin {game winner}
    for i:=0 to ServerSocket1.Socket.ActiveConnections-1 do
    serversocket1.socket.connections[i].Sendtext('23'+'ô'+copy(s,id+1,length(s)-id));
    gon:=false;
    end;
    end;
   end;
 



 procedure TForm1.ServerSocket1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);

  begin
{mengirimkan Index koneksi, Jumlah active connection}
label3.caption:= inttostr(ak+1) + '  Connection(S)' ;
serversocket1.socket.connections[ak].sendtext('5'+'ô'+ inttostr(ak)+'§'+pass);
inc(ak);
end;


procedure TForm1.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
  var i: byte;
begin
dec(ak);
label3.caption:= inttostr(ak)+'  Connection(S)';
for i:=0 to ak do
begin
serversocket1.socket.connections[i].sendtext('10'+'ô'+inttostr(putus)+'§'+inttostr(ak));
end;
dec(y);
end;

procedure TForm1.ServerSocket1ClientError(Sender: TObject;
Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
var ErrorCode: Integer);

begin
ErrorCode := 0;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
application.terminate
end;



procedure TForm1.Label5DblClick(Sender: TObject);
begin
form2.show;
end;

procedure TForm1.Label4DblClick(Sender: TObject);
begin
form3.show;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
form1.release;
form2.release;
form3.release;
end;

end.
