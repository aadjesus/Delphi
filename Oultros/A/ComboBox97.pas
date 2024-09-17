{
********************************************************************************
Módulo:        ComboBox97
Versión:       1.10
Descripción:   ComboBox con propiedad Flat (plano) al estilo Office97 derivado 
               de TCustomComboBox. Con código fuente pequeño y altamente 
               eficiente. FREEWARE
Autor:         Favio E. Ugalde Corral
Creación:       4 de septiembre de 1998
Modificación:  15 de septiembre de 1998
E-Mail:        fugalde@geocities.com
URL:           "Delphi en Español" http://www.geocities.com/~fugalde
Observaciones: Ideal para utilizarse en Barras de Herramientas tales como
               Toolbar97 de Jordan Russell http://www.connect.net/jordanr/
               o cualquier otra.
********************************************************************************
}

unit ComboBox97;

interface

uses Windows, Messages, Classes, Forms, Controls, Graphics, StdCtrls;

type
  TComboState97 = set of (csButtonPressed, csMouseCaptured);

  TCustomComboBox97 = class(TCustomComboBox)
  private
    FFlat: Boolean;
    FOldColor: TColor;
    FOldParentColor: Boolean;
    FButtonWidth: Integer;
    FEditState: TComboState97;
    FMouseInControl: Boolean;  // Indica si el ratón está sobre el ComboBox
    procedure SetFlat(const Value: Boolean);
    procedure DrawButtonBorder(DC: HDC); // Dibuja el borde del botón incluido
    procedure DrawControlBorder(DC: HDC); // Dibuja el borde del ComboBox
    procedure DrawBorders; // Dibuja los bordes del ComboBox y del botón incluido
    function  NeedDraw3DBorder: Boolean;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
  protected
    procedure TrackButtonPressed(X, Y: Integer); // Verifica si el botón todavía deba estar presionado
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;

    property Flat: Boolean read FFlat write SetFlat default False;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TComboBox97 = class(TCustomComboBox97)
  published
    property Style; // Debe ser siempre la primera
    property Flat;
    {$IFDEF VER120}
    property Anchors;
    property BiDiMode;
    property Constraints;
    {$ENDIF}
    property Color;
    property Ctl3D;
    property DragCursor;
    {$IFDEF VER120}
    property DragKind;
    {$ENDIF}
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    {$IFNDEF VER90}
    property ImeMode;
    property ImeName;
    {$ENDIF}
    property ItemHeight;
    property Items;
    property MaxLength;
    {$IFDEF VER120}
    property ParentBiDiMode;
    {$ENDIF}
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnStartDrag;
    {$IFDEF VER120}
    property OnEndDock;
    property OnStartDock;
    {$ENDIF}
  end;

procedure Register;

implementation

{ TCustomComboBox97 }

constructor TCustomComboBox97.Create(AOwner: TComponent);
begin
   inherited;

   FButtonWidth := GetSystemMetrics(SM_CXVSCROLL) + 2;
   // Valores por omisión
   FOldColor       := inherited Color;
   FOldParentColor := inherited ParentColor;
end;

procedure TCustomComboBox97.SetFlat(const Value: Boolean);
begin
  if Value <> FFlat then
    begin
    FFlat := Value;
    Ctl3D := not Value;
    Invalidate;
    end;
end;

// Verifica si el botón todavía deba estar presionado
procedure TCustomComboBox97.CMEnter(var Message: TCMEnter);
begin
  inherited;

  if not (csDesigning in ComponentState) then
    DrawBorders;
end;

procedure TCustomComboBox97.CMExit(var Message: TCMExit);
begin
  inherited;

  if not (csDesigning in ComponentState) then
    DrawBorders;
end;

procedure TCustomComboBox97.CMMouseEnter(var Message: TMessage);
begin
  inherited;

  // Si por primera vez el ratón está sobre el ComboBox se redibuja su borde
  if not FMouseInControl and Enabled then
    begin
    FMouseInControl := True;
    DrawBorders;
    end;
end;

procedure TCustomComboBox97.CMMouseLeave(var Message: TMessage);
begin
  inherited;

  // Si el ratón estaba sobre el ComboBox se redibuja su borde
  if FMouseInControl and Enabled then
    begin
    FMouseInControl := False;
    DrawBorders
    end;
end;

procedure TCustomComboBox97.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;

  // Si se desea plano
  if FFlat then
    // Si se habilita se recupera su color anterior ó
    // si se inhabilita se guarda su color actual y se utiliza el del contenedor,
    // así se dá la apariencia del ComboBox inhabilitado de Office97. 
    if Enabled then
      begin
      inherited Color       := FOldColor;
      inherited ParentColor := FOldParentColor;
      end
    else
      begin
      FOldParentColor := inherited Parentcolor;
      FOldColor       := inherited Color;
      inherited ParentColor := True;
      end;
end;

procedure TCustomComboBox97.WMPaint(var Message: TWMPaint);
var
   DC: HDC;
   PS: TPaintStruct;
procedure DrawButton;
var
  ARect: TRect;
begin
  // Obtiene las coordenadas de los límites del botón
  GetWindowRect(Handle, ARect);
  OffsetRect(ARect, -ARect.Left, -ARect.Top);
  Inc(ARect.Left, ClientWidth - FButtonWidth);
  InflateRect(ARect, -1, -1);
  // Dibuja el botón
  DrawFrameControl(DC, ARect, DFC_SCROLL, DFCS_SCROLLCOMBOBOX or DFCS_FLAT);
  // Notifica a Windows que ya no tiene que dibujar el botón
  ExcludeClipRect(DC, ClientWidth - FButtonWidth - 4, 0, ClientWidth, ClientHeight);
end;
begin
  // Si no es plano sólo se hacer lo de omisión
  if not FFlat then
    begin
    inherited;
    Exit;
    end;

  // Utiliza o crea el dispositivo de contexto
  if Message.DC = 0 then
    DC := BeginPaint(Handle, PS)
  else
    DC := Message.DC;
  try
    // Si el estilo así lo requiere dibuja el botón y una base
    if Style <> csSimple then
      begin
      FillRect(DC, ClientRect, Brush.Handle);
      DrawButton;//(DC);
      end;
    // Dibuja el ComboBox
    PaintWindow(DC);
  finally
    // Elimina el dispositivo de contexto si fué creado aquí
    if Message.DC = 0 then
      EndPaint(Handle, PS);
  end;
  // Dibuja los bordes del ComboBox y del botón incluido
  DrawBorders;
end;

function TCustomComboBox97.NeedDraw3DBorder: Boolean;
begin
  // Se requiere dibujar el borde cuando el ratón esta encima
  // o cuando es el control activo.
  if csDesigning in ComponentState then
    Result := Enabled
  else
    Result := FMouseInControl or (Screen.ActiveControl = Self);
end;

// Dibuja el borde del botón incluido
procedure TCustomComboBox97.DrawButtonBorder(DC: HDC);
const
   Flags: array[Boolean] of Integer = (0, BF_FLAT);
var
   ARect: TRect;
   BtnFaceBrush: HBRUSH;
begin
  // Notifica a Windows que no tiene que dibujar sobre botón
  ExcludeClipRect(DC, ClientWidth - FButtonWidth + 4, 4,
                  ClientWidth - 4, ClientHeight - 4);
  // Obtiene las coordenadas de los límites del botón
  GetWindowRect(Handle, ARect);
  OffsetRect(ARect, -ARect.Left, -ARect.Top);
  Inc(ARect.Left, ClientWidth - FButtonWidth - 2);
  InflateRect(ARect, -2, -2);

  // Dibuja un borde 3D o plano según se requiera
  if NeedDraw3DBorder then
    DrawEdge(DC, ARect, EDGE_RAISED, BF_RECT or Flags[csButtonPressed in FEditState])
  else
    begin
    BtnFaceBrush := CreateSolidBrush(GetSysColor(COLOR_BTNFACE));
    try
      InflateRect(ARect, -1, -1);
      FillRect(DC, ARect, BtnFaceBrush);
    finally
      DeleteObject(BtnFaceBrush);
    end;
    end;

  // Notifica a Windows que ya no tiene que dibujar el botón
  ExcludeClipRect(DC, ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
end;

// Dibuja el borde del ComboBox
procedure TCustomComboBox97.DrawControlBorder(DC: HDC);
var
  ARect: TRect;
  BtnFaceBrush, WindowBrush: HBRUSH; // Brochas necesarias para el efecto 3D
begin
  // Crea las brochas necesarias para el efecto 3D
  BtnFaceBrush := CreateSolidBrush(GetSysColor(COLOR_BTNFACE));
  WindowBrush := CreateSolidBrush(GetSysColor(COLOR_WINDOW));
  try
    // Obtiene las coordenadas de los límites del ComboBox
    GetWindowRect(Handle, ARect);
    OffsetRect(ARect, -ARect.Left, -ARect.Top);
    // Dibuja un borde 3D o plano según se requiera
    if NeedDraw3DBorder then
      begin
      DrawEdge(DC, ARect, BDR_SUNKENOUTER, BF_RECT or BF_ADJUST);
      FrameRect(DC, ARect, BtnFaceBrush);
      InflateRect(ARect, -1, -1);
      FrameRect(DC, ARect, WindowBrush);
      end
    else
      begin
      FrameRect(DC, ARect, BtnFaceBrush);
      InflateRect(ARect, -1, -1);
      FrameRect(DC, ARect, BtnFaceBrush);
      InflateRect(ARect, -1, -1);
      FrameRect(DC, ARect, WindowBrush);
      end;
  finally
    // Elimina las brochas
    DeleteObject(WindowBrush);
    DeleteObject(BtnFaceBrush);
  end;
end;

// Dibuja los bordes del ComboBox y del botón incluido
procedure TCustomComboBox97.DrawBorders;
var
  DC: HDC;
begin
  // Sólo se continua si es plano
  if not FFlat then
    Exit;

  // Dibuja el borde de la caja y si se requiere del botón incluido
  DC := GetWindowDC(Handle);
  try
    DrawControlBorder(DC);
    if Style <> csSimple then
      DrawButtonBorder(DC);
  finally
    ReleaseDC(DC, Handle);
  end;
end;

procedure TCustomComboBox97.TrackButtonPressed(X, Y: Integer);
var
   ARect: TRect;
begin
  // Dibuja correctamente el borde cuando se acaba de presionar el botón y
  // las coordenadas X,Y están fuera del botón del ComboBox.
  SetRect(ARect, ClientWidth - FButtonWidth, 0, ClientWidth, ClientHeight);
  if (csButtonPressed in FEditState) and not PtInRect(ARect, Point(X, Y)) then
    begin
    Exclude(FEditState, csButtonPressed); // Ya no se está presionando el botón
    DrawBorders;
    end;
end;

procedure TCustomComboBox97.MouseDown(Button: TMouseButton; Shift: TShiftState;
          X, Y: Integer);
begin
  // Si el click del ratón produjo que se abriera la lista desplegable, entonces
  // se presionó el botón y se capturó el ratón.
  if DroppedDown then
    begin
    Include(FEditState, csButtonPressed);
    Include(FEditState, csMouseCaptured);
    Invalidate; // Muestra el botón presionado (sumido)
    end;

  inherited;
end;

procedure TCustomComboBox97.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  // Dibuja correctamente el borde cuando se mueve el ratón a la lista desplegable
  if csMouseCaptured in FEditState then
    TrackButtonPressed(X, Y);

  inherited;
end;

procedure TCustomComboBox97.MouseUp(Button: TMouseButton; Shift: TShiftState;
          X, Y: Integer);
begin
  // Dibuja correctamente el borde cuando se suelta el botón fuera del botón del ComboBox
  TrackButtonPressed(-1, -1);

  inherited;
end;


procedure Register;
begin
  RegisterComponents('Additional', [TComboBox97]);
end;

end.

