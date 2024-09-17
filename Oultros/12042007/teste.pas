unit teste;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs;

type
  TService1 = class(TService)
    procedure ServiceCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  Service1: TService1;

implementation

{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  Service1.Controller(CtrlCode);
end;

function TService1.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TService1.ServiceCreate(Sender: TObject) ;
const
  cSacGD2 : Array [0..9,1..2] Of String = (('login.exe',      'SACEXE')
                                          ,('sacgd2.exe',     'SAC')
                                          ,('gd2.hlp',        'SAC')
                                          ,('sac.ini',        'SAC')
                                          ,('sachelp.hlp',    'SAC')
                                          ,('entrada.avi',    'SAC')
                                          ,('sac.exe',        'GD2EXE')
                                          ,('versoes.txt',    'GD2')
                                          ,('sachelp.hlp',    'GD2')
                                          ,('SII_CONEXAO.INI','GD2')
                                          ) ;
Var
  i    : Integer ;
  vParam,
  vNomeExe,
  vOri,
  vDes : String ;
begin
  vParam := UpperCase(ParamStr(1)) ;
  If Pos(vParam,'SAC_GD2') > 0 Then
  Begin
    ChDir('C:\') ;
    CreateDir('SAC') ;
    vNomeExe := '' ;
    For i := 0 to Length(cSacGD2)-1 do
      If Pos(vParam,cSacGD2[i,2]) > 0 Then
      Begin
        vOri := 'g:\sac\' + cSacGD2[i,1] ;
        vDes := 'c:\sac\' + cSacGD2[i,1] ;
        If FileExists(vDes) Then
          FileSetAttr(vDes,0) ;
        CopyFile(PChar(vOri),  PChar(vDes),True) ;
        If vParam + 'EXE' = cSacGD2[i,2] Then
          vNomeExe := vDes ;
      End ; // If Pos(vParam,cSacGD2[i,2]) > 0 Then

    If FileExists(vNomeExe) Then
      WinExec(PChar(vNomeExe),Sw_ShowNormal) ;
  End ; // If Pos(vParam,'SAC_GD2') > 0 Then
//  Abort ;
end;

end.


