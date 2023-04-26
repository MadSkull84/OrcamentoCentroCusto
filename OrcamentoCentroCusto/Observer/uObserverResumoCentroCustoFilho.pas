unit uObserverResumoCentroCustoFilho;

interface

uses System.Classes, ObserverOrcamentoCentroCusto, uOrcamentoCentroCusto,
  Datasnap.DBClient;

type
  TObserverResumoCentroCustoFilho = class(TInterfacedObject, IObserverOrcamentoCentroCusto)
  private
    FCdsUpdate: TClientDataSet;
  public
    constructor Create(oCdsUpdate: TClientDataSet);
    procedure Update(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
  end;

implementation

uses uServiceResumo, System.SysUtils, uOrcamentoCentroCustoDAO;

{ TObserverResumoCentroCustoFilho }

constructor TObserverResumoCentroCustoFilho.Create(oCdsUpdate: TClientDataSet);
begin
  Self.FCdsUpdate := oCdsUpdate;
end;

procedure TObserverResumoCentroCustoFilho.Update(
  oOrcamentoCentroCusto: TOrcamentoCentroCusto);
var oServiceResumo: TServiceResumo;
begin
  oServiceResumo := TServiceResumo.Create();
  try
    oServiceResumo.Update(uOrcamentoCentroCustoDAO.CENTROCUSTOFILHO, oOrcamentoCentroCusto, Self.FCdsUpdate);
  finally
    FreeAndNil(oServiceResumo);
  end;
end;

end.
