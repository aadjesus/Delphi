unit UListaMusicas3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DB, RxMemDS, Grids, DBGrids, MMSystem,
  MPlayer, Menus, FileCtrl, ComCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    RxMemoryData1: TRxMemoryData;
    RxMemoryData1GRUPO: TStringField;
    RxMemoryData1QTDE: TIntegerField;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    RxMemoryData2: TRxMemoryData;
    StringField1: TStringField;
    StringField2: TStringField;
    RxMemoryData2QTDE: TIntegerField;
    DataSource2: TDataSource;
    RxMemoryData1QTDEM: TIntegerField;
    MediaPlayer1: TMediaPlayer;
    Panel10: TPanel;
    Panel11: TPanel;
    DriveComboBox: TDriveComboBox;
    DirectoryListBox: TDirectoryListBox;
    Button1: TButton;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    StatusBar1: TStatusBar;
    EdtGrupo: TEdit;
    Panel2: TPanel;
    RxMemoryData3: TRxMemoryData;
    StringField4: TStringField;
    StringField5: TStringField;
    StringField6: TStringField;
    RxMemoryData3PATH: TStringField;
    DataSource3: TDataSource;
    PopupMenu1: TPopupMenu;
    Play1: TMenuItem;
    Pause1: TMenuItem;
    Stop1: TMenuItem;
    DBGrid3: TDBGrid;
    StatusBar2: TStatusBar;
    procedure RxMemoryData1AfterScroll(DataSet: TDataSet);
    procedure RxMemoryData2AfterScroll(DataSet: TDataSet);
    procedure RxMemoryData2FilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure RxMemoryData3FilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Play1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure RxMemoryData3AfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  listtemp2: TStrings;
  vFiltra : Boolean ;

implementation

{$R *.dfm}

procedure TForm1.RxMemoryData1AfterScroll(DataSet: TDataSet);
begin
  If vFiltra Then
  Begin
    RxMemoryData2.Filtered := False ;
    RxMemoryData2.Filtered := True ;
    RxMemoryData2.First ;
  End ;
end;

procedure TForm1.RxMemoryData2AfterScroll(DataSet: TDataSet);
begin
  If vFiltra Then
  Begin
    RxMemoryData3.Filtered := False ;
    RxMemoryData3.Filtered := True ;
    RxMemoryData3.First ;
  End ;
end;

procedure TForm1.RxMemoryData2FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  If vFiltra Then
    Accept := (RxMemoryData1.FieldByName('GRUPO').AsString = RxMemoryData2.FieldByName('GRUPO').AsString) ;
end;

procedure TForm1.RxMemoryData3FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  If vFiltra Then
    Accept := (RxMemoryData2.FieldByName('GRUPO').AsString = RxMemoryData3.FieldByName('GRUPO').AsString)
          And (RxMemoryData2.FieldByName('ALBUM').AsString = RxMemoryData3.FieldByName('ALBUM').AsString) ;
end;

procedure TForm1.Button1Click(Sender: TObject);
Var
  i : Integer ;
  vLinha,
  vGrupo,
  vAlbum,
  vMusica,
  vPath   : String ;

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
      for i := 0 to listatemp.Count - 1 do
      begin
        listatemp.Strings[i] := diretorioInicial + listatemp.Strings[i];
      end;
    end;
    AddLIstInOther(listatemp, listtemp2);
    if recursive = true then
    begin
      ListarDiretorios(diretorioInicial, listatemp);
      for i := 0 to listatemp.Count - 1 do
      begin

        ListarArquivos(diretorioInicial + listatemp.Strings[i] + '\', mascara, listtotaldir, recursive);
      end;
    end;
    listatemp.Free;
  end;
begin
  Screen.Cursor := crHourGlass ;
  listtemp2     := TStringList.Create;
  vFiltra       := False ;
  RxMemoryData1.EmptyTable ;
  RxMemoryData1.Open ;

  RxMemoryData2.EmptyTable ;
  RxMemoryData2.Open ;

  RxMemoryData3.EmptyTable ;
  RxMemoryData3.Open ;
  ListarArquivos(DirectoryListBox.Directory + '\', '*.mp3', true, true);

  RxMemoryData1.DisableControls ;
  RxMemoryData2.DisableControls ;
  RxMemoryData3.DisableControls ;

  For i := 0 to listtemp2.Count-1 do
  Begin
    vLinha   := StringReplace(listtemp2.Strings[i],DirectoryListBox.Directory + '\','',[]) ;
    vLinha   := Copy(vLinha,Pos('\',vLinha)+1,300) ;
    If Pos('\',vLinha) > 0 Then
      vLinha  := Copy(vLinha,Pos('\',vLinha)+1,300) ;

    vPath    := listtemp2.Strings[i] ;
    vGrupo   := Copy(vLinha,1,Pos(' - ',vLinha)-1) ;
    If Pos(',',vGrupo) > 0 Then
      vGrupo := Copy(vLinha,1,Pos(',',vGrupo)-1) ;

    vAlbum   := Copy(vLinha,Pos(' - ',vLinha)+3,300) ;
    vAlbum   := Copy(vAlbum,1,Pos(' - ',vAlbum)-1) ;

    vMusica  := Copy(vLinha,Pos(' - ',vLinha)+3,300) ;
    If Pos(' - ',vMusica) > 0 Then
      vMusica  := Copy(vMusica,Pos(' - ',vMusica)+3,300) ;
    vMusica  := Copy(vMusica,1,Pos('.mp3',vMusica)-1) ;

    If Not RxMemoryData1.Locate('GRUPO',vGrupo,[loCaseInsensitive]) Then
    Begin
      RxMemoryData1.Append ;
      RxMemoryData1.FieldByName('GRUPO').AsString := vGrupo ;
    End Else
      RxMemoryData1.Edit ;
    RxMemoryData1.FieldByName('QTDEM').AsInteger := RxMemoryData1.FieldByName('QTDEM').AsInteger + 1 ;
    RxMemoryData1.Post ;

    If Not RxMemoryData2.Locate('GRUPO;ALBUM',VarArrayOf([vGrupo,vAlbum]),[loCaseInsensitive]) Then
    Begin
      RxMemoryData2.Append ;
      RxMemoryData2.FieldByName('GRUPO').AsString := vGrupo ;
      RxMemoryData2.FieldByName('ALBUM').AsString := vAlbum ;
      If RxMemoryData1.Locate('GRUPO',vGrupo,[loCaseInsensitive]) Then
      Begin
        RxMemoryData1.Edit ;
        RxMemoryData1.FieldByName('QTDEA').AsInteger := RxMemoryData1.FieldByName('QTDEA').AsInteger + 1 ;
        RxMemoryData1.Post ;
      End ;
    End Else
      RxMemoryData2.Edit ;
    RxMemoryData2.FieldByName('QTDEM').AsInteger := RxMemoryData2.FieldByName('QTDEM').AsInteger + 1 ;
    RxMemoryData2.Post ;

    If Not RxMemoryData3.Locate('GRUPO;ALBUM;MUSICA',VarArrayOf([vGrupo,vAlbum,vMusica]),[loCaseInsensitive]) Then
    Begin
      RxMemoryData3.Append ;
      RxMemoryData3.FieldByName('GRUPO' ).AsString := vGrupo ;
      RxMemoryData3.FieldByName('ALBUM' ).AsString := vAlbum ;
      RxMemoryData3.FieldByName('MUSICA').AsString := vMusica ;
      RxMemoryData3.FieldByName('PATH'  ).AsString := vPath ;
      RxMemoryData3.Post ;
    End ;
  End ; //

  StatusBar1.Panels[0].Text := IntToStr(RxMemoryData1.RecordCount) + ', Grupos' ;
  StatusBar1.Panels[1].Text := IntToStr(RxMemoryData2.RecordCount) + ', Albuns' ;
  StatusBar1.Panels[2].Text := IntToStr(RxMemoryData3.RecordCount) + ', Músicas' ;

  listtemp2.free;
  RxMemoryData1.SortOnFields('GRUPO') ;
  RxMemoryData2.SortOnFields('GRUPO;ALBUM') ;
  RxMemoryData3.SortOnFields('GRUPO;ALBUM;MUSICA') ;

  RxMemoryData1.EnableControls ;
  RxMemoryData2.EnableControls ;
  RxMemoryData3.EnableControls ;

  vFiltra := True ;
  RxMemoryData1.First ;
  Screen.Cursor := crDefault ;
  DBGrid1.Setfocus ;
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
begin
  MediaPlayer1.FileName := RxMemoryData3.FieldByName('PATH'  ).AsString ;
  PopupMenu1.AutoPopup  := FileExists(RxMemoryData3.FieldByName('PATH'  ).AsString) ;
end;

procedure TForm1.Play1Click(Sender: TObject);
begin
  PopupMenu1Popup(Sender) ;
  If PopupMenu1.AutoPopup Then
  Begin
    If TMenuItem(Sender) = Play1 Then
    Begin
      MediaPlayer1.Open ;
      MediaPlayer1.Play ;
    End Else
    If TMenuItem(Sender) = Pause1 Then
      MediaPlayer1.Pause
    Else
      MediaPlayer1.Stop ;
  End ;
end;

procedure TForm1.DBGrid1DblClick(Sender: TObject);
begin
  If Trim(RxMemoryData1.FieldByName('GRUPO').AsString) <> '' Then
  Begin
    EdtGrupo.Text := RxMemoryData1.FieldByName('GRUPO').AsString ;
    EdtGrupo.SelectAll ;
    EdtGrupo.CopyToClipboard ;
  End ;
end;

procedure TForm1.RxMemoryData3AfterScroll(DataSet: TDataSet);
begin
  StatusBar2.Panels[0].Text := 'Path: ' + RxMemoryData3.FieldByName('PATH'  ).AsString ;
end;

end.
