unit UPrototicoDelphi7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls, UComboBoxEmpFilGar, ExtCtrls;

type
  TForm1 = class(TForm)
    Empresa: TComboBoxEmpFilGar;
    Filial: TComboBoxEmpFilGar;
    Garagem: TComboBoxEmpFilGar;
    db1: TDatabase;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Button1: TButton;
    MemoEmpresa: TMemo;
    MemoFilial: TMemo;
    MemoGaragem: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  MemoEmpresa.Clear ;
  MemoFilial.Clear ;
  MemoGaragem.Clear ;

  With Empresa.Estrutura do
  Begin
    MemoEmpresa.Lines.Add('Rasão social        : ' + Rsocial) ;
    MemoEmpresa.Lines.Add('Nome fantasia       : ' + NomeFantasia) ;
    MemoEmpresa.Lines.Add('Cidade              : ' + Cidade) ;
    MemoEmpresa.Lines.Add('UF                  : ' + Uf) ;
    MemoEmpresa.Lines.Add('Endereço            : ' + Endereco) ;
    MemoEmpresa.Lines.Add('Numero              : ' + NumeroEnd) ;
    MemoEmpresa.Lines.Add('Complemento         : ' + ComplEnd) ;
    MemoEmpresa.Lines.Add('Cep                 : ' + Cep) ;
    MemoEmpresa.Lines.Add('Bairro              : ' + Bairro) ;
    MemoEmpresa.Lines.Add('Fone                : ' + Fone) ;
    MemoEmpresa.Lines.Add('Fax                 : ' + Fax) ;
    MemoEmpresa.Lines.Add('Home Page           : ' + HomePag) ;
    MemoEmpresa.Lines.Add('E-Mail              : ' + EMail) ;
    MemoEmpresa.Lines.Add('Matriz              : ' + Matriz) ;
    MemoEmpresa.Lines.Add('Tipo de inscrição   : ' + TipoInscricao) ;
    MemoEmpresa.Lines.Add('Número              : ' + Inscricao) ;
    MemoEmpresa.Lines.Add('Inscrição municipal : ' + IMunicipal) ;
    MemoEmpresa.Lines.Add('Inscrição estadual  : ' + IEstadual) ;
  End ; // With Empresa.Estrutura do

  With Filial.Estrutura do
  Begin
    MemoFilial.Lines.Add('Rasão social        : ' + Rsocial) ;
    MemoFilial.Lines.Add('Nome fantasia       : ' + NomeFantasia) ;
    MemoFilial.Lines.Add('Cidade              : ' + Cidade) ;
    MemoFilial.Lines.Add('UF                  : ' + Uf) ;
    MemoFilial.Lines.Add('Endereço            : ' + Endereco) ;
    MemoFilial.Lines.Add('Numero              : ' + NumeroEnd) ;
    MemoFilial.Lines.Add('Complemento         : ' + ComplEnd) ;
    MemoFilial.Lines.Add('Cep                 : ' + Cep) ;
    MemoFilial.Lines.Add('Bairro              : ' + Bairro) ;
    MemoFilial.Lines.Add('Fone                : ' + Fone) ;
    MemoFilial.Lines.Add('Fax                 : ' + Fax) ;
    MemoFilial.Lines.Add('Home Page           : ' + HomePag) ;
    MemoFilial.Lines.Add('E-Mail              : ' + EMail) ;
    MemoFilial.Lines.Add('Matriz              : ' + Matriz) ;
    MemoFilial.Lines.Add('Tipo de inscrição   : ' + TipoInscricao) ;
    MemoFilial.Lines.Add('Número              : ' + Inscricao) ;
    MemoFilial.Lines.Add('Inscrição municipal : ' + IMunicipal) ;
    MemoFilial.Lines.Add('Inscrição estadual  : ' + IEstadual) ;
  End ; // With Filial.Estrutura do

  With Garagem.Estrutura do
  Begin
    MemoGaragem.Lines.Add('Nome                : ' + Rsocial) ;
    MemoGaragem.Lines.Add('Cidade              : ' + Cidade) ;
    MemoGaragem.Lines.Add('UF                  : ' + Uf) ;
    MemoGaragem.Lines.Add('Endereço            : ' + Endereco) ;
    MemoGaragem.Lines.Add('Numero              : ' + NumeroEnd) ;
    MemoGaragem.Lines.Add('Complemento         : ' + ComplEnd) ;
    MemoGaragem.Lines.Add('Cep                 : ' + Cep) ;
    MemoGaragem.Lines.Add('Bairro              : ' + Bairro) ;
    MemoGaragem.Lines.Add('Fone                : ' + Fone) ;
    MemoGaragem.Lines.Add('Fax                 : ' + Fax) ;
  End ; // With Garagem.Estrutura do
end;

end.
