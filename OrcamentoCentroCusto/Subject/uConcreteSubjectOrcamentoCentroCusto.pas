unit uConcreteSubjectOrcamentoCentroCusto;

interface

uses System.Classes, SubjectOrcamentoCentroCusto, ObserverOrcamentoCentroCusto, uOrcamentoCentroCusto,
  Datasnap.DBClient, System.Generics.Collections;

type
  TConcreteSubjectOrcamentoCentroCusto = class(TInterfacedObject, ISubjectOrcamentoCentroCusto)
  private
    FObservers: TList<IObserverOrcamentoCentroCusto>;
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
  Self.FObservers.Add(oObserver);
end;

constructor TConcreteSubjectOrcamentoCentroCusto.Create();
begin
  inherited;
  Self.FObservers := TList<IObserverOrcamentoCentroCusto>.Create;
end;

procedure TConcreteSubjectOrcamentoCentroCusto.DelObserver(oObserver: IObserverOrcamentoCentroCusto);
begin
  Self.FObservers.Delete(FObservers.IndexOf(oObserver));
end;

destructor TConcreteSubjectOrcamentoCentroCusto.Destroy;
begin
  FObservers.Free;
  inherited;
end;

procedure TConcreteSubjectOrcamentoCentroCusto.Notify(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
var
  Observer: IObserverOrcamentoCentroCusto;
begin
  for Observer in FObservers do
  begin
    Observer.Update(oOrcamentoCentroCusto);
  end;
end;

end.
