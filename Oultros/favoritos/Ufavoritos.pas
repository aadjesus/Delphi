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

    Function RemoveAcentos(Str: String): String;
        var i :integer;
        Const ComAcento = '‡ËÏÚ˘‚ÍÓÙ˚„ıÒ·ÈÌÛ˙˝Á‰ÎÔˆ¸ˇ¿»Ã“Ÿ¬ Œ‘€√’—¡…Õ”⁄›«ƒÀœ÷‹Ê∆Â≈ª´óñ†ï-{}';
              SemAcento = 'aeiouaeiouaonaeiouycaeiouyAEIOUAEIOUAONAEIOUYCAEIOUaAaA-------[]';
    Begin
      For i := 1 to Length(Str) do
      Begin
        if Pos(Str[i],ComAcento)<>0 Then
          Str[i] := SemAcento[Pos(Str[i],ComAcento)]
        else
        if Ord('A') >= 123 Then
           Str[i] := '-';
      end;
      Result := Str;
    end;

  begin
    listatemp := TStringList.Create;
    ListarAtahos(diretorioInicial, mascara, listatemp);
    if listtotaldir = true then
    begin
      vDiretorio := StringReplace(diretorioInicial ,DirectoryListBox.Directory + '\','',[]) ;
      vDiretorio := Copy(vDiretorio,1,Length(vDiretorio)-1) ;

      If Trim(vDiretorio) <> '' Then
        WriteLN( vArquivo, '            <TreeViewItem Header="'+ vDiretorio +'" FontWeight="Bold" IsExpanded="{Binding IsChecked, ElementName=toggleButton}">');

      for i := 0 to listatemp.Count - 1 do
      begin
        listatemp.Strings[i] := diretorioInicial + listatemp.Strings[i];

        Try
          vUrl     := TIniFile.Create(listatemp.Strings[i]) ;
          vHtml    := vUrl.ReadString('DEFAULT',   'BASEURL',''  ) ;
          vNomeArq := ExtractFileName(listatemp.Strings[i]) ;
          vNomeArq := StringReplace(vNomeArq,ExtractFileExt(vNomeArq),'',[]) ;

          vNomeArq := StringReplace(vNomeArq,'&','&amp;',[rfReplaceAll]) ;
          vHtml    := StringReplace(vHtml,'&','&amp;',[rfReplaceAll]) ;


          If Trim(vHtml) <> '' Then
            WriteLN( vArquivo, '                <Control Style="{StaticResource FadeIn}" Tag="'+ RemoveAcentos(vNomeArq) +'" DataContext="'+ vHtml +'"/>');

        finally
          vURL.Free ;
        End ; // Try - Except
      end;
      If Trim(vDiretorio) <> '' Then
        WriteLN( vArquivo, '            </TreeViewItem>') ;
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

  LblArqHtml.Caption := DirectoryListBox.Directory + '\Favoritos.xaml' ;
  If FileExists(LblArqHtml.Caption) Then
    DeleteFile(LblArqHtml.Caption) ;

  If FileExists(LblArqHtml.Caption) Then
    DeleteFile(LblArqHtml.Caption) ;

  AssignFile( vArquivo, LblArqHtml.Caption );
  ReWrite(vArquivo) ;

  WriteLN( vArquivo,'<Page xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"');
  WriteLN( vArquivo,'      xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"');
  WriteLN( vArquivo,'      Title="Principal">');
  WriteLN( vArquivo,'    <Page.Resources>');
  WriteLN( vArquivo,'        <Style  x:Key="FadeIn" TargetType="{x:Type Control}">');
  WriteLN( vArquivo,'            <Setter Property="Template">');
  WriteLN( vArquivo,'                <Setter.Value>');
  WriteLN( vArquivo,'                    <ControlTemplate TargetType="{x:Type Control}">');
  WriteLN( vArquivo,'                        <TextBlock>');
  WriteLN( vArquivo,'                            <Hyperlink NavigateUri="{Binding}" TextDecorations="None">');
  WriteLN( vArquivo,'                                <Border BorderThickness="2"');
  WriteLN( vArquivo,'                                        CornerRadius="20,0,10,0">');
  WriteLN( vArquivo,'                                    <TextBlock FontWeight="Bold"');
  WriteLN( vArquivo,'                                               Text="{TemplateBinding Tag}" />');
  WriteLN( vArquivo,'                                </Border>');
  WriteLN( vArquivo,'                            </Hyperlink>');
  WriteLN( vArquivo,'                        </TextBlock>');
  WriteLN( vArquivo,'                    </ControlTemplate>');
  WriteLN( vArquivo,'                </Setter.Value>');
  WriteLN( vArquivo,'            </Setter>');
  WriteLN( vArquivo,'        </Style>');
  WriteLN( vArquivo,'    </Page.Resources>');
  WriteLN( vArquivo,'    <Grid>');
  WriteLN( vArquivo,'        <Grid.RowDefinitions>');
  WriteLN( vArquivo,'            <RowDefinition Height="30"/>');
  WriteLN( vArquivo,'            <RowDefinition/>');
  WriteLN( vArquivo,'        </Grid.RowDefinitions>');
  WriteLN( vArquivo,'        <StackPanel Orientation="Horizontal">');
  WriteLN( vArquivo,'            <ToggleButton x:Name="toggleButton" Margin="11.5,0,0,0" >');
  WriteLN( vArquivo,'                <ToggleButton.Style>');
  WriteLN( vArquivo,'                    <Style TargetType="{x:Type ToggleButton}">');
  WriteLN( vArquivo,'                        <Setter Property="Template">');
  WriteLN( vArquivo,'                            <Setter.Value>');
  WriteLN( vArquivo,'                                <ControlTemplate TargetType="{x:Type ToggleButton}">');
  WriteLN( vArquivo,'                                    <Grid>');
  WriteLN( vArquivo,'                                        <Path RenderTransformOrigin="0.5,0.5"');
  WriteLN( vArquivo,'                                              Width="5"');
  WriteLN( vArquivo,'                                              Height="8"');
  WriteLN( vArquivo,'                                              Stretch="Fill"');
  WriteLN( vArquivo,'                                              Data="M21.166314,123.5 L34.911323,109.82977 21.166667,96.333333 z">');
  WriteLN( vArquivo,'                                            <Path.Style>');
  WriteLN( vArquivo,'                                                <Style TargetType="{x:Type Path}">');
  WriteLN( vArquivo,'                                                    <Style.Triggers>');
  WriteLN( vArquivo,'                                                        <DataTrigger Binding="{Binding IsChecked, ElementName=toggleButton}" Value="false">');
  WriteLN( vArquivo,'                                                            <DataTrigger.Setters>');
  WriteLN( vArquivo,'                                                                <Setter Property="Fill" Value="White"/>');
  WriteLN( vArquivo,'                                                                <Setter Property="Stroke" Value="#FFB7B3B3"/>');
  WriteLN( vArquivo,'                                                                <Setter Property="ToolTip" Value="Expandir todos niveis"/>');
  WriteLN( vArquivo,'                                                                <Setter Property="RenderTransform" >');
  WriteLN( vArquivo,'                                                                    <Setter.Value>');
  WriteLN( vArquivo,'                                                                        <TransformGroup>');
  WriteLN( vArquivo,'                                                                            <RotateTransform Angle="0"/>');
  WriteLN( vArquivo,'                                                                        </TransformGroup>');
  WriteLN( vArquivo,'                                                                    </Setter.Value>');
  WriteLN( vArquivo,'                                                                </Setter>');
  WriteLN( vArquivo,'                                                            </DataTrigger.Setters>');
  WriteLN( vArquivo,'                                                        </DataTrigger>');
  WriteLN( vArquivo,'                                                        <DataTrigger Binding="{Binding IsChecked, ElementName=toggleButton}" Value="True">');
  WriteLN( vArquivo,'                                                            <DataTrigger.Setters>');
  WriteLN( vArquivo,'                                                                <Setter Property="Fill" Value="#FF3D3C3C"/>');
  WriteLN( vArquivo,'                                                                <Setter Property="Stroke" Value="#FF3D3C3C"/>');
  WriteLN( vArquivo,'                                                                <Setter Property="ToolTip" Value="Ocultar todos niveis"/>');
  WriteLN( vArquivo,'                                                                <Setter Property="RenderTransform" >');
  WriteLN( vArquivo,'                                                                    <Setter.Value>');
  WriteLN( vArquivo,'                                                                        <TransformGroup>');
  WriteLN( vArquivo,'                                                                            <RotateTransform Angle="45"/>');
  WriteLN( vArquivo,'                                                                        </TransformGroup>');
  WriteLN( vArquivo,'                                                                    </Setter.Value>');
  WriteLN( vArquivo,'                                                                </Setter>');
  WriteLN( vArquivo,'                                                            </DataTrigger.Setters>');
  WriteLN( vArquivo,'                                                        </DataTrigger>');
  WriteLN( vArquivo,'                                                    </Style.Triggers>');
  WriteLN( vArquivo,'                                                </Style>');
  WriteLN( vArquivo,'                                            </Path.Style>');
  WriteLN( vArquivo,'                                        </Path>');
  WriteLN( vArquivo,'                                    </Grid>');
  WriteLN( vArquivo,'                                </ControlTemplate>');
  WriteLN( vArquivo,'                            </Setter.Value>');
  WriteLN( vArquivo,'                        </Setter>');
  WriteLN( vArquivo,'                    </Style>');
  WriteLN( vArquivo,'                </ToggleButton.Style>');
  WriteLN( vArquivo,'            </ToggleButton>');
  WriteLN( vArquivo,'            <Label Content="Favoritos"/>');
  WriteLN( vArquivo,'        </StackPanel>');
  WriteLN( vArquivo,'        <TreeView Grid.Row="1">');
  ListarArquivos(DirectoryListBox.Directory + '\', '*.url', true, true);

  WriteLN( vArquivo,'        </TreeView>');
  WriteLN( vArquivo,'    </Grid>');
  WriteLN( vArquivo,'</Page>');

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

