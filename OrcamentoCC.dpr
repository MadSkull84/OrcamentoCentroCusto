program OrcamentoCC;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  ObserverOrcamentoCentroCusto in 'OrcamentoCentroCusto\Observer\ObserverOrcamentoCentroCusto.pas',
  uOrcamentoCentroCusto in 'OrcamentoCentroCusto\Model\uOrcamentoCentroCusto.pas',
  uObserverResumoOrcamento in 'OrcamentoCentroCusto\Observer\uObserverResumoOrcamento.pas',
  SubjectOrcamentoCentroCusto in 'OrcamentoCentroCusto\Subject\SubjectOrcamentoCentroCusto.pas',
  uConcreteSubjectOrcamentoCentroCusto in 'OrcamentoCentroCusto\Subject\uConcreteSubjectOrcamentoCentroCusto.pas',
  uObserverResumoCentroCustoPai in 'OrcamentoCentroCusto\Observer\uObserverResumoCentroCustoPai.pas',
  uServiceResumo in 'OrcamentoCentroCusto\Service\uServiceResumo.pas',
  uObserverResumoCentroCustoFilho in 'OrcamentoCentroCusto\Observer\uObserverResumoCentroCustoFilho.pas',
  uServiceOrcamentoCentroCusto in 'OrcamentoCentroCusto\Service\uServiceOrcamentoCentroCusto.pas',
  uOrcamentoCentroCustoDAO in 'OrcamentoCentroCusto\DAO\uOrcamentoCentroCustoDAO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.