unit uConcreteSubjectOrcamentoCentroCusto;

interface

uses System.Classes, SubjectOrcamentoCentroCusto, ObserverOrcamentoCentroCusto, uOrcamentoCentroCusto,
  Datasnap.DBClient, System.Generics.Collections;

type
  TConcreteSubjectOrcamentoCentroCusto = class(TInterfacedObject, ISubjectOrcamentoCentroCusto)
  private
    FObserverOrcamentoCentroCustoList: TList<IObserverOrcamentoCentroCusto>;
  public
    constructor Create();
    destructor Destroy; override;

    procedure AddObserver(oObserver: IObserverOrcamentoCentroCusto);
    procedure DelObserver(oObserver: IObserverOrcamentoCentroCusto);
    procedure Notify(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
  end;

implementation

uses uServiceOrcamentoCentroCusto, System.SysUtils;

{ TConcreteSubject }

procedure TConcreteSubjectOrcamentoCentroCusto.AddObserver(oObserver: IObserverOrcamentoCentroCusto);
begin
  Self.FObserverOrcamentoCentroCustoList.Add(oObserver);
end;

constructor TConcreteSubjectOrcamentoCentroCusto.Create();
begin
  inherited;
  Self.FObserverOrcamentoCentroCustoList := TList<IObserverOrcamentoCentroCusto>.Create;
end;

procedure TConcreteSubjectOrcamentoCentroCusto.DelObserver(oObserver: IObserverOrcamentoCentroCusto);
begin
  Self.FObserverOrcamentoCentroCustoList.Delete(FObserverOrcamentoCentroCustoList.IndexOf(oObserver));
end;

destructor TConcreteSubjectOrcamentoCentroCusto.Destroy;
begin
  FObserverOrcamentoCentroCustoList.Free;
  inherited;
end;

procedure TConcreteSubjectOrcamentoCentroCusto.Notify(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
var
  ObserverOrcamentoCentroCusto: IObserverOrcamentoCentroCusto;
begin
  for ObserverOrcamentoCentroCusto in FObserverOrcamentoCentroCustoList do
  begin
    ObserverOrcamentoCentroCusto.Update(oOrcamentoCentroCusto);
  end;
end;

end.
