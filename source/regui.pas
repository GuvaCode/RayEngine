unit reGui;

{$mode objfpc}{$H+}

interface

uses
  raylib,raygui;

type
  { TreGuiWindow }
  TreGuiWindow = class(TObject)
   private
     FBounds: TRectangle;
     FCaption: string;
     FExitWindow: boolean;
     procedure SetCaption(AValue: string);
   public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Paint; virtual;
    property Bounds: TRectangle read FBounds write FBounds;
    property Caption: string read FCaption write SetCaption;
  end;

implementation

{ TreGuiWindow }
procedure TreGuiWindow.SetCaption(AValue: string);
begin
  if FCaption=AValue then Exit;
  FCaption:=AValue;
end;

constructor TreGuiWindow.Create;
begin
 FBounds:= RectangleCreate(100,100,300,100)
end;

destructor TreGuiWindow.Destroy;
begin
  inherited Destroy;
end;

procedure TreGuiWindow.Paint;
begin
 FExitWindow := GuiWindowBox(FBounds, Pchar(FCaption));
end;

end.

