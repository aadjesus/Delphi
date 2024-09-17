unit AboutBgmRodotec;

interface

uses
  Windows, Forms, ExtCtrls, StdCtrls, Controls, Classes,
  {$IFDEF VER120} {Delphi 4}
   DsgnIntf,
  {$ELSE}
  DesignIntf, DesignEditors,
  {$ENDIF}
  buttons ;

Var
  cAboutNomeComponente,
  cAboutVersao,
  cAboutAutor        : String ;

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

  TAboutProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function  GetAttributes : TPropertyAttributes; override;
    function  GetValue: string; override;
  end ; // TAboutProperty = class(TClassProperty)

implementation

{Resource Files}
{$R UAboutBgmRodotec.DFM}

{ TAboutProperty }
procedure TAboutProperty.Edit;
Var
  About : TFrmAboutBgmRodotec ;
begin
  Application.CreateForm(TFrmAboutBgmRodotec, About) ;
  About.EdtNomeComponente.Text := cAboutNomeComponente ;
  About.EdtVersao.Text         := cAboutVersao ;
  About.EdtAutor.Text          := cAboutAutor ;
  About.ShowModal ;
  About.Release ;
end;

function TAboutProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog, paReadOnly]
                                    - [paSubProperties] ;
end;

function TAboutProperty.GetValue: string;
begin
  Result := 'BgmRodotec' ;
end;

{ TFrmAboutBgmRodotec }
procedure TFrmAboutBgmRodotec.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Release;
end;

end.
