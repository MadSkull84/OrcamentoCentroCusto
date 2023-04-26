unit uServiceResumo;

interface

uses System.Classes, Datasnap.DBClient, uOrcamentoCentroCusto;

type
  TServiceResumo = class
  private
    function getKeyValue(sKey: String;
      oOrcamentoCentroCusto: TOrcamentoCentroCusto): String;
  public
    procedure Update(sKey: String; oOrcamentoCentroCusto: TOrcamentoCentroCusto;
      oCdsUpdate: TClientDataSet);
  end;

implementation

uses Data.DB, System.SysUtils, uOrcamentoCentroCustoDAO;

{ TServiceResumo }

function TServiceResumo.getKeyValue(sKey: String;
  oOrcamentoCentroCusto: TOrcamentoCentroCusto): String;
var sRetorno: String;
begin
  if CompareStr(sKey, uOrcamentoCentroCustoDAO.ORCAMENTO) = 0 then
    sRetorno := oOrcamentoCentroCusto.Orcamento.ToString
  else if CompareStr(sKey, uOrcamentoCentroCustoDAO.CENTROCUSTOPAI) = 0 then
    sRetorno := oOrcamentoCentroCusto.CentroCustoPai
  else
    sRetorno := oOrcamentoCentroCusto.CentroCustoFilho;
  Result := sRetorno;
end;

procedure TServiceResumo.Update(sKey: String;
  oOrcamentoCentroCusto: TOrcamentoCentroCusto; oCdsUpdate: TClientDataSet);
var
  sValue: String;
begin
  sValue := getKeyValue(sKey, oOrcamentoCentroCusto);
  if oCdsUpdate.Locate(sKey, sValue, [loCaseInsensitive]) then
  begin
    oCdsUpdate.Edit;
  end
  else
  begin
    oCdsUpdate.Insert;
    oCdsUpdate.FieldByName(sKey).AsString := sValue;
  end;
  oCdsUpdate.FieldByName(uOrcamentoCentroCustoDAO.VALOR).AsCurrency :=
    oCdsUpdate.FieldByName(uOrcamentoCentroCustoDAO.VALOR).AsCurrency + oOrcamentoCentroCusto.Valor ;
  oCdsUpdate.Post;
end;

end.
