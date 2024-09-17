unit CntNewServidores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, Grids, DBGrids, ExtCtrls;

type
  TFrmCntNewServidores = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    DBGridAlias: TDBGrid;
    DriveTrab: TDriveComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCntNewServidores: TFrmCntNewServidores;

implementation

{$R *.dfm}

end.
