unit Unit2;

interface

uses ActiveX, ComObj, Windows, Graphics;

const

{ Komponentenklassen-GUIDs }
  ClassGUID: TGUID = '{47FF61D0-FC96-11D4-9865-0090272E111B}';


type

  TOleTestImp = class(TComObject,
    IPersistStorage,
    IDataObject,
    IOleObject,
    IPersist,
    IPersistFile)
  private
    FOLEClientSite : IOLEClientSite;
    FOLEControlSite : IOLEControlSite;
    FDataAdviseHolder : IDataAdviseHolder;
    FOLEAdviseHolder : IOLEAdviseHolder;
    FCurFile : string;
    function CreateAdviseHolder : HResult;
  protected { Interfaces }
    { Renamed methods }
    function IPersistStorage.InitNew = PersistStorageInitNew;
    function IPersistStorage.Load = PersistStorageLoad;
    function IPersistStorage.Save = PersistStorageSave;
    function IPersistFile.SaveCompleted = PersistFileSaveCompleted;
   { IPersistStorage }
    function PersistStorageInitNew(const stg: IStorage): HResult; stdcall;
    function PersistStorageLoad(const stg: IStorage): HResult; stdcall;
    function PersistStorageSave(const stgSave: IStorage; fSameAsLoad: BOOL): HResult; stdcall;
    function SaveCompleted(const stgNew: IStorage): HResult; stdcall;
    function HandsOffStorage: HResult; stdcall;
    function GetClassID(out classID: TCLSID): HResult; stdcall;
    function IsDirty: HResult; stdcall;
   { IPersistFile }
    function Load(pszFileName: POleStr; dwMode: Longint): HResult;  stdcall;
    function Save(pszFileName: POleStr; fRemember: BOOL): HResult;  stdcall;
    function PersistFileSaveCompleted(pszFileName: POleStr): HResult;  stdcall;
    function GetCurFile(out pszFileName: POleStr): HResult;  stdcall;
   { IDataObject }
    function GetData(const formatetcIn: TFormatEtc; out medium: TStgMedium): HResult; stdcall;
    function GetDataHere(const formatetc: TFormatEtc; out medium: TStgMedium): HResult; stdcall;
    function QueryGetData(const formatetc: TFormatEtc): HResult; stdcall;
    function GetCanonicalFormatEtc(const formatetc: TFormatEtc; out formatetcOut: TFormatEtc): HResult; stdcall;
    function SetData(const formatetc: TFormatEtc; var medium: TStgMedium; fRelease: BOOL): HResult; stdcall;
    function EnumFormatEtc(dwDirection: Longint; out enumFormatEtc: IEnumFormatEtc): HResult; stdcall;
    function DAdvise(const formatetc: TFormatEtc; advf: Longint; const advSink: IAdviseSink; out dwConnection: Longint): HResult; stdcall;
    function DUnadvise(dwConnection: Longint): HResult; stdcall;
    function EnumDAdvise(out enumAdvise: IEnumStatData): HResult; stdcall;
    { IOleObject }
    function SetClientSite(const clientSite: IOleClientSite): HResult; stdcall;
    function GetClientSite(out clientSite: IOleClientSite): HResult; stdcall;
    function SetHostNames(szContainerApp: POleStr;  szContainerObj: POleStr): HResult; stdcall;
    function Close(dwSaveOption: Longint): HResult; stdcall;
    function SetMoniker(dwWhichMoniker: Longint; const mk: IMoniker): HResult;  stdcall;
    function GetMoniker(dwAssign: Longint; dwWhichMoniker: Longint; out mk: IMoniker): HResult; stdcall;
    function InitFromData(const dataObject: IDataObject; fCreation: BOOL; dwReserved: Longint): HResult; stdcall;
    function GetClipboardData(dwReserved: Longint; out dataObject: IDataObject): HResult; stdcall;
    function DoVerb(iVerb: Longint; msg: PMsg; const activeSite: IOleClientSite;
      lindex: Longint; hwndParent: HWND; const posRect: TRect): HResult; stdcall;
    function EnumVerbs(out enumOleVerb: IEnumOleVerb): HResult; stdcall;
    function Update: HResult; stdcall;
    function IsUpToDate: HResult; stdcall;
    function GetUserClassID(out clsid: TCLSID): HResult; stdcall;
    function GetUserType(dwFormOfType: Longint; out pszUserType: POleStr): HResult;  stdcall;
    function SetExtent(dwDrawAspect: Longint; const size: TPoint): HResult;  stdcall;
    function GetExtent(dwDrawAspect: Longint; out size: TPoint): HResult; stdcall;
    function Advise(const advSink: IAdviseSink; out dwConnection: Longint): HResult; stdcall;
    function Unadvise(dwConnection: Longint): HResult; stdcall;
    function EnumAdvise(out enumAdvise: IEnumStatData): HResult; stdcall;
    function GetMiscStatus(dwAspect: Longint; out dwStatus: Longint): HResult; stdcall;
    function SetColorScheme(const logpal: TLogPalette): HResult; stdcall;
  protected { Sonst }
    procedure LoadFromStream(Stream : IStream); dynamic;
    procedure SaveToStream(Stream : IStream); dynamic;
    function GetMetaPict : HGlobal; dynamic;
    function GetEnhMetaPict : HGlobal; dynamic;
    function GetBitMap : HGlobal; dynamic;
    function GetIsDirty : boolean; dynamic;
  public
    procedure Initialize; override;
    destructor Destroy; override;
    procedure CloseN;
  end;

  TOLETestImpFactory = class(TComObjectFactory)
  public
    procedure UpdateRegistry(Register : boolean); override;
  end;

implementation

uses Unit1, ComServ, SysUtils, AxCtrls, Forms, OleCtnrs, Dialogs;

function LongToShortFileName(const LongName: string): string; // from RX Lib
var
  Temp: TWIN32FindData;
  SearchHandle: THandle;
begin
  SearchHandle := FindFirstFile(PChar(LongName), Temp);
  if SearchHandle <> ERROR_INVALID_HANDLE then begin
    Result := string(Temp.cAlternateFileName);
    if Result = '' then Result := string(Temp.cFileName);
  end
  else Result := '';
  Windows.FindClose(SearchHandle);
end;


function LongToShortPath(const LongName: string): string; // from RX Lib
var
  LastSlash: PChar;
  TempPathPtr: PChar;
begin
  Result := '';
  TempPathPtr := PChar(LongName);
  LastSlash := StrRScan(TempPathPtr, '\');
  while LastSlash <> nil do begin
    Result := '\' + LongToShortFileName(TempPathPtr) + Result;
    if LastSlash <> nil then begin
      LastSlash^ := char(0);
      LastSlash := StrRScan(TempPathPtr, '\');
    end;
  end;
  Result := TempPathPtr + Result;
end;


function HandleException: HResult;
var
  E: TObject;
begin
  E := ExceptObject;
  if (E is EOleSysError) and (EOleSysError(E).ErrorCode < 0) then
    Result := EOleSysError(E).ErrorCode else
    Result := E_UNEXPECTED;
end;


function TOleTestImp.PersistStorageInitNew(const stg: IStorage): HResult;
begin
  try
    Result := S_OK;
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.PersistStorageLoad(const stg: IStorage): HResult;
var
  Stream: IStream;
begin
  try
    OleCheck(stg.OpenStream('OLETestStream1'#0, nil, STGM_READ +
      STGM_SHARE_EXCLUSIVE, 0, Stream));
    LoadFromStream(Stream);
    Result := S_OK;
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.PersistStorageSave(const stgSave: IStorage; fSameAsLoad: BOOL): HResult;
var
  Stream: IStream;
begin
  try
    OleCheck(stgSave.CreateStream('OLETestStream1'#0, STGM_WRITE +
      STGM_SHARE_EXCLUSIVE + STGM_CREATE, 0, 0, Stream));
    SaveToStream(Stream);
    Result := S_OK;
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.SaveCompleted(const stgNew: IStorage): HResult;
begin
  Result := S_OK;
end;

function TOleTestImp.HandsOffStorage: HResult;
begin
  Result := S_OK;
end;

function TOleTestImp.GetClassID(out classID: TCLSID): HResult;
begin
  classID := Factory.ClassID;
  Result := S_OK;
end;

function TOleTestImp.IsDirty: HResult;
begin
  if GetIsDirty then Result := S_OK else Result := S_FALSE;
end;

{ IPersistFile }

function TOleTestImp.Load(pszFileName: POleStr; dwMode: Longint): HResult;
begin
  try
    Form1.OleContainer1.DestroyObject;
    Form1.OleContainer1.LoadFromFile(pszFileName);
    Result := S_OK;
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.Save(pszFileName: POleStr; fRemember: BOOL): HResult;
begin
  try
    if fRemember then begin
      FCurFile := pszFileName;
    end;
    Form1.OleContainer1.SaveToFile(pszFileName);
    Result := S_OK;
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.PersistFileSaveCompleted(pszFileName: POleStr): HResult;
begin
  Result := S_OK;
end;

function TOleTestImp.GetCurFile(out pszFileName: POleStr): HResult;
begin
  pszFileName := PWideChar(WideString(FCurFile));
  Result := S_OK;
end;


{ IDataObject }

function GetCFFormat(n : integer) : String;
begin
  case n of
  CF_METAFILEPICT : Result := 'CF_METAFILEPICT';
  CF_BITMAP :       Result := 'CF_BITMAP';
  CF_ENHMETAFILE :  Result := 'CF_ENHMETAFILE';
  else Result := 'Unknown(' + IntToStr(n) + ')';
  end;
end;

function GetTymed(n : integer) : String;
begin
  case n of
  1 : Result := 'TYMED_HGLOBAL';
  2 : Result := 'TYMED_FILE';
  4 : Result := 'TYMED_ISTREAM';
  8 : Result := 'TYMED_ISTORAGE';
  16 : Result := 'TYMED_GDI';
  32 : Result := 'TYMED_MFPICT';
  64 : Result := 'TYMED_ENHMF';
  0 :  Result := 'TYMED_NULL';
  else Result := 'Unknown(' + IntToStr(n) + ')';
  end;
end;

function GetdwAspekt(n : integer) : String;
begin
  case n of
  1 : Result := 'DVASPECT_CONTENT';
  2 : Result := 'DVASPECT_THUMBNAIL';
  4 : Result := 'DVASPECT_ICON';
  8 : Result := 'DVASPECT_DOCPRINT';
  else Result := 'Unknown(' + IntToStr(n) + ')';
  end;
end;

function GetLIndex(n : integer) : String;
begin
  Result := 'Unknown(' + IntToStr(n) + ')';
end;


function TOleTestImp.GetData(const formatetcIn: TFormatEtc; out medium: TStgMedium): HResult;
var iData : IDataObject;
begin
  if (form1.OleContainer1.State <> osEmpty) then begin
    try
     if not (formatetcIn.cfFormat in [CF_METAFILEPICT, CF_ENHMETAFILE]) then begin
       Result := DV_E_TYMED;
       exit;
     end;
      OleCheck(form1.OleContainer1.OleObjectInterface.QueryInterface(IDataObject, IData));
      OLECheck(iData.GetData(formatetcIn, medium));
      Result := S_OK;
    except
      Result := DV_E_TYMED;
//      on E : Exception do
//        ShowMessage('GetDataError : ' + E.Message);
    end;
  end else begin
    Result := S_OK;
    case formatetcIn.cfFormat of
    CF_METAFILEPICT : begin
                        medium.tymed := TYMED_MFPICT;
                        medium.unkForRelease := nil;
                        medium.hMetaFilePict := GetMetaPict;
                      end;
    CF_BITMAP : begin
                  Result := DV_E_TYMED;
                  medium.tymed := TYMED_GDI;
                  medium.unkForRelease := nil;
                  medium.hMetaFilePict := GetBitMap;
                end;
    CF_ENHMETAFILE : begin
                        medium.tymed := TYMED_ENHMF;
                        medium.unkForRelease := nil;
                        medium.hMetaFilePict := GetEnhMetaPict;
                      end;
    else Result := DV_E_TYMED;
    end;
  end;
end;

function TOleTestImp.GetDataHere(const formatetc: TFormatEtc; out medium: TStgMedium): HResult;
var iData : IDataObject;
begin
  if form1.OleContainer1.State <> osEmpty then begin
    try
      OleCheck(form1.OleContainer1.OleObjectInterface.QueryInterface(IDataObject, IData));
      Result := iData.GetDataHere(formatetc, medium);
    except
      Result := HandleException;
    end;
  end else begin
    if (TYMED_ISTORAGE and medium.tymed) = 1 then begin
      medium.tymed := TYMED_ISTORAGE;
      medium.unkForRelease := nil;
      Result := PersistStorageSave(IStorage(medium.stg), False);
    end else Result := DV_E_TYMED;
  end;
end;

function TOleTestImp.QueryGetData(const formatetc: TFormatEtc): HResult;
begin
  if formatetc.cfFormat in [CF_METAFILEPICT] then Result := S_OK
  else Result:=DV_E_TYMED;
end;

function TOleTestImp.GetCanonicalFormatEtc(const formatetc: TFormatEtc; out formatetcOut: TFormatEtc): HResult;
begin
  formatetcOut.ptd := nil;
  Result := DATA_S_SAMEFORMATETC;
end;

function TOleTestImp.SetData(const formatetc: TFormatEtc; var medium: TStgMedium; fRelease: BOOL): HResult;
begin
  Result := E_NOTIMPL;
end;

function TOleTestImp.EnumFormatEtc(dwDirection: Longint; out enumFormatEtc: IEnumFormatEtc): HResult;
begin
  Result := OLE_S_USEREG;
end;

function TOleTestImp.DAdvise(const formatetc: TFormatEtc; advf: Longint; const advSink: IAdviseSink; out dwConnection: Longint): HResult;
begin
  if not Assigned(FDataAdviseHolder) then
    try
      OLECheck(CreateDataAdviseHolder(FDataAdviseHolder));
    except
      Result := E_OUTOFMEMORY;
      exit;
    end;
  try
    OLECheck(FDataAdviseHolder.Advise(Self, formatetc, advf, advSink, dwConnection));
    Result := S_OK;
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.DUnadvise(dwConnection: Longint): HResult;
begin
  if not Assigned(FDataAdviseHolder) then Result := E_FAIL
  else try
         OLECheck(FDataAdviseHolder.Unadvise(dwConnection));
         Result := S_OK;
       except
         Result := HandleException;
       end;
end;

function TOleTestImp.EnumDAdvise(out enumAdvise: IEnumStatData): HResult;
begin
  if not Assigned(FDataAdviseHolder) then Result := E_FAIL
  else try
         OLECheck(FDataAdviseHolder.EnumAdvise(enumAdvise));
         Result := S_OK;
       except
         Result := HandleException;
       end;
end;

{ IOleObject }

function TOleTestImp.SetClientSite(const clientSite: IOleClientSite): HResult;
begin
  if ClientSite <> nil then
  begin
    if FOleClientSite <> nil then
    begin
      Result := E_FAIL;
      Exit;
    end;
    FOleClientSite := ClientSite;
    ClientSite.QueryInterface(IOleControlSite, FOleControlSite);
  end else
  begin
    FOleControlSite := nil;
    FOleClientSite := nil;
  end;
  Result := S_OK;
end;

function TOleTestImp.GetClientSite(out clientSite: IOleClientSite): HResult;
begin
  ClientSite := FOleClientSite;
  Result := S_OK;
end;

function TOleTestImp.SetHostNames(szContainerApp: POleStr;  szContainerObj: POleStr): HResult;
begin
  Form1.Caption := ' Gestartet von : ' + String(szContainerApp) + ' (' + String(szContainerObj) + '). ' + STDCAption;
  Result := S_OK;
end;

function TOleTestImp.Close(dwSaveOption: Longint): HResult;
begin
  if (dwSaveOption <> OLECLOSE_NOSAVE) and GetIsDirty and (FOleClientSite <> nil) then begin
    FOleClientSite.SaveObject;
  end;
  Form1.Visible := False;
  Result := S_OK;
//  Result := InPlaceDeactivate;
end;

function TOleTestImp.SetMoniker(dwWhichMoniker: Longint; const mk: IMoniker): HResult;
begin
  Result := E_NOTIMPL;
end;

function TOleTestImp.GetMoniker(dwAssign: Longint; dwWhichMoniker: Longint; out mk: IMoniker): HResult;
begin
  Result := E_NOTIMPL;
end;

function TOleTestImp.InitFromData(const dataObject: IDataObject; fCreation: BOOL; dwReserved: Longint): HResult;
begin
  Result := E_NOTIMPL;
end;

function TOleTestImp.GetClipboardData(dwReserved: Longint; out dataObject: IDataObject): HResult;
begin
  Result := E_NOTIMPL;
end;

function TOleTestImp.DoVerb(iVerb: Longint; msg: PMsg; const activeSite: IOleClientSite;
  lindex: Longint; hwndParent: HWND; const posRect: TRect): HResult;
begin
  try
    Result := S_OK;
    case iVerb of
      OLEIVERB_SHOW,
      OLEIVERB_UIACTIVATE,
      OLEIVERB_INPLACEACTIVATE,
      OLEIVERB_PROPERTIES,
      OLEIVERB_PRIMARY,
      OLEIVERB_OPEN : begin
        if not Assigned(Form1) then Application.CreateForm(TForm1, Form1);
        FOLEClientSite.OnShowWindow(True);
        Form1.Show;
        SetForegroundWindow(Form1.Handle);
        FOLEClientSite.ShowObject;
      end;
      OLEIVERB_HIDE: if Assigned(Form1) then begin
        FOLEClientSite.OnShowWindow(False);
        Form1.Hide;
      end;
    else
      Result := OLEOBJ_S_INVALIDVERB;
    end;
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.EnumVerbs(out enumOleVerb: IEnumOleVerb): HResult;
begin
  Result := OLE_S_USEREG;
end;

function TOleTestImp.Update: HResult;
begin
  Result := NOERROR;
end;

function TOleTestImp.IsUpToDate: HResult;
begin
  Result := NOERROR;
end;

function TOleTestImp.GetUserClassID(out clsid: TCLSID): HResult;
begin
  clsid := Factory.ClassID;
  Result := S_OK;
end;

function TOleTestImp.GetUserType(dwFormOfType: Longint; out pszUserType: POleStr): HResult;
begin
  Result := OLE_S_USEREG;
end;

function TOleTestImp.SetExtent(dwDrawAspect: Longint; const size: TPoint): HResult;
var
  W, H: Integer;
begin
  try
    if dwDrawAspect <> DVASPECT_CONTENT then OleError(DV_E_DVASPECT);
    W := MulDiv(Size.X, Screen.PixelsPerInch, 2540);
    H := MulDiv(Size.Y, Screen.PixelsPerInch, 2540);
    with Form1 do SetBounds(Left, Top, W, H);
    Result := S_OK;
  except
    Result := HandleException;
  end;
end;

function TOleTestImp.GetExtent(dwDrawAspect: Longint; out size: TPoint): HResult;
begin
  if dwDrawAspect <> DVASPECT_CONTENT then
  begin
    Result := DV_E_DVASPECT;
    Exit;
  end;
  Size.X := MulDiv(Form1.Width, 2540, Screen.PixelsPerInch);
  Size.Y := MulDiv(Form1.Height, 2540, Screen.PixelsPerInch);
  Result := S_OK;
end;

function TOleTestImp.Advise(const advSink: IAdviseSink; out dwConnection: Longint): HResult;
begin
  Result := CreateAdviseHolder;
  if Result = S_OK then
    Result := FOleAdviseHolder.Advise(advSink, dwConnection);
end;

function TOleTestImp.Unadvise(dwConnection: Longint): HResult;
begin
  Result := CreateAdviseHolder;
  if Result = S_OK then
    Result := FOleAdviseHolder.Unadvise(dwConnection);
end;

function TOleTestImp.EnumAdvise(out enumAdvise: IEnumStatData): HResult;
begin
  Result := CreateAdviseHolder;
  if Result = S_OK then
    Result := FOleAdviseHolder.EnumAdvise(enumAdvise);
end;

function TOleTestImp.GetMiscStatus(dwAspect: Longint; out dwStatus: Longint): HResult;
begin
  Result := OLE_S_USEREG;
end;

function TOleTestImp.SetColorScheme(const logpal: TLogPalette): HResult;
begin
  Result := E_NOTIMPL;
end;


{ Sonst }


procedure TOleTestImp.LoadFromStream(Stream : IStream);
var
  OleStream: TOleStream;
begin
  OleStream := TOleStream.Create(Stream);
  try
    Form1.OleContainer1.LoadFromStream(OleStream);
  finally
    OleStream.Free;
  end;
end;

procedure TOleTestImp.SaveToStream(Stream : IStream);
var
  OleStream: TOleStream;
begin
  OleStream := TOleStream.Create(Stream);
  try
    Form1.OleContainer1.SaveToStream(OleStream);
  finally
    OleStream.Free;
  end;
end;

function TOleTestImp.GetMetaPict : HGlobal;
var P : TMetaFile;
begin
  Result := 0;
  exit;
  P := TMetafile.Create;
  try
    P.Width := Form1.Width;
    P.Height := Form1.Height;
    with TMetafileCanvas.Create(P, 0) do
    try
      Draw(0,0,Form1.GetFormImage);
      Brush.Color := clRed;
      Ellipse(0,0,100,100);
    finally
      Free;
    end;
//    Result := CopyMetaFile(P.Handle, nil);
    Result := P.HAndle;
  finally
    P.Free;
  end;
end;

function TOleTestImp.GetEnhMetaPict : HGlobal;
var P : TMetaFile;
begin
  P := TMetafile.Create;
  try
    P.Width := Form1.Width;
    P.Height := Form1.Height;
    with TMetafileCanvas.Create(P, 0) do
    try
      Draw(0,0,Form1.GetFormImage);
    finally
      Free;
    end;
    Result := CopyEnhMetaFile(P.Handle, nil);
  finally
    P.Free;
  end;
end;

function TOleTestImp.GetBitMap : HGlobal;
begin
  Result := 0;
  exit;
  Result := Form1.GetFormImage.Handle;
end;

procedure TOleTestImp.Initialize;
begin
  inherited;
  Form1.OleObj := Self;
  FCurFile := 'unbenant.ole';
end;

destructor TOleTestImp.Destroy;
begin
  inherited;
end;

function TOleTestImp.CreateAdviseHolder;
begin
  Result := S_OK;
  if not Assigned(FOLEAdviseHolder) then
    try
      OleCheck(CreateOleAdviseHolder(FOleAdviseHolder));
    except
      Result := HandleException;
    end;
end;

function TOleTestImp.GetIsDirty : boolean;
begin
  Result := True;
end;

procedure TOleTestImp.CloseN;
begin
  FOLEClientSite.SaveObject;
  FOLEAdviseHolder.SendOnSave;
  FOLEClientSite.OnShowWindow(False);
  FOLEClientSite.ShowObject;
  FDataAdviseHolder.SendOnDataChange(Self, 0, ADVFCACHE_ONSAVE);
  FOLEAdviseHolder.SendOnClose;
end;

{ TOLETestImpFactory }

procedure TOLETestImpFactory.UpdateRegistry(Register : boolean);
var ClassKey: string;
    myPath : string;
begin
  ClassKey := 'CLSID\' + GUIDToString(ClassID);
  if Register then begin
    inherited;
    myPath := LongToShortPath(Application.ExeName);
    CreateRegKey(ClassKey + '\InprocHandler32', '', 'OLE32.DLL');
    CreateRegKey(ClassKey + '\Insertable', '', '');
    CreateRegKey(ClassKey + '\Verb', '', '');
    CreateRegKey(ClassKey + '\Verb\0', '', '&Show,0,2');
    CreateRegKey(ClassKey + '\MiscStatus', '', '0');
    CreateRegKey(ProgID + '\Insertable','', '');
    CreateRegKey(ProgID + '\Shell','', '');
    CreateRegKey(ProgID + '\Shell\Open','', '');
    CreateRegKey(ProgID + '\Shell\Open\Command','', myPath  + ' %1');
    CreateRegKey('.ole','',ProgID);
    CreateRegKey('.ole','Content Type', 'OLE/Object');
  end else begin
    DeleteRegKey(ClassKey + '\InprocHandler32');
    DeleteRegKey(ClassKey + '\Insertable');
    DeleteRegKey(ClassKey + '\Verb\0');
    DeleteRegKey(ClassKey + '\Verb');
    DeleteRegKey(ClassKey + '\MiscStatus');
    DeleteRegKey(ProgID + '\Insertable');
    DeleteRegKey('.ole');
    inherited;
  end;
end;


initialization
 TOLETestImpFactory.Create(ComServer,TOLETestImp,ClassGUID,'OLEViewer','Delphi *.ole File Viewer',ciSingleInstance);

end.

