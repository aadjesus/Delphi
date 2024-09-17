unit Global_Ale;

interface

Uses Consts, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     ExtCtrls, StdCtrls, ComCtrls, db, DBTables, RxMemDS, Global, Menus,
     {$INCLUDE \Globus\Sistemas\UsesMigracao.txt}
     {$INCLUDE \Globus\Sistemas\UsesGLB.txt};

type
  TPrioridades = (tpNormal,tpAlta,tpBaixa) ;

Procedure MostraUltimoLogGravado ;
Procedure MostraLogDoDia ;
Procedure MostraMonitorDeLOGs ;
Procedure EnviarEMailDaTela ;
Procedure EnviarEMailDaCaixaDeSaida ;
Procedure HelpDoUsuario ;
Function  CampoExiste(pNomeDoCampo : String ; pNomeDaTabela : String = '') : Boolean;
Function  ExecutaSQL(pQuery: TQuery; pReferenciaGetSql : String = ''; pExecRollback : Boolean = True ): TAbrirQuery;
Function  SalvaEMailNaCaixaDeSaida(pDe
                                  ,pPara
                                  ,pCc
                                  ,pAssunto    : String
                                  ;pTexto      : AnsiString
                                  ;pArquivos   : Array Of String
                                  ;pPrioridade : TPrioridades=tpNormal) : Boolean ;
Procedure ApagaLembretes(pData: TDateTime; pApagaVencidos : Boolean) ;
Procedure MostraLembretes(pMenu : TPopupMenu) ;

implementation

uses Bgm_Tela
   , Bgm_String
   , CTR_LstLog
   , CTR_EnviarEMailDaTela
   , CTR_CaixaDeSaida
   , CTR_HelpDoUsuario
   , CTRMonitorDeLOGs
   , dmcontrole
   ;

var qrPesqAux, qrPesqAux2 : TQuery ;
    vQtdeLembretes : Integer ;

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
      SQL.Add('SELECT ' + IIf(i=1,'MAX(HORALOG) AS HORALOG','TEXTOLOG')) ;
      SQL.Add('  FROM CTR_LOG') ;
      SQL.Add(' WHERE SISTEMA = :P_SISTEMA') ;
      SQL.Add('   AND USUARIO = :P_USUARIO') ;
      SQL.Add('   AND DATALOG = :P_DATALOG') ;
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
    If vLog <> '' Then
      MensagemDLG( StringReplace(vLog,'......','',[rfReplaceAll, rfIgnoreCase]), mtInformacao, mbOk );
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

Procedure MostraMonitorDeLOGs ;
Begin
  frmCTRMonitorDeLOGs := TfrmCTRMonitorDeLOGs.Create(Application) ;
  Try
    frmCTRMonitorDeLOGs.ShowModal ;
  Finally
    frmCTRMonitorDeLOGs.Release ;
    frmCTRMonitorDeLOGs := Nil ;
  End ;
End ;

Procedure EnviarEMailDaTela ;
Var
  vNomeArquivo : String ;
  procedure CapturaTelaAtiva ;
  Var
    c      : TCanvas ;
    r,t    : TRect ;
    h      : THandle ;
    vImage : TBitMap ;
  Begin
    vImage := TBitMap.Create ;

    c := TCanvas.Create ;
    c.Handle := GetWindowDC(GetDesktopWindow) ;
    h := GetForegroundWindow ;
    If h > 0 then
      GetWindowRect(h,t) ;

    Try
      r := rect(0,0,t.Right-t.Left,t.Bottom - t.Top) ;
      vImage.Width  := t.Right  - t.Left ;
      vImage.Height := t.Bottom - t.Top ;
      vImage.Canvas.CopyRect(r,c,t) ;
    Finally
      Releasedc(0,c.Handle) ;
      C.Free ;
    End ;
    vNomeArquivo := ExtractFilePath(Application.ExeName) + Screen.ActiveForm.Name + '.Bmp';
    vImage.SaveToFile(vNomeArquivo);
    vImage.Free ;
  End ; // procedure CapturaTelaAtiva ;
Begin
// CTR_EnviarEMailDaTela
  FrmCTR_EnviarEMailDaTela := TFrmCTR_EnviarEMailDaTela.Create(Application) ;
  Try
    CapturaTelaAtiva ;
    FrmCTR_EnviarEMailDaTela.vNomeTela    := Copy(Screen.ActiveForm.Caption,7,100) ;
    FrmCTR_EnviarEMailDaTela.vNomeForm    := Screen.ActiveForm.Name ;
    FrmCTR_EnviarEMailDaTela.vNomeArquivo := vNomeArquivo ;
    FrmCTR_EnviarEMailDaTela.ShowModal ;
  Finally
    FrmCTR_EnviarEMailDaTela.Release ;
    FrmCTR_EnviarEMailDaTela := Nil ;
  End ;
End ;

Procedure EnviarEMailDaCaixaDeSaida ;
Begin
  With qrPesqAux do
  Begin
    Close ;
    SQL.Clear ;
    SQL.Add('SELECT A.CODEMAIL') ;
    SQL.Add('     , A.DATAEMAIL') ;
    SQL.Add('     , A.DE') ;
    SQL.Add('     , A.PARA') ;
    SQL.Add('     , A.CC') ;
    SQL.Add('     , A.ASSUNTO') ;
    SQL.Add('     , A.TEXTO') ;
    SQL.Add('     , A.PRIORIDADE') ;
    SQL.Add('     , 0 AS ENVIAR') ;
    SQL.Add('     , 2 AS ARQUIVOS') ;
    SQL.Add('     , B.QTDEARQ') ;
    SQL.Add('  FROM CTR_EMAIL A') ;
    SQL.Add('     , (  SELECT CODEMAIL') ;
    SQL.Add('               , COUNT(CODEMAIL) AS QTDEARQ') ;
    SQL.Add('            FROM CTR_EMAILARQ') ;
    SQL.Add('        GROUP BY CODEMAIL) B') ;
    SQL.Add('  WHERE A.CODEMAIL = B.CODEMAIL(+)') ;
    SQL.Add('    AND A.SISTEMA  = :P_SISTEMA') ;
    SQL.Add('    AND A.USUARIO  = :P_USUARIO') ;
    ParamByName('P_SISTEMA').AsString := vcSistema ;
    ParamByName('P_USUARIO').AsString := vcUsuario ;
  End ; // With qrPesqAux do

  If TabelaExiste('CTR_EMAIL') And AbrirQuery(qrPesqAux,'PesqEmailDaCaixaDeSaida').Achou Then
  Begin
    FrmCTR_CaixaDeSaida := TFrmCTR_CaixaDeSaida.Create(Application) ;
    Try
      FrmCTR_CaixaDeSaida.MDEMail.LoadFromDataSet(qrPesqAux,0,lmCopy) ;
      FrmCTR_CaixaDeSaida.ShowModal ;
    Finally
      FrmCTR_CaixaDeSaida.Release ;
      FrmCTR_CaixaDeSaida := Nil ;
    End ;
  End ; // If TabelaExiste('CTR_EMAIL') And  AbrirQuery(...
End ;

Function CampoExiste(pNomeDoCampo : String ; pNomeDaTabela : String = '') : Boolean;
Begin
  With qrPesqAux do
  Begin
    Close ;
    SQL.Clear ;
    SQL.Add('SELECT COUNT(COLUMN_NAME) AS QTDE') ;
    SQL.Add('  FROM USER_TAB_COLUMNS') ;
    SQL.Add(' WHERE COLUMN_NAME = :P_COLUMN_NAME') ;
    If Trim(pNomeDaTabela) <> '' Then
    Begin
      SQL.Add(' AND TABLE_NAME  = :P_TABLE_NAME') ;
      ParamByName('P_TABLE_NAME').AsString := UpperCase(pNomeDaTabela) ;
    End ; // If Trim(pNomeDaTabela) <> '' Then
    ParamByName('P_COLUMN_NAME' ).AsString := UpperCase(pNomeDoCampo) ;
    AbrirQuery(qrPesqAux,'PesqCampoTabela') ;
    Result := FieldByName('QTDE').AsInteger <> 0 ;
  End ; // With qrPesqAux do
End ;

Procedure HelpDoUsuario ;
Var
  vPos : Integer ;
Begin
  FrmCTR_HelpDoUsuario := TFrmCTR_HelpDoUsuario.Create(Application) ;
  Try
    vPos := Pos(vcSistema + ' - ',Screen.ActiveForm.Caption) ;
    FrmCTR_HelpDoUsuario.vNomeTela := Copy(Screen.ActiveForm.Caption,vPos,100) ;
    FrmCTR_HelpDoUsuario.vNomeForm := Screen.ActiveForm.Name ;
    FrmCTR_HelpDoUsuario.ShowModal ;
  Finally
    FrmCTR_HelpDoUsuario.Release ;
    FrmCTR_HelpDoUsuario := Nil ;
  End ;
End ;

Function ExecutaSQL(pQuery: TQuery; pReferenciaGetSql : String = ''; pExecRollback : Boolean = True ): TAbrirQuery;
Var
  Hour, Min, Sec, MSec: Word;
  vTpExec : String ;
begin
  With pQuery do
  Begin
    Try
      vTpExec := IIf(Pos('INSERT',UpperCase(SQL.Text)) > 0,'inclui',
                 IIf(Pos('UPDATE',UpperCase(SQL.Text)) > 0,'atualiza',
                 IIf(Pos('DELETE',UpperCase(SQL.Text)) > 0,'apaga',''))) ;

      If Trim(pReferenciaGetSql) = '' Then
        pReferenciaGetSql := IIf(Trim(pQuery.Name) = '',vTpExec +'ndo_dados',pQuery.Name) ;

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

          If MensagemDLG('Erro'+ IIf(vTpExec='','',' ao ' + vTpExec + 'r') + '. Deseja ver o erro ?', mtConfirmacao, mbSim+mbNao)= mrSim Then
            MostraErrosQuery(E, True) ;
        End ; // If pExecRollback Then
      End
    End ; // Try - Except
  End ; // With pQuery do
end;

Function SalvaEMailNaCaixaDeSaida(pDe
                                 ,pPara
                                 ,pCc
                                 ,pAssunto    : String
                                 ;pTexto      : AnsiString
                                 ;pArquivos   : Array Of String
                                 ;pPrioridade : TPrioridades=tpNormal) : Boolean ;
Var
  vInTransaction : Boolean ;
  i,
  vQtdeArq,
  vCodEmail      : Integer ;
Begin
  vInTransaction := vcDatabase.InTransaction ;
  Result         := True ;
  If Not vInTransaction Then vcDatabase.StartTransaction ;
  Msg('Salvando e-mail') ;

  vCodEmail := StrToInt(ProximoNumero('CTR_EMAIL','CODEMAIL','',0,True));

  With qrPesqAux do
  Begin
    Close ;
    SQL.Clear ;
    SQL.Add('INSERT INTO CTR_EMAIL (CODEMAIL') ;
    SQL.Add('                      ,USUARIO') ;
    SQL.Add('                      ,DATAEMAIL') ;
    SQL.Add('                      ,SISTEMA') ;
    SQL.Add('                      ,DE') ;
    SQL.Add('                      ,PARA') ;
    SQL.Add(IIf(Trim(pCc)='','','  ,CC')) ;
    SQL.Add('                      ,ASSUNTO') ;
    SQL.Add('                      ,PRIORIDADE') ;
    SQL.Add(IIf(Trim(pTexto)='','',',TEXTO')) ;
    Sql.Add(') VALUES (:P_CODEMAIL') ;
    Sql.Add('         ,:P_USUARIO') ;
    Sql.Add('         ,:P_DATAEMAIL') ;
    Sql.Add('         ,:P_SISTEMA') ;
    Sql.Add('         ,:P_DE') ;
    Sql.Add('         ,:P_PARA') ;
    Sql.Add(IIf(Trim(pCc)='','',' ,:P_CC')) ;
    Sql.Add('         ,:P_ASSUNTO') ;
    Sql.Add('         ,:P_PRIORIDADE') ;
    Sql.Add(IIf(Trim(pTexto)='','',' ,:P_TEXTO')) ;
    Sql.Add(' )') ;
    ParamByName('P_CODEMAIL'  ).AsInteger  := vCodEmail ;
    ParamByName('P_USUARIO'   ).AsString   := vcUsuario ;
    ParamByName('P_DATAEMAIL' ).AsDateTime := Date ;
    ParamByName('P_SISTEMA'   ).AsString   := vcSistema ;
    ParamByName('P_DE'        ).AsString   := pDe ;
    ParamByName('P_PARA'      ).AsString   := pPara ;
    If Trim(pCc) <> '' Then
      ParamByName('P_CC'      ).AsString  := pCc ;
    ParamByName('P_ASSUNTO'   ).AsString  := pAssunto ;
    ParamByName('P_PRIORIDADE').AsString  := IIf(pPrioridade = tpNormal,'N',
                                             IIf(pPrioridade = tpAlta,  'A','B')) ;
    If Trim(pTexto) <> '' Then
      ParamByName('P_TEXTO'   ).AsMemo    := pTexto ;
    Try
      ExecSQL ;
    Except on E:EDBEngineError do
      Result := False ;
    End ; // try - except

    If Result Then
    Begin
      vQtdeArq := Length(pArquivos)-1 ;

      SQL.Clear ;
      SQL.Add(' INSERT INTO CTR_EMAILARQ ('+
              '  CODEMAIL'+
              ' ,ARQUIVO'+
              '') ;
      Sql.Add(' ) VALUES ('+
              '  :P_CODEMAIL'+
              ' ,:P_ARQUIVO'+
              ' )') ;
      ParamByName('P_CODEMAIL').AsInteger := vCodEmail ;
      For i := 0 To vQtdeArq Do
      Begin
        If Trim(pArquivos[i]) <> '' Then
        Begin
          ParamByName('P_ARQUIVO').AsString := pArquivos[i] ;
          Try
            ExecSQL ;
          Except on E:EDBEngineError do
            Begin
              Result := False ;
              Break ;
            End ;
          End ; // try - except
        End ; // If Trim(pArquivos[i]) <> '' Then
      End ; // For i := 0 To vQtdeArq Do
    End ; // If Result Then

    If Not vInTransaction Then
    Begin
      If Result Then
        vcDatabase.Commit
      Else // If Result Then
      Begin
        vcDatabase.Rollback ;
        MensagemDlg('Erro ao salvar o e-mail.',mtinformacao,mbOk) ;
      End ; // Else // If Result Then
    End ; // If Not vInTransaction Then
  End ; // With qrPesqAux do

  Msg ;
End ;

Procedure ApagaLembretes(pData: TDateTime; pApagaVencidos : Boolean) ;
Begin
  With qrPesqAux do
  Begin
    Close ;
    If Not vcDatabase.InTransaction Then vcDatabase.StartTransaction ;
    If vcDatabase.InTransaction Then vcDatabase.Rollback ;
    Sql.Clear ;
    SQL.Add('DELETE FROM CTR_LEMBRETES') ;
    SQL.Add('WHERE USUARIO = :P_USUARIO') ;
    SQL.Add('  AND SISTEMA = :P_SISTEMA') ;
    SQL.Add('  AND ' + IIf(pApagaVencidos,'DATAVALIDADE <','DATALEMBRETE =') + ' :P_DATA') ;
    ParamByName('P_USUARIO').AsString   := vcUsuario ;
    ParamByName('P_SISTEMA').AsString   := vcSistema ;
    ParamByName('P_DATA'   ).AsDateTime := pData ;
    If ExecutaSQL(qrPesqAux).Achou Then
      If vcDatabase.InTransaction Then
        vcDatabase.Commit ;
  End ; // With TQuery.Create(Self) do
End ;

Procedure MostraLembretes(pMenu : TPopupMenu) ;
Var
  i : Integer ;
  Procedure CriaLembretes ;
  Var
    vShapeLembrete : TShape ;
    vPnlLembrete,
    vPnlLembrete2  : TPanel ;
    vLblLembrete   : TLabel ;
    vMemoLembrete  : TMemo ;
    vBvlLembrete   : TBevel ;
    i,
    vLeft,
    vTop           : Integer ;
    vAtencao       : Boolean ;
  Begin
    vQtdeLembretes := 0 ;
    vLeft          := 0 ;
    vTop           := 0 ;
    For i := 0 to dm.vPanelAux.ControlCount-1 do
      If (dm.vPanelAux.Controls[i] Is TShape) And
         (Pos('vShapeLembrete_',dm.vPanelAux.Controls[i].Name) > 0) Then
      Begin
        Inc(vQtdeLembretes) ;
        If (IncInt(vLeft) mod 3) = 0 Then
        Begin
          vLeft := 0 ;
          Inc(vTop) ;
        End ; // If IncInt(vLeft) = 3 Then
      End ; // If (Components[i] Is TShape) And (...

    vAtencao := (qrPesqAux.FieldByName('DATAATENCAO').AsDateTime <> 0) And
                (qrPesqAux.FieldByName('DATAATENCAO').AsDateTime <= Now) ;

    vShapeLembrete := TShape.Create(dm.vPanelAux) ;
    With vShapeLembrete do
    Begin
      Parent      := dm.vPanelAux ;
      Name        := 'vShapeLembrete_' + StrZero(vQtdeLembretes,2) ;
      Width       := 310 ;
      Height      := 90  ;
      Visible		  := True ;
//      Left        := dm.vPanelAux.Left + 5 + (vLeft * Width ) + (vLeft * 5) ;
      Left        :=                0 + 5 + (vLeft * Width ) + (vLeft * 5) ;
      Top         := dm.vPanelAux.Top + 5 + (vTop  * Height) + (vTop  * 5) ;
      Shape       := stRoundRect ;
      Brush.Color := StringToColor(qrPesqAux.FieldByName(IIf(vAtencao,'CORATENCAO','CORLEMBRETE')).AsString) ;

      BringToFront ;
      vPnlLembrete := TPanel.Create(dm.vPanelAux) ;
      With vPnlLembrete do
      Begin

        Parent     := dm.vPanelAux ;
        Name       := 'vPnlLembrete_' + StrZero(vQtdeLembretes,2) ;
        Width      := 300 ;
        Height     := 83 ;
        Left       := vShapeLembrete.Left + 4 ;
        Top        := vShapeLembrete.Top  + 4 ;
        BevelOuter := bvNone ;
        Color			 := vShapeLembrete.Brush.Color ;
        Font.Color := StringToColor(qrPesqAux.FieldByName(IIf(vAtencao,'CORFONTATENCAO','CORFONTLEMBRETE')).AsString) ;
        Font.Size  := 8 ;
        Font.Name  := 'MS Sans Serif' ;
        Visible		 := True ;
        Font.Style := [] ;
        PopupMenu   := pMenu ;

        Hint       := IIf(vAtencao,                                          '','Atenção : ' + qrPesqAux.FieldByName('DATAATENCAO' ).AsString) ;
        Hint       := IIf(qrPesqAux.FieldByName('DATAVALIDADE').AsDateTime=0,'',IIf(Trim(Hint)='','',Hint + #13) +
                                                                                'Validade: ' + qrPesqAux.FieldByName('DATAVALIDADE').AsString) ;
        ShowHint   := Trim(Hint) <> '' ;
        BringToFront ;

        vPnlLembrete2 := TPanel.Create(dm.vPanelAux) ;
        With vPnlLembrete2 do
        Begin
          Parent      := vPnlLembrete ;
          Name        := 'vPnlLembrete2_' + StrZero(vQtdeLembretes,2) ;
          Align       := alClient ;
          BevelOuter  := bvNone ;
          Enabled     := False ;
        	ParentColor := True ;
        	Visible		 	:= True ;
          PopupMenu   := pMenu ;

          vLblLembrete := TLabel.Create(dm.vPanelAux) ;
          With vLblLembrete do
          Begin
            Parent      := vPnlLembrete ;
            Name        := 'vLblLembrete_' + StrZero(vQtdeLembretes,2) ;
            Align       := alTop ;
            Caption     := FormatDateTime('dd/mm/yyyy " as " hh:mm:ss',qrPesqAux.FieldByName('DATALEMBRETE').AsDateTime) ;
        		ParentColor := True ;
        		Visible		 	:= True ;
          End ; // With vLblLembrete do

          vBvlLembrete := TBevel.Create(dm.vPanelAux) ;
          With vBvlLembrete do
          Begin
            Parent  := vPnlLembrete2 ;
            Name    := 'vBvlLembrete_' + StrZero(vQtdeLembretes,2) ;
            Align   := alTop ;
            Height  := 2  ;
            Top     := 30 ;
            Shape   := bsTopLine ;
            Style   := bsRaised ;
        		Visible	:= True ;
          End ; // With vBvlLembrete do

          vMemoLembrete := TMemo.Create(dm.vPanelAux) ;
          With vMemoLembrete do
          Begin
            Parent      := vPnlLembrete2 ;
            Name        := 'vMemoLembrete_' + StrZero(vQtdeLembretes,2) ;
            Align       := alClient ;
            Text        := qrPesqAux.FieldByName('LEMBRETE').AsString ;
            BevelOuter  := bvNone ;
            BorderStyle := bsNone ;
        		ParentColor := True ;
            Visible		  := True ;
          End ; // With vMemoLembrete do
        End ; // With vPnlLembrete2 do
      End ; // With vPnlLembrete do
    End ; // With vShapeLembrete do
  End ; // Procedure CriaLembretes ;
Begin
  With qrPesqAux do
  Begin
    Close ;
    Sql.Clear ;
    SQL.Add('   SELECT DATALEMBRETE') ;
    SQL.Add('        , LEMBRETE') ;
    SQL.Add('        , DATAVALIDADE') ;
    SQL.Add('        , DATAATENCAO') ;
    SQL.Add('        , CORLEMBRETE') ;
    SQL.Add('        , CORFONTLEMBRETE') ;
    SQL.Add('        , CORATENCAO') ;
    SQL.Add('        , CORFONTATENCAO') ;
    SQL.Add('   FROM CTR_LEMBRETES') ;
    SQL.Add('   WHERE USUARIO = :P_USUARIO') ;
    SQL.Add('     AND SISTEMA = :P_SISTEMA') ;
    SQL.Add('ORDER BY DATALEMBRETE') ;
    ParamByName('P_USUARIO').AsString := vcUsuario ;
    ParamByName('P_SISTEMA').AsString := vcSistema ;
    AbrirQuery(qrPesqAux,'PesqLembretes','','') ;

    For i := dm.vPanelAux.ControlCount-1 downto 0 do
      If (dm.vPanelAux.Controls[i] Is TPanel) And
         (Pos('vPnlLembrete_',dm.vPanelAux.Controls[i].Name) > 0) Then
        dm.vPanelAux.Controls[i].Free ;

    For i := dm.vPanelAux.ControlCount-1 downto 0 do
      If (dm.vPanelAux.Controls[i] Is TShape) And
         (Pos('vShapeLembrete_',dm.vPanelAux.Controls[i].Name) > 0) Then
        dm.vPanelAux.Controls[i].Free ;

    While Not Eof do
    Begin
      CriaLembretes ;
      Next ;
    End ; // While Not Eof do
  End ; // With qrPesqAux do
End ;

initialization

  qrPesqAux := TQuery.Create( qrPesqAux );
  qrPesqAux.DataBaseName := cDatabaseName;
  qrPesqAux2 := TQuery.Create( qrPesqAux );
  qrPesqAux2.DataBaseName := cDatabaseName;

end.
