{
********************************************************************************
HIST�RICO DE AJUSTES/IMPLEMENTA��ES
********************************************************************************
27/07/2006 Ver�nica   Colocado no create para quando for D7 a propriedade
                      AutoComplete fique false. Esta propriedade n�o existe no D4.
10/02/2006 - Lima   - Ajuste para preencher ao propriedade POPUPMENU somente se
                      a vari�vel vPMenuFilial for diferente de NIL.
27/01/2006 - Silvio - Inclus�o do DESTRUCTOR.
28/12/2004 - RIOBOO - Implementa��o de par�metros por Sistema/Empresa de Layout
                      de Filial (Raz�o Social, Nome Fantasia, etc...) para os
                      Modulos FLP/SRH/ESC/FRQ/TER/PLT (SIM 9295).
                      Qdo estiver configurado "Padr�o" ir� respeitar a configu-
                      ra��o do Componente.
********************************************************************************
}

unit BGMPedeFilialGaragem;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, dbTables, Bgm_String, Bgm_Utils, Bgm_Tela, menus ;

type
//  TKeyEvent = procedure (Sender: TObject; var Key: Word; Shift: TShiftState) of object;

  TBGMPedeFilialGaragem = class(TComboBox)
  private
    { Declara eventos }
    vPedeFilialGaragemExit,
    vPedeFilialGaragemEnter: TNotifyEvent;

    { Private declarations }
    vParamInterno, qryFilialGaragem,vQuery        :  TQuery;

    { propriedades }
    vDataBase      : TDataBase;

    vCodigoEmpresa,
    vCodigoFG      : Integer;

    vTabela        : TTable;
    vCampo         : String;

    vValorArqIniOld,
    vValorArqIni    : String ;

    FPopupMenu      : TPopupMenu ;
    FMenuItem       : Array[0..3] of TMenuItem ;

    vCidadeUF,
    vApenasNomeFantasia,
    vNomeFantasia      : Boolean;

    procedure pDataBase(Const Valor: TDataBase);
    procedure pCodigoEmpresa(Const Valor: Integer);
    procedure pCodigoFG(Const Valor: Integer);
    procedure pTabela(Const Valor: TTable);
    procedure pQuery(Const Valor: TQuery);
    procedure pCampo(Const Valor: String);
    procedure pNomeFantasia(Const Valor: Boolean);
    procedure pApenasNomeFantasia(Const Valor: Boolean);
    procedure pCidadeUF(Const Valor: Boolean);
    { procedures auxiliares }
    procedure PesquisaNaComboBox(Sender: TObject);
    procedure SaidaDaComboBox(Sender: TObject);
    Function ConsisteSaidaDaComboBox : Boolean;
    procedure FazEntradaNaComboBox(Sender: TObject);
    Function ConsisteDataEUsuarioParaFilial : Boolean;
    procedure FPopupMenuOnPopup(Sender: TObject);
    procedure FMenuItemClick(Sender: TObject);
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
  protected
    { Protected declarations }
    procedure PedeFilialGaragemExit; dynamic;
    procedure PedeFilialGaragemEnter; dynamic;
    procedure CreateWnd; override;
  public
    vLimparFilial : Boolean;
    vPosicionarNaFilial : Integer;
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure PopulaComboBox;
    procedure AtualizaComboBox;
    procedure LimpaFilial;
  published
    { Published declarations }
    property OnPedeFilialGaragemExit : TNotifyEvent Read vPedeFilialGaragemExit  Write vPedeFilialGaragemExit;
    property OnPedeFilialGaragemEnter: TNotifyEvent Read vPedeFilialGaragemEnter Write vPedeFilialGaragemEnter;
    property DataBase                : TDataBase    Read vDataBase               Write pDataBase;
    property CodigoEmpresa           : Integer      Read vCodigoEmpresa          Write pCodigoEmpresa;
    property CodigoFG                : Integer      Read vCodigoFG               Write pCodigoFG;
    property Tabela                  : TTable       Read vTabela                 Write pTabela;
    property Query                   : TQuery       Read vQuery                  Write pQuery;
    property Campo                   : String       Read vCampo                  Write pCampo;
    property NomeFantasia            : Boolean      Read vNomeFantasia           Write pNomeFantasia;
    property ApenasNomeFantasia      : Boolean      Read vApenasNomeFantasia     Write pApenasNomeFantasia;
    property CidadeUF                : Boolean      Read vCidadeUF               Write pCidadeUF;
  end;

procedure Register;

implementation

uses
  GlbComum,
  {$INCLUDE \Globus\Sistemas\UsesUtilitarios.txt} ;

procedure Register;
begin
  RegisterComponents('BGM', [TBGMPedeFilialGaragem]);
end;

constructor TBgmPedeFilialGaragem.Create (AOwner:TComponent);
Var
  i : Integer ;
const
  vMenuItemCaption  : Array[0..3] of String    = ( 'Raz�o social','Raz�o Social/Nome Fantasia',          'Nome fantasia', 'Nome Fantasia/Cidade/UF') ;
  vMenuItemShortCut : Array[0..3] of TShortCut = (          16466,                       16467,                    16462,                     16454) ;
  vMenuItemName     : Array[0..3] of String    = ('vIMenuRSocial','vIMenuNFantasia'           ,'vIMenuRSocial_NFantasia','vIMenuRFantasia_CidadeUF') ;
begin
  inherited Create(AOwner);
  qryFilialGaragem := TQuery.Create(Self);
  vParamInterno    := TQuery.Create(Self);
  { Seta propriedades }
  Height              := 21;
  Width               := 240;
  Text                := '';
  vLimparFilial       := False;
  vPosicionarNaFilial := 0;

  FPopupMenu         := TPopupMenu.Create(Nil) ;
  FPopupMenu.OnPopup := FPopupMenuOnPopup ;
  For i := 0 to 3 do
  Begin
    FMenuItem[i]          := TMenuItem.Create(Self) ;
    FMenuItem[i].Caption  := vMenuItemCaption[i] ;
    FMenuItem[i].ShortCut := vMenuItemShortCut[i] ;
    FMenuItem[i].Name     := vMenuItemName[i] ;

    FMenuItem[i].Checked  := False ;
    FPopupMenu.Items.Add(FMenuItem[i]) ;
    FPopupMenu.Items[i].OnClick := FMenuItemClick ;
  End ; // For i := 0 to Length(FIMenu) do

  vValorArqIni := '' ;

{$IFnDEF VER120} // Vers�o <> DELPHI 4
  { Esta propriedade estava fazendo com que ao digitar o n�mero 1 ela trouzesse a empresa 100 }
  AutoComplete := False;
{$ENDIF}

  { Eventos }
  OnChange := PesquisaNaComboBox;
  OnExit   := SaidaDaComboBox;
  OnEnter  := FazEntradaNaComboBox;
end;

destructor TBgmPedeFilialGaragem.Destroy;
Var
  i : Integer ;
begin
  OnChange := Nil;
  OnExit   := Nil;
  OnEnter  := Nil;
  qryFilialGaragem.Free;
  vParamInterno.Free;

  For i := 0 to 3 do
    FMenuItem[i].Free ;

  FPopupMenu.Free;
  inherited Destroy;
end;

{ Procedures auxiliares }

procedure TBgmPedeFilialGaragem.PopulaComboBox;
Var
  Sql : String;
  EmpExist :Boolean;
  nCont :Integer;
  vAuxCidadeUF,
  vAuxNomeFantasia,
  vAuxApenasNomeFantasia: Boolean;
begin
  { Estando no nosso ambiente }
  If vcUsuarioManagerComSenhaUm And (CodigoEmpresa = 0) Then
    ShowMessage('PopulaComboBox chamado antes de definir a propriedade CODIGOEMPRESA no PedeFilialGaragem. Avise o desenvolvimento.');

  // VOLTANDO VALORES ORIGINAIS DO COMPONENTE
  vAuxCidadeUF           := vCidadeUF;
  vAuxNomeFantasia       := vNomeFantasia;
  vAuxApenasNomeFantasia := vApenasNomeFantasia;

  { Seta variavel para false }
  vLimparFilial := False;
  { Define o script }

  If (vcUsuario = 'GLOBUS') Or
     (vcUsuario = 'MANAGER') Then // N�o consiste pelo grupo
    Sql := 'SELECT ' +
           'F.CODIGOFL, '                  +
           'A.RSOCIALEMPRESA, '            +
           'A.CHECKSUMEMPRESA, '           +
           'A.INSCRICAOEMPRESA, '          +
           'A.NOMEFANTASIAEMPRESA, '       +
           'A.CODINTEMPAUT, '              +
           'F.CODIGOUF, F.CIDADEFL, '      +
           'C.SISTEMA '                    +
         'FROM '                           +
           'CTR_FILIAL F, '                +
           'CTR_EMPAUTORIZADAS A, '        +
           'CTR_AUTORIZACAOSISTEMAS C '    +
         'WHERE ' +
           'F.CODIGOEMPRESA = ' + IntToStr(CodigoEmpresa) + ' AND ' +
           'F.CODINTEMPAUT  = A.CODINTEMPAUT AND '        +
           'F.CODINTEMPAUT  = C.CODINTEMPAUT AND '        +
           'C.SISTEMA = ''' + vcSistema + '''' +
         'ORDER BY ' +
           'F.CODIGOFL'
  Else
    Sql := 'SELECT ' +
           'F.CODIGOFL, '                  +
           'A.RSOCIALEMPRESA, '            +
           'A.CHECKSUMEMPRESA, '           +
           'A.INSCRICAOEMPRESA, '          +
           'A.NOMEFANTASIAEMPRESA, '       +
           'A.CODINTEMPAUT, '              +
           'F.CODIGOUF, F.CIDADEFL, '      +
           'C.SISTEMA '                    +
         'FROM '                           +
           'CTR_FILIAL F, '                +
           'CTR_EMPAUTORIZADAS A, '        +
           'CTR_AUTORIZACAOSISTEMAS C, '   +
           'CTR_AUTORIZACAOUSUARIOS AU, '  +
           'CTR_CADASTRODEUSUARIOS CADU, ' +
           'CTR_GRUPOUSUARIOS GU '         +
         'WHERE ' +
           'F.CODIGOEMPRESA = ' + IntToStr(CodigoEmpresa) + ' AND ' +
           'F.CODINTEMPAUT  = A.CODINTEMPAUT AND '        +
           'F.CODINTEMPAUT  = C.CODINTEMPAUT AND '        +
           'F.CODINTEMPAUT  = AU.CODINTEMPAUT AND '       +
           'AU.CODIGOGRPUSU = CADU.CODIGOGRPUSU AND '     +
           'GU.CODIGOGRPUSU = CADU.CODIGOGRPUSU AND '     +
           'C.SISTEMA = ''' + vcSistema + ''' AND '     +
           'CADU.USUARIO = ''' + vcUsuario + ''' ' +
         'ORDER BY ' +
           'F.CODIGOFL';
  { Limpa a ComboBox }
  Items.Clear;
//  Text := '';

  // PARTICULARIDADES DE SISTEMAS PARA LAYOUT DO NOME DA FILIAL EM "FREQUENCIA"
  // PARTICULARIDADES DE SISTEMAS PARA LAYOUT DO NOME DA FILIAL EM "ESCALA"
  // PARTICULARIDADES DE SISTEMAS PARA LAYOUT DO NOME DA FILIAL EM "PLANTAO"
  If (vcSistema = 'FRQ') OR
     (vcSistema = 'ESC') OR
     (vcSistema = 'PLT') Then
  begin
    vParamInterno.DataBaseName := DataBase.Name;
    vParamInterno.Close;
    vParamInterno.SQL.Clear;

    If (vcSistema = 'ESC') Then
      // ESCALA
      vParamInterno.Sql.Add('SELECT ' +
                            '  LAYOUTFILIAL ' +
                            'FROM ' +
                            '  T_ESC_PARAM_ESCALA ' +
                            'WHERE ' +
                            '  CODIGOEMPRESA = ' + IntToStr(CodigoEmpresa))
    Else If (vcSistema = 'FRQ') Then
      // FREQUENCIA
      vParamInterno.Sql.Add('SELECT ' +
                            '  LAYOUTFILIAL ' +
                            'FROM ' +
                            '  FRQ_PARAM_EMPRESA ' +
                            'WHERE ' +
                            '  CODIGOEMPRESA = ' + IntToStr(CodigoEmpresa))
    Else
      // PLANTAO
      vParamInterno.Sql.Add('SELECT ' +
                            '  LAYOUTFILIAL ' +
                            'FROM ' +
                            '  PLT_PARAMETROS ' +
                            'WHERE ' +
                            '  SISTEMA = ''' + vcSistema + '''');

    vParamInterno.Open;
    If (NOT vParamInterno.IsEmpty) And
       (vParamInterno.FieldByName('LAYOUTFILIAL').AsInteger > 0) Then
    begin
      vAuxNomeFantasia       := (vParamInterno.FieldByName('LAYOUTFILIAL').AsInteger = 2);
      vAuxApenasNomeFantasia := (vParamInterno.FieldByName('LAYOUTFILIAL').AsInteger = 3);
      vAuxCidadeUF           := (vParamInterno.FieldByName('LAYOUTFILIAL').AsInteger = 4);
    end;
  end;

  // PARTICULARIDADES DE SISTEMAS PARA LAYOUT DO NOME DA FILIAL EM "RECURSOS HUMANOS"
  // PARTICULARIDADES DE SISTEMAS PARA LAYOUT DO NOME DA FILIAL EM "FOLHA DE PAGAMENTO"
  If (vcSistema = 'FLP') OR
     (vcSistema = 'SRH') Then
  begin
    vParamInterno.DataBaseName := DataBase.Name;
    vParamInterno.Close;
    vParamInterno.SQL.Clear;
    If (vcSistema = 'FLP') Then
      // FOLHA
      vParamInterno.Sql.Add('SELECT ' +
                            '  RESPOSTAPARAMINTERNO ' +
                            'FROM ' +
                            '  FLP_PARAMINTERNODESTINO ' +
                            'WHERE ' +
                            '  CODPARAMINTERNO = 809 AND ' +
                            '  CODIGOEMPRESA = ' + IntToStr(CodigoEmpresa))
    Else
      // RECURSOS HUMANOS
      vParamInterno.Sql.Add('SELECT ' +
                            '  RESPOSTAPARAM RESPOSTAPARAMINTERNO ' +
                            'FROM ' +
                            '  SRH_PARAMETROSDESTINO ' +
                            'WHERE ' +
                            '  CODPARAM = 202 AND ' +
                            '  CODIGOEMPRESA = ' + IntToStr(CodigoEmpresa));
    vParamInterno.Open;
    If (NOT vParamInterno.IsEmpty) And
       (vParamInterno.FieldByName('RESPOSTAPARAMINTERNO').AsString <> 'Padr�o') Then
    begin
      vAuxCidadeUF           := (vParamInterno.FieldByName('RESPOSTAPARAMINTERNO').AsString = 'Nome Fantasia -- Cidade/UF');
      vAuxNomeFantasia       := (vParamInterno.FieldByName('RESPOSTAPARAMINTERNO').AsString = 'Raz�o Social -- Nome Fantasia');
      vAuxApenasNomeFantasia := (vParamInterno.FieldByName('RESPOSTAPARAMINTERNO').AsString = 'Nome Fantasia');
    end;
  end;

  If Trim(vValorArqIni) = '' Then
  Begin
    vValorArqIni    := LeArqIni(vcUsuario,'T=' + Screen.Forms[0].Name + 'C=' + Name) ;
    vValorArqIniOld := vValorArqIni ;
  End Else // If Trim(vValorArqIni) = '' Then
  If vValorArqIniOld = vValorArqIni Then
  Begin
    vAuxCidadeUF           := Copy(vValorArqIni,Pos('vCUF=',vValorArqIni) + 5,1) = 'S' ;
    vAuxNomeFantasia       := Copy(vValorArqIni,Pos('vNF=', vValorArqIni) + 4,1) = 'S' ;
    vAuxApenasNomeFantasia := Copy(vValorArqIni,Pos('vANF=',vValorArqIni) + 5,1) = 'S' ;
  End Else // End Else // If Trim(vValorArqIni) = '' Then
  If vValorArqIniOld <> vValorArqIni Then
  Begin
    GravaArqIni(vcUsuario
               ,'T='    + Screen.Forms[0].Name
               +'C='    + Name
               ,vValorArqIni) ;
    vValorArqIniOld := vValorArqIni ;
  End ; // If vValorArqIniOld <> vValorArqIni Then
  {
  vIMenuRSocial.Checked            := (Not vAuxCidadeUF) And (Not vAuxNomeFantasia) And (Not vAuxApenasNomeFantasia) ;
  vIMenuRSocial_NFantasia.Checked  := (Not vAuxCidadeUF) And (    vAuxNomeFantasia) And (Not vAuxApenasNomeFantasia) ;
  vIMenuNFantasia.Checked          := (Not vAuxCidadeUF) And (    vAuxNomeFantasia) And (    vAuxApenasNomeFantasia) ;
  vIMenuRFantasia_CidadeUF.Checked := (    vAuxCidadeUF) ;
  }

  { Executa a query }
  qryFilialGaragem.DataBaseName := DataBase.Name;
  qryFilialGaragem.Close;
  qryFilialGaragem.SQL.Clear;
  qryFilialGaragem.Sql.Add(Sql);
  With qryFilialGaragem do
  begin
    Open;
    First;
    While Not Eof Do
    begin
      If FieldByName('CHECKSUMEMPRESA').asString =
         Encripta( FieldByName('RSocialEmpresa'     ).asString +
                   FieldByName('InscricaoEmpresa'   ).asString +
                   FieldByName('NomeFantasiaEmpresa').asString , 10 ) Then
      Begin
        If (vAuxCidadeUF) then { Traz codigo, cidade e a uf da filial }
          Items.Add( StrZero(FieldByName('CodigoFL').asInteger,3,0) + ' ' +
                     FieldByName('NomeFantasiaEmpresa').asString + ' -- ' +
                     FieldByName('CidadeFL').asString  + '/' + FieldByName('CodigoUF').asString )
        else
        If (Not vAuxNomeFantasia) and (not vAuxApenasNomeFantasia) Then { Traz o codigo e a raz�o social }
          Items.Add( StrZero(FieldByName('CodigoFL').asInteger,3,0) + ' ' + FieldByName('RSocialEmpresa').asString )
        Else  // Se informou tag, acrescenta o chr dele e o nome fantasia da filial
          If (vAuxNomeFantasia) and (not vAuxApenasNomeFantasia) Then { Traz codigo, raz�o e nome fantasia }
            Items.Add( StrZero(FieldByName('CodigoFL').asInteger,3,0) + ' ' +
                     FieldByName('RSocialEmpresa').asString +
                     //#0 + // Para identificar onde encerra a raz�o social
                     ' -- ' + FieldByName('NomeFantasiaEmpresa').asString)
          else { Apenas nome fantasia }
            Items.Add( StrZero(FieldByName('CodigoFL').asInteger,3,0) + ' ' +
                       FieldByName('NomeFantasiaEmpresa').asString)

      End;
      Next;
    end;
    Close;
  end;

  If Text = '' then Text := Items[0]
  Else
  begin
    EmpExist := False;
    For nCont := 0 To Items.Count -1 do
    begin
      If Items[nCont] = Text then
      begin
        EmpExist := True;
        Break;
      end;
    end;
    If not EmpExist then Text := Items[0]
  end;

  { Caso tenha sido informado para posicionar na Filial atraves da variavel }
  If vPosicionarNaFilial > 0 Then
  begin
    CodigoFG := vPosicionarNaFilial;
    AtualizaComboBox;
    vPosicionarNaFilial := 0;
  end
  else
  begin
    { Testa se a tabela esta ativa para saber se deve ou n�o atualizar a
      informacao }
    If Campo <> '' Then
    begin
      If ( Query <> Nil                           ) And
         ( Query.Active                           ) And
         ( Query.FieldByName(Campo).asInteger > 0 ) Then
      begin
        CodigoFG := Query.FieldByName(Campo).asInteger;
        AtualizaComboBox;
      end;
    end
    else
    begin
      If ( Tabela <> Nil                           ) And
         ( Tabela.Active                           ) And
         ( Tabela.FieldByName(Campo).asInteger > 0 ) Then
      begin
        CodigoFG := Tabela.FieldByName(Campo).asInteger;
        AtualizaComboBox;
      end;
    end;
  end;
end;

{ Definicao de propriedades }

procedure TBgmPedeFilialGaragem.pDataBase(Const Valor: TDataBase);
begin
  vDataBase := Valor ;
end;

procedure TBgmPedeFilialGaragem.pCodigoEmpresa(Const Valor: Integer);
begin
  vCodigoEmpresa := Valor;
end;

procedure TBgmPedeFilialGaragem.pCodigoFG(Const Valor: Integer);
begin
  vCodigoFG := Valor;
end;

procedure TBgmPedeFilialGaragem.pTabela(Const Valor: TTable);
begin
  vTabela := Valor;
end;

procedure TBgmPedeFilialGaragem.pQuery(Const Valor: TQuery);
begin
  vQuery := Valor;
end;

procedure TBgmPedeFilialGaragem.pCampo(Const Valor: String);
begin
  vCampo := Valor;
end;

procedure TBgmPedeFilialGaragem.pNomeFantasia(Const Valor: Boolean);
begin
  vNomeFantasia := Valor;
end;

procedure TBgmPedeFilialGaragem.pApenasNomeFantasia(Const Valor: Boolean);
begin
  vApenasNomeFantasia := Valor;
end;

procedure TBgmPedeFilialGaragem.pCidadeUF(Const Valor: Boolean);
begin
  vCidadeUF := Valor;
end;

{ Metodos }

procedure TBgmPedeFilialGaragem.AtualizaComboBox;
begin
  Text := IntToStr(CodigoFG);
  ConsisteSaidaDaComboBox;
end;

procedure TBgmPedeFilialGaragem.LimpaFilial;
begin
  Text           := '';
  Enabled        := True;
  CodigoEmpresa  := 0;
  CodigoFG       := 0;
  vLimparFilial  := True;
end;

{ Eventos }

procedure TBgmPedeFilialGaragem.PedeFilialGaragemExit;
begin
  If Assigned(vPedeFilialGaragemExit) Then vPedeFilialGaragemExit(Self);
end;

procedure TBgmPedeFilialGaragem.PedeFilialGaragemEnter;
begin
  If Assigned(vPedeFilialGaragemEnter) Then vPedeFilialGaragemEnter(Self);
end;

procedure TBgmPedeFilialGaragem.PesquisaNaComboBox(Sender: TObject);
Var
  I: Integer;
begin
  { Seta variavel para False }
  vLimparFilial := False;
  { Encontra a filial na combo }
  For I := 0 To Items.Count-1 do
  begin
    If Copy(Items[I],1,3) = Text Then
    begin
      Text := Items[I];
      CodigoFG := StrToInt(Copy(Items[I],1,3));
      ConsisteDataEUsuarioParaFilial; // Silvio
      Break;
    end
  end;
end;

procedure TBgmPedeFilialGaragem.FazEntradaNaComboBox(Sender: TObject);
begin
  { Seta a variavel }
  vLimparFilial := False;
  { Popula Combo }
  PopulaComboBox;
  { Chama o Evento }
  PedeFilialGaragemEnter;
  Inherited;
end;

procedure TBgmPedeFilialGaragem.SaidaDaComboBox(Sender: TObject);
begin
  { Caso seja para limpar a filial, ignora a consistencia }
  If vLimparFilial Then Exit;
  { Faz Consistencia da Combo }
  If ConsisteSaidaDaComboBox Then PedeFilialGaragemExit { Chama o evento }
  else FazEntradaNaComboBox(Self);
  Inherited;
end;

Function TBgmPedeFilialGaragem.ConsisteSaidaDaComboBox : Boolean;
Var
  I, T : Integer;
  Achou: Boolean;
begin
//  Result := True;

  Achou := False;

  try
    T := StrToInt(Copy(Text,1,3));
  except
    T := 0;
  end;
  For I := 0 To Items.Count-1 do
  begin
    If StrToInt(Copy(Items[I],1,3)) = T Then
    begin
      Text  := Items[I];
      Achou := True;
      Break;
    end
  end;
  If Not Achou Then
  begin
    MensagemDlg('Filial n�o encontrada.', mtInformacao, mbOk );
    CodigoFg := 0;
    Result := False;
    SetFocus;
    Exit;
  end;
  CodigoFG := T;
  If Tabela = Nil Then
    begin
      If ( Campo <> ''   ) And
         ( Query.Active ) Then
        Query.FieldByName(Campo).asInteger := CodigoFG;
    end
  else
    begin
      If ( Campo <> ''   ) And
         ( Tabela.Active ) Then
        Tabela.FieldByName(Campo).asInteger := CodigoFG;
    end;
  Result := ConsisteDataEUsuarioParaFilial; // Silvio
end;

Function TBgmPedeFilialGaragem.ConsisteDataEUsuarioParaFilial : Boolean; // Silvio
Var
  vSql       : String;
//  vGrupo     : Integer;
  vAutorizado: Boolean;
begin
  Result := True;
  { Caso a tabela esteja aberta, grava no campo o conteudo de CodigoFG }
  If Tabela = Nil Then
  begin
    If ( Campo <> ''   ) And
       ( Query.Active ) Then
      Query.FieldByName(Campo).asInteger := CodigoFG;
  end
  else
  begin
    If ( Campo <> ''   ) And
       ( Tabela.Active ) Then
      Tabela.FieldByName(Campo).asInteger := CodigoFG;
  end;
  { Faz consistencia do sistema }
  vSql := 'SELECT ' +
            'A.SISTEMA, ' +
            'A.DATALIMITEDEUSO, ' +
            'A.CHECKSUMAUTSISTEMAS ' +
          'FROM ' +
            'CTR_AUTORIZACAOSISTEMAS A, ' +
            'CTR_FILIAL ' +
          'WHERE ' +
            'CTR_FILIAL.CODIGOFL = ' + IntToStr(CodigoFG) + ' AND ' +
            'CTR_FILIAL.CODIGOEMPRESA = ' + IntToStr(CodigoEmpresa) + ' AND ' +
            'A.CODINTEMPAUT = CTR_FILIAL.CODINTEMPAUT AND ' +
            'A.SISTEMA = ''' + vcSistema + '''';
  qryFilialGaragem.Close;
  qryFilialGaragem.Sql.Clear;
  qryFilialGaragem.Sql.Add(vSql);
  qryFilialGaragem.Open;
  If qryFilialGaragem.IsEmpty Then
  begin
    MensagemDlg('Filial ' + StrZero(CodigoFG,3) + ' n�o autorizada para o sistema ' + vcSistema + '.', mtErro, mbOk );
    CodigoFG := 0;
    qryFilialGaragem.Close;
    Result := False;
    SetFocus;
    Exit;
  End;
  If qryFilialGaragem.FieldByName('CheckSumAutSistemas').asString <>
     Encripta( qryFilialGaragem.FieldByName('Sistema').asString + qryFilialGaragem.FieldByName('DataLimiteDeUso').asString, 10 ) Then
  begin
    MensagemDlg('Autoriza��o de sistemas violada. Contactar o suporte.', mtErro, mbOk );
    CodigoEmpresa := 0;
    qryFilialGaragem.Close;
    Result := False;
    SetFocus;
    Exit;
  end;
  qryFilialGaragem.Close;
  { Caso o usuario seja GLOBUS ou MANAGER, n�o consiste os dados abaixo }
  If (vcUsuario = 'GLOBUS') Or (vcUsuario = 'MANAGER') Then
    Exit;
  { Checa se o usuario est� autorizado a utilizar esta filial }
  vSql := 'SELECT ' +
            'AUT.CODINTEMPAUT, '       +
            'AUT.CODIGOGRPUSU, '       +
            'AUT.CHECKSUMAUTUSUARIOS ' +
          'FROM ' +
            'CTR_CADASTRODEUSUARIOS  USU, ' +
            'CTR_AUTORIZACAOUSUARIOS AUT, ' +
            'CTR_FILIAL              FIL  ' +
          'WHERE ' +
            'AUT.CODINTEMPAUT = FIL.CODINTEMPAUT AND ' +
            'AUT.CODIGOGRPUSU = USU.CODIGOGRPUSU AND ' +
            'USU.USUARIO = ' + '''' + vcUsuario + '''' + ' AND ' +
            'FIL.CODIGOEMPRESA = '  + IntToStr(CodigoEmpresa) + ' AND ' +
            'FIL.CODIGOFL = '  + IntToStr(CodigoFG);
  vAutorizado := True;
  { Abre a query }
  With qryFilialGaragem Do
  begin
    Close;
    Sql.Clear;
    Sql.Add(vSql);
    Open;
    If ( IsEmpty ) Or
       ( FieldByName('CHECKSUMAUTUSUARIOS').asString <> Encripta( FieldByName('CODINTEMPAUT').asString +
                                                                  FieldByName('CODIGOGRPUSU').asString, 10 ) ) Then
    begin
      MensagemDlg('Usu�rio n�o autorizado a utilizar esta filial. (Grupo)', mtInformacao, mbOk );
      CodigoFG := 0;
      vAutorizado   := False;
      Result := False;
    end;
    Close;
  end;
  { Caso n�o esteja autorizado, faz um foco na propria empresa }
  If Not vAutorizado Then SetFocus;
end;

procedure TBgmPedeFilialGaragem.FPopupMenuOnPopup(Sender: TObject);
Begin
  FMenuItem[0].Visible := CodigoEmpresa <> 0 ;
  FMenuItem[1].Visible := FMenuItem[0].Visible ;
  FMenuItem[2].Visible := FMenuItem[0].Visible ;
  FMenuItem[3].Visible := FMenuItem[0].Visible ;

  FMenuItem[0].Checked := (Not CidadeUF) And (Not NomeFantasia) And (Not ApenasNomeFantasia) ;
  FMenuItem[1].Checked := (Not CidadeUF) And (    NomeFantasia) And (Not ApenasNomeFantasia) ;
  FMenuItem[2].Checked := (Not CidadeUF) And (    NomeFantasia) And (    ApenasNomeFantasia) ;
  FMenuItem[3].Checked := (    CidadeUF) ;
End;

procedure TBgmPedeFilialGaragem.FMenuItemClick(Sender: TObject);
begin
  If TMenuItem(Sender).Visible Then
  Begin
    NomeFantasia       := (TMenuItem(Sender).MenuIndex  = 1) Or
                          (TMenuItem(Sender).MenuIndex  = 2) ;
    ApenasNomeFantasia := (TMenuItem(Sender).MenuIndex  = 1) ;
    CidadeUF           := (TMenuItem(Sender).MenuIndex  = 3) ;

    vValorArqIni := 'vCUF=' + IIf(CidadeUF,'S','N')+
                    'vNF='  + IIf(NomeFantasia,'S','N')+
                    'vANF=' + IIf(ApenasNomeFantasia,'S','N') ;
    PopulaComboBox ;
  End ; // If TMenuItem(Sender).Visible Then
End;

procedure TBGMPedeFilialGaragem.CNKeyDown(var Message: TWMKeyDown);
begin
  If Message.CharCode = 93 Then
  Begin
    FMenuItem[0].MenuIndex := 0 ;
    FPopupMenu.Popup(Self.ClientOrigin.x+2 ,Self.ClientOrigin.y+2) ;
  End ; // If Message.CharCode = 93 Then

  inherited ;
end;

procedure TBGMPedeFilialGaragem.CreateWnd;
begin
  inherited CreateWnd ;

  If csDesigning In ComponentState Then
    PopupMenu := Nil
  Else
    PopupMenu := FPopupMenu ;
end;

end.
