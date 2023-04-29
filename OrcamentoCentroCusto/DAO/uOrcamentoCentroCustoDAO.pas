unit uOrcamentoCentroCustoDAO;

interface

uses System.Classes, Datasnap.DBClient, uOrcamentoCentroCusto, FireDAC.Comp.Client;

type
  TOrcamentoCentroCustoDAO = class
  private
    FCdsOrcamentoCC: TClientDataSet;
    procedure SaveDataBase(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
    procedure SaveClientDataSet(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
    procedure InsertClientDataSet(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
    procedure UpdateClientDataSet(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
    procedure SetCdsOrcamentoCC(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
    procedure SetConnectionOrcamentoCentroCusto;
    procedure SetOrcamentoCentroCustoDataBase(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
    procedure InsertOrcamentoCentroCustoDataBase(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
    procedure UpdateOrcamentoCentroCustoDataBase(oOrcamentoCentroCusto: TOrcamentoCentroCusto);

    function GetConnectionPostgreSQL: TFDConnection;
    function GetOrcamentoCentroCusto: TFDTable;
  public
    constructor Create(oCdsOrcamentoCC: TClientDataSet);

    procedure Save(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
    procedure Delete(iId: SmallInt);
    procedure LoadOrcamentoCentroCustoToCdsOrcamentoCC;
  end;

implementation

{ TOrcamentoCentroCustoDAO }

uses udmDataBase, uConfigFile, System.Math;

const
  DATABASE = 'Database';
  USER_NAME = 'User_Name';
  PASSWORD = 'Password';
  SERVER = 'Server';
  PORT = 'Port';

constructor TOrcamentoCentroCustoDAO.Create(oCdsOrcamentoCC: TClientDataSet);
begin
  Self.FCdsOrcamentoCC := oCdsOrcamentoCC;
  if TConfigFile.GetInstance.IsDataBasePostgreSql then
    Self.SetConnectionOrcamentoCentroCusto;
end;

procedure TOrcamentoCentroCustoDAO.Delete(iId: SmallInt);
begin
  if Self.FCdsOrcamentoCC.Locate(uOrcamentoCentroCusto.ID, iId, []) then
    Self.FCdsOrcamentoCC.Delete;

  if (TConfigFile.GetInstance.IsDataBasePostgreSql) and
     (Self.GetOrcamentoCentroCusto.Locate(uOrcamentoCentroCusto.ID, iId)) then
    Self.GetOrcamentoCentroCusto.Delete;
end;

function TOrcamentoCentroCustoDAO.GetConnectionPostgreSQL: TFDConnection;
begin
  Result := dmDataBase.ConnectionPostgreSQL;
end;

function TOrcamentoCentroCustoDAO.GetOrcamentoCentroCusto: TFDTable;
begin
  Result := dmDataBase.OrcamentoCentroCusto;
end;

procedure TOrcamentoCentroCustoDAO.SetConnectionOrcamentoCentroCusto;
begin
  Self.GetConnectionPostgreSQL.Params.Values[DATABASE] := TConfigFile.GetInstance.GetDataBase;
  Self.GetConnectionPostgreSQL.Params.Values[USER_NAME] := TConfigFile.GetInstance.GetDataBaseUser;
  Self.GetConnectionPostgreSQL.Params.Values[PASSWORD] := TConfigFile.GetInstance.GetDataBasePassword;
  Self.GetConnectionPostgreSQL.Params.Values[SERVER] := TConfigFile.GetInstance.GetDataBaseIp;
  Self.GetConnectionPostgreSQL.Params.Values[PORT] := TConfigFile.GetInstance.GetDataBasePort;
  Self.GetConnectionPostgreSQL.Connected := True;
end;

procedure TOrcamentoCentroCustoDAO.InsertClientDataSet(
  oOrcamentoCentroCusto: TOrcamentoCentroCusto);
var
  iNewId: SmallInt;
begin
  iNewId := Self.FCdsOrcamentoCC.RecordCount;
  inc(iNewId);
  Self.FCdsOrcamentoCC.Insert;
  Self.FCdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.ID).AsInteger := iNewId;
  Self.SetCdsOrcamentoCC(oOrcamentoCentroCusto);
  Self.FCdsOrcamentoCC.Post;
end;

procedure TOrcamentoCentroCustoDAO.LoadOrcamentoCentroCustoToCdsOrcamentoCC;
begin
  dmDataBase.OrcamentoCentroCusto.Open;
  while not dmDataBase.OrcamentoCentroCusto.Eof do
  begin
    Self.FCdsOrcamentoCC.Insert;
    Self.FCdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.ID).AsInteger :=
      Self.GetOrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.ID).AsInteger;
    Self.FCdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.ORCAMENTO).AsInteger :=
      Self.GetOrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.ORCAMENTO).AsInteger;
    Self.FCdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.CENTROCUSTO).AsString :=
      Self.GetOrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.CENTROCUSTO).AsString;
    Self.FCdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.CENTROCUSTOPAI).AsString :=
      Self.GetOrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.CENTROCUSTOPAI).AsString;
    Self.FCdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.CENTROCUSTOFILHO).AsString :=
      Self.GetOrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.CENTROCUSTOFILHO).AsString;
    Self.FCdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.VALOR).AsCurrency :=
      Self.GetOrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.VALOR).AsCurrency;
    Self.FCdsOrcamentoCC.Post;

    dmDataBase.OrcamentoCentroCusto.Next;
  end;
end;

procedure TOrcamentoCentroCustoDAO.UpdateOrcamentoCentroCustoDataBase(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
begin
  if Self.GetOrcamentoCentroCusto.Locate(uOrcamentoCentroCusto.ID, oOrcamentoCentroCusto.Id) then
  begin
    Self.GetOrcamentoCentroCusto.Edit;
    Self.SetOrcamentoCentroCustoDataBase(oOrcamentoCentroCusto);
    Self.GetOrcamentoCentroCusto.Post;
  end;
end;

procedure TOrcamentoCentroCustoDAO.InsertOrcamentoCentroCustoDataBase(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
begin
  Self.GetOrcamentoCentroCusto.Insert;
  Self.SetOrcamentoCentroCustoDataBase(oOrcamentoCentroCusto);
  Self.GetOrcamentoCentroCusto.Post;
end;

procedure TOrcamentoCentroCustoDAO.SetOrcamentoCentroCustoDataBase(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
begin
  Self.GetOrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.ORCAMENTO).AsInteger := oOrcamentoCentroCusto.Orcamento;
  Self.GetOrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.CENTROCUSTO).AsString := oOrcamentoCentroCusto.CentroCusto;
  Self.GetOrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.CENTROCUSTOPAI).AsString := oOrcamentoCentroCusto.CentroCustoPai;
  Self.GetOrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.CENTROCUSTOFILHO).AsString := oOrcamentoCentroCusto.CentroCustoFilho;
  Self.GetOrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.VALOR).AsCurrency := oOrcamentoCentroCusto.Valor;
end;

procedure TOrcamentoCentroCustoDAO.Save(
  oOrcamentoCentroCusto: TOrcamentoCentroCusto);
begin
  SaveClientDataSet(oOrcamentoCentroCusto);
  if TConfigFile.GetInstance.IsDataBasePostgreSql then
    SaveDataBase(oOrcamentoCentroCusto);
end;

procedure TOrcamentoCentroCustoDAO.SetCdsOrcamentoCC(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
begin
  Self.FCdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.ORCAMENTO).AsInteger := oOrcamentoCentroCusto.Orcamento;
  Self.FCdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.CENTROCUSTOPAI).AsString := oOrcamentoCentroCusto.CentroCustoPai;
  Self.FCdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.CENTROCUSTOFILHO).AsString := oOrcamentoCentroCusto.CentroCustoFilho;
  Self.FCdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.CENTROCUSTO).AsString := oOrcamentoCentroCusto.CentroCusto;
  Self.FCdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.VALOR).AsCurrency := oOrcamentoCentroCusto.Valor;
end;

procedure TOrcamentoCentroCustoDAO.SaveClientDataSet(
  oOrcamentoCentroCusto: TOrcamentoCentroCusto);
begin
  if oOrcamentoCentroCusto.Id = System.Math.ZeroValue then
    Self.InsertClientDataSet(oOrcamentoCentroCusto)
  else
    Self.UpdateClientDataSet(oOrcamentoCentroCusto);
end;

procedure TOrcamentoCentroCustoDAO.SaveDataBase(
  oOrcamentoCentroCusto: TOrcamentoCentroCusto);
begin
  if not Self.GetOrcamentoCentroCusto.Active then
    Self.GetOrcamentoCentroCusto.Open;

  if oOrcamentoCentroCusto.Id > System.Math.ZeroValue then
    Self.UpdateOrcamentoCentroCustoDataBase(oOrcamentoCentroCusto)
  else
    Self.InsertOrcamentoCentroCustoDataBase(oOrcamentoCentroCusto);
end;

procedure TOrcamentoCentroCustoDAO.UpdateClientDataSet(
  oOrcamentoCentroCusto: TOrcamentoCentroCusto);
begin
  if not Self.FCdsOrcamentoCC.Locate(uOrcamentoCentroCusto.ID, oOrcamentoCentroCusto.Id, []) then
    Exit;

  Self.FCdsOrcamentoCC.Edit;
  Self.SetCdsOrcamentoCC(oOrcamentoCentroCusto);
  Self.FCdsOrcamentoCC.Post;
end;

end.
