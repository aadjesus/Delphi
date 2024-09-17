unit Ufavoritos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles, FileCtrl, ExtCtrls, DdeMan, ShellAPI ;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Panel10: TPanel;
    Panel11: TPanel;
    DriveComboBox: TDriveComboBox;
    DirectoryListBox: TDirectoryListBox;
    LblArqHtml: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure LblArqHtmlMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LblArqHtmlClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  listtemp2: TStrings;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
Var
  vNomeArq,
  vDiretorio,
  vHtml    : String ;
  vUrl     : TIniFile ;
  vArquivo : TextFile;

  procedure ListarArquivos(diretorioInicial, mascara: string; listtotaldir: boolean = false; recursive: boolean = true);
  var
    i: integer;
    listatemp: TStrings;
    procedure ListarDiretorios(Folder: string; lista: Tstrings);
    var
      Rec: TSearchRec;
      i: integer;
      temps: string;
    begin
      lista.Clear;
      if SysUtils.FindFirst(Folder + '*', faDirectory, Rec) = 0 then
      try
        repeat
          lista.Add(rec.Name);
        until SysUtils.FindNext(Rec) <> 0;
      finally
        if lista.count <> 0 then
        begin
          // deleta o diretorio ..
          lista.Delete(1);
          // deleta o diretorio .
          lista.Delete(0);
          i := 0;
          //deleta os arquivos isto e fica apenas os diretorios
          if lista.count <> 0 then
          begin
            repeat
              temps := lista.Strings[i];
              temps := extractfileext(temps);
              if temps <> '' then
                lista.Delete(i)
              else
                inc(i);
            until i >= lista.Count;
          end;
        end;
      end;
    end;

    procedure ListarAtahos(Folder, mask: string; Lista: Tstrings);
    var
      Rec: TSearchRec;
    begin
      lista.Clear;
      if SysUtils.FindFirst(Folder + mask, faAnyFile, Rec) = 0 then
      try
        repeat
          lista.Add(rec.Name);
        until SysUtils.FindNext(Rec) <> 0;
      finally
        SysUtils.FindClose(Rec);
      end;
    end;

    procedure AddLIstInOther(ListSource, ListDestino: TStrings);
    var
      f: integer;
    begin
      for f := 0 to ListSource.Count - 1 do
      begin
        ListDestino.Add(ListSource.Strings[f]);
      end;
    end;
  begin
    listatemp := TStringList.Create;
    ListarAtahos(diretorioInicial, mascara, listatemp);
    if listtotaldir = true then
    begin
      WriteLN( vArquivo, '<table bgcolor="#A1BBE4" border="1" color="#FFFFFF" bordercolor="#FFFFFF" width="30%">') ;

      vDiretorio := StringReplace(diretorioInicial ,DirectoryListBox.Directory + '\','',[]) ;
      vDiretorio := Copy(vDiretorio,1,Length(vDiretorio)-1) ;

      If Trim(vDiretorio) <> '' Then
        WriteLN( vArquivo, '<TR align=center style="color: #000080; FONT-SIZE: 10pt"> <TD>'+ vDiretorio +'</TD></TR>') ;


      for i := 0 to listatemp.Count - 1 do
      begin
        listatemp.Strings[i] := diretorioInicial + listatemp.Strings[i];

        Try
          vUrl     := TIniFile.Create(listatemp.Strings[i]) ;
          vHtml    := vUrl.ReadString('DEFAULT',   'BASEURL',''  ) ;
          vNomeArq := ExtractFileName(listatemp.Strings[i]) ;
          vNomeArq := StringReplace(vNomeArq,ExtractFileExt(vNomeArq),'',[]) ;
          If Trim(vHtml) <> '' Then
            WriteLN( vArquivo, '<TR bgcolor="#D4DDED" style="color: #000080; FONT-SIZE: 10pt"> <TD><A href="'+ vHtml +'">'+ vNomeArq +'</A></TD></TR>'
                   ) ;
        finally
          vURL.Free ;
        End ; // Try - Except
      end;
      WriteLN( vArquivo, '</table> <p></p>') ;
    end;

    AddLIstInOther(listatemp, listtemp2) ;

    if recursive = true then
    begin
      ListarDiretorios(diretorioInicial, listatemp);
      for i := 0 to listatemp.Count - 1 do
        ListarArquivos(diretorioInicial + listatemp.Strings[i] + '\', mascara, listtotaldir, recursive);
    end;
    listatemp.Free;
  end;
begin
  Screen.Cursor := crHourGlass ;
  listtemp2     := TStringList.Create;

  LblArqHtml.Caption := DirectoryListBox.Directory + '\Favoritos.html' ;
  If FileExists(LblArqHtml.Caption) Then
    DeleteFile(LblArqHtml.Caption) ;

  If FileExists(LblArqHtml.Caption) Then
    DeleteFile(LblArqHtml.Caption) ;

  AssignFile( vArquivo, LblArqHtml.Caption );
  ReWrite(vArquivo) ;

//  WriteLN( vArquivo,'<body>'
//                   +'<p align="center"><font face="Arial" color="#000099" size="5"><STRONG>Lista de favoritos</STRONG></font></p>'
//                   +'<table bgcolor="#A1BBE4" border="1"  color="#FFFFFF" bordercolor="#FFFFFF" width="30%" >'
//          ) ;


  WriteLN( vArquivo,'<Page x:Class="Favoritos.Principal"');
  WriteLN( vArquivo,'    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"');
  WriteLN( vArquivo,'    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"');
  WriteLN( vArquivo,'    Title="Principal">');
  WriteLN( vArquivo,'    <Grid>');
  WriteLN( vArquivo,'        <Grid.RowDefinitions>');
  WriteLN( vArquivo,'            <RowDefinition Height="30"/>');
  WriteLN( vArquivo,'            <RowDefinition/>');
  WriteLN( vArquivo,'        </Grid.RowDefinitions>');
  WriteLN( vArquivo,'        <Label Content="Favoritos"/>');
  WriteLN( vArquivo,'        <TreeView Grid.Row="1">');

  ListarArquivos(DirectoryListBox.Directory + '\', '*.url', true, true);

  WriteLN( vArquivo,'        </TreeView>');
  WriteLN( vArquivo,'    </Grid>');
  WriteLN( vArquivo,'</Page>');

//  WriteLN( vArquivo,'</table> </body>') ;

  CloseFile(vArquivo) ;

  If listtemp2.Count = 0 Then
  Begin
    If FileExists(LblArqHtml.Caption) Then
      DeleteFile(LblArqHtml.Caption) ;
    ShowMessage('Nenhuma URL encontrada.') ;
    LblArqHtml.Caption := 'Arquivo' ; 
  End Else
  If FileExists(LblArqHtml.Caption) Then
    ShowMessage('Arquivo gerado.') ;

  listtemp2.free;
  Screen.Cursor := crDefault ;
end;

procedure TForm1.LblArqHtmlMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin

  If Sender = LblArqHtml Then
  Begin
    LblArqHtml.Cursor  := crHandPoint ;
    LblArqHtml.Font.Color := clBlue ;
  End Else
  Begin
    LblArqHtml.Font.Color := clNavy ;
    LblArqHtml.Cursor     := crDefault ;
  End ;
end;

procedure TForm1.LblArqHtmlClick(Sender: TObject);
begin
  If FileExists(LblArqHtml.Caption) Then
    ShellExecute(Application.Handle, nil, PChar(LblArqHtml.Caption), nil, nil, SW_SHOWNORMAL);
end;

end.

