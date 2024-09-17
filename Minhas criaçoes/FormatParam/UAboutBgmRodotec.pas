unit UAboutBgmRodotec;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$IFDEF VER120} {Delphi 4}
   DsgnIntf,
  {$ELSE}
  DesignIntf, DesignEditors,
  {$ENDIF}
  jpeg, ExtCtrls, StdCtrls, Buttons;

type
  TFrmAboutBgmRodotec = class(TForm)
    PnlTelaAbout: TPanel;
    Label1: TLabel;
    LblNomeFantasia: TLabel;
    LblEmail: TLabel;
    LblPagHtml: TLabel;
    ImageBgmRodotec: TImage;
    EdtNomeComponente: TEdit;
    EdtVersao: TEdit;
    LblVersao: TLabel;
    LblAutor: TLabel;
    EdtAutor: TEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAboutBgmRodotec: TFrmAboutBgmRodotec;

implementation

uses
  FormatParam ;

{$R *.DFM}

procedure TFrmAboutBgmRodotec.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;

end.
