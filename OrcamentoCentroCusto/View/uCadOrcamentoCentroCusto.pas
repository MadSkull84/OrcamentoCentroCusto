unit uCadOrcamentoCentroCusto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls,
  uOrcamentoCentroCusto, uServiceOrcamentoCentroCusto, uConcreteSubjectOrcamentoCentroCusto,
  Datasnap.DBClient;

type
  TfrmCadOrcamentoCentroCusto = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    lblOrcamento: TLabel;
    edtValor: TEdit;
    edtCentroCusto: TEdit;
    lblCentroCusto: TLabel;
    lblValor: TLabel;
    edtOrcamento: TEdit;
    btnSalvar: TSpeedButton;
    btnCancelar: TSpeedButton;
    procedure edtOrcamentoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCentroCustoKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
    FServiceOrcamentoCentroCusto: TServiceOrcamentoCentroCusto;
    FConcreteSubjectOrcamentoCentroCusto: TConcreteSubjectOrcamentoCentroCusto;
    FCdsOrcamentoCentroCusto: TClientDataSet;
    FOrcamentoCentroCusto: TOrcamentoCentroCusto;

    property ServiceOrcamentoCentroCusto: TServiceOrcamentoCentroCusto read FServiceOrcamentoCentroCusto;

    function IsAllowedCurrency(const Key: Char): Boolean;
    function IsAllowedInteger(const Key: Char): Boolean;
    function IsAllowed(const Key: Char; const AllowedKeyList: TSysCharSet): Boolean;

    procedure SetOrcamentoCentroCusto;
    procedure SetFields;
    procedure InitServiceOrcamentoCentroCusto;
    procedure Save;
  public
    { Public declarations }
    property ConcreteSubjectOrcamentoCentroCusto: TConcreteSubjectOrcamentoCentroCusto read FConcreteSubjectOrcamentoCentroCusto write FConcreteSubjectOrcamentoCentroCusto;
    property CdsOrcamentoCentroCusto: TClientDataSet read FCdsOrcamentoCentroCusto write FCdsOrcamentoCentroCusto;
    property OrcamentoCentroCusto: TOrcamentoCentroCusto read FOrcamentoCentroCusto write FOrcamentoCentroCusto;
  end;

const
  NONE = #0;
  BACK_SPACE = #8;
  SEMICOLON = #44;

var
  frmCadOrcamentoCentroCusto: TfrmCadOrcamentoCentroCusto;

implementation

uses System.Math;

{$R *.dfm}

function TfrmCadOrcamentoCentroCusto.IsAllowed(const Key: Char;
  const AllowedKeyList: TSysCharSet): Boolean;
begin
  Result := CharInSet(Key, AllowedKeyList);
end;

function TfrmCadOrcamentoCentroCusto.IsAllowedCurrency(const Key: Char): Boolean;
begin
  Result := IsAllowed(Key, ['0'..'9', BACK_SPACE,SEMICOLON]);
end;

function TfrmCadOrcamentoCentroCusto.IsAllowedInteger(const Key: Char): Boolean;
begin
  Result := IsAllowed(Key, ['0'..'9', BACK_SPACE]);
end;

procedure TfrmCadOrcamentoCentroCusto.Save;
const
  TITULO_ERRO = 'Erro';
  TITULO_INFORMACAO = 'Informação';
  MSG_SUCESSO = 'Registro salvo com sucesso.';
var
  sMsgError: string;
begin
  Self.SetOrcamentoCentroCusto;
  if not ServiceOrcamentoCentroCusto.IsRequiredFieldsValid(Self.OrcamentoCentroCusto, sMsgError) then
  begin
    Application.MessageBox(PWideChar(sMsgError), TITULO_ERRO, MB_ICONERROR + MB_OK);
    Exit;
  end;

  ServiceOrcamentoCentroCusto.Save(Self.OrcamentoCentroCusto);
  ConcreteSubjectOrcamentoCentroCusto.Notify(Self.OrcamentoCentroCusto);
  Application.MessageBox(MSG_SUCESSO, TITULO_INFORMACAO, MB_ICONINFORMATION + MB_OK);
end;

procedure TfrmCadOrcamentoCentroCusto.SetFields;
begin
  edtOrcamento.Text := OrcamentoCentroCusto.Orcamento.ToString;
  edtCentroCusto.Text := OrcamentoCentroCusto.CentroCusto;
  edtValor.Text := CurrToStr(OrcamentoCentroCusto.Valor);
end;

procedure TfrmCadOrcamentoCentroCusto.SetOrcamentoCentroCusto;
var
  cValor: Currency;
begin
  OrcamentoCentroCusto.Orcamento := StrToIntDef(edtOrcamento.Text, System.Math.NegativeValue);
  OrcamentoCentroCusto.CentroCustoPai := Copy(edtCentroCusto.Text, System.Math.ZeroValue, 2);
  OrcamentoCentroCusto.CentroCustoFilho := Copy(edtCentroCusto.Text, 3, 6);
  OrcamentoCentroCusto.CentroCusto := edtCentroCusto.Text;
  cValor := StrToCurrDef((edtValor.Text), System.Math.ZeroValue);
  if OrcamentoCentroCusto.Id > System.Math.ZeroValue then
    OrcamentoCentroCusto.Diferenca := (OrcamentoCentroCusto.Valor - cValor) * System.Math.NegativeValue;
  OrcamentoCentroCusto.Valor := cValor;
end;

procedure TfrmCadOrcamentoCentroCusto.InitServiceOrcamentoCentroCusto;
begin
  Self.FServiceOrcamentoCentroCusto := TServiceOrcamentoCentroCusto.Create(CdsOrcamentoCentroCusto);
end;

procedure TfrmCadOrcamentoCentroCusto.btnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadOrcamentoCentroCusto.btnSalvarClick(Sender: TObject);
begin
  Self.Save;
  Close;
end;

procedure TfrmCadOrcamentoCentroCusto.edtCentroCustoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not Self.IsAllowedInteger(Key) then
    Key := NONE;
end;

procedure TfrmCadOrcamentoCentroCusto.edtOrcamentoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not Self.IsAllowedInteger(Key) then
    Key := NONE;
end;

procedure TfrmCadOrcamentoCentroCusto.edtValorKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not Self.IsAllowedCurrency(Key) then
    Key := NONE;
end;

procedure TfrmCadOrcamentoCentroCusto.FormDestroy(Sender: TObject);
begin
  Self.FOrcamentoCentroCusto.Free;
  Self.FServiceOrcamentoCentroCusto.Free;
end;

procedure TfrmCadOrcamentoCentroCusto.FormShow(Sender: TObject);
begin
  Self.InitServiceOrcamentoCentroCusto;
  if Self.OrcamentoCentroCusto.Id > System.Math.ZeroValue then
    Self.SetFields;
end;

end.
