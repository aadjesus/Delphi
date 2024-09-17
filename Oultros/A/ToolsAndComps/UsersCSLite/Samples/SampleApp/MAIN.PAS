unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, Db, DBTables, UsersCSLite, Grids, DBGrids;

type
  TForm1 = class(TForm)
    database: TDatabase;
    MainMenu1: TMainMenu;
    Projects1: TMenuItem;
    NewProject1: TMenuItem;
    EditProjectData1: TMenuItem;
    DeleteProject1: TMenuItem;
    N1: TMenuItem;
    ListProjects1: TMenuItem;
    Tasks2: TMenuItem;
    NewTask2: TMenuItem;
    EditTaskData2: TMenuItem;
    DeleteTask2: TMenuItem;
    N3: TMenuItem;
    ListTasks2: TMenuItem;
    N2: TMenuItem;
    Print1: TMenuItem;
    ControledeUsurios1: TMenuItem;
    MudarPassword1: TMenuItem;
    AdministraodeUsurios1: TMenuItem;
    Login1: TMenuItem;
    procedure MudarPassword1Click(Sender: TObject);
    procedure AdministraodeUsurios1Click(Sender: TObject);
    procedure Login1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NewProject1Click(Sender: TObject);
    procedure databaseBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.MudarPassword1Click(Sender: TObject);
begin
  UsersCSLite1.ChangeUserPassword;
end;

procedure TForm1.AdministraodeUsurios1Click(Sender: TObject);
begin
  UsersCSLite1.UsersAdm;
end;

procedure TForm1.Login1Click(Sender: TObject);
begin
  UsersCSLite1.Login;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //ShortDateFormat:='dd/mm/yy';
end;

procedure TForm1.NewProject1Click(Sender: TObject);
begin
  ShowMessage((Sender as TMenuItem).Caption);
end;

procedure TForm1.databaseBeforeConnect(Sender: TObject);
begin
  Database.Params.Values['PATH']:=ExtractFilePath(Application.Exename)+'..\Data';  
end;

end.
