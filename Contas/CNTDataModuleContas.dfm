�
 TDMCONTAS 0�  TPF0	TDMContasDMContasOldCreateOrderLeft�Top� Height(Width TTable
TBUsuariosDatabaseNameContas	FieldDefsNameCodigoDataTypeftStringSize NameNomeDataTypeftStringSize( NameEnderecoDataTypeftStringSize( NameBairroDataTypeftStringSize NameCidadeDataTypeftStringSize NameUfDataTypeftStringSize NameCepDataTypeftStringSize	 NameRgDataTypeftStringSize
 NameCpfDataTypeftStringSize
 NameTelefoneDataTypeftStringSize
  	IndexDefsNameTBUsuariosIndex1FieldsCodigoOptions	ixPrimaryixUnique  Name	IndexNomeFieldsNomeOptionsixCaseInsensitive   	StoreDefs		TableNameUsuarios.dbLefthTop TStringFieldTBUsuariosCodigo	FieldNameCodigoSize  TStringFieldTBUsuariosNome	FieldNameNomeSize(  TStringFieldTBUsuariosEndereco	FieldNameEnderecoSize(  TStringFieldTBUsuariosBairro	FieldNameBairro  TStringFieldTBUsuariosCidade	FieldNameCidade  TStringFieldTBUsuariosUf	FieldNameUfSize  TStringFieldTBUsuariosCep	FieldNameCepSize	  TStringFieldTBUsuariosRg	FieldNameRgSize
  TStringFieldTBUsuariosCpf	FieldNameCpfSize
  TStringFieldTBUsuariosTelefone	FieldNameTelefoneSize
   TDataSource
DSUsuariosDataSet
TBUsuariosLeft Top  TDataSourceDSHistoricoDataSetTBHistoricoLeft Top8  TTableTBHistoricoDatabaseNameContas	TableNameHistorico.dbLefthTopH TStringFieldTBHistoricoCodigo	FieldNameCodigoSize  TStringFieldTBHistoricoDescricao	FieldName	DescricaoSize  TStringFieldTBHistoricoDebitoCredito	FieldNameDebitoCreditoSize  TBooleanFieldTBHistoricoComplemento	FieldNameComplemento   TDataSourceDSMovimentacaoDataSetTBMovimentacaoLeft Toph  TTableTBMovimentacaoDatabaseNameContas	TableNameMovimentacao.dbLefthTopx TStringFieldTBMovimentacaoUsuario	FieldNameUsuarioSize  
TDateFieldTBMovimentacaoEntrada	FieldNameEntrada  TStringFieldTBMovimentacaoDocumento	FieldName	DocumentoSize
  TStringFieldTBMovimentacaoParcela	FieldNameParcelaSize  
TDateFieldTBMovimentacaoVencimento	FieldName
Vencimento  
TDateFieldTBMovimentacaoPagamento	FieldName	Pagamento  TStringFieldTBMovimentacaoValorDocumento	FieldNameValorDocumentoSize  TStringFieldTBMovimentacaoAcrescimo	FieldName	AcrescimoSize  TStringFieldTBMovimentacaoDesconto	FieldNameDescontoSize  TBooleanFieldTBMovimentacaoSubstitui	FieldName	Substitui  TStringFieldTBMovimentacaoSubstituido	FieldNameSubstituidoSize  TStringFieldTBMovimentacaoCheque	FieldNameChequeSize
  TStringFieldTBMovimentacaoHistorico	FieldName	HistoricoSize  TStringFieldTBMovimentacaoHistComplemento	FieldNameHistComplementoSize(   TQueryQueryPagamentoActive	DatabaseNameCONTAS
DataSourceDSMovimentacao
ParamCheckSQL.Strings4SELECT * FROM MOVIMENTACAO WHERE (USUARIO = '0001' )  Left� Top� 	ParamData    