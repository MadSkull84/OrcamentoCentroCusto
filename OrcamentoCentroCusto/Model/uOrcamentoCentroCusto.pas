unit uOrcamentoCentroCusto;

interface

uses System.Classes, Datasnap.DBClient;

const
  ID = 'ID';
  ORCAMENTO = 'ORCAMENTO';
  CENTROCUSTOPAI = 'CENTRO_CUSTO_PAI';
  CENTROCUSTOFILHO = 'CENTRO_CUSTO_FILHO';
  CENTROCUSTO = 'CENTRO_CUSTO';
  VALOR = 'VALOR';

type
  TOrcamentoCentroCusto = class
  private
    FId: SmallInt;
    FOrcamento: SmallInt;
    FCentroCustoPai: String;
    FCentroCustoFilho: String;
    FCentroCusto: String;
    FValor: Currency;
    FDiferenca: Currency;
  public
    property Id: SmallInt read FId write FId;
    property Orcamento: SmallInt read FOrcamento write FOrcamento;
    property CentroCustoPai: String read FCentroCustoPai write FCentroCustoPai;
    property CentroCustoFilho: String read FCentroCustoFilho write FCentroCustoFilho;
    property CentroCusto: String read FCentroCusto write FCentroCusto;
    property Valor: Currency read FValor write FValor;
    property Diferenca: Currency read FDiferenca write FDiferenca;

    constructor Create;
  end;

implementation

uses System.Math;

{ TOrcamentoCentroCusto }

constructor TOrcamentoCentroCusto.Create;
begin
  Self.FId := System.Math.ZeroValue;
  Self.FDiferenca := System.Math.ZeroValue;
end;

end.
