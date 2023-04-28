unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, Vcl.Buttons, uObserverResumoOrcamento,
  uConcreteSubjectOrcamentoCentroCusto, uObserverResumoCentroCustoPai,
  uObserverResumoCentroCustoFilho, uServiceOrcamentoCentroCusto, uOrcamentoCentroCusto;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    cdsOrcamentoCC: TClientDataSet;
    dsOrcamentoCC: TDataSource;
    grdResumoOrcamento: TDBGrid;
    cdsOrcamentoCCID: TIntegerField;
    cdsOrcamentoCCVALOR: TCurrencyField;
    cdsOrcamentoCCORCAMENTO: TSmallintField;
    grdResumoCentroCustoPai: TDBGrid;
    grdResumoCentroCustoFilho: TDBGrid;
    cdsResumoOrcamento: TClientDataSet;
    cdsResumoOrcamentoID: TSmallintField;
    cdsResumoOrcamentoORCAMENTO: TSmallintField;
    cdsResumoOrcamentoVALOR: TCurrencyField;
    dsResumoOrcamento: TDataSource;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    cdsResumoCentroCustoPai: TClientDataSet;
    dsResumoCentroCustoPai: TDataSource;
    cdsResumoCentroCustoPaiVALOR: TCurrencyField;
    cdsOrcamentoCCCENTRO_CUSTO: TStringField;
    cdsOrcamentoCCCENTRO_CUSTO_PAI: TStringField;
    cdsOrcamentoCCCENTRO_CUSTO_FILHO: TStringField;
    cdsResumoCentroCustoPaiCENTRO_CUSTO_PAI: TStringField;
    cdsResumoCentroCustoFilho: TClientDataSet;
    dsResumoCentroCustoFilho: TDataSource;
    cdsResumoCentroCustoFilhoCENTRO_CUSTO_FILHO: TStringField;
    cdsResumoCentroCustoFilhoVALOR: TCurrencyField;
    Panel3: TPanel;
    btnNovo: TSpeedButton;
    grdOrcamentoCentroCusto: TDBGrid;
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);
    procedure edtOrcamentoKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure edtCentroCustoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FObserverResumoOrcamento: TObserverResumoOrcamento;
    FObserverResumoCentroCustoPai: TObserverResumoCentroCustoPai;
    FObserverResumoCentroCustoFilho: TObserverResumoCentroCustoFilho;
    FConcreteSubjectOrcamentoCentroCusto: TConcreteSubjectOrcamentoCentroCusto;
    FServiceOrcamentoCentroCusto: TServiceOrcamentoCentroCusto;

    property ServiceOrcamentoCentroCusto: TServiceOrcamentoCentroCusto read FServiceOrcamentoCentroCusto;

    procedure InitClientDataSets;
    procedure InitObservers;
    procedure InitServiceOrcamentoCentroCusto;
    procedure CallViewCadOrcamentoCentroCusto;
    procedure LoadXMLFile;
    procedure SaveXMLFile;


    function isAllowedCurrency(const Key: Char): Boolean;
    function isAllowedInteger(const Key: Char): Boolean;
    function isAllowed(const Key: Char; const AllowedKeyList: TSysCharSet): Boolean;
  public
    { Public declarations }
  end;

const
  NONE = #0;
  BACK_SPACE = #8;
  SEMICOLON = #44;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses System.Math, uCadOrcamentoCentroCusto, uConfigFile;

{$R *.dfm}

procedure TfrmPrincipal.CallViewCadOrcamentoCentroCusto;
var
  ofrmCadOrcamentoCentroCusto: TfrmCadOrcamentoCentroCusto;
begin
  ofrmCadOrcamentoCentroCusto := TfrmCadOrcamentoCentroCusto.Create(Self);
  try
    ofrmCadOrcamentoCentroCusto.CdsOrcamentoCentroCusto := cdsOrcamentoCC;
    ofrmCadOrcamentoCentroCusto.ConcreteSubjectOrcamentoCentroCusto := Self.FConcreteSubjectOrcamentoCentroCusto;
    ofrmCadOrcamentoCentroCusto.ShowModal;
  finally
    FreeAndNil(ofrmCadOrcamentoCentroCusto);
  end;
end;

procedure TfrmPrincipal.edtCentroCustoKeyPress(Sender: TObject; var Key: Char);
begin
  if not isAllowedInteger(Key) then
    Key := NONE;
end;

procedure TfrmPrincipal.InitClientDataSets;
begin
  cdsOrcamentoCC.CreateDataSet;
  cdsResumoOrcamento.CreateDataSet;
  cdsResumoCentroCustoPai.CreateDataSet;
  cdsResumoCentroCustoFilho.CreateDataSet;
end;

procedure TfrmPrincipal.InitObservers;
begin
  Self.FObserverResumoOrcamento := TObserverResumoOrcamento.Create(cdsResumoOrcamento);
  Self.FObserverResumoCentroCustoPai := TObserverResumoCentroCustoPai.Create(cdsResumoCentroCustoPai);
  Self.FObserverResumoCentroCustoFilho := TObserverResumoCentroCustoFilho.Create(cdsResumoCentroCustoFilho);
  Self.FConcreteSubjectOrcamentoCentroCusto := TConcreteSubjectOrcamentoCentroCusto.Create;

  Self.FConcreteSubjectOrcamentoCentroCusto.AddObserver(Self.FObserverResumoOrcamento);
  Self.FConcreteSubjectOrcamentoCentroCusto.AddObserver(Self.FObserverResumoCentroCustoPai);
  Self.FConcreteSubjectOrcamentoCentroCusto.AddObserver(Self.FObserverResumoCentroCustoFilho);
end;

function TfrmPrincipal.isAllowed(const Key: Char;
  const AllowedKeyList: TSysCharSet): Boolean;
begin
  Result := CharInSet(Key, AllowedKeyList);
end;

procedure TfrmPrincipal.InitServiceOrcamentoCentroCusto;
begin
  Self.FServiceOrcamentoCentroCusto := TServiceOrcamentoCentroCusto.Create(cdsOrcamentoCC);
end;

function TfrmPrincipal.isAllowedCurrency(const Key: Char): Boolean;
begin
  Result := isAllowed(Key, ['0'..'9', BACK_SPACE,SEMICOLON]);
end;

function TfrmPrincipal.isAllowedInteger(const Key: Char): Boolean;
begin
  Result := isAllowed(Key, ['0'..'9', BACK_SPACE]);
end;

procedure TfrmPrincipal.LoadXMLFile;
begin
  if (not TConfigFile.GetInstance.IsDataBasePostgreSql) and
     (FileExists(ExtractFilePath(Application.ExeName)+'orcamentocentrocusto.xml')) then
  begin
    cdsOrcamentoCC.LoadFromFile(ExtractFilePath(Application.ExeName)+'orcamentocentrocusto.xml');
  end;
end;

procedure TfrmPrincipal.SaveXMLFile;
begin
  if (not TConfigFile.GetInstance.IsDataBasePostgreSql) then
  begin
    cdsOrcamentoCC.SaveToFile(ExtractFilePath(Application.ExeName)+'orcamentocentrocusto.xml');
  end;
end;

procedure TfrmPrincipal.edtOrcamentoKeyPress(Sender: TObject; var Key: Char);
begin
  if not isAllowedInteger(Key) then
    Key := NONE;
end;

procedure TfrmPrincipal.edtValorKeyPress(Sender: TObject; var Key: Char);
begin
  if not isAllowedCurrency(Key) then
    Key := NONE;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  Self.InitClientDataSets;
  Self.InitObservers;
  Self.InitServiceOrcamentoCentroCusto;
  Self.LoadXMLFile;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  Self.FConcreteSubjectOrcamentoCentroCusto.Free;
  Self.FServiceOrcamentoCentroCusto.Free;
  Self.SaveXMLFile;
end;

procedure TfrmPrincipal.btnNovoClick(Sender: TObject);
begin
  Self.CallViewCadOrcamentoCentroCusto;
end;

end.
