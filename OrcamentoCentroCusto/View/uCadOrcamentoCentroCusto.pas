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

    property ServiceOrcamentoCentroCusto: TServiceOrcamentoCentroCusto read FServiceOrcamentoCentroCusto;

    function IsAllowedCurrency(const Key: Char): Boolean;
    function IsAllowedInteger(const Key: Char): Boolean;
    function IsAllowed(const Key: Char; const AllowedKeyList: TSysCharSet): Boolean;
    function InitOrcamentoCentroCusto: TOrcamentoCentroCusto;

    procedure InitServiceOrcamentoCentroCusto;
    procedure Save;
  public
    { Public declarations }
    property ConcreteSubjectOrcamentoCentroCusto: TConcreteSubjectOrcamentoCentroCusto read FConcreteSubjectOrcamentoCentroCusto write FConcreteSubjectOrcamentoCentroCusto;
    property CdsOrcamentoCentroCusto: TClientDataSet read FCdsOrcamentoCentroCusto write FCdsOrcamentoCentroCusto;
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
    ConcreteSubjectOrcamentoCentroCusto.Notify(oOrcamentoCentroCusto);
  finally
    FreeAndNil(oOrcamentoCentroCusto);
  end;
end;

function TfrmCadOrcamentoCentroCusto.InitOrcamentoCentroCusto: TOrcamentoCentroCusto;
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
  Self.FServiceOrcamentoCentroCusto.Free;
end;

procedure TfrmCadOrcamentoCentroCusto.FormShow(Sender: TObject);
begin
  Self.InitServiceOrcamentoCentroCusto;
end;

end.
