unit uOrcamentoCentroCustoDAO;

interface

uses System.Classes, Datasnap.DBClient, uOrcamentoCentroCusto;

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
  public
    constructor Create(oCdsOrcamentoCC: TClientDataSet);

    procedure Save(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
    procedure Delete(iId: SmallInt);
    procedure LoadOrcamentoCentroCustoToCdsOrcamentoCC;
  end;

implementation

{ TOrcamentoCentroCustoDAO }

uses udmDataBase, uConfigFile, System.Math;

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
     (dmDataBase.OrcamentoCentroCusto.Locate(uOrcamentoCentroCusto.ID, iId)) then
     dmDataBase.OrcamentoCentroCusto.Delete;
end;

procedure TOrcamentoCentroCustoDAO.SetConnectionOrcamentoCentroCusto;
begin
  dmDataBase.ConnectionPostgreSQL.Params.Values['Database'] := TConfigFile.GetInstance.GetDataBase;
  dmDataBase.ConnectionPostgreSQL.Params.Values['User_Name'] := TConfigFile.GetInstance.GetDataBaseUser;
  dmDataBase.ConnectionPostgreSQL.Params.Values['Password'] := TConfigFile.GetInstance.GetDataBasePassword;
  dmDataBase.ConnectionPostgreSQL.Params.Values['Server'] := TConfigFile.GetInstance.GetDataBaseIp;
  dmDataBase.ConnectionPostgreSQL.Params.Values['Port'] := TConfigFile.GetInstance.GetDataBasePort;
  dmDataBase.ConnectionPostgreSQL.Connected := True;
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
      dmDataBase.OrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.ID).AsInteger;
    Self.FCdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.ORCAMENTO).AsInteger :=
      dmDataBase.OrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.ORCAMENTO).AsInteger;
    Self.FCdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.CENTROCUSTO).AsString :=
      dmDataBase.OrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.CENTROCUSTO).AsString;
    Self.FCdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.CENTROCUSTOPAI).AsString :=
      dmDataBase.OrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.CENTROCUSTOPAI).AsString;
    Self.FCdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.CENTROCUSTOFILHO).AsString :=
      dmDataBase.OrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.CENTROCUSTOFILHO).AsString;
    Self.FCdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.VALOR).AsCurrency :=
      dmDataBase.OrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.VALOR).AsCurrency;
    Self.FCdsOrcamentoCC.Post;

    dmDataBase.OrcamentoCentroCusto.Next;
  end;
end;

procedure TOrcamentoCentroCustoDAO.UpdateOrcamentoCentroCustoDataBase(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
begin
  if dmDataBase.OrcamentoCentroCusto.Locate(uOrcamentoCentroCusto.ID, oOrcamentoCentroCusto.Id) then
  begin
    dmDataBase.OrcamentoCentroCusto.Edit;
    Self.SetOrcamentoCentroCustoDataBase(oOrcamentoCentroCusto);
    dmDataBase.OrcamentoCentroCusto.Post;
  end;
end;

procedure TOrcamentoCentroCustoDAO.InsertOrcamentoCentroCustoDataBase(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
begin
  dmDataBase.OrcamentoCentroCusto.Insert;
  Self.SetOrcamentoCentroCustoDataBase(oOrcamentoCentroCusto);
  dmDataBase.OrcamentoCentroCusto.Post;
end;

procedure TOrcamentoCentroCustoDAO.SetOrcamentoCentroCustoDataBase(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
begin
  dmDataBase.OrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.ORCAMENTO).AsInteger := oOrcamentoCentroCusto.Orcamento;
  dmDataBase.OrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.CENTROCUSTO).AsString := oOrcamentoCentroCusto.CentroCusto;
  dmDataBase.OrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.CENTROCUSTOPAI).AsString := oOrcamentoCentroCusto.CentroCustoPai;
  dmDataBase.OrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.CENTROCUSTOFILHO).AsString := oOrcamentoCentroCusto.CentroCustoFilho;
  dmDataBase.OrcamentoCentroCusto.FieldByName(uOrcamentoCentroCusto.VALOR).AsCurrency := oOrcamentoCentroCusto.Valor;
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
  if not dmDataBase.OrcamentoCentroCusto.Active then
    dmDataBase.OrcamentoCentroCusto.Open;

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
