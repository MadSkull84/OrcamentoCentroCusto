unit uOrcamentoCentroCustoDAO;

interface

uses System.Classes, Datasnap.DBClient, uOrcamentoCentroCusto;

const
  ORCAMENTO = 'ORCAMENTO';
  CENTROCUSTOPAI = 'CENTRO_CUSTO_PAI';
  CENTROCUSTOFILHO = 'CENTRO_CUSTO_FILHO';
  CENTROCUSTO = 'CENTRO_CUSTO';
  VALOR = 'VALOR';

type
  TOrcamentoCentroCustoDAO = class
  private
    FCdsOrcamentoCC: TClientDataSet;
    procedure InsertDataBase(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
    procedure InsertClientDataSet(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
  public
    constructor Create(oCdsOrcamentoCC: TClientDataSet);

    procedure Insert(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
  end;

implementation

{ TOrcamentoCentroCustoDAO }

uses udmDataBase, uConfigFile;

constructor TOrcamentoCentroCustoDAO.Create(oCdsOrcamentoCC: TClientDataSet);
begin
  Self.FCdsOrcamentoCC := oCdsOrcamentoCC;
  if TConfigFile.GetInstance.IsDataBasePostgreSql then
    dmDataBase.ConnectionPostgreSQL.Connected := True;
end;

procedure TOrcamentoCentroCustoDAO.Insert(
  oOrcamentoCentroCusto: TOrcamentoCentroCusto);
begin
  InsertClientDataSet(oOrcamentoCentroCusto);
  if TConfigFile.GetInstance.IsDataBasePostgreSql then
    InsertDataBase(oOrcamentoCentroCusto);
end;

procedure TOrcamentoCentroCustoDAO.InsertClientDataSet(
  oOrcamentoCentroCusto: TOrcamentoCentroCusto);
begin
  Self.FCdsOrcamentoCC.Insert;
  Self.FCdsOrcamentoCC.FieldByName(ORCAMENTO).AsInteger := oOrcamentoCentroCusto.Orcamento;
  Self.FCdsOrcamentoCC.FieldByName(CENTROCUSTOPAI).AsString := oOrcamentoCentroCusto.CentroCustoPai;
  Self.FCdsOrcamentoCC.FieldByName(CENTROCUSTOFILHO).AsString := oOrcamentoCentroCusto.CentroCustoFilho;
  Self.FCdsOrcamentoCC.FieldByName(CENTROCUSTO).AsString := oOrcamentoCentroCusto.CentroCusto;
  Self.FCdsOrcamentoCC.FieldByName(VALOR).AsCurrency := oOrcamentoCentroCusto.Valor;
  Self.FCdsOrcamentoCC.Post;
end;

procedure TOrcamentoCentroCustoDAO.InsertDataBase(
  oOrcamentoCentroCusto: TOrcamentoCentroCusto);
begin
  dmDataBase.OrcamentoCentroCusto.Open;
  dmDataBase.OrcamentoCentroCusto.Insert;
  dmDataBase.OrcamentoCentroCusto.FieldByName(ORCAMENTO).AsInteger := oOrcamentoCentroCusto.Orcamento;
  dmDataBase.OrcamentoCentroCusto.FieldByName(CENTROCUSTO).AsString := oOrcamentoCentroCusto.CentroCusto;
  dmDataBase.OrcamentoCentroCusto.FieldByName(CENTROCUSTOPAI).AsString := oOrcamentoCentroCusto.CentroCustoPai;
  dmDataBase.OrcamentoCentroCusto.FieldByName(CENTROCUSTOFILHO).AsString := oOrcamentoCentroCusto.CentroCustoFilho;
  dmDataBase.OrcamentoCentroCusto.FieldByName(VALOR).AsCurrency := oOrcamentoCentroCusto.Valor;
  dmDataBase.OrcamentoCentroCusto.Post;
end;

end.
