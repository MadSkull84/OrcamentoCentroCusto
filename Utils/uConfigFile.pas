unit uConfigFile;

interface

uses System.Classes, IniFiles, uConfigOrcamentoCentroCusto;

type
  TConfigFile = class
  private
    FConfigOrcamentoCentroCusto: TConfigOrcamentoCentroCusto;

    constructor Create;
    destructor Destroy; override;

    procedure ApplyDefaultConfig(oConfigFile: TIniFile);
    procedure LoadConfig(oConfigFile: TIniFile);
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

procedure TConfigFile.ApplyDefaultConfig(oConfigFile: TIniFile);
begin
  oConfigFile.WriteString(DB, DATABASE, DATABASE_DEFAULT_VALUE);
  oConfigFile.WriteString(DB, DATABASE_USER, DATABASE_USER_DEFAULT_VALUE);
  oConfigFile.WriteString(DB, DATABASE_PASSWORD, DATABASE_PASSWORD_DEFAULT_VALUE);
  oConfigFile.WriteString(DB, DATABASE_IP, DATABASE_IP_DEFAULT_VALUE);
  oConfigFile.WriteString(DB, DATABASE_PORT, DATABASE_PORT_DEFAULT_VALUE);
end;

constructor TConfigFile.Create;
var
  oConfigFile: TIniFile;
  bNew: Boolean;
begin
  bNew := not FileExists(ExtractFilePath(Application.ExeName)+FILE_NAME);
  oConfigFile := TIniFile.Create(ExtractFilePath(Application.ExeName)+FILE_NAME);
  try
    if bNew then
      Self.ApplyDefaultConfig(oConfigFile);
    Self.LoadConfig(oConfigFile);
  finally
    FreeAndNil(oConfigFile);
  end;
end;

destructor TConfigFile.Destroy;
begin
  FreeAndNil(Self.FConfigOrcamentoCentroCusto);
  inherited;
end;

function TConfigFile.GetDataBase: String;
begin
  Result := Self.FConfigOrcamentoCentroCusto.DataBase;
end;

function TConfigFile.GetDataBaseIp: String;
begin
  Result := Self.FConfigOrcamentoCentroCusto.DataBaseIp;
end;

function TConfigFile.GetDataBasePassword: String;
begin
  Result := Self.FConfigOrcamentoCentroCusto.DataBasePassword;
end;

function TConfigFile.GetDataBasePort: String;
begin
  Result := Self.FConfigOrcamentoCentroCusto.DataBasePort;
end;

function TConfigFile.GetDataBaseUser: String;
begin
  Result := Self.FConfigOrcamentoCentroCusto.DataBaseUser;
end;

class function TConfigFile.GetInstance: TConfigFile;
begin
  result := TConfigFile.Create;
end;

function TConfigFile.IsDataBasePostgreSql: Boolean;
begin
  Result := Self.FConfigOrcamentoCentroCusto.DataBase = POSTGRESSQL;
end;

procedure TConfigFile.LoadConfig(oConfigFile: TIniFile);
begin
  if not Assigned(Self.FConfigOrcamentoCentroCusto) then
    Self.FConfigOrcamentoCentroCusto := TConfigOrcamentoCentroCusto.Create;

  Self.FConfigOrcamentoCentroCusto.DataBase :=
    oConfigFile.ReadString(DB, DATABASE, DATABASE_DEFAULT_VALUE);
  Self.FConfigOrcamentoCentroCusto.DataBaseUser :=
    oConfigFile.ReadString(DB, DATABASE_USER, DATABASE_USER_DEFAULT_VALUE);
  Self.FConfigOrcamentoCentroCusto.DataBasePassword :=
    oConfigFile.ReadString(DB, DATABASE_PASSWORD, DATABASE_PASSWORD_DEFAULT_VALUE);
  Self.FConfigOrcamentoCentroCusto.DataBaseIp :=
    oConfigFile.ReadString(DB, DATABASE_IP, DATABASE_IP_DEFAULT_VALUE);
  Self.FConfigOrcamentoCentroCusto.DataBasePort :=
    oConfigFile.ReadString(DB, DATABASE_PORT, DATABASE_PORT_DEFAULT_VALUE);
end;

class function TConfigFile.NewInstance: TObject;
begin
  if not Assigned(Instance) then
    Instance := TConfigFile(inherited NewInstance);
  Result := Instance;
end;

initialization

finalization
  FreeAndNil(Instance);

end.
