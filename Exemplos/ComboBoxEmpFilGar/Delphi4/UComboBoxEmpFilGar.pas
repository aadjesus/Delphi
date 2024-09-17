unit UComboBoxEmpFilGar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, Db, DBTables, RxMemDS;

type
  TTipoCampo = (tpEmpresa, tpFilial, tpGaragem) ;
  TLayOut    = (loRSocial, loRSocialNFantasia, loNFantasia, loNFantasiaCidadeUF, loNGaragem, loNGaragemCidadeUF) ;

  TComboBoxEmpFilGar = class ;

  TPropriedades = class(TPersistent)
  private
    { Private declarations }
    FOwner     : TComboBoxEmpFilGar ;
    FTipoCampo : TTipoCampo ;
    FLayOut    : TLayOut ;
    FCodigo    : Integer ;
    FCampoAnt  : TComboBoxEmpFilGar ;
    FFiltraUsu : Boolean ;

    vDataBase      : TDataBase;
    procedure pDataBase(Const Valor: TDataBase);
    function IIf(pCondicao: Boolean; pResultTrue, pResultFalse: Variant): Variant ;

    procedure SetCampoAnt(Value: TComboBoxEmpFilGar);
    procedure SetTipoCampo(Value: TTipoCampo); virtual;
    procedure GetCodigo(const Value: Integer);
    procedure SetLayOut(Value: TLayOut);
    procedure GetFiltraUsu(const Value: Boolean);
  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComboBoxEmpFilGar );  virtual;
    destructor  Destroy; override;
  published
    { Published declarations }
    property TipoCampo : TTipoCampo         read FTipoCampo write SetTipoCampo default tpEmpresa ;
    property Codigo    : Integer            read FCodigo    write GetCodigo ;
    property LayOut    : TLayOut            read FLayOut    write SetLayOut default loRSocial ;
    property CampoAnt  : TComboBoxEmpFilGar read FCampoAnt  write SetCampoAnt;
    property FiltraUsu : Boolean            read FFiltraUsu write GetFiltraUsu default False ;

    property DataBase                : TDataBase    Read vDataBase               Write pDataBase;

  end ; // TPropriedades = class(TPersistent)

  TEstrutura = Record
    Codigo        : String ;
    Rsocial       : String ;
    NomeFantasia  : String ;
    Cidade        : String ;
    Uf            : String ;
    Endereco      : String ;
    NumeroEnd     : String ;
    ComplEnd      : String ;
    Cep           : String ;
    Bairro        : String ;
    Fone          : String ;
    Fax           : String ;
    HomePag       : String ;
    EMail         : String ;
    Matriz        : String ;
    TipoInscricao : String ;
    Inscricao     : String ;
    IMunicipal    : String ;
    IEstadual     : String ;
  End ; // TEstrutura = Record

  TComboBoxEmpFilGar = class(TCustomComboBox)
  private
    { Private declarations }
    FPropriedades : TPropriedades ;
    FPMenuOp      : TPopupMenu ;
    FQuery        : TQuery ;
    FRxMData      : TRxMemoryData ;
    FIMenu        : Array[0..5] of TMenuItem ;
    FDadosNoHint  : Boolean ;
    LimpaEstru    : TEstrutura ;
    FCodigoEmp,
    FCodigoFil    : Integer ;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure PMenuOnPopup(Sender: TObject);
    procedure IMenuOnClick(Sender: TObject);
  protected
    { Protected declarations }
    property  PopupMenu ;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    Procedure MontaListaEmpFilGar ;
  public
    { Public declarations }
    Estrutura : TEstrutura ;
    constructor Create(AOwner: TComponent);  override;
    destructor  Destroy; override;
  published
    { Published declarations }
    property Color;
    property Font;
    property Enabled;
    property TabOrder;
    property Visible;
    property ShowHint;
    
    property OnChange;
    property OnClick;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property Propriedades : TPropriedades read FPropriedades write FPropriedades ;
  end;

procedure Register;

implementation

//uses
//  {$INCLUDE \Globus\Sistemas\UsesUtilitarios.txt};

Var
  vcSistema, vcUsuario : String ;

procedure Register;
begin
  RegisterComponents('Comum', [TComboBoxEmpFilGar]);
end;

{ TPropriedades }

constructor TPropriedades.Create(AOwner: TComboBoxEmpFilGar);
begin
  inherited Create ;
  FOwner := AOwner ;
end;

destructor TPropriedades.Destroy;
begin
  inherited Destroy ;
end;

procedure TPropriedades.GetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TPropriedades.SetLayOut(Value: TLayOut);
Var
  i   : Integer ;
  vOk : Boolean ;
begin
  vOk := ((TipoCampo  = tpGaragem) And (Value In [loNGaragem, loNGaragemCidadeUF])) Or
         ((TipoCampo <> tpGaragem) And (Value In [loRSocial, loRSocialNFantasia, loNFantasia, loNFantasiaCidadeUF])) ;

  If Not vOk Then
    ShowMessage('LayOut especifico para o TipoCampo = ' + IIf(TipoCampo = tpGaragem,'tpEmpresa ou tpFilial'
                                                                                   ,'tpGaragem') )
  Else
    FLayOut := Value ;

  For i := 0 to 5 do
    FOwner.FIMenu[i].Checked := False ;

  Case FLayOut of
    loRSocial           : FOwner.FIMenu[0].Checked := True ;
    loRSocialNFantasia  : FOwner.FIMenu[1].Checked := True ;
    loNFantasia         : FOwner.FIMenu[2].Checked := True ;
    loNFantasiaCidadeUF : FOwner.FIMenu[3].Checked := True ;
    loNGaragem          : FOwner.FIMenu[4].Checked := True ;
    loNGaragemCidadeUF  : FOwner.FIMenu[5].Checked := True ;
  End ; // Case FLayOut of
end;

procedure TPropriedades.SetCampoAnt(Value: TComboBoxEmpFilGar);
Var
  vOk : Boolean ;
begin
  vOk := (Value <> Self.CampoAnt) And
         (((TipoCampo = tpFilial)  And (Value.Propriedades.TipoCampo = tpEmpresa)) Or
          ((TipoCampo = tpGaragem) And (Value.Propriedades.TipoCampo = tpFilial))) ;

  If Not vOk Then
  Begin
    If Value <> CampoAnt Then
      ShowMessage(IIf(TipoCampo = tpEmpresa,'O componente com TipoCompo = tpEmpresa não é associado a nenhum componente'
                                           ,'O TipoCompo do compomente associado tem que ser igual a ' + IIf(TipoCampo = tpFilial,'tpEmpresa'
                                                                                                                                 ,'tpFilial')) + '.' )
  End Else
    FCampoAnt := Value ;

  If CampoAnt <> Nil Then
    CampoAnt.FreeNotification(Self.CampoAnt) ;
end;

procedure TPropriedades.SetTipoCampo(Value: TTipoCampo);
begin
  FTipoCampo := Value ;
  If (Value = tpGaragem) And (LayOut In [loRSocial, loRSocialNFantasia, loNFantasia, loNFantasiaCidadeUF]) Then
    LayOut := loNGaragem ;
end;

procedure TPropriedades.GetFiltraUsu(const Value: Boolean);
begin
  FFiltraUsu := Value ;
end;

procedure TPropriedades.pDataBase(const Valor: TDataBase);
begin
  vDataBase := Valor;
end;

function TPropriedades.IIf(pCondicao: Boolean; pResultTrue,
  pResultFalse: Variant): Variant;
begin
  If pCondicao Then
    Result := pResultTrue
  else
    Result := pResultFalse;
end;

{ TComboBoxEmpFilGar }
constructor TComboBoxEmpFilGar.Create(AOwner: TComponent);
Var
  i : Integer ;
const
  vIMenuCaption  : Array[0..5] of String    = ('Razão social','Razão Social/Nome Fantasia','Nome fantasia','Nome Fantasia/Cidade/UF','Nome','Nome/Cidade/UF') ;
  vIMenuShortCut : Array[0..5] of TShortCut = (         16466,                       16467,          16462,                    16454, 16462,           16454) ;
begin
  inherited Create(AOwner);
  FPropriedades := TPropriedades.Create(Self) ;
  FQuery        := TQuery.Create(Self) ;
//  FQuery.DatabaseName := cDataBaseName ;
  FRxMData      := TRxMemoryData.Create(Self) ;

  FPMenuOp         := TPopupMenu.Create(Self) ;
  FPMenuOp.Name    := 'FPopupMenuOp' + Self.Name ;
  FPMenuOp.OnPopup := PMenuOnPopup ;
  If Self <> Nil Then
    PopupMenu := FPMenuOp ;

  Estrutura  := LimpaEstru ;
  FCodigoEmp := 0 ;
  FCodigoFil := 0 ;

  FDadosNoHint := Trim(Hint) = '' ;
  For i := 0 to 5 do
  Begin
    FIMenu[i]          := TMenuItem.Create(Self) ;
    FIMenu[i].Caption  := vIMenuCaption[i] ;
    FIMenu[i].ShortCut := vIMenuShortCut[i] ;
    FIMenu[i].Checked  := False ;
    FIMenu[i].Checked  := (i=0) And (Propriedades.LayOut = loRSocial) ;
    FPMenuOp.Items.Add(FIMenu[i]) ;
    FPMenuOp.Items[i].OnClick := IMenuOnClick ;
  End ; // For i := 0 to Length(FIMenu) do

  vcSistema := 'EST' ;
  vcUsuario := 'GLOBUS' ;

  If Propriedades.LayOut = loRSocial Then
    Propriedades.SetLayOut( loRSocial ) ;
end;

procedure TComboBoxEmpFilGar.CMEnter(var Message: TCMEnter);
  Procedure PopulaEmpresa ;
  Begin
    With FQuery do
    Begin
      Close ;
      SQL.Clear ;
      SQL.Add(' SELECT'+
              '  A.CODIGOEMPRESA       AS CODIGO'+
              ' ,B.CHECKSUMEMPRESA     AS CHECKSUM'+
              ' ,B.RSOCIALEMPRESA      AS RSOCIAL'+
              ' ,B.NOMEFANTASIAEMPRESA AS NOMEFANTASIA'+
              ' ,A.CIDADEEMPRESA       AS CIDADE'+
              ' ,A.CODIGOUF            AS UF'+
              ' ,A.ENDERECOEMPRESA     AS ENDERECO'+
              ' ,A.NUMEROENDEMPRESA    AS NUMEROEND'+
              ' ,A.COMPLENDEMPRESA     AS COMPLEND'+
              ' ,A.CEPEMPRESA          AS CEP'+
              ' ,A.BAIRROEMPRESA       AS BAIRRO'+
              ' ,A.FONEEMPRESA         AS FONE'+
              ' ,A.FAXEMPRESA          AS FAX'+
              ' ,A.HOMEPAGEEMPRESA     AS HOMEPAG'+
              ' ,A.EMAILEMPRESA        AS EMAIL'+
              ' ,'' ''                 AS MATRIZ'+
              ' ,B.TIPOINSCRICAOEMPAUT AS TIPOINSCRICAO'+
              ' ,B.INSCRICAOEMPRESA    AS INSCRICAO'+
              ' ,A.IMUNICIPALEMPRESA   AS IMUNICIPAL'+
              ' ,A.IESTADUALEMPRESA    AS IESTADUAL'+
              '') ;
      Sql.Add(' FROM'+
              '  CTR_CADEMP              A'+
              ' ,CTR_EMPAUTORIZADAS      B'+
              ' ,CTR_AUTORIZACAOSISTEMAS C'+
              '') ;
      Sql.Add(' WHERE'+
              '     A.CODINTEMPAUT = B.CODINTEMPAUT'+
              ' AND A.CODINTEMPAUT = C.CODINTEMPAUT'+
              ' AND C.SISTEMA      = :P_SISTEMA'+
              '') ;
              If Propriedades.FiltraUsu Then
              Begin
                SQL.Add(' AND A.CODIGOEMPRESA IN'+
                        ' ('+
                        '') ;
                SQL.Add(' SELECT'+
                        ' DISTINCT A.CODIGOEMPRESA'+
                        '') ;
                SQL.Add(' FROM'+
                        '  CTR_FILIAL              A'+
                        ' ,CTR_EMPAUTORIZADAS      B'+
                        ' ,CTR_AUTORIZACAOSISTEMAS C'+
                        ' ,CTR_CADASTRODEUSUARIOS  D'+
                        ' ,CTR_AUTORIZACAOUSUARIOS E'+
                        ' ,CTR_GRUPOUSUARIOS       F'+
                        '') ;
                SQL.Add(' WHERE'+
                        '     A.CODINTEMPAUT = B.CODINTEMPAUT'+
                        ' AND A.CODINTEMPAUT = C.CODINTEMPAUT'+
                        ' AND A.CODINTEMPAUT = E.CODINTEMPAUT'+
                        ' AND E.CODIGOGRPUSU = D.CODIGOGRPUSU'+
                        ' AND D.CODIGOGRPUSU = F.CODIGOGRPUSU'+
                        ' AND C.SISTEMA      = :P_SISTEMA'+
                        ' )'+
                        '') ;
              End ; // If Propriedades.FiltraUsu Then
      ParamByName('P_SISTEMA').AsString  := vcSistema ;
    End ; // With FQuery do
  End ; // Procedure PopulaEmpresa ;

  Procedure PopulaFilial ;
  Begin
    With FQuery do
    Begin
      Close ;
      SQL.Clear ;
      SQL.Add(' SELECT'+
              '  A.CODIGOFL            AS CODIGO'+
              ' ,B.CHECKSUMEMPRESA     AS CHECKSUM'+
              ' ,B.RSOCIALEMPRESA      AS RSOCIAL'+
              ' ,B.NOMEFANTASIAEMPRESA AS NOMEFANTASIA'+
              ' ,A.CIDADEFL            AS CIDADE'+
              ' ,A.CODIGOUF            AS UF'+
              ' ,A.ENDERECOFL          AS ENDERECO'+
              ' ,A.NUMEROENDFL         AS NUMEROEND'+
              ' ,A.COMPLENDFL          AS COMPLEND'+
              ' ,A.CEPFL               AS CEP'+
              ' ,A.BAIRROFL            AS BAIRRO'+
              ' ,A.FONEFL              AS FONE'+
              ' ,A.FAXFL               AS FAX'+
              ' ,A.HOMEPAGEFL          AS HOMEPAG'+
              ' ,A.EMAILFL             AS EMAIL'+
              ' ,A.MATRIZFL            AS MATRIZ'+
              ' ,B.TIPOINSCRICAOEMPAUT AS TIPOINSCRICAO'+
              ' ,B.INSCRICAOEMPRESA    AS INSCRICAO'+
              ' ,A.INSCMUNICIPALFL     AS IMUNICIPAL'+
              ' ,A.IESTADUALFL         AS IESTADUAL'+
              '') ;
      Sql.Add(' FROM'+
              '  CTR_FILIAL              A'+
              ' ,CTR_EMPAUTORIZADAS      B'+
              ' ,CTR_AUTORIZACAOSISTEMAS C'+
              '') ;
              If Propriedades.FiltraUsu Then
                SQL.Add('  CTR_CADASTRODEUSUARIOS  D'+
                        ' ,CTR_AUTORIZACAOUSUARIOS E'+
                        ' ,CTR_GRUPOUSUARIOS       F'+
                        '') ;
      Sql.Add(' WHERE'+
              '     A.CODINTEMPAUT = B.CODINTEMPAUT'+
              ' AND A.CODINTEMPAUT = C.CODINTEMPAUT'+
              ' AND CODIGOEMPRESA  = :P_CODIGOEMPRESA'+
              ' AND C.SISTEMA      = :P_SISTEMA'+
              '') ;
              If Propriedades.FiltraUsu Then
                SQL.Add(' AND A.CODINTEMPAUT = E.CODINTEMPAUT'+
                        ' AND E.CODIGOGRPUSU = D.CODIGOGRPUSU'+
                        ' AND D.CODIGOGRPUSU = F.CODIGOGRPUSU'+
                        '') ;
      ParamByName('P_CODIGOEMPRESA').AsInteger := Propriedades.CampoAnt.Propriedades.Codigo ;
      ParamByName('P_SISTEMA'      ).AsString  := vcSistema ;
    End ; // With FQuery do
  End ; // Procedure PopulaFilial ;

  Procedure PopulaGaragem ;
  Begin
    With FQuery do
    Begin
      Close ;
      SQL.Clear ;
      SQL.Add(' SELECT'+
              '  A.CODIGOGA    AS CODIGO'+
              ' ,'' ''         AS CHECKSUM'+
              ' ,A.NOMEGA      AS RSOCIAL'+
              ' ,A.NOMEGA      AS NOMEFANTASIA'+
              ' ,A.CIDADEGA    AS CIDADE'+
              ' ,A.CODIGOUF    AS UF'+
              ' ,A.ENDERECOGA  AS ENDERECO'+
              ' ,A.NUMEROENDGA AS NUMEROEND'+
              ' ,A.COMPLENDGA  AS COMPLEND'+
              ' ,A.CEPGA       AS CEP'+
              ' ,A.BAIRROGA    AS BAIRRO'+
              ' ,'' ''         AS FONE'+
              ' ,'' ''         AS FAX'+
              ' ,'' ''         AS HOMEPAG'+
              ' ,'' ''         AS EMAIL'+
              ' ,'' ''         AS MATRIZ'+
              ' ,'' ''         AS TIPOINSCRICAO'+
              ' ,'' ''         AS INSCRICAO'+
              ' ,'' ''         AS IMUNICIPAL'+
              ' ,'' ''         AS IESTADUAL'+
              '') ;
      SQL.Add(' FROM'+
              '  CTR_GARAGEM    A'+
              ' ,CTR_FILIAL_GAR B'+
              '') ;
              If Propriedades.FiltraUsu Then
                SQL.Add('  CTR_FILIAL               C'+
                        ' ,CTR_USUARIOSPOREMPFILGAR D'+
                        '') ;
      SQL.Add(' WHERE'+
              '     A.CODIGOGA      = B.CODIGOGA'+
              ' AND B.CODIGOEMPRESA = :P_CODIGOEMPRESA'+
              ' AND B.CODIGOFL      = :P_CODIGOFL'+
              '') ;
              If Propriedades.FiltraUsu Then
                SQL.Add(' AND C.CODIGOEMPRESA = B.CODIGOEMPRESA'+
                        ' AND C.CODIGOFL      = B.CODIGOFL'+
                        ' AND D.CODIGOEMPRESA = B.CODIGOEMPRESA'+
                        ' AND D.CODIGOFL      = B.CODIGOFL'+
                        ' AND D.CODIGOGA      = B.CODIGOGA'+
                        '') ;
      ParamByName('P_CODIGOEMPRESA').AsInteger := Propriedades.CampoAnt.Propriedades.CampoAnt.Propriedades.Codigo ;
      ParamByName('P_CODIGOFL'     ).AsInteger := Propriedades.CampoAnt.Propriedades.Codigo ;
    End ; // With FQuery do
  End ; // Procedure PopulaGaragem ;
begin
{
  If ((Propriedades.TipoCampo = tpEmpresa) And (Not FRxMData.IsEmpty)) Or
     ((Propriedades.TipoCampo = tpFilial ) And (Propriedades.CampoAnt.Propriedades.Codigo <> Propriedades.CampoAnt.Propriedades.FCodigo) ) Or
     ((Propriedades.TipoCampo = tpGaragem) And (Propriedades.CampoAnt.Propriedades.CampoAnt.Propriedades.Codigo <> Propriedades.CampoAnt.Propriedades.CampoAnt.Propriedades.FCodigo) ) Then
    Exit ;
}
  If Propriedades.TipoCampo = tpEmpresa Then
  Begin
    If Not FRxMData.IsEmpty Then
    Begin
      ShowMessage('A empresa já esta populado') ;
      Exit ;
    End ;
  End ;

  If Propriedades.TipoCampo = tpFilial  Then
  Begin
//  Propriedades.CampoAnt.Tag
    If Propriedades.CampoAnt.Propriedades.Codigo = FCodigoEmp Then
    Begin
      ShowMessage('A filial já esta populado') ;
      Exit ;
    End ;
  End ;
  If Propriedades.TipoCampo = tpGaragem Then
  Begin
    If (Propriedades.CampoAnt.Propriedades.Codigo                       = FCodigoEmp) And
       (Propriedades.CampoAnt.Propriedades.CampoAnt.Propriedades.Codigo = FCodigoFil) Then
    Begin
      ShowMessage('A garagem já esta populado') ;
      Exit ;
    End ;
  End ;

  FQuery.DatabaseName := Propriedades.DataBase.Name ; // cDataBaseName ;
  If Propriedades.FiltraUsu Then
    Propriedades.FiltraUsu := Pos(vcUsuario,'GLOBUS_MANAGER') = 0 ;

  Case Propriedades.TipoCampo of
    tpEmpresa : PopulaEmpresa ;
    tpFilial  : PopulaFilial  ;
    tpGaragem : PopulaGaragem ;
  End ; // Case Propriedades.TipoCampo of

  If Propriedades.FiltraUsu Then
  Begin
    FQuery.SQL.Add(' AND D.USUARIO = :P_USUARIO') ;
    FQuery.ParamByName('P_USUARIO').AsString := vcUsuario ;
  End ; // If Propriedades.FiltraUsu Then

  FQuery.Open ;
  FRxMData.LoadFromDataSet(FQuery,0,lmCopy) ;
  FRxMData.SortOnFields('CODIGO') ;

  If FDadosNoHint Then
    ShowHint := False ;

  FCodigoEmp := 0 ;
  FCodigoFil := 0 ;
  Estrutura  := LimpaEstru ;
  MontaListaEmpFilGar ;
  inherited ;
end;

procedure TComboBoxEmpFilGar.CMExit(var Message: TCMExit);
Var
  vCodigo : Integer ;
begin
  Try

    vCodigo := StrToInt(Copy(Text,1,3)) ;
  Except
    vCodigo := 0 ;
  End;

  If Not FRxMData.Locate('CODIGO',vCodigo ,[LocaseInsensitive]) Then
  Begin
    ShowMessage(Propriedades.IIf(Propriedades.TipoCampo=tpEmpresa,'Empresa',
                Propriedades.IIf(Propriedades.TipoCampo=tpFilial,'Filial','Garagem')) + ' não encontrada.') ;
    Exit ;
  End ; // If Not FRxMData.Locate(...

  With Estrutura do
  Begin
    Codigo        := FRxMData.FieldByName('CODIGO'       ).AsString ;
    Rsocial       := FRxMData.FieldByName('RSOCIAL'      ).AsString ;
    NomeFantasia  := FRxMData.FieldByName('NOMEFANTASIA' ).AsString ;
    Cidade        := FRxMData.FieldByName('CIDADE'       ).AsString ;
    Uf            := FRxMData.FieldByName('UF'           ).AsString ;
    Endereco      := FRxMData.FieldByName('ENDERECO'     ).AsString ;
    NumeroEnd     := FRxMData.FieldByName('NUMEROEND'    ).AsString ;
    ComplEnd      := FRxMData.FieldByName('COMPLEND'     ).AsString ;
    Cep           := FRxMData.FieldByName('CEP'          ).AsString ;
    Bairro        := FRxMData.FieldByName('BAIRRO'       ).AsString ;
    Fone          := FRxMData.FieldByName('FONE'         ).AsString ;
    Fax           := FRxMData.FieldByName('FAX'          ).AsString ;
    HomePag       := FRxMData.FieldByName('HOMEPAG'      ).AsString ;
    EMail         := FRxMData.FieldByName('EMAIL'        ).AsString ;
    Matriz        := FRxMData.FieldByName('MATRIZ'       ).AsString ;
    TipoInscricao := FRxMData.FieldByName('TIPOINSCRICAO').AsString ;
    Inscricao     := FRxMData.FieldByName('INSCRICAO'    ).AsString ;
    IMunicipal    := FRxMData.FieldByName('IMUNICIPAL'   ).AsString ;
    IEstadual     := FRxMData.FieldByName('IESTADUAL'    ).AsString ;
    If FDadosNoHint Then
    Begin
      Hint := Propriedades.IIf(Propriedades.TipoCampo = tpGaragem, 'Nome          : ' + Rsocial
                                                                 , 'Rasão social  : ' + Rsocial
                                                                 +  #13 + 'Nome fantasia : ' + NomeFantasia)

             + Propriedades.IIf(Trim(Cidade)        ='','',#13 + 'Cidade              : ' + Cidade)
             + Propriedades.IIf(Trim(Uf)            ='','',#13 + 'UF                  : ' + Uf)
             + Propriedades.IIf(Trim(Endereco)      ='','',#13 + 'Endereço            : ' + Endereco)
             + Propriedades.IIf(Trim(NumeroEnd)     ='','',#13 + 'Numero              : ' + NumeroEnd)
             + Propriedades.IIf(Trim(ComplEnd)      ='','',#13 + 'Complemento         : ' + ComplEnd)
             + Propriedades.IIf(Trim(Cep)           ='','',#13 + 'Cep                 : ' + Cep)
             + Propriedades.IIf(Trim(Bairro)        ='','',#13 + 'Bairro              : ' + Bairro)
             + Propriedades.IIf(Trim(Fone)          ='','',#13 + 'Fone                : ' + Fone)
             + Propriedades.IIf(Trim(Fax)           ='','',#13 + 'Fax                 : ' + Fax)
             + Propriedades.IIf(Trim(HomePag)       ='','',#13 + 'Home Page           : ' + HomePag)
             + Propriedades.IIf(Trim(EMail)         ='','',#13 + 'E-Mail              : ' + EMail)
             + Propriedades.IIf(Trim(Matriz)        ='','',#13 + 'Matriz              : ' + Matriz)
             + Propriedades.IIf(Trim(TipoInscricao) ='','',#13 + 'Tipo de inscrição   : ' + TipoInscricao)
             + Propriedades.IIf(Trim(Inscricao)     ='','',#13 + 'Número              : ' + Inscricao)
             + Propriedades.IIf(Trim(IMunicipal)    ='','',#13 + 'Inscrição municipal : ' + IMunicipal)
             + Propriedades.IIf(Trim(IEstadual)     ='','',#13 + 'Inscrição estadual  : ' + IEstadual) ;
      ShowHint := True ;
    End ; // If FDadosNoHint Then
  End ; // With Estrutura do

  If Propriedades.TipoCampo = tpEmpresa Then 
    FCodigoEmp := vCodigo
  Else
  If Propriedades.TipoCampo = tpFilial Then
    FCodigoFil := vCodigo ;
//    tpGaragem
    
  Propriedades.Codigo := vCodigo ;
  inherited ;
end;

destructor TComboBoxEmpFilGar.Destroy;
Var
  i : Integer ;
begin
  For i := 0 to 5 do
    FIMenu[i].Free ;

  FPropriedades.Free ;
  FPMenuOp.Free ;
  FQuery.Free ;
  FRxMData.Free ;
  inherited Destroy ;
end;

procedure TComboBoxEmpFilGar.Notification(AComponent: TComponent; Operation: TOperation);
begin
  Inherited Notification(AComponent, Operation) ;
  If (Operation = opRemove) and (AComponent = FPropriedades.FCampoAnt) then
    FPropriedades.FCampoAnt := nil ;
end;

procedure TComboBoxEmpFilGar.MontaListaEmpFilGar ;
Var
  vCampo : String ;
  Function Encripta( sCampo : String; iQtdChar : Byte; Posicional : Boolean = False  ) : String;
  Var I          : Byte;
      iAux       : LongInt;
      oRes, nRes : String;
  begin
    iAux := 0;
    sCampo := AnsiUpperCase( sCampo ) ;
    { Adiciona 32 ao código ASCII de cada caracter da string e
      acumula seus respectivos códigos em um somador }
    For I := 1 To Length( sCampo ) Do
    Begin
      If Posicional Then
        Inc( iAux, Ord( sCampo[I] ) * I)
      Else
        Inc( iAux, Ord( sCampo[I] ) + 32 );
    End;
    { Retorna as 10 primeiras posições do resultado da divisão
      do somador por 357 }
    oRes := Copy( FloatToStr(iAux / 357), 1, iQtdChar );
    nRes := '';
    For I := 1 To Length(oRes) Do
    begin
      If Copy(oRes,I,1) = ',' Then
        nRes := nRes + '.'
      else
        nRes := nRes + Copy(oRes,I,1);
    end;
    Result := nRes;
  end ;
  
  Function StrZero( nNum : Real; iTam : Byte; iPrec : Byte = 0 ): String;
  var I    : Byte;
      sAux : String;
  begin
    Str( nNum:iTam:iPrec, sAux );
    I := 1;
    While sAux[I] = ' ' Do
    Begin
      sAux[I] := '0';
      Inc( I );
    End;
    Result := sAux;
  end ;
begin
  Items.Clear ;

  With FRxMData Do
  Begin
    First ;
    While Not Eof Do
    Begin
      If (Propriedades.TipoCampo = tpGaragem) Or
         (FieldByName('CHECKSUM').AsString = Encripta(FieldByName('RSOCIAL'     ).AsString
                                                     +FieldByName('INSCRICAO'   ).AsString
                                                     +FieldByName('NOMEFANTASIA').AsString,10)) Then
      Begin
        vCampo := '' ;
        If Propriedades.LayOut In [loRSocial, loRSocialNFantasia, loNGaragem] Then
          vCampo := FieldByName('RSOCIAL').AsString ;

        If Propriedades.LayOut In [loRSocialNFantasia, loNFantasia, loNFantasiaCidadeUF] Then
          If Propriedades.LayOut In [loRSocialNFantasia] Then
            vCampo := vCampo +' -- '+ FieldByName('NOMEFANTASIA').AsString
          Else
            vCampo := FieldByName('NOMEFANTASIA').AsString ;

        If Propriedades.LayOut In [loNFantasiaCidadeUF, loNGaragemCidadeUF] Then
            vCampo := vCampo + ' -- ' + FieldByName('CIDADE').AsString
                             + '/'    + FieldByName('UF'    ).AsString ;

        Items.Add(StrZero(FieldByName('CODIGO').AsInteger,3)
                  + ' ' + vCampo
                 ) ; // Items.Add(...
      End ; // If (Propriedades.TipoCampo = tpGaragem) Or
      Next ;
    End ; // While Not Eof Do
    ItemIndex := 0 ;
  End ; // With FRxMData Do
end;

procedure TComboBoxEmpFilGar.PMenuOnPopup(Sender: TObject);
Var
  i : Integer ;
begin
  FPMenuOp.AutoPopup := True ;
  For i := 0 to 5 do
    FIMenu[i].Visible := ((i <= 3) And (Propriedades.TipoCampo <> tpGaragem)) Or
                         ((i >= 4) And (Propriedades.TipoCampo  = tpGaragem)) ;
end;

procedure TComboBoxEmpFilGar.IMenuOnClick(Sender: TObject);
begin
  If Not TMenuItem(Sender).Visible Then Exit ;

  Case TMenuItem(Sender).MenuIndex of
    0 : Propriedades.LayOut := loRSocial ;
    1 : Propriedades.LayOut := loRSocialNFantasia ;
    2 : Propriedades.LayOut := loNFantasia ;
    3 : Propriedades.LayOut := loNFantasiaCidadeUF ;
    4 : Propriedades.LayOut := loNGaragem ;
    5 : Propriedades.LayOut := loNGaragemCidadeUF ;
  End ; // Case FLayOut of

  MontaListaEmpFilGar ;
end;

end.
