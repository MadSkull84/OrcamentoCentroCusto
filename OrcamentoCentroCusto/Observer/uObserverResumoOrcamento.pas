unit uObserverResumoOrcamento;

interface

uses System.Classes, ObserverOrcamentoCentroCusto, uOrcamentoCentroCusto,
  Datasnap.DBClient;

type
  TObserverResumoOrcamento = class(TInterfacedObject, IObserverOrcamentoCentroCusto)
  private
    FCdsUpdate: TClientDataSet;
  public
    constructor Create(oCdsUpdate: TClientDataSet);
    procedure Update(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
  end;

implementation

uses uServiceResumo, System.SysUtils, uOrcamentoCentroCustoDAO;

{ ObserverResumoOrcamento }

constructor TObserverResumoOrcamento.Create(oCdsUpdate: TClientDataSet);
begin
  Self.FCdsUpdate := oCdsUpdate;
end;

procedure TObserverResumoOrcamento.Update(
  oOrcamentoCentroCusto: TOrcamentoCentroCusto);
var oServiceResumo: TServiceResumo;
begin
  oServiceResumo := TServiceResumo.Create();
  try
    oServiceResumo.Update(uOrcamentoCentroCusto.ORCAMENTO, oOrcamentoCentroCusto, Self.FCdsUpdate);
  finally
    FreeAndNil(oServiceResumo);
  end;
end;

end.
