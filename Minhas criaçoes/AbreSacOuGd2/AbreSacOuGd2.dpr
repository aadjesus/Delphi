program AbreSacOuGd2;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Windows;

const
  cSacGD2 : Array [0..11,1..2] Of String = (('login.exe',      'GD2EXE')
                                           ,('sacgd2.exe',     'GD2')
                                           ,('gd2.hlp',        'GD2')
                                           ,('sac.ini',        'GD2')
                                           ,('sachelp.hlp',    'GD2')
                                           ,('entrada.avi',    'GD2')
                                           ,('ZipDLL.dll',     'GD2')
                                           ,('UnzDLL.dll',     'GD2')
                                           ,('sac.exe',        'SACEXE')
                                           ,('versoes.txt',    'SAC')
                                           ,('sachelp.hlp',    'SAC')
                                           ,('SII_CONEXAO.INI','SAC')
                                           ) ;

Var
  vParam,
  vNomeExe,
  vOri,
  vDes  : String ;
  i     : Integer ;
  vProg : HWnd ;
  vMostra : Boolean ;
begin
  vParam := UpperCase(ParamStr(1)) ;
  If Pos(vParam,'SAC_GD2') > 0 Then
  Begin
    If vParam = 'SAC' Then
    Begin
      vProg := FindWindow('TFrm_Login','SAC - Login - 18/10/2006') ;

      If vProg = 0 Then
        vProg := FindWindow('TFrm_MenuPrincipal',nil) ;
      vMostra := vProg <> 0 ;
    End Else // If vParam = 'SAC' Then
    Begin
      vProg := FindWindow('TFrmLoginCenter',nil) ;
      If vProg = 0 Then
        vProg := FindWindow('tfrmGerenciador',nil) ;

      vMostra := vProg <> 0 ;
      If vProg = 0 Then
      Begin
        vProg := FindWindow('TFrm_Login','SAC - Login') ;
        vMostra := False ;
      End ;
    End ; // End Else // If vParam = 'SAC' Then

    If vProg = 0 Then
    Begin
      ChDir('C:\') ;
      CreateDir('SAC') ;
      ChDir('C:\SAC') ;

      vProg := FindWindow(Nil,'AbreSacOuGd2.exe') ;
      If vProg > 0 Then
        ShowWindow(vProg,SW_HIDE) ; // Esconde o icone da barra iniciar

      vNomeExe := '' ;
      for I := Length(cSacGD2)-1 downto 0 do
      Begin
        If Pos(vParam,cSacGD2[i,2]) > 0 Then
        Begin
          vOri := 'G:\SAC\' + cSacGD2[i,1] ;
          vDes := 'C:\SAC\' + cSacGD2[i,1] ;
          If FileExists(vOri) Then
          Begin
            If FileExists(vDes) Then
            Begin
              FileSetAttr(vDes,0) ;
              DeleteFile(PChar(vDes)) ;
            End ; // If FileExists(vDes) Then

            CopyFile(PChar(vOri),  PChar(vDes),True) ;
            If vParam + 'EXE' = cSacGD2[i,2] Then
              vNomeExe := vDes ;
          End ; // If FileExists(vOri) Then
        End ; // If Pos(vParam,cSacGD2[i,2]) > 0 Then
      End ;

      If FileExists(vNomeExe) Then
        WinExec(PChar(vNomeExe),Sw_ShowNormal) ;
    End ; // If vProg = 0 Then

    If vMostra Then
    Begin
      SetForegroundWindow(vProg) ;
      If vParam = 'SAC' Then
        ShowWindow( vProg, SW_SHOWNORMAL)
      Else
        ShowWindow( vProg, SW_SHOWMAXIMIZED) ;
    End ; // If vMostra And vProg <> 0 Then
  End ; // If Pos(vParam,'SAC_GD2') > 0 Then
end.


