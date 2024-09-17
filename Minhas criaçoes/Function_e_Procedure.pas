unit Funcoes;

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Wordcap, Menus, ComCtrls, ImgList, MemTable, db ;

Type
  TAbrirQuery = Record
    Achou    : Boolean ;
    TempoIni : TDateTime ;
    TempoFin : TDateTime ;
    Minutos  : TDateTime ;
  End ; // TAbrirQuery = Record

interface

Uses
  MenuItemPesquisa ;

Function TrazComparacaoDivergente(pQuery : TQuery
                                 ;pCriaRx: Boolean = True): String;      // 10/10/2003 - Global.Pas

Procedure IdentificaHintNaTela(Sender: TObject);                         // 12/01/2004 - Global.Pas

procedure OrdenaColunas(pColuna: TColumn) ;                              // 19/03/2004 - Global.Pas

Function  VerificaParametrosDaTela: Boolean ;                            // 19/03/2004 - Global.Pas

Procedure PosicionaBotoes(pPanel: TPanel
                         ;pMudaTamanhoDoPainel  : Boolean = True
                         ;pMudaTamanhoDosBotoes : Boolean = True ) ;     // 14/09/2004 - Global.Pas

function RetornaEmpFilAutorizadas(pNomeCampoEmpresa
                                 ,pNomeCampoFilial : String
                                 ;pFiltroEmpIni
                                 ,pFiltroEmpFin
                                 ,pFiltroFilIni
                                 ,pFiltroFilFin : Integer ): AnsiString; // 04/03/2005 - Global.Pas

Function AbrirQuery(pQuery: TQuery
                   ;pReferenciaGetSql : String = ''
                   ;pMsgQdoEmpty : String = ''
                   ;pMsgBarraStatus : String = ''): TAbrirQuery;         // 17/03/2006 - Global.Pas

procedure GravaLogDasExcecoes(Sender: TObject
                             ; E: Exception) ;                           // 30/03/2006 - dmControle.Pas (Ainda ñ foi implementada)

Function ValidaCodCliente(pClientes : Array Of Integer ) : Boolean ;     // 10/08/2006 - Global.Pas

Procedure MostraUltimoLogGravado ;                                       // 01/11/2006 - Global.Pas (Ainda ñ foi implementada)

Function CampoExiste(pNomeDoCampo : String
                    ;pNomeDaTabela : String = '') : Boolean;             // 06/02/2007 - Global.Pas (Ainda ñ foi implementada)

Procedure MostraLogDoDia ;                                               // 07/02/2007 - Global.Pas (Ainda ñ foi implementada)


Function ExecQuery(pQuery: TQuery
                  ;pReferenciaGetSql : String = ''
                  ;pMsg : String = ''
                  ;pMsgBarraStatus : String = ''
                  ;pExecRollback : Boolean = True ): TAbrirQuery;       // 14/03/2007 - Global.Pas (Ainda ñ foi implementada)

Var
  vColuna : Integer ;
  vOrdem  : Boolean ;
  PMenuPesquisa : TPopupMenu ;
  IMenuPesquisa : TMenuItemPesquisa ;

implementation

Uses
  RxMemDS ;

Var
  vRxCompDive : TRxMemoryData ;

Function TrazComparacaoDivergente(pQuery : TQuery; pCriaRx : Boolean = True ) : String;
Var
  vItem : Integer ;
Begin
  // Quando o componente já estiver e for cria novamente
  If (vRxCompDive <> nil) And (pCriaRx) Then
  Begin
    vRxCompDive := Nil ;
    vRxCompDive.Free ;
  End ; // If (vRxCompDive <> nil) And
  
  If (vRxCompDive = nil) Or (pCriaRx) then
    vRxCompDive := TRxMemoryData.Create(Nil) ;

  Result := '' ;
  If vRxCompDive.RecordCount <= 0 Then // Verifica se existe registro na Memory Data
  Begin
    vRxCompDive.EmptyTable ;
    vRxCompDive.LoadFromDataSet(pQuery,0,lmCopy) ; // Copia a estrutura e todos registros da query p/ a Memory Data
  End Else // If pRx.RecordCount <= 0 Then
  Begin
    With vRxCompDive.Fields do
    Begin
      // Se q quandidade de campos do 2º select estiver diferente com a do 1º select cai fora
      If Count <> pQuery.Fields.Count Then
        Exit ;

      For vItem := 0 to Count-1 Do
        If Fields[vItem].AsString <> pQuery.Fields[vItem].AsString Then // Compara o conteúdo dos campos
          Result := Result + '(' + Fields[vItem].FieldName +') de ' +
                           IIf( Trim(              Fields[vItem].AsString)='','<vazio>',              Fields[vItem].AsString) +' para ' +
                           IIf( Trim(pQuery.Fields.Fields[vItem].AsString)='','<vazio>',pQuery.Fields.Fields[vItem].AsString) +', '  ;

      // Se achou alguma diferença, retira a ultima virgula.
      Result := IIf(Trim(Result)<>'',Copy(Result,1,Length(Trim(Result))-1),'') ;

      vRxCompDive := Nil ; // Iguala a Nil pq o componente só é liberado da memoria quando o mesmo esta em um Form.
      vRxCompDive.Free ; // Apenas p/ garantir que foi liberado da memoria
    End ; // With vRxCompDive.Fields do
  End ; // End Else
End ; // TrazComparacaodivergente(pQuery : TQuery) : String;

Procedure IdentificaHintNaTela(Sender : TObject) ;
Var
  v,
  vTop,
  vLeft  : integer ;
  vImage : TImage ;
  vPanel : TPanel ;
  Procedure CriaIdendificadorDeHint(Seq : Integer) ;
  Var a,b : integer ;
  Begin
    // Cria um componente panel
    vPanel := TPanel.Create(TForm(Sender));
    vPanel.Name       := 'hintpnl'+IntToStr(seq);
    vPanel.Caption    := '' ;
    vPanel.BevelOuter := bvNone ;
    vPanel.Height := 04 ;
    vPanel.Width  := 04 ;

    // Cria um componente image p/ desenhar o triangulo dentro
    vImage := TImage.Create(vPanel) ;
    vImage.Name       := 'hintimg'+IntToStr(seq);
    vImage.Parent      := vPanel ;
    vImage.Align       := alClient ;
    vImage.Transparent := True ;

    // Desenha um triangulo no image
    For a := 0 to vImage.Width do
      For b := 0 to vImage.Width do
        vImage.Canvas.Pixels[b,vImage.Top+b-a] := clRed ;
  End ;
Begin
  With TForm(Sender) do
  Begin
    For v := ComponentCount-1 downto 0 do
      If (Components[v].Classtype = TPanel) And
         (Copy(TPanel(Components[v]).name,1,7) = 'hintpnl') Then
        TPanel(Components[v]).destroy ;

    For v := 0 to ComponentCount - 1 do
    Begin
      If (Components[v] Is TWinControl)                And
         (TWinControl(Components[v]).ShowHint)         And
         (Trim(TWinControl(Components[v]).Hint) <> '') Then
      Begin
        CriaIdendificadorDeHint(v);
        vPanel.Parent := TWinControl(Components[v]).Parent ;

        // Quando for um TGROUPBOX ou TRADIOGROUP desce + 3 p/ o identificador ficar dentro do quadro
        vTop := TWinControl(Components[v]).Top+1 ;
        If (Components[v] Is TGroupBox) Or (Components[v] Is TRadioGroup) Then
          vTop := vTop+4 ;

        // Posiciona o panel no canto superior esquerdo do componente
        vPanel.Top   := vTop ;
        vPanel.Left  := TWinControl(Components[v]).Left+TWinControl(Components[v]).Width-6 ;
        vPanel.Color := TWinControl(Components[v]).Brush.Color ;
        vPanel.Hint  := Traduz(TWinControl(Components[v]).Hint) ;
        vPanel.ShowHint := True ;
      End Else // If (Components[v] Is TWinControl) And (...
      If (Components[v] Is TGraphicControl)                And
         (TGraphicControl(Components[v]).ShowHint)         And
         (Trim(TGraphicControl(Components[v]).Hint) <> '') Then
      Begin
        CriaIdendificadorDeHint(v) ;
        vPanel.Parent := TGraphicControl(Components[v]).Parent ;

        // Quando for um LABEL o identificador vai ficar do lado do componente p/ ficar encima da ultima letra
        vLeft := TGraphicControl(Components[v]).Left+TGraphicControl(Components[v]).Width-7 ;
        If Components[v] Is TLabel Then
          vLeft := vLeft + vPanel.Width ;

        // Posiciona o panel no canto superior esquerdo do componente
        vPanel.Top   := TGraphicControl(Components[v]).Top+1 ;
        vPanel.Left  := vLeft ;
        vPanel.Hint  := Traduz(TGraphicControl(Components[v]).Hint) ;
        vPanel.ShowHint := True ;
      End ; // If (Components[v] Is TGraphicControl) And (...

    End ; // For i := 0 to ComponentCount - 1 do
  End ; // With TForm(Sender) do
End ;

procedure OrdenaColunas(pColuna: TColumn) ;
Var
  i      : Integer ;
  vGrid  : TCustomDBGrid ;
  vPanel : TPanel ;
  vImage : TImage ;
  vNomeItemMenu : String ;
  Procedure DesenhaSetas(pDecrescente : Boolean) ;
  Var
    Lin,Col,Ini,Fin : Integer ;
  Begin
    // Verifica se o componenet PanelSeta ja existe
    If vGrid.FindComponent('PanelSeta') = Nil Then
    Begin
      vPanel := TPanel.Create(vGrid) ;
      vPanel.Parent  := vGrid ;
      vPanel.Name    := 'PanelSeta' ;
      vPanel.Left    := 0 ;
      vPanel.Top     := 0 ;
      vPanel.Height  := 17 ;
      vPanel.Width   := 11 ;
      vPanel.Caption := '' ;

      vImage := TImage.Create(vPanel) ;
      vImage.Name        := 'ImageSeta' ;
      vImage.Parent      := vPanel ;
      vImage.Align       := alClient ;
      vImage.Transparent := True ;
    End Else // If vGrid.FindComponent('PanelSeta') = Nil Then
    Begin // Caso existe atribui o valor na variavel
      vPanel := TPanel(vGrid.FindComponent( 'PanelSeta')) ;
      vImage := TImage(vPanel.FindComponent('ImageSeta')) ;
    End ; // End Else

    // Limpa o componente image
    vImage.Canvas.Brush.color := clMenu ;
    vImage.Canvas.Rectangle(0,0,vImage.Width,vImage.Height) ;

    Ini := IIf(pDecrescente,4,0) ;
    Fin := IIf(pDecrescente,3,7) ;
    For Lin := 5 to 9 do
    Begin
      For Col := Ini to Fin do // Desenha seta
        vImage.Canvas.Pixels[ Col , Lin] := clBlue ;

      Ini := IIf(pDecrescente, Ini - 1, Ini + 1 ) ;
      Fin := IIf(pDecrescente, Fin + 1, Fin - 1 ) ;
    End ; // For Lin := 8 to 12 do
    vImage.Hint := IIf(pDecrescente,'Decrescente','Crescente') ;
  End ; // Procedure DesenhaSetas(pTipo : String) ;

Begin
  vGrid := pColuna.Grid ;

  If TDBGrid(vGrid).DataSource.DataSet.RecordCount <= 1 Then Exit ;

  vOrdem  := (vColuna = pColuna.Index) And (Not vOrdem);
  vColuna := pColuna.Index ;
  For i := 0 to TDBGrid(vGrid).Columns.Count-1 do
    TDBGrid(vGrid).Columns[i].Title.Font.Color := ClBlack ;

  TDBGrid(vGrid).Columns[pColuna.Index].Title.Font.Color := ClBlue ;
  TRxMemoryData(TDBGrid(vGrid).DataSource.DataSet).SortOnFields(pColuna.FieldName,True,vOrdem) ;

  // So desenha a seta se o dgIndicator estiver true
  If dgIndicator In TDBGrid(vGrid).Options Then
    DesenhaSetas(vOrdem) ;

  // Cria menu
  If TDBGrid(vGrid).PopupMenu = Nil Then
  Begin
    PMenuPesquisa      := TPopupMenu.Create(TDBGrid(vGrid)) ;
    PMenuPesquisa.Name := 'PMenuPesquisa' ;
    TDBGrid(vGrid).PopupMenu := PMenuPesquisa ;
  End ; // If vGrid.FindComponent('PMenuPesquisa') = Nil Then

  // Cria item de menu (No menu criado ou no ja existente)
  vNomeItemMenu := TDBGrid(vGrid).Name +'_'+ 'IMenuPesquisa' ;
  If TDBGrid(vGrid).FindComponent(vNomeItemMenu) = Nil Then
  Begin
    IMenuPesquisa      := TMenuItemPesquisa.Create(TDBGrid(vGrid)) ;
    IMenuPesquisa.Name := vNomeItemMenu ;
    TPopupMenu(TDBGrid(vGrid).PopupMenu).Items.Add(IMenuPesquisa) ;
  End ; // If TDBGrid(vGrid).FindComponent(vNomeItemMenu) = Nil Then

  IMenuPesquisa.ColunaPesquisa(pColuna) ;
End;


Function VerificaParametrosDaTela : Boolean ;
Var i : Integer ;
Begin
  Result := True ;
  With Screen.Forms[0] do
  Begin
    For i := 0 to ComponentCount - 1 do
    Begin
      If ((Components[i] Is TWinControl) And ((Not TWinControl(Components[i]).Enabled) Or
                                              (Not TWinControl(Components[i]).Visible) Or
                                              (Not TWinControl(TWinControl(Components[i]).Parent).Visible) )) Then
        Continue ;

      If ((Components[i] Is TNumEdit)    And       (TNumEdit(   Components[i]).Value = 0 )) Or
         ((Components[i] Is TDateEdit)   And       (TDateEdit(  Components[i]).Date  = 0 )) Or
         ((Components[i] Is TComboBox)   And  (Trim(TComboBox(  Components[i]).Text) = '')) Or
         ((Components[i] Is TMaskEdit)   And  (Trim(TMaskEdit(  Components[i]).Text) = '')) Or
         ((Components[i] Is TCustomEdit) And  (Trim(TCustomEdit(Components[i]).Text) = '')) Then
      Begin
        MensagemDlg('Dados essenciais não foram digitados !',mtErro,mbOK) ;
        TWinControl(Components[i]).SetFocus ;
        Result := False ;
        Exit ;
      End ; // If ((Components[i] Is TNumEdit) And (...
    End ; // for i := 0 to ComponentCount - 1 do
  End ; // With Screen.Forms[0] do
End ;

Procedure PosicionaBotoes(pPanel: TPanel ; pMudaTamanhoDoPainel : Boolean = True ; pMudaTamanhoDosBotoes : Boolean = True ) ;
var
  i,
  vEspaco,
  vControle,
  vQtdeBotoes  : Integer ;
  vLBoxOrdenar : TListBox ;
Const
  HeightPanelBotoes = 55 ;
  TopBotoes         = 13 ;
  HeightBotoes      = 30 ;
  WidthBotoes       = 85 ;
begin
  With TPanel(pPanel) do
  Begin
    // Cria ListBox p/ ordenar os botões conforme o TabOrder
    vLBoxOrdenar := TListBox.Create(pPanel) ;
    vLBoxOrdenar.Visible := False ;
    vLBoxOrdenar.Parent  := pPanel ;
    vLBoxOrdenar.Name    := 'vLBoxOrdenarBotoes' ;
    vLBoxOrdenar.Sorted  := True ;
    vLBoxOrdenar.Clear   ;

    // Conta a quantidade de botões visíveis no painel e guarda o TabOrder e o Controle de cada componente
    For i := 0 To ControlCount - 1 Do
      If (Controls[i] Is TButton) And (TButton(Controls[i]).Visible) Then
        vLBoxOrdenar.Items.Add('A:'+ StrZero(TButton(Controls[i]).TabOrder,2) +
                               'B:'+ StrZero(i,2) ) ;

    If pMudaTamanhoDoPainel Then
      Height := HeightPanelBotoes ; // Redefine o panel

    vQtdeBotoes := vLBoxOrdenar.Items.Count ;
    vEspaco     := Trunc((pPanel.Width-(vQtdeBotoes*WidthBotoes))/(vQtdeBotoes+1) ) ;
    For i := 0 To vLBoxOrdenar.Items.Count-1  Do
    Begin
      // Identifica qual é o controle do componente
      vControle := StrToInt(Copy(vLBoxOrdenar.Items[i],Pos('B:',vLBoxOrdenar.Items[i])+ 2,2)) ;

      If Controls[vControle] Is TButton Then
      Begin
        If pMudaTamanhoDosBotoes Then
        Begin
          // Redefine tamanho e largura dos botões
          TButton(Controls[vControle]).Height := HeightBotoes ;
          TButton(Controls[vControle]).Width  := WidthBotoes  ;
          // Define as posições dos botões
          TButton(Controls[vControle]).Top    := TopBotoes    ;
        End Else // If pTamaBotoes Then
          TButton(Controls[vControle]).Top    := Trunc((Height-TButton(Controls[vControle]).Height)/2) ;

        If TButton(Controls[vControle]).TabOrder = 0 Then
          TButton(Controls[vControle]).Left := vEspaco
        Else
          TButton(Controls[vControle]).Left := vEspaco * (TButton(Controls[vControle]).TabOrder+1) + (WidthBotoes*TButton(Controls[vControle]).TabOrder) ;
      End ; // If Controls[vControle] Is TButton Then
    End ; // For i := 0 To ControlCount-1 Do
    vLBoxOrdenar.Free ;
  End ; // With TPanel(pPanel) do
End ;

function RetornaEmpFilAutorizadas(pNomeCampoEmpresa,pNomeCampoFilial : String; pFiltroEmpIni,pFiltroEmpFin,pFiltroFilIni,pFiltroFilFin : Integer ): AnsiString ; 
var
  vQuery : TQuery;
begin
  vRetornoLogEmpFilAut := IIf(StrZero(pFiltroEmpIni,3)+StrZero(pFiltroEmpFin,3) = '001999'
                             ,''
                             ,', Empresa' + IIf(pFiltroEmpIni = pFiltroEmpFin
                                               , ': '   + StrZero(pFiltroEmpIni,3)
                                               ,'s: '   + StrZero(pFiltroEmpIni,3) +' ate ' + StrZero(pFiltroEmpFin,3) ))
                        + IIf(StrZero(pFiltroFilIni,3)+StrZero(pFiltroFilFin,3) = '001999'
                             ,''
                             ,', Filia'   + IIf(pFiltroFilIni = pFiltroFilFin
                                               ,'l: '   + StrZero(pFiltroFilIni,3)
                                               ,'is: '  + StrZero(pFiltroFilIni,3) +' ate ' + StrZero(pFiltroFilFin,3) )) ;

  // Para os usuários Globus e Manager, traz todas as empresas e filiais
  If Pos(vcUsuario,'GLOBUS_MANAGER') > 0 then
  Begin
    Result := pNomeCampoEmpresa + ' >= ' + StrZero(pFiltroEmpIni,3) + ' AND ' +
              pNomeCampoEmpresa + ' <= ' + StrZero(pFiltroEmpFin,3) + ' AND ' +

              pNomeCampoFilial  + ' >= ' + StrZero(pFiltroFilIni,3) + ' AND ' +
              pNomeCampoFilial  + ' <= ' + StrZero(pFiltroFilFin,3);
    Exit ;
  End ; // If Pos(vcUsuario,'GLOBUS_MANAGER') > 0 then

  vQuery := TQuery.Create(Application) ;
  vQuery.DataBaseName := cDatabaseName ;
  with vQuery do
  begin
    // Filtra as empresas e filiais autorizadas para o usuário, dentro do filtro solicitado.
    Close ;
    Sql.Clear ;
    Sql.Add(' SELECT'+
            '  A.CODIGOEMPRESA'+
            ' ,A.CODIGOFL') ;
    Sql.Add(' FROM'+
            '  CTR_FILIAL              A'+
            ' ,CTR_EMPAUTORIZADAS      B'+
            ' ,CTR_AUTORIZACAOUSUARIOS C'+
            ' ,CTR_GRUPOUSUARIOS       D'+
            ' ,CTR_CADASTRODEUSUARIOS  E'+
            ' ,CTR_AUTORIZACAOSISTEMAS F') ;
    Sql.Add(' WHERE'+
            '     A.CODINTEMPAUT = B.CODINTEMPAUT'+
            ' AND C.CODINTEMPAUT = B.CODINTEMPAUT'+
            ' AND D.CODIGOGRPUSU = C.CODIGOGRPUSU'+
            ' AND E.CODIGOGRPUSU = D.CODIGOGRPUSU'+
            ' AND F.CODINTEMPAUT = B.CODINTEMPAUT'+
            ' AND E.USUARIO      = :P_USUARIO'+
            ' AND F.SISTEMA      = :P_SISTEMA'+
            ' AND A.CODIGOEMPRESA BETWEEN :P_EMPRESAINI AND :P_EMPRESAFIN'+
            ' AND A.CODIGOFL      BETWEEN :P_FILIAINI   AND :P_FILIAFIN') ;
    Sql.Add(' ORDER BY'+
            '  A.CODIGOEMPRESA'+
            ' ,A.CODIGOFL') ;
    ParamByName('P_USUARIO'   ).AsString  := vcUsuario ;
    ParamByName('P_SISTEMA'   ).AsString  := vcSistema ;
    ParamByName('P_EMPRESAINI').AsInteger := pFiltroEmpIni ;
    ParamByName('P_EMPRESAFIN').AsInteger := pFiltroEmpFin ;
    ParamByName('P_FILIAINI'  ).AsInteger := pFiltroFilIni ;
    ParamByName('P_FILIAFIN'  ).AsInteger := pFiltroFilFin ;
    Open ;
    Result := '' ;
    while not Eof do
    begin
      Result := Result + '('    + pNomeCampoEmpresa + ' = ' + FieldByName('CODIGOEMPRESA').AsString
                       + ' AND '+ pNomeCampoFilial  + ' = ' + FieldByName('CODIGOFL'     ).AsString
                       + ') '  ;
      Next ;

      Result := Result + IIf(Eof,'',' OR ') ;
    End ; // While Not Eof do

    Result := ' (' + IIf(Result='', pNomeCampoEmpresa + ' = -1 AND ' +
                                    pNomeCampoFilial  + ' = -1'  // Se não achar empresas autorizadas, retorna empresa e filial = -1
                                  , Result ) + ') ' ;
    Free ;
  End ; // With vQuery Do
end;

Function AbrirQuery(pQuery: TQuery;pReferenciaGetSql : String = '';pMsgQdoEmpty : String = '';pMsgBarraStatus : String = ''): TAbrirQuery;
Var
  Hour, Min, Sec, MSec: Word;
begin
  With pQuery do
  Begin
    Try
      If Trim(pMsgBarraStatus) <> '' Then Msg(pMsgBarraStatus);

      If (Trim(pReferenciaGetSql) = '') And (Trim(pQuery.Name) <> '') Then
        pReferenciaGetSql := pQuery.Name ;

      Result.TempoIni := Time ;
      GetSql(pQuery) ;
      Open ;
      Result.TempoFin := Time ;
      Result.Minutos := Result.TempoFin - Result.TempoIni ;
      DecodeTime(Result.Minutos, Hour, Min, Sec, MSec);

      GetSql(pQuery, Nil, False, pReferenciaGetSql + ', Tempo: ' + FormatDateTime('hh:mm:ss',Result.Minutos) + '.' + IntToStr(MSec)) ;

      Result.Achou := Not IsEmpty ;
      If (Not Result.Achou) And (Trim(pMsgQdoEmpty) <> '') Then MensagemDlg(pMsgQdoEmpty , mtInformacao, mbOk) ;
      If Trim(pMsgBarraStatus) <> '' Then Msg ;

    Except on E:EDBEngineError do
      Begin
        Result.Achou := False ;
        MensagemDLG( MostraErrosQuery(E,False), mtErro, mbOK ) ;
      End
    End ; // Try - Except
  End ; // With pQuery do
end;

procedure GravaLogDasExcecoes(Sender: TObject; E: Exception);
var
  NomeArq : String ;
  Arquivo : TextFile ;
begin
  NomeArq := ChangeFileExt(Application.Exename, '.Err') ;
  AssignFile(Arquivo, NomeArq) ;

  If FileExists(NomeArq) Then
    Append(Arquivo)
  Else // If FileExists(NomeArq) Then
  Begin
    ReWrite(Arquivo);
    WriteLn(Arquivo, '   Data      Hora   Usuários        Tela                                     Erro');
    WriteLn(Arquivo, '---------- -------- --------------- ---------------------------------------- ------------------------------------------------------------') ;
    //                99/99/9999 99:99:99 123456789012345 1234567890123456789012345678901234567890 123456789012345678901234567890123456789012345678901234567890
  End ; // Else // If FileExists(NomeArq) Then

  Try
    WriteLn(Arquivo, FormatDateTime('DD/MM/YYYY HH:MM:NN', now)
               +' '+ Pad(vcUsuario,15)
               +' '+ Pad(Screen.ActiveForm.Name,40)
               +' '+ StringReplace(E.Message
                                  ,Chr(13) + Chr(10)
                                  ,Chr(13) + Chr(10) + Space(61)
                                  ,[rfReplaceAll,rfIgnoreCase])) ;
    Application.ShowException(E) ;
  Finally
    CloseFile(Arquivo) ;
  End ; // Try - Finally
end;

Function ValidaCodCliente(pClientes : Array Of Integer ) : Boolean ;
Var
  i,
  vQtde : Integer ;
Begin
  Result := False ;
  vQtde  := Length(pClientes)-1 ;
  For i := 0 To vQtde Do
    If vcCodigoCliente = pClientes[i] Then
    Begin
      Result := True ;
      Break ;
    End ; // If vcCodigoCliente = pClientes[i] Then
End ;

Procedure MostraUltimoLogGravado ;
Var
  vUltimaHora : TDateTime ;
  i           : Integer ;
  vLog        : String ;
Begin
  With qrPesqAux do
  Begin
    Close ;
    vUltimaHora  := Now ; 
    For i := 1 to 2 do
    Begin
      SQL.Clear ;
      SQL.Add(' SELECT'+
              ' '+ IIf(i=1,'MAX(HORALOG) AS HORALOG','TEXTOLOG')+
              '') ;
      SQL.Add(' FROM'+
              ' CTR_LOG'+
              '') ;
      SQL.Add(' WHERE'+
              '     SISTEMA = :P_SISTEMA'+
              ' AND USUARIO = :P_USUARIO'+
              ' AND DATALOG = :P_DATALOG'+
              '') ;
      ParamByName('P_SISTEMA').AsString   := vcSistema ;
      ParamByName('P_USUARIO').AsString   := vcUsuario ;
      ParamByName('P_DATALOG').AsDateTime := Date ;
      If i = 2 Then
      Begin
        SQL.Add(' AND HORALOG = :P_HORALOG') ;
        ParamByName('P_HORALOG').AsDateTime := vUltimaHora ;
      End ; // If i = 2 Then
      AbrirQuery(qrPesqAux,'PesqUltimoLog') ;
      If i = 1 Then
        vUltimaHora := FieldByName('HORALOG').AsDateTime ;
    End ; // For i := 1 to 2 do

    vLog := '' ;
    While Not Eof do
    Begin
      vLog := vLog + FieldByName('TEXTOLOG').AsString ;
      Next ;
    End ; // While Not Eof do
    MensagemDLG( StringReplace(vLog,'......','',[rfReplaceAll, rfIgnoreCase]), mtInformacao, mbOk );
  End ; // With qrPesqAux do
End ;

Function CampoExiste(pNomeDoCampo : String ; pNomeDaTabela : String = '') : Boolean;
Begin
  With qrPesqAux do
  Begin
    Close ;
    SQL.Clear ;
    SQL.Add(' SELECT'+
            ' COUNT(COLUMN_NAME) AS QTDE'+
            '') ;
    SQL.Add(' FROM'+
            ' USER_TAB_COLUMNS'+
            '') ;
    SQL.Add(' WHERE'+
            ' COLUMN_NAME = :P_COLUMN_NAME'+
            '') ;
    If Trim(pNomeDaTabela) <> '' Then
    Begin
      SQL.Add(' AND TABLE_NAME  = :P_TABLE_NAME') ;
      ParamByName('P_TABLE_NAME').AsString := UpperCase(pNomeDaTabela) ;
    End ; // If Trim(pNomeDaTabela) <> '' Then
    ParamByName('P_COLUMN_NAME' ).AsString := UpperCase(pNomeDoCampo) ;
    AbrirQuery(qrPesqAux,'PesqEmailDaCaixaDeSaida') ;
    Result := FieldByName('QTDE').AsInteger <> 0 ;
  End ; // With qrPesqAux do
End ;

Procedure MostraLogDoDia ;
Begin
  frmCtr_LstLog := TfrmCtr_LstLog.Create(Application) ;
  Try
    With frmCtr_LstLog do
    Begin
      EdtSistemaIni.Text := vcSistema ;
      EdtUsuarioIni.Text := vcUsuario ;
      EdtDataIni.Date    := Date ;
      EdtDataFin.Date    := Date ;
      EdtSistemaIniExit(EdtSistemaIni) ;
      EdtUsuarioIniExit(EdtUsuarioIni) ;
      EdtDataIniExit(   EdtDataIni   ) ;
      EdtDataFinExit(   EdtDataFin   ) ;
      Visualizar1Click(Visualizar1) ;
    End ;
  Finally
    frmCtr_LstLog.Release ;
    frmCtr_LstLog := Nil ;
  End ;
End ;

Function ExecQuery(pQuery: TQuery; pReferenciaGetSql : String = ''; pMsg : String = ''; pMsgBarraStatus : String = ''; pExecRollback : Boolean = True ): TAbrirQuery;
Var
  Hour, Min, Sec, MSec: Word;
begin
  With pQuery do
  Begin
    Try
      If Trim(pMsgBarraStatus) <> '' Then Msg(pMsgBarraStatus);

      If (Trim(pReferenciaGetSql) = '') And (Trim(pQuery.Name) <> '') Then
        pReferenciaGetSql := pQuery.Name ;

      Result.TempoIni := Time ;
      GetSql(pQuery) ;
      ExecSql ;
      Result.TempoFin := Time ;
      Result.Minutos := Result.TempoFin - Result.TempoIni ;
      DecodeTime(Result.Minutos, Hour, Min, Sec, MSec);

      GetSql(pQuery, Nil, False, pReferenciaGetSql + ', Tempo: ' + FormatDateTime('hh:mm:ss',Result.Minutos) + '.' + IntToStr(MSec)) ;

      Result.Achou := True ;
    Except on E:EDBEngineError do
      Begin
        Result.Achou := False ;
        If pExecRollback Then
        Begin
          If vcDatabase.InTransaction Then vcDatabase.Rollback ;

          If MensagemDLG(IIf(pMsg='','Erro',pMsg) + '. Deseja ver o erro ?', mtConfirmacao, mbSim+mbNao)= mrSim Then
            MostraErrosQuery(E, True) ;
        End ; // If pExecRollback Then
      End
    End ; // Try - Except
  End ; // With pQuery do
end;

end.
