unit ftp1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OleCtrls, ISP, Menus, StdCtrls, ExtCtrls, ComCtrls, FileCtrl;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    RemoteDir: TListBox;
    CopyToServer: TButton;
    CopyToLocal: TButton;
    LocalDir: TEdit;
    MkDir: TButton;
    RmDir: TButton;
    RemoteFiles: TListBox;
    MainMenu1: TMainMenu;
    Delete: TButton;
    Refresh: TButton;
    Server1: TMenuItem;
    Connect1: TMenuItem;
    Disconnect1: TMenuItem;
    FTP1: TFTP;
    StatusBar: TStatusBar;
    FileType1: TMenuItem;
    ASCII1: TMenuItem;
    EBCIDIC1: TMenuItem;
    Image1: TMenuItem;
    Binary1: TMenuItem;
    FileListBox1: TFileListBox;
    DirectoryListBox1: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    NameListButton: TButton;
    ListButton: TButton;
    FileDetailsButton: TButton;
    procedure Connect1Click(Sender: TObject);
    procedure FTP1ProtocolStateChanged(Sender: TObject;
      ProtocolState: Smallint);
    procedure FTP1StateChanged(Sender: TObject; State: Smallint);
    procedure FTP1ListItem(Sender: TObject; const Item: Variant);
    procedure Disconnect1Click(Sender: TObject);
    procedure MkDirClick(Sender: TObject);
    procedure RemoteDirDblClick(Sender: TObject);
    procedure FTP1Error(Sender: TObject; Number: Smallint;
      var Description: string; Scode: Integer; const Source,
      HelpFile: string; HelpContext: Integer; var CancelDisplay: Wordbool);
    procedure RefreshClick(Sender: TObject);
    procedure NameListButtonClick(Sender: TObject);
    procedure FTP1DocOutput(Sender: TObject; const DocOutput: Variant);
    procedure ListButtonClick(Sender: TObject);
    procedure FTP1CreateDir(Sender: TObject);
    procedure RmDirClick(Sender: TObject);
    procedure FileDetailsButtonClick(Sender: TObject);
    procedure CopyToServerClick(Sender: TObject);
    procedure CopyToLocalClick(Sender: TObject);
    procedure FTP1DocInput(Sender: TObject; const DocInput: Variant);
    procedure FTP1Busy(Sender: TObject; isBusy: Wordbool);
    procedure DeleteClick(Sender: TObject);
    procedure FTP1DelFile(Sender: TObject);
    procedure ASCII1Click(Sender: TObject);
    procedure EBCIDIC1Click(Sender: TObject);
    procedure Binary1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    ChangedDir: Boolean;
    ReadData: Variant;
    NameList, List, FileDetail, CopyingFiles, GettingFiles: Boolean;
    DirStringList: TStringList;
  end;

var
  Form1: TForm1;

implementation
uses UsrInfo, log, ole2;

{$R *.DFM}

procedure TForm1.Connect1Click(Sender: TObject);
var
  ConnectForm: TConnectForm;
begin
  if FTP1.State = prcConnected then
  begin
    FTP1.Quit;
    Application.ProcessMessages;
  end;
  ConnectForm := TConnectForm.Create(Self);
  try
    if ConnectForm.ShowModal = mrOk then
      begin
        FTP1.UserID := ConnectForm.UserNameEdit.Text;
        FTP1.Password := ConnectForm.PasswordEdit.Text;
        FTP1.RemoteHost := ConnectForm.RemoteHostEdit.Text;
        FTP1.RemotePort := StrToInt(ConnectForm.RemotePortEdit.Text);
        FTP1.Connect(FTP1.RemoteHost, FTP1.RemotePort);
      end;
  finally
    ConnectForm.Free;
  end;
end;

procedure TForm1.FTP1ProtocolStateChanged(Sender: TObject;
  ProtocolState: Smallint);
begin
  case ProtocolState of
    ftpAuthentication: FTP1.Authenticate(FTP1.UserID, FTP1.Password);
    ftpTransaction:
      begin
        RemoteDir.Items.Clear;
        RemoteDir.Items.Add('..');
        FTP1.List('/');
      end;
  end;
end;

procedure TForm1.FTP1StateChanged(Sender: TObject; State: Smallint);
begin
  case FTP1.State of
    prcConnecting   : Statusbar.Panels[0].Text := 'Connecting';
    prcResolvingHost: Statusbar.Panels[0].Text := 'Connecting';
    prcHostResolved : Statusbar.Panels[0].Text := 'Host resolved';
    prcConnected    : Statusbar.Panels[0].Text := 'Connected to: ' + FTP1.RemoteHost;
    prcDisconnecting: Statusbar.Panels[0].Text := 'Disconnecting';
    prcDisconnected : Statusbar.Panels[0].Text := 'Disconnected';
  end;
end;

procedure TForm1.FTP1ListItem(Sender: TObject; const Item: Variant);
begin
 {This is where you can get all the information regarding the File Item}
  if Item.Attributes = 1 then
    RemoteDir.Items.Add(Item.FileName);
  if Item.Attributes = 2 then
  begin
    RemoteFiles.Items.Add(Item.FileName);
  end;
  if Item.Attributes = 3 then
  begin
    RemoteFiles.Items.Add('Other: ' + Item.FileName);
  end;
end;

procedure TForm1.Disconnect1Click(Sender: TObject);
begin
if ftp1.state <> prcDisconnected then
  begin
    FTP1.Quit;
    Application.ProcessMessages;
  end;
end;

procedure TForm1.MkDirClick(Sender: TObject);
var
  DirName: String;
begin
  if InputQuery('Input Box', 'New Directory Name', DirName) then
    FTP1.CreateDir('/' + DirName);
end;

procedure TForm1.RemoteDirDblClick(Sender: TObject);
var
  GotoDir: String;
begin
  GotoDir:= RemoteDir.Items[RemoteDir.ItemIndex];
  RemoteDir.Items.Clear;
  RemoteDir.Items.Add('..');
  RemoteFiles.Items.Clear;
  If GotoDir = '..' then
  begin
    ChangedDir:= False;
    ftp1.changeDir('..');
    repeat
      application.ProcessMessages;
    until ChangedDir;
    Application.ProcessMessages;
    FTP1.List('.');
  end
  else
  begin
    ChangedDir:= False;
    FTP1.ChangeDir(GotoDir + '/');
    repeat
      Application.ProcessMessages;
    until ChangedDir;
    Application.ProcessMessages;
    FTP1.List('.');
  end;
end;

procedure TForm1.FTP1Error(Sender: TObject; Number: Smallint;
  var Description: string; Scode: Integer; const Source, HelpFile: string;
  HelpContext: Integer; var CancelDisplay: Wordbool);
begin
  showmessage(Description);
end;

procedure TForm1.RefreshClick(Sender: TObject);
begin
  RemoteDir.Items.Clear;
  RemoteDir.Items.Add('..');
  RemoteFiles.Items.Clear;
  FTP1.List('.');
end;

procedure TForm1.NameListButtonClick(Sender: TObject);
begin
  NameList:= True;
  FTP1.NameList('.');
end;

procedure TForm1.FTP1DocOutput(Sender: TObject; const DocOutput: Variant);
var
  s: Variant;
begin
  Case DocOutput.State of
    icDocBegin:
      begin
        logsheet.Memo1.Lines.Clear;
        ReadData := '';
      end;
    icDocData:
      begin
        DocOutput.GetData(S, VT_BSTR);
        ReadData:= ReadData + S;
      end;
    icDocEnd:
      begin
        if List then
        begin
          logSheet.Caption:= 'List';
          logSheet.Memo1.Lines.Add(ReadData);
          logSheet.Show;
          List:= False;
        end;
        if NameList then
        begin
          logSheet.Caption:= 'Name List';
          logSheet.Memo1.Lines.Add(ReadData);
          logSheet.Show;
          NameList:= False;
        end;
        if FileDetail then
        begin
          logSheet.Caption:= 'File Detail';
          logSheet.Memo1.Lines.Add(ReadData);
          logSheet.Show;
          NameList:= False;
        end;
        if GettingFiles then
        begin
          FileListBox1.Update;
          GettingFiles:= False;
        end;
        Statusbar.Panels[1].Text := FTP1.ReplyString;
      end;
  end;
end;

procedure TForm1.ListButtonClick(Sender: TObject);
begin
  List:= True;
  FTP1.List('.');
end;

procedure TForm1.FTP1CreateDir(Sender: TObject);
begin
  RemoteDir.Items.Clear;
  RemoteDir.Items.Add('..');
  RemoteFiles.Items.Clear;
  FTP1.List('.');
end;

procedure TForm1.RmDirClick(Sender: TObject);
var
  x: integer;
begin
  for x:= 0 to RemoteDir.Items.Count - 1 do
  begin
    if RemoteDir.Selected[x] then
      FTP1.DeleteDir(RemoteDir.Items[x]);
  end;
end;

procedure TForm1.FileDetailsButtonClick(Sender: TObject);
begin
  FileDetail:= True;
  FTP1.List('./' + RemoteFiles.Items[RemoteFiles.ItemIndex]);
end;

procedure TForm1.CopyToServerClick(Sender: TObject);
var
  x: integer;
begin
  CopyingFiles:= True;
  FTP1.PutFile(FileListBox1.Items[FileListBox1.ItemIndex],
               FileListBox1.Items[FileListBox1.ItemIndex]);
end;

procedure TForm1.CopyToLocalClick(Sender: TObject);
var
  x: integer;
begin
  GettingFiles:= True;
  FTP1.GetFile(RemoteFiles.Items[RemoteFiles.ItemIndex], RemoteFiles.Items[RemoteFiles.ItemIndex]);
end;

procedure TForm1.FTP1DocInput(Sender: TObject; const DocInput: Variant);
begin
  Case DocInput.State of
  icDocEnd:
    begin
      if CopyingFiles then
        CopyingFiles:= False;
    end;
  end;
end;

procedure TForm1.FTP1Busy(Sender: TObject; isBusy: Wordbool);
begin
  if isBusy then
    Screen.Cursor := crHourGlass
  else
    Screen.Cursor := crDefault;
end;

procedure TForm1.DeleteClick(Sender: TObject);
begin
    FTP1.DeleteFile('./' + RemoteFiles.Items[RemoteFiles.ItemIndex]);
end;


procedure TForm1.FTP1DelFile(Sender: TObject);
begin
  RefreshClick(nil);
end;

procedure TForm1.ASCII1Click(Sender: TObject);
begin
  If Ascii1.Checked then
    Ascii1.Checked:= False
  else
  begin
    Ebcidic1.Checked:= False;
    Binary1.Checked:= False;
    Image1.Checked:= False;
    Ascii1.Checked:= True;
    FTP1.Type_(ftpASCII);
  end;
end;

procedure TForm1.EBCIDIC1Click(Sender: TObject);
begin
  If Ebcidic1.Checked then
    Ebcidic1.Checked:= False
  else
  begin
    Ascii1.Checked:= False;
    Binary1.Checked:= False;
    Image1.Checked:= False;
    Ebcidic1.Checked:= True;
    FTP1.Type_(ftpEBCDIC);
  end;
end;

procedure TForm1.Binary1Click(Sender: TObject);
begin
  If Binary1.Checked then
    Binary1.Checked:= False
  else
  begin
    Ascii1.Checked:= False;
    Ebcidic1.Checked:= False;
    Image1.Checked:= False;
    Binary1.Checked:= True;
    FTP1.Type_(ftpBinary);
  end;
end;

procedure TForm1.Image1Click(Sender: TObject);
begin
  If Image1.Checked then
    Image1.Checked:= False
  else
  begin
    Ascii1.Checked:= False;
    Ebcidic1.Checked:= False;
    Binary1.Checked:= False;
    Image1.Checked:= True;
    FTP1.Type_(ftpImage);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DirStringList:= TStringList.Create;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if ftp1.state <> prcDisconnected then
  begin
    FTP1.Quit;
    Application.ProcessMessages;
  end;
end;

end.
