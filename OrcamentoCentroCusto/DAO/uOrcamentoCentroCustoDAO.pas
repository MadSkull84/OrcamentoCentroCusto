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
  public
    constructor Create(oCdsOrcamentoCC: TClientDataSet);

    procedure Insert(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
  end;

implementation

{ TOrcamentoCentroCustoDAO }

constructor TOrcamentoCentroCustoDAO.Create(oCdsOrcamentoCC: TClientDataSet);
begin
  Self.FCdsOrcamentoCC := oCdsOrcamentoCC;
end;

procedure TOrcamentoCentroCustoDAO.Insert(
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

end.
