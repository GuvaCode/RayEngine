unit reGui;

{$mode objfpc}{$H+}

interface

uses
  raylib, raygui, classes;

type
  { TreGuiObject }
  TreGuiObject = class(TObject)
  private
    FBounds: TRectangle;
    FFont: TFont;
    FVisible: boolean;
    function GetFontSize: Longint;
    function GetHeight: Single;
    function GetLeft: Single;
    function GetTop: Single;
    function GetWidth: Single;
    procedure SetFontSize(AValue: Longint);
    procedure SetHeight(AValue: Single);
    procedure SetLeft(AValue: Single);
    procedure SetTop(AValue: Single);
    procedure SetVisible(AValue: boolean);
    procedure SetWidth(AValue: Single);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Render; virtual;
    procedure Update; virtual;
    procedure LoadFont(FileName:String);
    procedure SetFont(Font:TFont);
    property Bounds:TRectangle read FBounds;
  published
    property Top:Single read GetTop write SetTop;
    property Left:Single read GetLeft write SetLeft;
    property Height: Single read GetHeight write SetHeight;//Visote
    property Width: Single read GetWidth write SetWidth;//Shirote
    property FontSize: Longint read GetFontSize write SetFontSize;
    property Visible: boolean read FVisible write SetVisible;
  end;

  { TreForm }
  TreGuiForm = class(TreGuiObject)
  private
    FCaption: String;
    FMovingForm: Boolean;
    FOnClose: TNotifyEvent;
    FClose: Boolean;
    procedure SetCaption(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Render; override;
    procedure Update; override;
  published
    property Caption: String read FCaption write SetCaption;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
  end;

  { TreGuiLabel }

  TreGuiLabel = class(TreGuiObject)
  private
    FCaption: String;
    procedure SetCaption(AValue: String);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Render; override;
  published
    property Caption: String read FCaption write SetCaption;
  end;

implementation

{ TreGuiLabel }

procedure TreGuiLabel.SetCaption(AValue: String);
begin
  if FCaption=AValue then Exit;
  FCaption:=AValue;
end;

constructor TreGuiLabel.Create;
begin
  Caption:='Label';
  FVisible:=True;
end;

destructor TreGuiLabel.Destroy;
begin
  inherited Destroy;
end;

procedure TreGuiLabel.Render;
begin
  inherited Render;
  if FVisible then GuiLabel(Fbounds,Pchar(Caption));
end;

{ TreForm }
procedure TreGuiForm.SetCaption(AValue: String);
begin
  if FCaption=AValue then Exit;
  FCaption:=AValue;
end;

procedure TreGuiForm.Render;
begin
  inherited Render;
  if FVisible then
   begin
     FClose:= GuiWindowBox(FBounds, PChar(FCaption));
     if FClose and assigned(OnClose) then FOnClose(self);
   end;
end;

procedure TreGuiForm.Update;
begin
  inherited Update;
end;

constructor TreGuiForm.Create;
begin
  inherited Create;
  FVisible:=True;
end;

destructor TreGuiForm.Destroy;
begin
  inherited Destroy;
end;

{ TreGuiObject }
function TreGuiObject.GetHeight: Single;
begin
 result:=FBounds.height;
end;

function TreGuiObject.GetFontSize: Longint;
begin
  result:=FFont.baseSize;
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

procedure TreGuiObject.SetFont(Font: TFont);
begin
  FFont:=Font;
end;

procedure TreGuiObject.SetFontSize(AValue: Longint);
begin
  FFont.baseSize:=AValue;
end;

procedure TreGuiObject.SetHeight(AValue: Single);
begin
  FBounds:=RectangleCreate(FBounds.X,FBounds.y,FBounds.width,AValue);
end;

procedure TreGuiObject.SetLeft(AValue: Single);
begin
  FBounds:=RectangleCreate(AValue,FBounds.y,FBounds.width,Fbounds.height);
end;

procedure TreGuiObject.SetTop(AValue: Single);
begin
 FBounds:=RectangleCreate(FBounds.x,AValue,FBounds.width,Fbounds.width);
end;

procedure TreGuiObject.SetVisible(AValue: boolean);
begin
  if FVisible=AValue then Exit;
  FVisible:=AValue;
end;

procedure TreGuiObject.SetWidth(AValue: Single);
begin
  FBounds:=RectangleCreate(FBounds.x,FBounds.y,AValue,Fbounds.height);
end;

constructor TreGuiObject.Create;
begin
  FBounds:=RectangleCreate(50,50,50,50);
  FFont:=GetFontDefault;
end;

destructor TreGuiObject.Destroy;
begin
  UnloadFont(FFont);
  inherited Destroy;
end;

procedure TreGuiObject.Render;
begin
 // nothing
end;

procedure TreGuiObject.Update;
begin
  // nothing
end;

procedure TreGuiObject.LoadFont(FileName: String);
begin
  FFont:=rayLib.LoadFont(Pchar(FileName));
end;

end.

