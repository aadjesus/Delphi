unit CNTPrincipal;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, DBTables, jpeg, ComCtrls, Tabnotbk, StdActns, DBActns,
  ActnList, Buttons, ToolWin, Psock, NMFngr, NMHttp, StdCtrls;

type
  TCNTFormPricipal = class(TForm)
    MenuPrincipal: TMainMenu;
    Cadastro: TMenuItem;
    CadUsuarios: TMenuItem;
    CadHistorico: TMenuItem;
    Movimentacao: TMenuItem;
    MovDigitacao: TMenuItem;
    N1: TMenuItem;
    RelatorioMovimentao: TMenuItem;
    Saida: TMenuItem;
    Listagem: TMenuItem;
    ListagemClientes: TMenuItem;
    ListagemHistoricos: TMenuItem;
    Panel1: TPanel;
    Image1: TImage;
    procedure CadUsuariosClick(Sender: TObject);
    procedure SaidaClick(Sender: TObject);
    procedure CadHistoricoClick(Sender: TObject);
    procedure MovDigitacaoClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ListagemClientesClick(Sender: TObject);
    procedure ListagemHistoricosClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  CNTFormPricipal: TCNTFormPricipal ;
  UsuaOuHist     : String           ;

implementation

{$R *.DFM}

uses CNTUsuarios          , CNTHistorico        , CNTInclusao,
     CNTPesquisaUsuario   , CNTDataModuleContas ,
     CNTListagemCadastros ;

//--------- Simula Enter ao inves de Tab ( Evento KeyPress ) ---------\\
procedure TCNTFormPricipal.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 then
  Begin
    Key := #0;
    Perform( WM_NEXTDLGCTL, 0, 0 );
  end;
end;

//----------------- Cadastro de usuarios ------------------\\
procedure TCNTFormPricipal.CadUsuariosClick(Sender: TObject);
Begin
  With TCNTFormUsuario.Create(Self) Do
  Begin
    ShowModal;
    Free;
  End;
end;

//-------------- Cadastro de historico ---------------------\\
procedure TCNTFormPricipal.CadHistoricoClick(Sender: TObject);
Begin
  With TCNTFormHistorico.Create(Self) Do
  Begin
    ShowModal;
    Free;
  End;
end;

//-------------- Inclusao de ducumentos -----------------\\
procedure TCNTFormPricipal.MovDigitacaoClick(Sender: TObject);
begin
  With TCNTMovDigIclusao.Create(Self) Do
  Begin
    ShowModal;
    Free;
  End;
end;

//--------------- Sai do sistema --------------------\\
procedure TCNTFormPricipal.SaidaClick(Sender: TObject);
Begin
   If MessageDlg( 'Confirma saída da aplicação?',
      mtConfirmation,[mbYes,mbNo],0 ) = mrYes Then
   Begin
      Close ;
   end;
end;

//--------- Listagem do cadastro de clientes -----------------\\
procedure TCNTFormPricipal.ListagemClientesClick(Sender: TObject);
begin
  UsuaOuHist := 'USU' ;
  CNTFormListagemCadastro.ShowModal ;
end;

//--------- Listagem do cadastro de Historico --------------------\\
procedure TCNTFormPricipal.ListagemHistoricosClick(Sender: TObject);
begin
  UsuaOuHist := 'HIT' ;
  CNTFormListagemCadastro.ShowModal ;
end;
{
//------- Evento OnActivate -------------------------------\\
var I : Integer;
begin
  For i := 0 to 800 do Left := Left-i ;
end;
}
end.
