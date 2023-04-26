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
    procedure InitClientDataSets;
    procedure InitObservers;
    procedure Save;
    function InitOrcamentoCentroCusto: TOrcamentoCentroCusto;
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

uses System.Math;

{$R *.dfm}

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
  Self.FServiceOrcamentoCentroCusto := TServiceOrcamentoCentroCusto.Create(cdsOrcamentoCC);
  Self.FConcreteSubjectOrcamentoCentroCusto.AddObserver(Self.FObserverResumoOrcamento);
  Self.FConcreteSubjectOrcamentoCentroCusto.AddObserver(Self.FObserverResumoCentroCustoPai);
  Self.FConcreteSubjectOrcamentoCentroCusto.AddObserver(Self.FObserverResumoCentroCustoFilho);
end;

function TfrmPrincipal.InitOrcamentoCentroCusto: TOrcamentoCentroCusto;
var
  oOrcamentoCentroCusto: TOrcamentoCentroCusto;
begin
  oOrcamentoCentroCusto := TOrcamentoCentroCusto.Create;
  oOrcamentoCentroCusto.Orcamento := StrToIntDef(edtOrcamento.Text, System.Math.NegativeValue);
  oOrcamentoCentroCusto.CentroCustoPai := Copy(edtCentroCusto.Text, System.Math.ZeroValue, 2);
  oOrcamentoCentroCusto.CentroCustoFilho := Copy(edtCentroCusto.Text, 3, 6);
  oOrcamentoCentroCusto.CentroCusto := edtCentroCusto.Text;
  oOrcamentoCentroCusto.Valor := StrToCurrDef((edtValor.Text), System.Math.ZeroValue);
  Result := oOrcamentoCentroCusto;
end;

function TfrmPrincipal.isAllowed(const Key: Char;
  const AllowedKeyList: TSysCharSet): Boolean;
begin
  Result := CharInSet(Key, AllowedKeyList);
end;

function TfrmPrincipal.isAllowedCurrency(const Key: Char): Boolean;
begin
  Result := isAllowed(Key, ['0'..'9', BACK_SPACE,SEMICOLON]);
end;

function TfrmPrincipal.isAllowedInteger(const Key: Char): Boolean;
begin
  Result := isAllowed(Key, ['0'..'9', BACK_SPACE]);
end;

procedure TfrmPrincipal.Save;
var
  oOrcamentoCentroCusto: TOrcamentoCentroCusto;
  sMsgError: string;
begin
    oOrcamentoCentroCusto := InitOrcamentoCentroCusto;
  try
    if not ServiceOrcamentoCentroCusto.IsRequiredFieldsValid(oOrcamentoCentroCusto, sMsgError) then
    begin
      Application.MessageBox(PWideChar(sMsgError), 'Aviso', MB_ICONERROR + MB_OK);
      Exit();
    end;

    ServiceOrcamentoCentroCusto.Insert(oOrcamentoCentroCusto);
    Self.FConcreteSubjectOrcamentoCentroCusto.Notify(oOrcamentoCentroCusto);
  finally
    FreeAndNil(oOrcamentoCentroCusto);
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
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  Self.FConcreteSubjectOrcamentoCentroCusto.Free;
  Self.FServiceOrcamentoCentroCusto.Free;
end;

procedure TfrmPrincipal.btnSalvarClick(Sender: TObject);

begin
  Self.Save;
end;

end.
