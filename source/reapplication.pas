unit reApplication;

{$mode objfpc}{$H+}

interface

uses
  raylib;

type
{ TreApplication }

TreApplication = class (TObject)
  private
    FClearBackgroundColor: TColor;

  protected

  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Shutdown; virtual;
    procedure Update; virtual;
    procedure Render; virtual;

    procedure Run;
    procedure Terminate;
    property ClearBackgroundColor: TColor read FClearBackgroundColor write FClearBackgroundColor;
  end;


implementation

{ TreApplication }

constructor TreApplication.Create;
begin

end;

destructor TreApplication.Destroy;
begin
  inherited Destroy;
end;

procedure TreApplication.Shutdown;
begin

end;

procedure TreApplication.Update;
begin

end;

procedure TreApplication.Render;
begin
end;

procedure TreApplication.Run;
begin
  while not WindowShouldClose() do
    begin
      Update;
      BeginDrawing;
      ClearBackground(FClearBackgroundColor); //todo
      Render;
      EndDrawing;
    end;
  Shutdown;
end;

procedure TreApplication.Terminate;
begin

end;



end.

