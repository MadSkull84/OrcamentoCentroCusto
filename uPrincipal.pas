unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, Vcl.Buttons, uObserverResumoOrcamento,
  uConcreteSubjectOrcamentoCentroCusto, uObserverResumoCentroCustoPai,
  uObserverResumoCentroCustoFilho, uServiceOrcamentoCentroCusto;

type
  TfrmPrincipal = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    edtValor: TEdit;
    btnSalvar: TSpeedButton;
    cdsOrcamentoCC: TClientDataSet;
    dsOrcamentoCC: TDataSource;
    grdResumoOrcamento: TDBGrid;
    cdsOrcamentoCCID: TIntegerField;
    cdsOrcamentoCCVALOR: TCurrencyField;
    lblCentroCusto: TLabel;
    lblValor: TLabel;
    lblOrcamento: TLabel;
    edtOrcamento: TEdit;
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
    edtCentroCusto: TEdit;
    procedure btnSalvarClick(Sender: TObject);
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
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses uOrcamentoCentroCusto;

{$R *.dfm}

procedure TfrmPrincipal.edtCentroCustoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (CharInSet(Key, ['0'..'9', #8])) then
    Key := #0;
end;

procedure TfrmPrincipal.edtOrcamentoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (CharInSet(Key, ['0'..'9', #8])) then
    Key := #0;
end;

procedure TfrmPrincipal.edtValorKeyPress(Sender: TObject; var Key: Char);
begin
  if not (CharInSet(Key, ['0'..'9', #8, #44])) then
    Key := #0;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  cdsOrcamentoCC.CreateDataSet;
  cdsResumoOrcamento.CreateDataSet;
  cdsResumoCentroCustoPai.CreateDataSet;
  cdsResumoCentroCustoFilho.CreateDataSet;

  Self.FObserverResumoOrcamento :=
    TObserverResumoOrcamento.Create(cdsResumoOrcamento);
  Self.FObserverResumoCentroCustoPai :=
    TObserverResumoCentroCustoPai.Create(cdsResumoCentroCustoPai);
  Self.FObserverResumoCentroCustoFilho :=
    TObserverResumoCentroCustoFilho.Create(cdsResumoCentroCustoFilho);
  Self.FConcreteSubjectOrcamentoCentroCusto := TConcreteSubjectOrcamentoCentroCusto.Create;
  Self.FServiceOrcamentoCentroCusto := TServiceOrcamentoCentroCusto.Create(cdsOrcamentoCC);

  Self.FConcreteSubjectOrcamentoCentroCusto.AddObserver(Self.FObserverResumoOrcamento);
  Self.FConcreteSubjectOrcamentoCentroCusto.AddObserver(Self.FObserverResumoCentroCustoPai);
  Self.FConcreteSubjectOrcamentoCentroCusto.AddObserver(Self.FObserverResumoCentroCustoFilho);
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  Self.FConcreteSubjectOrcamentoCentroCusto.Free;
  Self.FServiceOrcamentoCentroCusto.Free;
end;

procedure TfrmPrincipal.btnSalvarClick(Sender: TObject);
var
  oOrcamentoCentroCusto: TOrcamentoCentroCusto;
  sMsgError: String;
begin
  oOrcamentoCentroCusto := TOrcamentoCentroCusto.Create;
  try
    oOrcamentoCentroCusto.Orcamento := StrToIntDef(edtOrcamento.Text, -1);
    oOrcamentoCentroCusto.CentroCustoPai := Copy(edtCentroCusto.Text, 0, 2);
    oOrcamentoCentroCusto.CentroCustoFilho := Copy(edtCentroCusto.Text, 3, 6);
    oOrcamentoCentroCusto.CentroCusto := edtCentroCusto.Text;
    oOrcamentoCentroCusto.Valor := StrToCurrDef((edtValor.Text), 0);
    if not ServiceOrcamentoCentroCusto.IsRequiredFieldsValid(oOrcamentoCentroCusto, sMsgError) then
      Application.MessageBox(PWideChar(sMsgError), 'Aviso', MB_ICONERROR + MB_OK)
    else
    begin
      ServiceOrcamentoCentroCusto.Insert(oOrcamentoCentroCusto);
      Self.FConcreteSubjectOrcamentoCentroCusto.Notify(oOrcamentoCentroCusto);
    end;
  finally
    FreeAndNil(oOrcamentoCentroCusto);
  end;
end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.
