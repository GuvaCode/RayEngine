unit reDescriptor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LazIDEIntf, ProjectIntf, Controls, Forms;

type
  { TRayEngineApplicationDescriptor }
  TRayEngineApplicationDescriptor = class(TProjectDescriptor)
  public
    constructor Create; override;
    function GetLocalizedName: string; override;
    function GetLocalizedDescription: string; override;
    function InitProject(AProject: TLazProject): TModalResult; override;
    function CreateStartFiles(AProject: TLazProject): TModalResult; override;
  end;

  { TRayEngineFileUnit }
  TRayEngineFileUnit = class(TFileDescPascalUnit)
  public
    constructor Create; override;
    function GetInterfaceUsesSection: string; override;
    function GetUnitDirectives: string; override;
    function GetImplementationSource(const Filename, SourceName, ResourceName: string): string; override;
    function GetInterfaceSource(const aFilename, aSourceName, aResourceName: string): string; override;
  end;

  const LE = #10;

  resourcestring
    AboutProject = 'RayEngine simple application';
    AboutDescription = 'The RayEngine is a set of classes for helping in the creation of 2D and 3D games in pascal.';

  procedure Register;

implementation

procedure Register;
begin
  RegisterProjectFileDescriptor(TRayEngineFileUnit.Create,FileDescGroupName);
  RegisterProjectDescriptor(TRayEngineApplicationDescriptor.Create);
end;


function FileDescriptorByName() : TProjectFileDescriptor;
begin
 Result:=ProjectFileDescriptors.FindByName('RayEngine_Unit');
end;


{ TRayEngineFileUnit }
constructor TRayEngineFileUnit.Create;
begin
  inherited Create;
  Name:='RayEngine_Unit';
  UseCreateFormStatements:=False;
end;

function TRayEngineFileUnit.GetInterfaceUsesSection: string;
begin
  Result:='raylib, reApplication';
end;

function TRayEngineFileUnit.GetUnitDirectives: string;
begin
  result := '{$mode objfpc}{$H+}';
end;

function TRayEngineFileUnit.GetImplementationSource(const Filename, SourceName,
  ResourceName: string): string;
begin
  Result:=
'constructor TGame.Create;'+LE+
'begin'+LE+
' //setup and initialization engine' +LE+
' InitWindow(800, 600, ''raylib [Game Project]''); // Initialize window and OpenGL context '+LE+
' SetWindowState(FLAG_VSYNC_HINT or FLAG_MSAA_4X_HINT); // Set window configuration state using flags'+LE+
' SetTargetFPS(60); // Set target FPS (maximum)' +LE+
' ClearBackgroundColor:= White; // Set background color (framebuffer clear color)'+LE+
'end;'+LE+
''+LE+
'procedure TGame.Update;'+LE+
'begin'+LE+
'end;'+LE+
''+LE+
'procedure TGame.Render;'+LE+
'begin'+LE+
' DrawFPS(10,10); // Draw current FPS'+LE+
'end;'+LE+
''+LE+
'procedure TGame.Shutdown;'+LE+
'begin'+LE+
'end;' +LE+LE;
end;

function TRayEngineFileUnit.GetInterfaceSource(const aFilename, aSourceName,
  aResourceName: string): string;
begin
  Result:=
'type'+LE+
'TGame = class(TreApplication)'+LE+
'  private'+LE+
'  protected'+LE+
'  public'+LE+
'    constructor Create; override;'+LE+
'    procedure Update; override;'+LE+
'    procedure Render; override;'+LE+
'    procedure Shutdown; override;'+LE+
'  end;'+LE+LE
end;

{ TRayEngineApplicationDescriptor }

constructor TRayEngineApplicationDescriptor.Create;
begin
  inherited Create;
  Name := AboutDescription;
end;

function TRayEngineApplicationDescriptor.GetLocalizedName: string;
begin
  Result := AboutProject;
end;

function TRayEngineApplicationDescriptor.GetLocalizedDescription: string;
begin
  Result:=AboutDescription;
end;

function TRayEngineApplicationDescriptor.InitProject(AProject: TLazProject
  ): TModalResult;
var
  NewSource: String;
  MainFile: TLazProjectFile;
begin
  Result:=inherited InitProject(AProject);

  MainFile:=AProject.CreateProjectFile('myGame.lpr');
  MainFile.IsPartOfProject:=true;
  AProject.AddFile(MainFile,false);
  AProject.MainFileID:=0;
  AProject.UseAppBundle:=true;

 // create program source
  NewSource:=
  'program Game;'+LE+
   ''+LE+
  'uses'+LE+
  '   SysUtils;'+LE+
  ''+LE+
  ''+LE+
  'var myGame: TGame;'+LE+
  ''+LE+
  'begin'+LE+
  '  myGame:= TGame.Create;'+LE+
  '  myGame.Run;'+LE+
  '  myGame.Free;'+LE+
  'end.'+LE;

  AProject.MainFile.SetSourceText(NewSource,true);


  AProject.AddPackageDependency('ray4laz');
  AProject.AddPackageDependency('RayEngine');
  AProject.LazCompilerOptions.UnitOutputDirectory:='lib'+PathDelim+'$(TargetCPU)-$(TargetOS)';
  AProject.LazCompilerOptions.TargetFilename:='Game';
  AProject.LazCompilerOptions.Win32GraphicApp:=True;
//AProject.LazCompilerOptions.GenerateDebugInfo:=False;

end;

function TRayEngineApplicationDescriptor.CreateStartFiles(AProject: TLazProject
  ): TModalResult;
begin
  Result:=LazarusIDE.DoNewEditorFile(FileDescriptorByName,'','',[nfIsPartOfProject,nfOpenInEditor,nfCreateDefaultSrc]);
end;

end.

