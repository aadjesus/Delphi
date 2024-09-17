unit FormatParam;

(*
Programador         Alterado   Detalhamento
------------------- ---------- -----------------------------------------------------------------------------------------------------
Alessandro          17/11/2006 Criado rotina para retornar o cabeçalho conforme os filtros
                    06/11/2006 Alterado a procedure Execute para Função e incluído parâmetro para definir se mota o filtro da query.
*)


interface

uses
  Windows, Classes, Forms, Controls, DBTables, Graphics, DB,
  {$IFDEF VER120} {Delphi 4}
  DsgnIntf,
  {$ELSE}
  DesignIntf, DesignEditors,
  SqlExpr,
  {$ENDIF}
  AboutBgmRodotec, SBSelecaoAle,
  {$INCLUDE \Globus\Sistemas\UsesUtilitarios.txt},
  {$INCLUDE \Globus\Sistemas\UsesMigracao.txt}
  {$INCLUDE \Globus\Sistemas\UsesGLB.txt};

type
  TTipoCampo = (tpString, tpInteger, tpDate) ;
  TOperadorLogico = (olAndL, olOrL, olAndR, olOrR, olNenhum) ;
  TFormatParam = class;

  TFormatParamEditor = class(TDefaultEditor)
    {$IFDEF VER120} {Delphi 4}
      procedure EditProperty(Prop: TPropertyEditor; var Continue, FreeEditor: Boolean); override;
    {$ELSE}
      procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;
    {$ENDIF}
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): string; override;
    procedure ExecuteVerb(Index: Integer); override;
  end; // TFormatParamEditor = class(TDefaultEditor)

  TParametro = class(TCollectionItem)
  private
    FNomeCampo: String;
    FTextoLog: String;
    FCampoFin: TWinControl;
    FCampoIni: TWinControl;
    FTipoCampo: TTipoCampo;
    FOperadorLogico: TOperadorLogico;
    FAceitaNulo: Boolean;
    FTSBSelecaoAle: TSBSelecaoAle;
    FIgnoraParam: Boolean;
    FLog: String;
    FCabecalho: String;
    procedure SetCampoFin(const Value: TWinControl);
    procedure SetCampoIni(const Value: TWinControl);
    procedure SetNomeCampo(const Value: String);
    procedure SetTextoLog(const Value: String);
    procedure SetTipoCampo(Value: TTipoCampo) ;
    procedure SetOperadorLogico(Value: TOperadorLogico);
    procedure SetAceitaNulo(const Value: Boolean);
    procedure SetSelecaoAle(const Value: TSBSelecaoAle);
    procedure SetIgnoraParam(const Value: Boolean);
    procedure SetLog(const Value: String);
    procedure SetCabecalho(const Value: String);
  protected
    function GetDisplayName : string; override;
    property IgnoraParam : Boolean read FIgnoraParam write SetIgnoraParam default False ;
    property Log         : String  read FLog         write SetLog ;
    property Cabecalho   : String  read FCabecalho   write SetCabecalho ;
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
  published
    property NomeCampo      : String          read FNomeCampo      write SetNomeCampo ;
    property CampoFin       : TWinControl     read FCampoFin       write SetCampoFin ;
    property CampoIni       : TWinControl     read FCampoIni       write SetCampoIni ;
    property TextoLog       : String          read FTextoLog       write SetTextoLog ;
    property TipoCampo      : TTipoCampo      read FTipoCampo      write SetTipoCampo default tpString ;
    property OperadorLogico : TOperadorLogico read FOperadorLogico write SetOperadorLogico default olAndL ;
    property AceitaNulo     : Boolean         read FAceitaNulo     write SetAceitaNulo default False ;
    property SelecaoAle     : TSBSelecaoAle   read FTSBSelecaoAle  write SetSelecaoAle ;
  end; // TParametro = class(TCollectionItem)

  TParametros = class(TCollection)
  private
    FParametro : TFormatParam ;
    function GetItem(Index: Integer): TParametro;
    procedure SetItem(Index: Integer; Value: TParametro);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(Parametro: TFormatParam);
    function Add: TParametro;
    property Items[Index: Integer]: TParametro read GetItem write SetItem; default;
  end; // TParametros = class(TCollection)

  TFormatParam = class(TComponent)
  private
    { Private declarations }
    FAbout : TAboutProperty ;
    FParametros : TParametros ;
    FQuery : TDataSet ;
    FAbrirQuery : TAbrirQuery ;
    FRefGetSql: String;
    FMsgQdoEmpty: String;
    FMsgBarraStatus: String;
    procedure SetQuery(Value: TDataSet);
    procedure SetParametros(Value: TParametros);
    procedure SetMsgQdoEmpty(const Value: String);
    procedure SetRefGetSql(const Value: String);
    procedure SetMsgBarraStatus(const Value: String);
  protected
    { Protected declarations }
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override ;
    destructor Destroy ; override ;
    Function Execute(pMontaFiltros : Boolean = True) : Boolean ;
    Function TextoLog : String ;
    Function Achou : Boolean ;
    Function TempoDeExecucao : String ;
    Function Cabecalho(pCampo: String; pTextoCab : String='') : String ;
    procedure IgnoraParam(pCampos : Array Of String) ;
    procedure GravaLog(pComplementoLog : String=''; pNomeTela : String=''; pTempoDeExecucao : Boolean=True) ;
  published
    { Published declarations }
    property About          : TAboutProperty read FAbout          write FAbout ;
    property Query          : TDataSet       read FQuery          write SetQuery ;
    property Parametros     : TParametros    read FParametros     write SetParametros ;
    property RefGetSql      : String         read FRefGetSql      write SetRefGetSql ;
    property MsgQdoEmpty    : String         read FMsgQdoEmpty    write SetMsgQdoEmpty ;
    property MsgBarraStatus : String         read FMsgBarraStatus write SetMsgBarraStatus ;
  end; // TFormatParam = class(TComponent)

procedure Register;

implementation

Uses SysUtils,
     NumEdit,
     Mask,
     StdCtrls,
     TimeEdit,
     ToolEdit,
     Bgm_String,
     Bgm_Dados,
     Dialogs;

procedure Register;
begin
  RegisterComponents('BGM', [TFormatParam]);
  RegisterComponentEditor(TFormatParam,TFormatParamEditor);
end;

{ TFormatParamEditor }
procedure TFormatParamEditor.EditProperty ;
begin
  If (CompareText(Prop.GetName, 'Parametros') = 0) then
  Begin
    Prop.Edit ;
    Continue := False ;
  End ; // If (CompareText(Prop.GetName, 'Parametros') = 0) then
end;

procedure TFormatParamEditor.ExecuteVerb(Index: Integer);
begin
  inherited ;
  Edit ;
end;

function TFormatParamEditor.GetVerb(Index: Integer): string;
begin
  Result := 'Parametros...';
end;

function TFormatParamEditor.GetVerbCount: Integer;
begin
  Result := 1 ;
end;

{ TParametro }
procedure TParametro.Assign(Source: TPersistent);
begin
  If Source is TParametro then
  Begin
    IgnoraParam    := TParametro(Source).IgnoraParam ;
    Log            := TParametro(Source).Log ;
    Cabecalho      := TParametro(Source).Cabecalho ;
    NomeCampo      := TParametro(Source).NomeCampo ;
    CampoFin       := TParametro(Source).CampoFin ;
    CampoIni       := TParametro(Source).CampoIni ;
    TextoLog       := TParametro(Source).TextoLog ;
    TipoCampo      := TParametro(Source).TipoCampo ;
    OperadorLogico := TParametro(Source).OperadorLogico ;
    AceitaNulo     := TParametro(Source).AceitaNulo ;
    SelecaoAle     := TParametro(Source).SelecaoAle ;
  End Else
    inherited Assign(Source) ;
end;

constructor TParametro.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

function TParametro.GetDisplayName: string;
begin
  Result := FNomeCampo ;
  if Result = '' Then Result := inherited GetDisplayName;
end;

procedure TParametro.SetAceitaNulo(const Value: Boolean);
begin
  FAceitaNulo := Value;
end;

procedure TParametro.SetCabecalho(const Value: String);
begin
  FCabecalho := Value;
end;

procedure TParametro.SetCampoFin(const Value: TWinControl);
begin
  If (CampoIni <> Nil) And
     (Value <> Nil) And
     (TwinControl(Value).ClassType <> TwinControl(CampoIni).ClassType ) Then
    ShowMessage('Tipo de componente diferente do CampoIni.')
  Else // If (CampoIni <> Nil) And ...
  Begin
    FCampoFin := Value ;

    If Value Is TNumEdit Then
      TipoCampo := tpInteger
    Else // If Value Is TNumEdit Then
    If Value Is TDateEdit Then
      TipoCampo := tpDate ;
  End ; // Else // If (CampoIni <> Nil) And ...
end;

procedure TParametro.SetCampoIni(const Value: TWinControl);
begin
  If (CampoFin <> Nil) And
     (Value <> Nil) And
     (TwinControl(Value).ClassType <> TwinControl(CampoFin).ClassType ) Then
    ShowMessage('Tipo de componente diferente do CampoFin.')
  Else // If (CampoFin <> Nil) And ...
  Begin
    FCampoIni := Value ;

    If Value Is TNumEdit Then
      TipoCampo := tpInteger
    Else // If Value Is TNumEdit Then
    If Value Is TDateEdit Then
      TipoCampo := tpDate ;
  End ; // Else // If (CampoFin <> Nil) And ...
end;

procedure TParametro.SetIgnoraParam(const Value: Boolean);
begin
  FIgnoraParam := Value;
end;

procedure TParametro.SetLog(const Value: String);
begin
  FLog := Value;
end;

procedure TParametro.SetNomeCampo(const Value: String);
Var
  i, vQtde : Integer ;
  vAchou   : Boolean ;
begin
  vQtde  := Collection.Count-1 ;
  vAchou := False ;

  For i := 0 to vQtde do
    If (Trim(Value)<>'') And
       (Index <> i) And
       (Collection.Items[i].DisplayName = Value) Then
      vAchou := True ;

  If vAchou Then
    ShowMessage('NomeCampo já cadastrado.')
  Else
    FNomeCampo := Value ;
end;

procedure TParametro.SetOperadorLogico(Value: TOperadorLogico);
begin
  FOperadorLogico := Value;
end;

procedure TParametro.SetSelecaoAle(const Value: TSBSelecaoAle);
begin
  FTSBSelecaoAle := Value;
end;

procedure TParametro.SetTextoLog(const Value: String);
begin
  FTextoLog := Value ;
end;

procedure TParametro.SetTipoCampo(Value: TTipoCampo);
begin
  If (CampoIni Is TNumEdit) Or (CampoFin Is TNumEdit) Then
    FTipoCampo := tpInteger
  Else // If Value Is TNumEdit Then
  If (CampoIni Is TDateEdit) Or (CampoFin Is TDateEdit) Then
    FTipoCampo := tpDate
  Else
    FTipoCampo := Value;
end;

{ TParametros }
function TParametros.Add: TParametro;
begin
  Result := TParametro(inherited Add);
end;

constructor TParametros.Create(Parametro: TFormatParam);
begin
  inherited Create(TParametro);
  FParametro := Parametro ;
end;

function TParametros.GetItem(Index: Integer): TParametro;
begin
  Result := TParametro(inherited GetItem(Index));
end;

function TParametros.GetOwner: TPersistent;
begin
  Result := FParametro ;
end;

procedure TParametros.SetItem(Index: Integer; Value: TParametro);
begin
  inherited SetItem(Index, Value);
end;

{ TFormatParam }
constructor TFormatParam.Create(AOwner: TComponent);
begin
  inherited Create(AOwner) ;
  FParametros := TParametros.Create(Self) ;

  RefGetSql      := 'Pesq' + Screen.ActiveForm.Name ;
  MsgQdoEmpty    := 'Não foram encontrados dados com os filtros selecionados.' ;
  MsgBarraStatus := 'Consultando ...' ;

  cAboutNomeComponente := 'FormatParam' ;
  cAboutAutor          := 'Alessando A.J - 10/07/2006' ;
  cAboutVersao         := '3.3.0' ; // 1º propriedade nova ( zera o 2 e 3)
                                    // 2º Propriedades, funcões ou procedures novas ( zera o 3)
                                    // 3º controles e ajustes
  vRetornoLogEmpFilAut := '' ; // Variavel populada dentro funcao RetornaEmpFilAutorizadas
end;

destructor TFormatParam.Destroy;
begin
  FParametros.Free ;
  FAbout.Free ;
  inherited Destroy;
end;

procedure TFormatParam.SetQuery(Value: TDataSet);
begin
  FQuery := Value;
end;

procedure TFormatParam.SetParametros(Value: TParametros);
begin
  FParametros.Assign(Value);
end;

procedure TFormatParam.SetMsgQdoEmpty(const Value: String);
begin
  FMsgQdoEmpty := Value;
end;

procedure TFormatParam.SetMsgBarraStatus(const Value: String);
begin
  FMsgBarraStatus := Value;
end;

procedure TFormatParam.SetRefGetSql(const Value: String);
begin
  FRefGetSql := Value;
end;

procedure TFormatParam.Notification(AComponent: TComponent;  Operation: TOperation);
Var
  i, vQtde : Integer ;
begin
  inherited ;
  If Operation = opRemove Then
  Begin
    If AComponent = FQuery Then FQuery := nil ;

    vQtde := ComponentCount - 1 ;
    For i := 0 to vQtde do
    Begin
           If Components[i] = FParametros[i].FCampoFin      Then FParametros[i].FCampoFin      := nil
      Else If Components[i] = FParametros[i].FCampoIni      Then FParametros[i].FCampoIni      := nil
      Else If Components[i] = FParametros[i].FTSBSelecaoAle Then FParametros[i].FTSBSelecaoAle := nil ;
    End ; // For i := 0 to vQtde do
  End ; // If Operation = opRemove Then
end;

Function TFormatParam.Execute(pMontaFiltros : Boolean = True) : Boolean ;
Var
  i,
  vQtde       : Integer ;
  vTamanho,
  vCampoIni,
  vCampoFin   : Variant ;
  vFazFiltro,
  vIniDifFin  : Boolean ;
  vSeparaTexto,
  vParamIni,
  vParamFin   : String ;
  vCarFim     : Char ;
begin
  Result := False ;
  If Query = Nil Then
  Begin
    ShowMessage('Query não definida.') ;
    Exit ;
  End ; // If Query = Nil Then

  vQtde := Parametros.Count-1 ;
  For i := 0 To vQtde Do
  Begin
    With Parametros.Items[i] do
    Begin
      If (Trim(NomeCampo)='') Or
         (CampoIni=nil) Or
         (CampoFin=nil) Or
         (IgnoraParam) Then
      Begin
        If pMontaFiltros Then
          IgnoraParam := False ;
        Continue ;
      End ; // If (Trim(NomeCampo)='') Or (...

      Log         := '' ;
      vFazFiltro  := False ;
      vCampoIni   := '' ;
      vCampoFin   := '' ;
      vParamIni   := 'P_' + Copy(NomeCampo,Pos('.',NomeCampo)+1,Length(Trim(NomeCampo)) ) + '_INI' ;
      vParamFin   := 'P_' + Copy(NomeCampo,Pos('.',NomeCampo)+1,Length(Trim(NomeCampo)) ) + '_FIN' ;

      If CampoIni Is TEdit Then
      Begin
        vTamanho   := TEdit(CampoIni).MaxLength ;
        vCampoIni  := Trim(TEdit(CampoIni).Text) ;
        vCampoFin  := Trim(TEdit(CampoFin).Text) ;
        If TEdit(CampoFin).CharCase = ecUpperCase Then
          vCarFim  := 'Z'
        Else
           vCarFim := 'z' ;
        vFazFiltro := (Trim(vCampoIni) <> '') And
                      (Trim(vCampoFin) <> '') And
                      IIf(TipoCampo = tpString,(Trim(vCampoIni) <> '!')                 Or (Trim(vCampoFin) <> Replicate(vCarFim,vTamanho))
                                              ,(Trim(vCampoIni) <> StrZero(1,vTamanho)) Or (Trim(vCampoFin) <> Replicate('9',vTamanho))) ;
      End Else // If CampoIni Is TEdit Then
      If CampoIni Is TNumEdit Then
      Begin
        vTamanho   := TNumEdit(CampoIni).MaxValue ;
        vCampoIni  := TNumEdit(CampoIni).Value ;
        vCampoFin  := TNumEdit(CampoFin).Value ;
        vFazFiltro := (vCampoIni <> 0) And
                      (vCampoFin <> 0) And
                      ((vCampoIni <> 0) Or (FloatToStr(vCampoFin) <> Replicate('9',vTamanho))) ;
      End Else // If CampoIni Is TNumEdit Then
      If CampoIni Is TDateEdit Then
      Begin
        vCampoIni  := TDateEdit(CampoIni).Date ;
        vCampoFin  := TDateEdit(CampoFin).Date ;
        vFazFiltro := (vCampoIni <> 0) And
                      (vCampoFin <> 0) ;
      End Else // If CampoIni Is TDateEdit Then
      If CampoIni Is TMaskEdit Then
      Begin
        vTamanho   := TMaskEdit(CampoIni).MaxLength ;
        vCampoIni  := Trim(TMaskEdit(CampoIni).Text) ;
        vCampoFin  := Trim(TMaskEdit(CampoFin).Text) ;
        If TMaskEdit(CampoFin).CharCase = ecUpperCase Then
          vCarFim  := 'Z'
        Else
           vCarFim := 'z' ;
        vFazFiltro := (Trim(vCampoIni) <> '') And
                      (Trim(vCampoFin) <> '') And
                      IIf(TipoCampo = tpString,(Trim(vCampoIni) <> '!')                 Or (Trim(vCampoFin) <> Replicate(vCarFim,vTamanho))
                                              ,(Trim(vCampoIni) <> StrZero(1,vTamanho)) Or (Trim(vCampoFin) <> Replicate('9',vTamanho))) ;
      End Else // If CampoIni Is TMaskEdit Then
      If CampoIni Is TTimeEdit Then
      Begin
        {
           Em desenvolvimento
        }
      End ; // If CampoIni Is TTimeEdit Then

      If (Not pMontaFiltros) And
         vFazFiltro Then
      Begin
        Result := True ;
        Exit ;
      End ; // If (Not pMontaFiltros) And ...

      vIniDifFin := vCampoIni <> vCampoFin ;

      // Verifica se existe virgula no texto p/ separa-los (Antes da vírgula período, apos único)
      vSeparaTexto := '' ;
      If Pos(',',TextoLog) > 0 Then
      Begin
        If vIniDifFin Then
          vSeparaTexto := Trim(Copy(TextoLog,0,Pos(',',TextoLog)-1))
        Else // If vIniDifFin Then
          vSeparaTexto := Trim(Copy(TextoLog,Pos(',',TextoLog)+1,Length(Trim(TextoLog)))) ;
      End Else // If Pos(',',TextoLog) > 0 Then
        vSeparaTexto := TextoLog ;

      If vFazFiltro then
      begin
        Result := True ;

        With TQuery(Query) do
        Begin
          SQL.Add(' ' + IIf(OperadorLogico=olAndL,'AND',IIf(OperadorLogico=olOrL,'OR',''))
                 +' ' + IIf(AceitaNulo And vIniDifFin,'(','')
                 +' ' + NomeCampo + IIf(vIniDifFin,' BETWEEN :' + vParamIni + ' AND ',' = ')+ ' :' + vParamFin
                 +' ' + IIf(AceitaNulo And vIniDifFin,' OR '+ NomeCampo + ' IS NULL)','')
                 +' ' + IIf(OperadorLogico=olAndR,'AND',IIf(OperadorLogico=olOrR,'OR',''))) ;

          If vIniDifFin And (SelecaoAle <> Nil) Then
            SQL.Add(SelecaoAle.StringRetorno(Copy(NomeCampo,1,Pos('.',NomeCampo)-1), SelecaoAle.BuscaOL(IIf(OperadorLogico=olAndL,'AL','AR')) ) ) ;

          If TipoCampo = tpString Then
          Begin
            If vIniDifFin Then
              ParamByName(vParamIni).AsString := vCampoIni ;
            ParamByName(vParamFin  ).AsString := vCampoFin ;
          End Else // If TipoCampo = tpString Then
          If TipoCampo = tpInteger Then
          Begin
            If vTamanho > 9 Then
            Begin
              If vIniDifFin Then
                ParamByName(vParamIni).AsFloat := vCampoIni ;
              ParamByName(vParamFin  ).AsFloat := vCampoFin ;
            End Else // If vTamanho > 9 Then
            Begin
              If vIniDifFin Then
                ParamByName(vParamIni).AsInteger := vCampoIni ;
              ParamByName(vParamFin  ).AsInteger := vCampoFin ;
            End ; // End Else // If vTamanho > 9 Then
          End Else // If TipoCampo = tpInteger Then
          If TipoCampo = tpDate Then
          Begin
            If vIniDifFin Then
              ParamByName(vParamIni).AsDateTime := vCampoIni ;
            ParamByName(vParamFin  ).AsDateTime := vCampoFin ;
          End ; // If TipoCampo = tpDate Then
        End ; // With TQuery(Query) do

        If Trim(TextoLog) <> '' Then
        Begin
          Log := ', ' + vSeparaTexto + ': '  ;
          If (SelecaoAle <> Nil) And (Not SelecaoAle.IgnoraSelecao) Then
            Log := Log + SelecaoAle.StringRetornoLog
          Else // If (SelecaoAle <> Nil) And (...
            Log := Log + VarToStr(vCampoIni) + IIf(vIniDifFin,' ate ' + VarToStr(vCampoFin),'') ;
        End ; // If Trim(TextoLog) <> '' Then
      End ; // If vFazFiltro then

      Cabecalho := vSeparaTexto + ': '  ;
      If vFazFiltro Then
      Begin
        If (SelecaoAle <> Nil) And (Not SelecaoAle.IgnoraSelecao) Then
          Cabecalho := Cabecalho + SelecaoAle.StringRetornoLog
        Else // If (SelecaoAle <> Nil) And (...
          Cabecalho := Cabecalho + VarToStr(vCampoIni) + IIf(vIniDifFin,' ate ' + VarToStr(vCampoFin),'') ;
      End Else
        Cabecalho := Cabecalho + 'Todos' ;

    End ; // With Parametros.Items[i] do
  End ; // For i := 0 vQtde Do
end;

function TFormatParam.TextoLog: String;
Var
  i, vQtde : Integer ;
begin
  Result := '' ;
  vQtde  := Parametros.Count-1 ;
  For i := 0 To vQtde Do
    If Pos(Parametros.Items[i].Log,Result) = 0 Then
      Result := Result + Parametros.Items[i].Log ;
end;

function TFormatParam.Achou: Boolean;
Var
  vTempoIni : TDateTime ;
begin
  Result := False ;
  If Query = Nil Then
    ShowMessage('Query não definida.')
  Else // If Query = Nil Then
  Begin // Else // If Query = Nil Then
    vTempoIni := 0 ;
    If FAbrirQuery.TempoIni <> 0 Then // p/ guardar o tp ini somente uma vez, ate que seja exec a function TempoDeExecucao
      vTempoIni := FAbrirQuery.TempoIni ;

    FAbrirQuery := AbrirQuery(TQuery(Query)
                             ,IIf(Trim(RefGetSql)     ='','Pesq' + Screen.ActiveForm.Name,RefGetSql)
                             ,IIf(Trim(MsgQdoEmpty)   ='','Não foram encontrados dados com os filtros selecionados.',MsgQdoEmpty)
                             ,IIf(Trim(MsgBarraStatus)='','Consultando ...',MsgBarraStatus )) ;

    If vTempoIni <> 0 Then
      FAbrirQuery.TempoIni := vTempoIni ;

    Result := FAbrirQuery.Achou ;
  End ; // Else // If Query = Nil Then  
end;

function TFormatParam.TempoDeExecucao: String;
begin
  If FAbrirQuery.TempoIni <> 0 Then
    Result := ', tempo de execucao: ' + FormatDateTime('hh:mm:ss',Time - FAbrirQuery.TempoIni) ;
  FAbrirQuery.TempoIni := 0 ;
end;

procedure TFormatParam.IgnoraParam(pCampos: array of String);
Var
  i, j,
  vQtdeI, vQtdeJ : Integer ;
begin
  vQtdeI := Length(pCampos)-1 ;
  vQtdeJ := Parametros.Count-1 ;
  For i := 0 To vQtdeI Do
    For j := 0 To vQtdeJ Do
      If Parametros.Items[j].NomeCampo = pCampos[i] Then
      Begin
        Parametros.Items[j].IgnoraParam := True ;
        Break ;
      End ; // If Parametros.Items[j].NomeCampo = pCampos[i] Then
end;

procedure TFormatParam.GravaLog(pComplementoLog : String=''; pNomeTela : String=''; pTempoDeExecucao : Boolean=True) ;
begin
  BGM_Dados.GravaLog(vcSistema
                    ,vcUsuario
                    ,Now
                    ,RemoveAcentos(IIf(Trim(pNomeTela)='',StringReplace(Trim(Screen.ActiveForm.Caption),vcSistema + ' - ','',[rfReplaceAll, rfIgnoreCase])
                                                         ,pNomeTela)
                    +vRetornoLogEmpFilAut
                    +TextoLog
                    +pComplementoLog
                    +IIf(pTempoDeExecucao,TempoDeExecucao,''))
                    ) ;
end;

Function TFormatParam.Cabecalho(pCampo: String; pTextoCab : String='') : String ;
Var
  i,
  vQtde : Integer ;
begin
  vQtde  := Parametros.Count-1 ;
  Result := '' ;
  For i := 0 To vQtde Do
    If Parametros.Items[i].NomeCampo = pCampo Then
    Begin
      Result := Parametros.Items[i].Cabecalho ;
      Result := IIf(pTextoCab='',Result
                                ,pTextoCab + Copy(Result,Pos(': ',Result)+1,Length(Result))) ;
      Break ;
    End ; // If NomeCampo = pCampo Then
end;

end.
