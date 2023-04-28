unit udmDataBase;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Comp.UI;

type
  TdmDataBase = class(TDataModule)
    ConnectionPostgreSQL: TFDConnection;
    TransactionPostgreSQL: TFDTransaction;
    GUIxWaitCursorPostgreSQL: TFDGUIxWaitCursor;
    PhysPgDriverLinkPostgreSQL: TFDPhysPgDriverLink;
    OrcamentoCentroCusto: TFDTable;
    OrcamentoCentroCustocentro_custo: TWideStringField;
    OrcamentoCentroCustocentro_custo_pai: TWideStringField;
    OrcamentoCentroCustocentro_custo_filho: TWideStringField;
    OrcamentoCentroCustovalor: TBCDField;
    OrcamentoCentroCustoorcamento: TSmallintField;
    OrcamentoCentroCustoid: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDataBase: TdmDataBase;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
