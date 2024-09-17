unit UNomeExe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormShow(Sender: TObject);
begin
  Memo1.Clear ;
  Memo1.Lines.Add( 'Application.ExeName : ' + Application.ExeName ) ;
  Memo1.Lines.Add( 'ExtractFileDir      : ' + ExtractFileDir(Application.ExeName) ) ;
  Memo1.Lines.Add( 'ExtractFileDrive    : ' + ExtractFileDrive(Application.ExeName) ) ;
  Memo1.Lines.Add( 'ExtractFileExt      : ' + ExtractFileExt(Application.ExeName) ) ;

//  Memo1.Lines.Add( 'xxxxx: ' + StringReplace( Application.ExeName,ExtractFileDrive(Application.ExeName),'',[] ) ) ;



  Memo1.Lines.Add( 'ExtractFileName     : ' + ExtractFileName(Application.ExeName) ) ;
  Memo1.Lines.Add( 'ExtractFilePath     : ' + ExtractFilePath(Application.ExeName) ) ;
  Memo1.Lines.Add( 'ChangeFileExt       : ' + ChangeFileExt('O:\trabalho\ale\'+ExtractFileName(Application.ExeName), '.Err') ) ;
end;

end.
