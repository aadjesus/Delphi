unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure CriarAtalho (NomeDoPrograma,ParametrosdeExcecucao,DiretoriodeInicializacao, NomedoAtalho,IniciarEm,NomedoGrupo : String);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses ShlObj, ActiveX,ComObj, Registry,FileCtrl;

{$R *.dfm}

{ TForm1 }

procedure TForm1.CriarAtalho(NomeDoPrograma, ParametrosdeExcecucao, DiretoriodeInicializacao, NomedoAtalho, IniciarEm, NomedoGrupo: String);
var
  MeuObjeto : IUnknown;
  MeuAtalho : IShellLink;
  MeuArquivo : IPersistFile;
  Diretorio : String;
  CriarAtalho : WideString;
  Var_Registro : TRegIniFile;
begin
  MeuObjeto := CreateComObject(CLSID_ShellLink);
  MeuAtalho := MeuObjeto as IShellLink;
  MeuArquivo := MeuObjeto as IPersistFile;
  with MeuAtalho do
  begin
    SetArguments(PChar(ParametrosdeExcecucao));
    SetPath(PChar(NomeDoPrograma));
    SetWorkingDirectory(PChar(DiretoriodeInicializacao));
  end;

  Var_Registro := TRegIniFile.Create('Software\Microsoft\Windows\CurrentVersion\Explorer');
  Diretorio := Var_Registro.ReadString ('Shell Folders','Programs','');

  //Cria o Atalho No Menu Iniciar
  if trim(NomedoGrupo)<>'' then
  begin
    Diretorio:=Diretorio+'\'+NomedoGrupo;
    if not DirectoryExists(Diretorio) then
    ForceDirectories(Diretorio);
  end;
  CriarAtalho := Diretorio + '\' + NomedoAtalho + '.lnk';
  MeuArquivo.Save (PWChar (CriarAtalho), False);

  //Cria o Atal]ho na area de Trabalho
  Diretorio := Var_Registro.ReadString ('Shell Folders','Desktop','');
  CriarAtalho := Diretorio + '\' + NomedoAtalho + '.lnk';

  MeuArquivo.Save (PWChar (CriarAtalho), False);
  Var_Registro.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  CriarAtalho('C:\Globus\Sistemas\Atualizacao\Atualizacao.exe'
             ,''
             ,'C:\Globus\Sistemas\Atualizacao\'
             ,'Atualizacao'
             ,'C:\Globus\Sistemas\Atualizacao\'
             ,'Globus'
             ) ;
{
 CriarAtalho('Arquivo.Exe'
            ,'parametro pa abertura'
            ,'Diretorio onde o Arquivo Esta'
            ,'Nome do Atalho'
            ,'onde o Arquivo Esta'
            ,'Nome do Gupo');
}
end;

end.




