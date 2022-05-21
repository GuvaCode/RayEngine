unit reGui;

{$mode objfpc}{$H+}

interface

uses
  raylib, raygui, classes;

type
  { TreGuiContainer }
  TreGuiContainer = class
  private
    FGlobalBounds: TRectangle;
    FVisible: boolean;
    procedure SetGlobalBounds(AValue: TRectangle);
    procedure SetVisible(AValue: boolean);
  protected
    FGuiList: TList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Render; virtual;
    procedure Update; virtual;
    property GlobalBounds:TRectangle read FGlobalBounds write SetGlobalBounds;
    property Visible: boolean read FVisible write SetVisible;
  end;

  { TreGuiObject }
  TreGuiObject = class(TObject)
  private
    FOffSetBounds:TRectangle;
    FBounds: TRectangle;
    FUseGlobalBounds: boolean;
    FVisible: boolean;
    procedure SetBounds(AValue: TRectangle);
    procedure SetUseGlobalBounds(AValue: boolean);
    procedure SetVisible(AValue: boolean);
  protected
    FGuiContainer: TreGuiContainer;
  public
    constructor Create(GuiContainer: TreGuiContainer); virtual;
    destructor Destroy; override;
    procedure Render; virtual;
    procedure Update; virtual;
    function GetOffSetBounds(Bounds:TRectangle): TRectangle;
    property Bounds: TRectangle read FBounds write SetBounds;
    property Visible: boolean read FVisible write SetVisible;
    property UseGlobalBounds: boolean read FUseGlobalBounds write SetUseGlobalBounds;
  end;

  { TreGuiForm }
  TreGuiForm = class(TreGuiObject)
  private
    FClose: Boolean;
    FCaption: PChar;
    FIconIndex: longint;
    FOnClose: TNotifyEvent;
    FUseIcon: Boolean;
    procedure SetCaption(AValue: PChar);
    procedure SetIconIndex(AValue: longint);
    procedure SetUseIcon(AValue: Boolean);
  public
    constructor Create(GuiContainer: TreGuiContainer);override;
    procedure Update;override;
    procedure Render;override;
    property Caption: PChar read FCaption write SetCaption;
    property UseIcon: Boolean read FUseIcon write SetUseIcon;
    property IconIndex: longint read FIconIndex write SetIconIndex;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
  end;

  { TreGuiLabel }
  TreGuiLabel = class(TreGuiObject)
  private
    FCaption: PChar;
    procedure SetCaption(AValue: PChar);
  public
    constructor Create(GuiContainer: TreGuiContainer);override;
    procedure Render;override;
    property Caption: PChar read FCaption write SetCaption;
  end;


implementation

{ TreGuiLabel }
procedure TreGuiLabel.SetCaption(AValue: PChar);
begin
  if FCaption=AValue then Exit;
  FCaption:=AValue;
end;

constructor TreGuiLabel.Create(GuiContainer: TreGuiContainer);
begin
  inherited Create(GuiContainer);
  FCaption:='GuiLabel';
  FVisible:=True;
end;

procedure TreGuiLabel.Render;
begin
  inherited Render;
  if Fvisible then
   begin
     if FUseGlobalBounds then GuiLabel(GetOffSetBounds(FBounds),FCaption)
      else GuiLabel(FBounds,FCaption);
   end;
end;

{ TreGuiForm }
procedure TreGuiForm.SetCaption(AValue: PChar);
begin
  if FCaption=AValue then Exit;
  FCaption:=AValue;
end;

procedure TreGuiForm.SetIconIndex(AValue: longint);
begin
  if FIconIndex=AValue then Exit;
  FIconIndex:=AValue;
end;

procedure TreGuiForm.SetUseIcon(AValue: Boolean);
begin
  if FUseIcon=AValue then Exit;
  FUseIcon:=AValue;
end;

constructor TreGuiForm.Create(GuiContainer: TreGuiContainer);
begin
  inherited Create(GuiContainer);
  FBounds:=GuiContainer.FGlobalBounds;
  FCaption:='GuiForm';
  FVisible:=True;
end;

procedure TreGuiForm.Update;
begin
  inherited Update;
end;

procedure TreGuiForm.Render;
begin
  inherited Render;
  if Fvisible then
   begin
     if FUseIcon then FClose:=GuiWindowBox(FBounds,GuiIconText(FIconIndex, FCaption))
     else
     FClose:= GuiWindowBox(FBounds, PChar(FCaption));
     if FClose and assigned(OnClose) then FOnClose(self);
   end;
end;

procedure TreGuiObject.SetBounds(AValue: TRectangle);
begin
  FBounds:=AValue;
end;

procedure TreGuiObject.SetUseGlobalBounds(AValue: boolean);
begin
  if FUseGlobalBounds=AValue then Exit;
  FUseGlobalBounds:=AValue;
end;

procedure TreGuiObject.SetVisible(AValue: boolean);
begin
  if FVisible=AValue then Exit;
  FVisible:=AValue;
end;

{ TreGuiObject }
constructor TreGuiObject.Create(GuiContainer: TreGuiContainer);
begin
  FGuiContainer := GuiContainer;
  FGuiContainer.FGuiList.Add(Self);
  FOffSetBounds:=GuiContainer.FGlobalBounds;
  FUseGlobalBounds:=True;
end;

destructor TreGuiObject.Destroy;
begin
  inherited Destroy;
end;

procedure TreGuiObject.Render;
begin
//
end;

procedure TreGuiObject.Update;
begin
// nothing
end;

function TreGuiObject.GetOffSetBounds(Bounds: TRectangle): TRectangle;
begin
  result:=RectangleCreate(FOffSetBounds.x + Bounds.x,FOffSetBounds.y + Bounds.y+ 20,Bounds.width, Bounds.height);
end;

{ TreGuiContainer }
procedure TreGuiContainer.SetGlobalBounds(AValue: TRectangle);
begin
  FGlobalBounds:=AValue;
end;

procedure TreGuiContainer.SetVisible(AValue: boolean);
begin
  if FVisible=AValue then Exit;
  FVisible:=AValue;
end;

constructor TreGuiContainer.Create;
begin
  FGuiList := TList.Create;
  FVisible := True;

end;

destructor TreGuiContainer.Destroy;
var i: integer;
begin
  for i := 0 to FGuiList.Count- 1 do TreGuiObject(FGuiList.Items[i]).Destroy;
  FGuiList.Destroy;
  inherited Destroy;
end;

procedure TreGuiContainer.Render;
var i: Integer;
begin
  if FVisible then for i := 0 to FGuiList.Count - 1 do
  TreGuiObject(FGuiList.Items[i]).Render;
end;

procedure TreGuiContainer.Update;
var i: Integer;
begin
  for i := 0 to FGuiList.Count - 1 do TreGuiObject(FGuiList.Items[i]).Update;
end;

end.

