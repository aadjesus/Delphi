unit Grava_Teclas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, Db, RxMemDS, ComCtrls, Buttons, ExtCtrls, Grids, DBGrids;

type
  TForm1 = class(TForm)
    FPanelMenus: TPanel;
    FPanelTitulo: TPanel;
    FSButExpande: TSpeedButton;
    FSButCompacta: TSpeedButton;
    FLabelTitulo: TLabel;
    vMDTeclas: TRxMemoryData;
    MainMenu1: TMainMenu;
    FSaida: TMenuItem;
    FPanelTeclas: TPanel;
    FDSTeclas: TDataSource;
    FTViewMenuTeclas: TTreeView;
    FLabelTecla: TLabel;
    FEdtTecla: TEdit;
    FSButCopiar: TSpeedButton;
    FSButLimpar: TSpeedButton;
    procedure FSButCopiarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FSButCopiarClick(Sender: TObject);
begin
//
end;

end.
        