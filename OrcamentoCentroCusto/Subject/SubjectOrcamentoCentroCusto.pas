unit SubjectOrcamentoCentroCusto;

interface

uses ObserverOrcamentoCentroCusto, uOrcamentoCentroCusto;

type
  ISubjectOrcamentoCentroCusto = interface
    procedure AddObserver(oObserver: IObserverOrcamentoCentroCusto);
    procedure DelObserver(oObserver: IObserverOrcamentoCentroCusto);
    procedure Notify(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
  end;

implementation

end.
