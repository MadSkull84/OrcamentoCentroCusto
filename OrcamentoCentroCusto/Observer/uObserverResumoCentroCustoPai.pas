unit uObserverResumoCentroCustoPai;

interface

uses System.Classes, ObserverOrcamentoCentroCusto, uOrcamentoCentroCusto,
  Datasnap.DBClient;

type
  TObserverResumoCentroCustoPai = class(TInterfacedObject, IObserverOrcamentoCentroCusto)
  private
    FCdsUpdate: TClientDataSet;
  public
    constructor Create(oCdsUpdate: TClientDataSet);
    procedure Update(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
  end;

implementation

uses uServiceResumo, System.SysUtils, uOrcamentoCentroCustoDAO;

{ TObserverResumoCentroCustoPai }

constructor TObserverResumoCentroCustoPai.Create(oCdsUpdate: TClientDataSet);
begin
  Self.FCdsUpdate := oCdsUpdate;
end;

procedure TObserverResumoCentroCustoPai.Update(
  oOrcamentoCentroCusto: TOrcamentoCentroCusto);
var oServiceResumo: TServiceResumo;
begin
  oServiceResumo := TServiceResumo.Create();
  try
    oServiceResumo.Update(uOrcamentoCentroCusto.CENTROCUSTOPAI, oOrcamentoCentroCusto, Self.FCdsUpdate);
  finally
    FreeAndNil(oServiceResumo);
  end;
end;

end.
