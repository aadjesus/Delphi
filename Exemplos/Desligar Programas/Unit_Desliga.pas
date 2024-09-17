unit Unit_Desliga;

interface
// meu mone é luciano e meu e-mail lucianopsonline@ig.com.br
// espero que está dica lhe seja util
// caso faça algumas melhorias no programa favor me enviar um exemplo com fontes
// o limite da máquina é a imaginação do homem " e tambem a da mulher "
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, CheckLst;

type
  TFormDesliga = class(TForm)
    SBInfo: TStatusBar;
    ButtonDesliga: TButton;
    Edit1: TEdit;
    Timer1: TTimer;
    ListBox1: TListBox;
    procedure ListBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ButtonDesligaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDesliga: TFormDesliga;

implementation

{$R *.dfm}

// função para listar todos os programas ativos
function EnumWindowsProc(Wnd : HWnd;Form : TFormDesliga) : Boolean; Export; {$ifdef Win32} StdCall; {$endif}
var
  Buffer : Array[0..99] of char;
begin
  GetWindowText(Wnd,Buffer,100);
  if StrLen(Buffer) <> 0 then
    Form.listbox1.Items.Add(StrPas(Buffer));
    Result := True;
end;

procedure TFormDesliga.ButtonDesligaClick(Sender: TObject);
var
  i: integer;
  hHandle : THandle;
  programa: pchar;
  nome: string;
begin
  listbox1.Clear;
  // transforma o conteúto do edit em pchar
  nome:= edit1.Text;
  programa:= pchar(nome);
  // fecha o programa "no qual o nome aparece no edit"
  hHandle := FindWindow( nil,programa );
  if hHandle <> 0 then
  SendMessage( hHandle, WM_CLOSE, 0, 0);
  // lista todos os programas ativos
  EnumWindows(@EnumWindowsProc,LongInt(Self));
  i:= listbox1.Items.Count;
  // exibe a quantidade de programas ativos
  SBInfo.Panels[0].Text:= 'Total de programas em uso: '+ inttostr(i);
  ButtonDesliga.Enabled:= false;
  end;

procedure TFormDesliga.Timer1Timer(Sender: TObject);
var
   MemoryStatus: TMemoryStatus;
begin
  // status da memoria
  MemoryStatus.dwLength:= sizeof(MemoryStatus);
  GlobalMemoryStatus(MemoryStatus);
  // exibe o percentual de memoria em uso
  SBInfo.Panels[1].Text:= 'Percentual de memória em uso : ' + IntToStr(MemoryStatus.dwMemoryLoad)+ ' %';

end;

procedure TFormDesliga.FormCreate(Sender: TObject);
var
  i: integer;
begin
  //lista todos os programas ativos
  Listbox1.Clear;
  EnumWindows(@EnumWindowsProc,LongInt(Self));
  i:= listbox1.Items.Count;
  // exibe a quntidade de programas ativos
  SBInfo.Panels[0].Text:= 'Total de programas em uso: '+ inttostr(i);
end;

procedure TFormDesliga.ListBox1Click(Sender: TObject);
var
  i: integer;
begin
  // envia item selecionado no listbox par o edit
  with listbox1 do
  begin
    for i := 0 to Items.Count - 1 do
      if Selected[i] then
      begin
        edit1.Text:=(Items[i]);
      end;
  end;
  ButtonDesliga.Enabled:= true;
end;

end.
