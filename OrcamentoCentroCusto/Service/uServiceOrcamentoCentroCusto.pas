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
    procedure Save(oOrcamentoCentroCusto: TOrcamentoCentroCusto);
    procedure Delete(iId: SmallInt);
    procedure LoadOrcamentoCentroCustoToCdsOrcamentoCC;
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

procedure TServiceOrcamentoCentroCusto.Delete(iId: SmallInt);
begin
  Self.FOrcamentoCentroCustoDAO.Delete(iId);
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

procedure TServiceOrcamentoCentroCusto.LoadOrcamentoCentroCustoToCdsOrcamentoCC;
begin
  Self.FOrcamentoCentroCustoDAO.LoadOrcamentoCentroCustoToCdsOrcamentoCC;
end;

function TServiceOrcamentoCentroCusto.IsRequiredFieldsValid(
  oOrcamentoCentroCusto: TOrcamentoCentroCusto; var sMsgError: String): Boolean;
const
  MSG_ORCAMENTO_INVALIDO = 'Or�amento informado n�o � valido ou est� vazio.';
  MSG_CENTRO_CUSTO_PAI_INVALIDO = 'Centro de custo pai informado n�o � valido ou est� vazio.';
  MSG_CENTRO_CUSTO_FILHO_INVALIDO = 'Centro de custo filho informado n�o � valido ou est� vazio.';
  MSG_VALOR_INVALIDO = 'Valor informado n�o � valido ou est� vazio.';
begin
  sMsgError := EmptyStr;

  if not Self.IsOrcamentoValid(oOrcamentoCentroCusto.Orcamento) then
    ConcatMessage(sMsgError, MSG_ORCAMENTO_INVALIDO);

  if not Self.IsCentroCustoPaiValid(oOrcamentoCentroCusto.CentroCustoPai) then
    ConcatMessage(sMsgError, MSG_CENTRO_CUSTO_PAI_INVALIDO);

  if not Self.IsCentroCustoFilhoValid(oOrcamentoCentroCusto.CentroCustoFilho) then
    ConcatMessage(sMsgError, MSG_CENTRO_CUSTO_FILHO_INVALIDO);

  if not Self.IsValorValid(oOrcamentoCentroCusto.Valor) then
    ConcatMessage(sMsgError, MSG_VALOR_INVALIDO);

  Result := Trim(sMsgError) = EmptyStr;
end;

procedure TServiceOrcamentoCentroCusto.Save(
  oOrcamentoCentroCusto: TOrcamentoCentroCusto);
begin
  Self.FOrcamentoCentroCustoDAO.Save(oOrcamentoCentroCusto);
end;

procedure TServiceOrcamentoCentroCusto.ConcatMessage(var sMsgError: string;
  sNewMsg: String);
begin
  sMsgError := sMsgError + IfThen((Trim(sMsgError) <> EmptyStr), sLineBreak, EmptyStr) + sNewMsg;
end;

end.
