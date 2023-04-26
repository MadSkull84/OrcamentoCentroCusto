unit uOrcamentoCentroCusto;

interface

uses System.Classes, Datasnap.DBClient;

type
  TOrcamentoCentroCusto = class
  private
    FOrcamento: SmallInt;
    FCentroCustoPai: String;
    FCentroCustoFilho: String;
    FCentroCusto: String;
    FValor: Currency;
  public
    property Orcamento: SmallInt read FOrcamento write FOrcamento;
    property CentroCustoPai: String read FCentroCustoPai write FCentroCustoPai;
    property CentroCustoFilho: String read FCentroCustoFilho write FCentroCustoFilho;
    property CentroCusto: String read FCentroCusto write FCentroCusto;
    property Valor: Currency read FValor write FValor;
  end;

implementation

{ TOrcamentoCentroCusto }

end.
