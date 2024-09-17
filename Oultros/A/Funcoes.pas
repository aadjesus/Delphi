unit Funcoes;

interface

uses
  SysUtils, IniFiles, Dialogs, ExtDlgs, StrUtils, TypInfo;

type
   TClassOpenDialog = class of TOpenDialog;
   TCharSet= Set of Char;   

procedure GravaInfoDialog(Dialog: TOpenDialog; Secao: String; ArquivoCFG: TFileName);
procedure RecuperaInfoDialog(Dialog: TOpenDialog; Secao: String; ArquivoCFG: TFileName);
function  ShowDialog(DialogClass: TClassOpenDialog; Secao: String; ArquivoCFG: TFileName; Filter: String; FileName: String = ''): TOpenDialog;
function  OpenDialog(ArquivoCFG: TFileName; Secao: String; Filter: String; FileName: String = ''): String;
function  SaveDialog(ArquivoCFG: TFileName; Secao: String; Filter: String; FileName: String = ''): String;
function  OpenPictureDialog(ArquivoCFG: TFileName; Secao, Filter: String): String;
function  SavePictureDialog(ArquivoCFG: TFileName; Secao, Filter: String): String;
function  getExtensao(Filter: String; Index: Integer): String;
function  ExtractWord(Num:integer;const Str: string;const  WordDelims:TCharSet):string;
procedure setValorPropriedade(Instance: TObject; const PropName: String; Valor: Variant);
function WordCount(const S: string; const WordDelims: TCharSet): Integer;

implementation

procedure GravaInfoDialog(Dialog: TOpenDialog; Secao: String; ArquivoCFG: TFileName);
var
   FIni: TIniFile;
begin
   FIni := TIniFile.Create(ArquivoCFG);
   try
      FIni.WriteString(Secao,'UltimoDiretorio',ExtractFilePath(Dialog.FileName));
      FIni.WriteInteger(Secao,'UltimaExtensao',Dialog.FilterIndex);
   finally
      FIni.Free;
   end;
end;

procedure RecuperaInfoDialog(Dialog: TOpenDialog; Secao: String; ArquivoCFG: TFileName);
var
   FIni: TIniFile;
begin
   FIni := TIniFile.Create(ArquivoCFG);
   try
      Dialog.InitialDir  := FIni.ReadString(Secao,'UltimoDiretorio','C:\');
      Dialog.FilterIndex := FIni.ReadInteger(Secao,'UltimaExtensao',1);
   finally
      FIni.Free;
   end;
end;

function ShowDialog(DialogClass: TClassOpenDialog; Secao: String; ArquivoCFG: TFileName; Filter: String; FileName: String = ''): TOpenDialog;
begin
   Result := DialogClass.Create(nil);
   Result.Filter := Filter;
   Result.FileName := FileName;
   RecuperaInfoDialog(Result, Secao, ArquivoCFG);
   if Result.Execute then
   begin
      GravaInfoDialog(Result,Secao,ArquivoCFG);
   end else
   begin
      Result.FileName := '';
   end;
end;

function OpenDialog(ArquivoCFG: TFileName; Secao: String; Filter: String; FileName: String = ''): String;
var
   Dlg: TOpenDialog;
begin
   Dlg := ShowDialog(TOpenDialog,Secao,ArquivoCFG, Filter,FileName);
   try
      Result := Dlg.FileName;
   finally
      Dlg.Free;
   end;
end;

function SaveDialog(ArquivoCFG: TFileName; Secao: String; Filter: String; FileName: String = ''): String;
var
   Dlg: TOpenDialog;
   ext: String;
begin
   Dlg := ShowDialog(TSaveDialog,Secao,ArquivoCFG, Filter,FileName);
   try
      if Dlg.FileName <> '' then
      begin
         ext := getExtensao(Dlg.Filter, Dlg.FilterIndex);
         if ExtractFileExt(Dlg.FileName) = '' then
            Dlg.FileName := Dlg.FileName+getExtensao(Dlg.Filter,
                                                     Dlg.FilterIndex);
         Result := Dlg.FileName;
      end;
   finally
      Dlg.Free;
   end;
end;

function OpenPictureDialog(ArquivoCFG: TFileName; Secao, Filter: String): String;
var
   Dlg: TOpenPictureDialog;
begin
   Dlg := TOpenPictureDialog(ShowDialog(TOpenPictureDialog,Secao,ArquivoCFG,Filter));
   try
      Result := Dlg.FileName;
   finally
      Dlg.Free;
   end;
end;

function SavePictureDialog(ArquivoCFG: TFileName; Secao, Filter: String): String;
var
   Dlg: TSavePictureDialog;
   ext: String;
begin
   Dlg := TSavePictureDialog(ShowDialog(TSavePictureDialog,Secao,ArquivoCFG, Filter));
   try
      if Dlg.FileName <> '' then
      begin
         ext := getExtensao(Dlg.Filter, Dlg.FilterIndex);
         if ExtractFileExt(Dlg.FileName) = '' then
            Dlg.FileName := Dlg.FileName+getExtensao(Dlg.Filter,
                                                     Dlg.FilterIndex);
         Result := Dlg.FileName;
      end;
   finally
      Dlg.Free;
   end;
end;

function getExtensao(Filter: String; Index: Integer): String;
begin
   Result := AnsiReplaceText(ExtractWord(Index*2,Filter,['|']),'*','');
end;

function ExtractWord(Num:integer;const Str: string;const  WordDelims:TCharSet):string;
var
  SLen, I: Cardinal;
  wc: Integer;
begin
  Result := '';
  I := 1; wc:=0;
  SLen := Length(Str);
  while I <= SLen do begin
    while (I <= SLen) and (Str[I] in WordDelims) do Inc(I);
    if I <= SLen then Inc(wc);
    if wc=Num then Break;
    while (I <= SLen) and not(Str[I] in WordDelims) do Inc(I);
  end;
  if (wc=0) and (Num=1) then Result:=Str
  else
  if wc<>0 then begin
     while (I <= SLen) and not (Str[I] in WordDelims) do begin
       Result:=Result+Str[I];
       Inc(I);
     end;
  end;
end;

procedure setValorPropriedade(Instance: TObject; const PropName: String; Valor: Variant);
var
   i: Integer;
   Ref: Longint;
   num_niveis: Integer;
begin
   num_niveis := WordCount(PropName,['.']);
   if num_niveis > 1 then
   begin
      Ref := Longint(Instance);
      for i:=1 to num_niveis-1 do
      begin
         Ref := GetPropValue(ptr(Ref),ExtractWord(i,PropName,['.']));
      end;
      SetPropValue(ptr(Ref),ExtractWord(num_niveis,PropName,['.']), Valor);
   end else
   begin
      SetPropValue(Instance,PropName,Valor);
   end;
end;

function WordCount(const S: string; const WordDelims: TCharSet): Integer;
var
  SLen, I: Cardinal;
begin
  Result := 0;
  I := 1;
  SLen := Length(S);
  while I <= SLen do begin
    while (I <= SLen) and (S[I] in WordDelims) do Inc(I);
    if I <= SLen then Inc(Result);
    while (I <= SLen) and not(S[I] in WordDelims) do Inc(I);
  end;
end;

end.
