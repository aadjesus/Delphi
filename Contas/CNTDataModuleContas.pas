unit CNTDataModuleContas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDMContas = class(TDataModule)
    TBUsuarios: TTable;
    DSUsuarios: TDataSource;
    TBUsuariosCodigo: TStringField;
    TBUsuariosNome: TStringField;
    TBUsuariosEndereco: TStringField;
    TBUsuariosBairro: TStringField;
    TBUsuariosCidade: TStringField;
    TBUsuariosUf: TStringField;
    TBUsuariosCep: TStringField;
    TBUsuariosRg: TStringField;
    TBUsuariosCpf: TStringField;
    TBUsuariosTelefone: TStringField;
    DSHistorico: TDataSource;
    TBHistorico: TTable;
    TBHistoricoCodigo: TStringField;
    TBHistoricoDescricao: TStringField;
    TBHistoricoDebitoCredito: TStringField;
    DSMovimentacao: TDataSource;
    TBMovimentacao: TTable;
    TBMovimentacaoUsuario: TStringField;
    TBMovimentacaoEntrada: TDateField;
    TBMovimentacaoDocumento: TStringField;
    TBMovimentacaoParcela: TStringField;
    TBMovimentacaoVencimento: TDateField;
    TBMovimentacaoPagamento: TDateField;
    TBMovimentacaoValorDocumento: TStringField;
    TBMovimentacaoAcrescimo: TStringField;
    TBMovimentacaoDesconto: TStringField;
    TBMovimentacaoSubstitui: TBooleanField;
    TBMovimentacaoSubstituido: TStringField;
    TBMovimentacaoCheque: TStringField;
    TBMovimentacaoHistorico: TStringField;
    TBMovimentacaoHistComplemento: TStringField;
    TBHistoricoComplemento: TBooleanField;
    QueryPagamento: TQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMContas: TDMContas;


implementation

{$R *.DFM}

end.
