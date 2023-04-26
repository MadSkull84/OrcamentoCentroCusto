unit uServiceOrcamentoCentroCusto;

interface

uses System.Classes, Datasnap.DBClient, uOrcamentoCentroCusto,
  uOrcamentoCentroCustoDAO;

type
  TServiceOrcamentoCentroCusto = class
  private
    FCdsOrcamentoCC: TClientDataSet;
    FOrcamentoCentroCustoDAO: TOrcamentoCentroCustoDAO;
    function IsOrcamentoValid(iOrcamento: SmallInt): Boolean;
    function IsCentroCustoPaiValid(sCentroCustoPai: String): Boolean;
    function IsCentroCustoFilhoValid(sCentroCustoFilho: String): Boolean;
    function IsValorValid(fValor: Currency): Boolean;
    procedure ConcatMessage(var sMsgError: string; sNewMsg: String);
  public
    constructor Create(oCdsOrcamentoCC: TClientDataSet);
    destructor Destroy; override;

    function IsRequiredFieldsValid(oOrcamentoCentroCusto: TOrcamentoCentroCusto;
      var sMsgError: String): Boolean;
    procedure Insert(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
  end;

implementation

uses System.SysUtils, System.Math, System.StrUtils;

{ TServiceOrcamentoCentroCusto }

constructor TServiceOrcamentoCentroCusto.Create(
  oCdsOrcamentoCC: TClientDataSet);
begin
  Self.FCdsOrcamentoCC := oCdsOrcamentoCC;
  FOrcamentoCentroCustoDAO := TOrcamentoCentroCustoDAO.Create(Self.FCdsOrcamentoCC);
end;

destructor TServiceOrcamentoCentroCusto.Destroy;
begin
  Self.FOrcamentoCentroCustoDAO.Free;
  inherited;
end;

function TServiceOrcamentoCentroCusto.IsCentroCustoFilhoValid(
  sCentroCustoFilho: String): Boolean;
var
  iFilho: SmallInt;
begin
  iFilho := StrToIntDef(sCentroCustoFilho, System.Math.NegativeValue);
  Result := (Length(sCentroCustoFilho) = 4) and
    InRange(iFilho, System.Math.ZeroValue, 9999);
end;

function TServiceOrcamentoCentroCusto.IsCentroCustoPaiValid(
  sCentroCustoPai: String): Boolean;
var
  iPai: SmallInt;
begin
  iPai := StrToIntDef(sCentroCustoPai, System.Math.NegativeValue);
  Result := (Length(sCentroCustoPai) = 2) and
    InRange(iPai, System.Math.ZeroValue, 99);
end;

function TServiceOrcamentoCentroCusto.IsOrcamentoValid(
  iOrcamento: SmallInt): Boolean;
begin
  Result := InRange(iOrcamento, System.Math.ZeroValue, 999999);
end;

function TServiceOrcamentoCentroCusto.IsValorValid(fValor: Currency): Boolean;
begin
  Result := fValor > System.Math.ZeroValue;
end;

function TServiceOrcamentoCentroCusto.IsRequiredFieldsValid(
  oOrcamentoCentroCusto: TOrcamentoCentroCusto; var sMsgError: String): Boolean;
begin
  sMsgError := EmptyStr;

  if not Self.IsOrcamentoValid(oOrcamentoCentroCusto.Orcamento) then
    ConcatMessage(sMsgError, 'Orçamento informado não é valido ou está vazio.');

  if not Self.IsCentroCustoPaiValid(oOrcamentoCentroCusto.CentroCustoPai) then
    ConcatMessage(sMsgError, 'Centro de custo pai informado não é valido ou está vazio.');

  if not Self.IsCentroCustoFilhoValid(oOrcamentoCentroCusto.CentroCustoFilho) then
    ConcatMessage(sMsgError, 'Centro de custo filho informado não é valido ou está vazio.');

  if not Self.IsValorValid(oOrcamentoCentroCusto.Valor) then
    ConcatMessage(sMsgError, 'Valor informado não é valido ou está vazio.');

  Result := Trim(sMsgError) = EmptyStr;
end;

procedure TServiceOrcamentoCentroCusto.Insert(
  oOrcamentoCentroCusto: TOrcamentoCentroCusto);
begin
  Self.FOrcamentoCentroCustoDAO.Insert(oOrcamentoCentroCusto);
end;

procedure TServiceOrcamentoCentroCusto.ConcatMessage(var sMsgError: string;
  sNewMsg: String);
begin
  sMsgError := sMsgError + IfThen((Trim(sMsgError) <> EmptyStr), sLineBreak, EmptyStr) + sNewMsg;
end;

end.
