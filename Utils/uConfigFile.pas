unit uConfigFile;

interface

uses System.Classes, IniFiles;

type
  TConfigFile = class
  private
    FConfigFile: TIniFile;

    constructor Create;

    procedure BeforeDestruction; override;

    property ConfigFile: TIniFile read FConfigFile write FConfigFile;
  public
    class function GetInstance: TConfigFile;
    class function NewInstance: TObject; override;


    function IsDataBasePostgreSql: Boolean;
  end;

var
  Instance: TConfigFile;

const
  POSTGRESQL = 'POSTGRESQL';
  XML = 'XML';

implementation

uses System.SysUtils, Vcl.Forms;

{ TConfigFile }

procedure TConfigFile.BeforeDestruction;
begin
  FreeAndNil(Self.FConfigFile);
  inherited;
end;

constructor TConfigFile.Create;
var
  bNew: Boolean;
begin
  bNew := not FileExists(ExtractFilePath(Application.ExeName)+'\config.ini');
  Self.ConfigFile := TIniFile.Create(ExtractFilePath(Application.ExeName)+'config.ini');
  if bNew then
    Self.ConfigFile.WriteString('DB', 'DATABASE', POSTGRESQL);
end;

class function TConfigFile.GetInstance: TConfigFile;
begin
  result := TConfigFile.Create;
end;

function TConfigFile.IsDataBasePostgreSql: Boolean;
begin
  Result := Self.ConfigFile.ReadString('DB', 'DATABASE', POSTGRESQL) = POSTGRESQL;
end;

class function TConfigFile.NewInstance: TObject;
begin
  if not Assigned(Instance) then
  begin
    Instance := TConfigFile(inherited NewInstance);
  end;
  Result := Instance;
end;

initialization

finalization
  FreeAndNil(Instance);

end.
