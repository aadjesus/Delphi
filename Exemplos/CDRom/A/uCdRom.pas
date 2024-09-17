unit uCdRom;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, MMSystem;

type
  TfrmPrincipal = class(TForm)
    btnAbreDrive: TButton;
    btnFechaDrive: TButton;
    procedure btnAbreDriveClick(Sender: TObject);
    procedure btnFechaDriveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.DFM}

procedure TfrmPrincipal.btnAbreDriveClick(Sender: TObject);
begin
  { Para abrir }
  mciSendString('Set cdaudio door open wait', nil, 0, handle);
end;

procedure TfrmPrincipal.btnFechaDriveClick(Sender: TObject);
begin
  { Para fechar }
  mciSendString('Set cdaudio door closed wait', nil, 0, handle);
end;

end.
