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
  uOrcamentoCentroCustoDAO in 'OrcamentoCentroCusto\DAO\uOrcamentoCentroCustoDAO.pas',
  uCadOrcamentoCentroCusto in 'OrcamentoCentroCusto\View\uCadOrcamentoCentroCusto.pas' {frmCadOrcamentoCentroCusto},
  udmDataBase in 'Connection\udmDataBase.pas' {dmDataBase: TDataModule},
  uConfigFile in 'Utils\uConfigFile.pas',
  uConfigOrcamentoCentroCusto in 'Utils\Model\uConfigOrcamentoCentroCusto.pas';

{$R *.res}

begin
  Application.Initialize;
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown:= True;
  {$ENDIF}
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmDataBase, dmDataBase);
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
