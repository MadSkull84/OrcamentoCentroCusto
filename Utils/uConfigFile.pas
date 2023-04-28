unit uConfigFile;

interface

uses System.Classes, IniFiles;

type
  TConfigFile = class
  private
    FConfigFile: TIniFile;

    constructor Create;

    procedure BeforeDestruction; override;
    procedure ApplyDefaultConfig;

    property ConfigFile: TIniFile read FConfigFile write FConfigFile;
  public
    class function GetInstance: TConfigFile;
    class function NewInstance: TObject; override;

    function IsDataBasePostgreSql: Boolean;
    function GetDataBase: String;
    function GetDataBaseUser: String;
    function GetDataBasePassword: String;
    function GetDataBaseIp: String;
    function GetDataBasePort: String;
  end;

var
  Instance: TConfigFile;

const
  FILE_NAME = 'config.ini';

  DATABASE_DEFAULT_VALUE = 'XML';
  DATABASE_USER_DEFAULT_VALUE = 'postgres';
  DATABASE_PASSWORD_DEFAULT_VALUE = 'postgres';
  DATABASE_IP_DEFAULT_VALUE = 'localhost';
  DATABASE_PORT_DEFAULT_VALUE = '7777';

  DB = 'DB';

  DATABASE = 'DATABASE';
  DATABASE_USER = 'DATABASE_USER';
  DATABASE_PASSWORD = 'DATABASE_PASSWORD';
  DATABASE_IP = 'DATABASE_IP';
  DATABASE_PORT = 'DATABASE_PORT';

  POSTGRESSQL = 'postgres';
  XML = 'XML';

implementation

uses System.SysUtils, Vcl.Forms;

{ TConfigFile }

procedure TConfigFile.ApplyDefaultConfig;
begin
  Self.ConfigFile.WriteString(DB, DATABASE, DATABASE_DEFAULT_VALUE);
  Self.ConfigFile.WriteString(DB, DATABASE_USER, DATABASE_USER_DEFAULT_VALUE);
  Self.ConfigFile.WriteString(DB, DATABASE_PASSWORD, DATABASE_PASSWORD_DEFAULT_VALUE);
  Self.ConfigFile.WriteString(DB, DATABASE_IP, DATABASE_IP_DEFAULT_VALUE);
  Self.ConfigFile.WriteString(DB, DATABASE_PORT, DATABASE_PORT_DEFAULT_VALUE);
end;

procedure TConfigFile.BeforeDestruction;
begin
  FreeAndNil(Self.FConfigFile);
  inherited;
end;

constructor TConfigFile.Create;
var
  bNew: Boolean;
begin
  bNew := not FileExists(ExtractFilePath(Application.ExeName)+FILE_NAME);
  if not Assigned(Self.ConfigFile) then
    Self.ConfigFile := TIniFile.Create(ExtractFilePath(Application.ExeName)+FILE_NAME);
  if bNew then
    Self.ApplyDefaultConfig;
end;

function TConfigFile.GetDataBase: String;
begin
  Result := Self.ConfigFile.ReadString(DB, DATABASE, DATABASE_DEFAULT_VALUE);
end;

function TConfigFile.GetDataBaseIp: String;
begin
  Result := Self.ConfigFile.ReadString(DB, DATABASE_IP, DATABASE_IP_DEFAULT_VALUE);
end;

function TConfigFile.GetDataBasePassword: String;
begin
  Result := Self.ConfigFile.ReadString(DB, DATABASE_PASSWORD, DATABASE_PASSWORD_DEFAULT_VALUE);
end;

function TConfigFile.GetDataBasePort: String;
begin
  Result := Self.ConfigFile.ReadString(DB, DATABASE_PORT, DATABASE_PORT_DEFAULT_VALUE);
end;

function TConfigFile.GetDataBaseUser: String;
begin
  Result := Self.ConfigFile.ReadString(DB, DATABASE_USER, DATABASE_USER_DEFAULT_VALUE);
end;

class function TConfigFile.GetInstance: TConfigFile;
begin
  result := TConfigFile.Create;
end;

function TConfigFile.IsDataBasePostgreSql: Boolean;
begin
  Result := Self.ConfigFile.ReadString(DB, DATABASE, DATABASE_DEFAULT_VALUE) = POSTGRESSQL;
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
