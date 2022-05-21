unit reGui;

{$mode objfpc}{$H+}

interface

uses
  raylib,raygui, classes;

type
  { TreGuiObject }
  TreGuiObject = class(TObject)
  private
    FBounds: TRectangle;
    function GetHeight: Single;
    function GetLeft: Single;
    function GetTop: Single;
    function GetWidth: Single;
    procedure SetHeight(AValue: Single);
    procedure SetLeft(AValue: Single);
    procedure SetTop(AValue: Single);
    procedure SetWidth(AValue: Single);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Render; virtual;
  published
    property Top:Single read GetTop write SetTop;
    property Left:Single read GetLeft write SetLeft;
    property Height: Single read GetHeight write SetHeight;//Visote
    property Width: Single read GetWidth write SetWidth;//Shirote
  end;

  { TreForm }
  TreForm = class(TreGuiObject)
  private
    FCaption: String;
    FOnClose: TNotifyEvent;
    FClose: Boolean;
    procedure SetCaption(AValue: String);
    procedure Render; override;
  published
    property Caption: String read FCaption write SetCaption;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
  end;


implementation

{ TreForm }
procedure TreForm.SetCaption(AValue: String);
begin
  if FCaption=AValue then Exit;
  FCaption:=AValue;
  if FBounds.width<MeasureText(Pchar(AValue),14) then
  FBounds.width:=MeasureText(Pchar(AValue),14);
end;

procedure TreForm.Render;
begin
  inherited Render;
  FClose:= GuiWindowBox(FBounds, PChar(FCaption));
  if FClose then FOnClose(self);
end;

{ TreGuiObject }
function TreGuiObject.GetHeight: Single;
begin
 result:=FBounds.height;
end;

function TreGuiObject.GetLeft: Single;
begin
  result:=FBounds.x;
end;

function TreGuiObject.GetTop: Single;
begin
 result:=FBounds.y;
end;

function TreGuiObject.GetWidth: Single;
begin
 result:=FBounds.height;
end;

procedure TreGuiObject.SetHeight(AValue: Single);
begin
  FBounds:=RectangleCreate(FBounds.X,FBounds.y,FBounds.height,AValue);
end;

procedure TreGuiObject.SetLeft(AValue: Single);
begin
  FBounds:=RectangleCreate(AValue,FBounds.y,FBounds.width,Fbounds.height);
end;

procedure TreGuiObject.SetTop(AValue: Single);
begin
 FBounds:=RectangleCreate(FBounds.x,AValue,FBounds.width,Fbounds.width);
end;

procedure TreGuiObject.SetWidth(AValue: Single);
begin
  FBounds:=RectangleCreate(FBounds.x,FBounds.y,AValue,Fbounds.height);
end;

constructor TreGuiObject.Create;
begin
  FBounds:=RectangleCreate(50,50,50,50);
end;

destructor TreGuiObject.Destroy;
begin
  inherited Destroy;
end;

procedure TreGuiObject.Render;
begin
 // nothing
end;



end.

