{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit RayEngine;

{$warn 5023 off : no warning about unused units}
interface

uses
  reDescriptor, reApplication, reGui, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('reDescriptor', @reDescriptor.Register);
end;

initialization
  RegisterPackage('RayEngine', @Register);
end.
