unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient, Vcl.Buttons, uObserverResumoOrcamento,
  uConcreteSubjectOrcamentoCentroCusto, uObserverResumoCentroCustoPai,
  uObserverResumoCentroCustoFilho, uServiceOrcamentoCentroCusto, uOrcamentoCentroCusto,
  System.Generics.Collections;

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
    btnAlterar: TSpeedButton;
    btnExcluir: TSpeedButton;
    procedure btnNovoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);
    procedure edtOrcamentoKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure edtCentroCustoKeyPress(Sender: TObject; var Key: Char);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
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
    procedure CallViewCadOrcamentoCentroCusto(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
    procedure LoadXMLFile;
    procedure SaveXMLFile;
    procedure LoadOrcamentoCentroCusto(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
    procedure InsertOrcamentoCentroCusto;
    procedure UpdateOrcamentoCentroCusto;
    procedure DeleteOrcamentoCentroCusto;
    procedure DisableControlsCds;
    procedure EnableControlsCds;
    procedure LoadResumos;
    procedure LoadOrcamentoCentroCustoToCdsOrcamentoCC;

    function isAllowedCurrency(const Key: Char): Boolean;
    function isAllowedInteger(const Key: Char): Boolean;
    function isAllowed(const Key: Char; const AllowedKeyList: TSysCharSet): Boolean;
    function InitOrcamentoCentroCusto: TOrcamentoCentroCusto;
    function HaveData: Boolean;
    function GetOrcamentoCentroCustoList: TObjectList<TOrcamentoCentroCusto>;
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

procedure TfrmPrincipal.CallViewCadOrcamentoCentroCusto(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
var
  ofrmCadOrcamentoCentroCusto: TfrmCadOrcamentoCentroCusto;
begin
  ofrmCadOrcamentoCentroCusto := TfrmCadOrcamentoCentroCusto.Create(Self);
  try
    ofrmCadOrcamentoCentroCusto.CdsOrcamentoCentroCusto := cdsOrcamentoCC;
    ofrmCadOrcamentoCentroCusto.ConcreteSubjectOrcamentoCentroCusto := Self.FConcreteSubjectOrcamentoCentroCusto;
    ofrmCadOrcamentoCentroCusto.OrcamentoCentroCusto := oOrcamentoCentroCusto;
    ofrmCadOrcamentoCentroCusto.ShowModal;
  finally
    FreeAndNil(ofrmCadOrcamentoCentroCusto);
  end;
end;

procedure TfrmPrincipal.DeleteOrcamentoCentroCusto;
var
  oOrcamentoCentroCusto: TOrcamentoCentroCusto;
begin
  if not self.HaveData then
    Exit;

  oOrcamentoCentroCusto := Self.InitOrcamentoCentroCusto;
  try
    Self.DisableControlsCds;
    Self.LoadOrcamentoCentroCusto(oOrcamentoCentroCusto);
    oOrcamentoCentroCusto.Diferenca := oOrcamentoCentroCusto.Valor * System.Math.NegativeValue;
    Self.FConcreteSubjectOrcamentoCentroCusto.Notify(oOrcamentoCentroCusto);
    Self.ServiceOrcamentoCentroCusto.Delete(Self.cdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.ID).AsInteger);
    Self.EnableControlsCds;
  finally
    FreeAndNil(oOrcamentoCentroCusto);
  end;
end;

procedure TfrmPrincipal.DisableControlsCds;
begin
  cdsOrcamentoCC.DisableControls;
  cdsResumoOrcamento.DisableControls;
  cdsResumoCentroCustoPai.DisableControls;
  cdsResumoCentroCustoFilho.DisableControls;
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

function TfrmPrincipal.InitOrcamentoCentroCusto: TOrcamentoCentroCusto;
begin
  Result := TOrcamentoCentroCusto.Create;;
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

procedure TfrmPrincipal.InsertOrcamentoCentroCusto;
begin
  Self.DisableControlsCds;
  Self.CallViewCadOrcamentoCentroCusto(Self.InitOrcamentoCentroCusto);
  Self.EnableControlsCds;
end;

function TfrmPrincipal.isAllowedCurrency(const Key: Char): Boolean;
begin
  Result := isAllowed(Key, ['0'..'9', BACK_SPACE,SEMICOLON]);
end;

function TfrmPrincipal.isAllowedInteger(const Key: Char): Boolean;
begin
  Result := isAllowed(Key, ['0'..'9', BACK_SPACE]);
end;

procedure TfrmPrincipal.LoadOrcamentoCentroCusto(
  oOrcamentoCentroCusto: TOrcamentoCentroCusto);
begin
  oOrcamentoCentroCusto.Id := cdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.ID).AsInteger;
  oOrcamentoCentroCusto.Orcamento := cdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.ORCAMENTO).AsInteger;
  oOrcamentoCentroCusto.CentroCustoPai := cdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.CENTROCUSTOPAI).AsString;
  oOrcamentoCentroCusto.CentroCustoFilho := cdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.CENTROCUSTOFILHO).AsString;
  oOrcamentoCentroCusto.CentroCusto := cdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.CENTROCUSTO).AsString;
  oOrcamentoCentroCusto.Valor := cdsOrcamentoCC.FieldByName(uOrcamentoCentroCusto.VALOR).AsCurrency;
end;

procedure TfrmPrincipal.LoadOrcamentoCentroCustoToCdsOrcamentoCC;
begin
  if TConfigFile.GetInstance.IsDataBasePostgreSql then
  begin
    Self.DisableControlsCds;
    Self.ServiceOrcamentoCentroCusto.LoadOrcamentoCentroCustoToCdsOrcamentoCC;
    Self.LoadResumos;
    Self.EnableControlsCds;
  end;
end;

procedure TfrmPrincipal.LoadResumos;
var
  oOrcamentoCentroCusto: TOrcamentoCentroCusto;
  oOrcamentoCentroCustoList: TObjectList<TOrcamentoCentroCusto>;
begin
  oOrcamentoCentroCustoList := Self.GetOrcamentoCentroCustoList;
  try
    for oOrcamentoCentroCusto in oOrcamentoCentroCustoList do
      Self.FConcreteSubjectOrcamentoCentroCusto.Notify(oOrcamentoCentroCusto);
  finally
    FreeAndNil(oOrcamentoCentroCustoList);
  end;
end;

function TfrmPrincipal.GetOrcamentoCentroCustoList: TObjectList<TOrcamentoCentroCusto>;
var
  oOrcamentoCentroCusto: TOrcamentoCentroCusto;
  oOrcamentoCentroCustoList: TObjectList<TOrcamentoCentroCusto>;
begin
  oOrcamentoCentroCustoList := TObjectList<TOrcamentoCentroCusto>.Create;
  cdsOrcamentoCC.First;
  while not cdsOrcamentoCC.Eof do
  begin
    oOrcamentoCentroCusto := InitOrcamentoCentroCusto;
    Self.LoadOrcamentoCentroCusto(oOrcamentoCentroCusto);
    oOrcamentoCentroCustoList.Add(oOrcamentoCentroCusto);
    cdsOrcamentoCC.Next;
  end;
  Result := oOrcamentoCentroCustoList;
end;

procedure TfrmPrincipal.LoadXMLFile;
begin
  if (not TConfigFile.GetInstance.IsDataBasePostgreSql) and
     (FileExists(ExtractFilePath(Application.ExeName)+'orcamentocentrocusto.xml')) then
  begin
    Self.DisableControlsCds;
    cdsOrcamentoCC.LoadFromFile(ExtractFilePath(Application.ExeName)+'orcamentocentrocusto.xml');
    Self.LoadResumos;
    Self.EnableControlsCds;
  end;
end;

procedure TfrmPrincipal.SaveXMLFile;
begin
  if (not TConfigFile.GetInstance.IsDataBasePostgreSql) then
  begin
    cdsOrcamentoCC.SaveToFile(ExtractFilePath(Application.ExeName)+'orcamentocentrocusto.xml');
  end;
end;

procedure TfrmPrincipal.UpdateOrcamentoCentroCusto;
var
  oOrcamentoCentroCusto: TOrcamentoCentroCusto;
begin
  if not self.HaveData then
    Exit;
  Self.DisableControlsCds;
  oOrcamentoCentroCusto := Self.InitOrcamentoCentroCusto;
  Self.LoadOrcamentoCentroCusto(oOrcamentoCentroCusto);
  Self.CallViewCadOrcamentoCentroCusto(oOrcamentoCentroCusto);
  Self.EnableControlsCds;
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

procedure TfrmPrincipal.EnableControlsCds;
begin
  cdsOrcamentoCC.EnableControls;
  cdsResumoOrcamento.EnableControls;
  cdsResumoCentroCustoPai.EnableControls;
  cdsResumoCentroCustoFilho.EnableControls;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  Self.InitClientDataSets;
  Self.InitObservers;
  Self.InitServiceOrcamentoCentroCusto;
  Self.LoadXMLFile;
  Self.LoadOrcamentoCentroCustoToCdsOrcamentoCC;
end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
  Self.FConcreteSubjectOrcamentoCentroCusto.Free;
  Self.FServiceOrcamentoCentroCusto.Free;
  Self.SaveXMLFile;
end;

function TfrmPrincipal.HaveData: Boolean;
begin
  Result := cdsOrcamentoCC.RecordCount > System.Math.ZeroValue;
end;

procedure TfrmPrincipal.btnAlterarClick(Sender: TObject);
begin
  Self.UpdateOrcamentoCentroCusto;
end;

procedure TfrmPrincipal.btnExcluirClick(Sender: TObject);
begin
  Self.DeleteOrcamentoCentroCusto;
end;

procedure TfrmPrincipal.btnNovoClick(Sender: TObject);
begin
  Self.InsertOrcamentoCentroCusto;
end;

end.
