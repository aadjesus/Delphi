unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus, OleCtnrs, Unit2, Mask;

type
  TForm1 = class(TForm)
    OleContainer1: TOleContainer;
    Button1: TButton;
    procedure Init1Click(Sender: TObject);
    procedure Deactivate1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Save1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure test1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  public
    FAuto, FReg : boolean;
    OleObj : TOleTestImp;
  end;

var
  Form1: TForm1;

function FindCmdLineSwitch(const Switch: string): Boolean;  

const STDCAption = 'Delphi OLE - Viewer 1.0 (C) Alexandre Rai.';  

implementation

{$R *.DFM}

function FindCmdLineSwitch(const Switch: string): Boolean;
var
  I: Integer;
  S: string;
begin
  for I := 1 to ParamCount do
  begin
    S := ParamStr(I);
    if (S[1] in ['-', '/']) and
      (CompareText(Copy(S, 2, Maxint), Switch) = 0) then
    begin
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;


procedure TForm1.Init1Click(Sender: TObject);
begin
  OleContainer1.InsertObjectDialog;
end;

procedure TForm1.Deactivate1Click(Sender: TObject);
begin
  OleContainer1.Run
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not Visible or (not FAuto);
  if not CanClose then begin
    OleObj.CloseN;
    OleContainer1.Close;
    CanClose := True;
  //  Hide;
  end;
end;

procedure TForm1.Save1Click(Sender: TObject);
begin
  OleContainer1.SaveToFile('c:\test.ole');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Caption := STDCAption;
  FAuto := FindCmdLineSwitch('AUTOMATION') or FindCmdLineSwitch('EMBEDDING');
  FReg := FindCmdLineSwitch('REGSERVER') or FindCmdLineSwitch('UNREGSERVER');
//  if FReg then Application.Terminate
  if (ParamCount > 0) and not (FReg or FAuto) then
          OleContainer1.LoadFromFile(ParamStr(1))
end;

procedure TForm1.test1Click(Sender: TObject);
var i : integer;
begin
  for i := 0 to ParamCount - 1 do
  ShowMessage(ParamStr(i));
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    OleContainer1.Refresh;
    OleContainer1.SaveToFile('xisto.ole');
end;

end.
