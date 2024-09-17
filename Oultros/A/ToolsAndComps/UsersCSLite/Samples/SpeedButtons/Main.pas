unit Main;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, Buttons, StdCtrls, Menus, ExtCtrls, DB, DBTables,
  UsersCSLite;

type
  TDateOrder = (doMDY, doDMY, doYMD);

  TMainForm = class(TForm)
    MainPanel: TPanel;
    PrinterSetup: TPrinterSetupDialog;
    OrderBtn: TSpeedButton;
    BrowseBtn: TSpeedButton;
    PartsBtn: TSpeedButton;
    CloseBtn: TSpeedButton;
    ReportBtn: TSpeedButton;
    HelpBtn: TSpeedButton;
    MainMenu: TMainMenu;
    FileMenu: TMenuItem;
    FilePrinterSetup: TMenuItem;
    FileExit: TMenuItem;
    FileNewOrder: TMenuItem;
    FilePrintReport: TMenuItem;
    PrintCustList: TMenuItem;
    PrintOrders: TMenuItem;
    PrintInvoice: TMenuItem;
    ViewMenu: TMenuItem;
    ViewOrders: TMenuItem;
    ViewPartsInventory: TMenuItem;
    ViewStayOnTop: TMenuItem;
    ViewLocal: TMenuItem;
    ViewRemote: TMenuItem;
    HelpMenu: TMenuItem;
    HelpAbout: TMenuItem;
    HelpContents: TMenuItem;
    Users1: TMenuItem;
    UserAdministration1: TMenuItem;
    ChangeUserPassword1: TMenuItem;
    BrowseData: TMenuItem;
    N2: TMenuItem;
    Login1: TMenuItem;
    database: TDatabase;
    Memo1: TMemo;
    procedure CloseApp(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure PrinterSetupClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure UserAdministration1Click(Sender: TObject);
    procedure ChangeUserPassword1Click(Sender: TObject);
    procedure Login1Click(Sender: TObject);
    procedure databaseBeforeConnect(Sender: TObject);
  private
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.CloseApp(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
//  ClientWidth := CloseBtn.Left + CloseBtn.Width + 1;
//  ClientHeight := CloseBtn.Top + CloseBtn.Height;
  MainPanel.Align := alClient;
  { position the form at the top of display }
  {***}
  OrderBtn.Enabled:=FileNewOrder.Enabled;
  OrderBtn.Visible:=FileNewOrder.Visible;
  {***}
  PartsBtn.Enabled:=ViewPartsInventory.Enabled;
  PartsBtn.Visible:=ViewPartsInventory.Visible;
  {***}
  ReportBtn.Enabled:=FilePrintReport.Enabled;
  ReportBtn.Visible:=FilePrintReport.Visible;
  {***}
  BrowseBtn.Enabled:=BrowseData.Enabled;
  BrowseBtn.Visible:=BrowseData.Visible;

end;

procedure TMainForm.HelpBtnClick(Sender: TObject);
begin
  Application.HelpCommand(HELP_CONTENTS, 0);
end;

procedure TMainForm.PrinterSetupClick(Sender: TObject);
begin
  PrinterSetup.Execute;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Application.HelpCommand(HELP_QUIT,0);
end;

procedure TMainForm.UserAdministration1Click(Sender: TObject);
begin
  UsersCSLite1.UsersADM;
end;

procedure TMainForm.ChangeUserPassword1Click(Sender: TObject);
begin
  UsersCSLite1.ChangeUserPassword;
end;


procedure TMainForm.Login1Click(Sender: TObject);
begin
  if not UsersCSLite1.Login then
    Application.Terminate;
  OrderBtn.Enabled:=FileNewOrder.Enabled;
  OrderBtn.Visible:=FileNewOrder.Visible;
  {***}
  PartsBtn.Enabled:=ViewPartsInventory.Enabled;
  PartsBtn.Visible:=ViewPartsInventory.Visible;
  {***}
  ReportBtn.Enabled:=FilePrintReport.Enabled;
  ReportBtn.Visible:=FilePrintReport.Visible;
  {***}
  BrowseBtn.Enabled:=BrowseData.Enabled;
  BrowseBtn.Visible:=BrowseData.Visible;
  
end;



procedure TMainForm.databaseBeforeConnect(Sender: TObject);
begin
  Database.Params.Values['PATH']:=ExtractFilePath(Application.Exename)+'..\Data';  
end;

end.
