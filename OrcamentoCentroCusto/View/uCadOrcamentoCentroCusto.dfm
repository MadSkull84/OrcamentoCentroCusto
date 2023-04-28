object frmCadOrcamentoCentroCusto: TfrmCadOrcamentoCentroCusto
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro Or'#231'amento Centro Custo'
  ClientHeight = 113
  ClientWidth = 324
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 324
    Height = 74
    Align = alClient
    TabOrder = 0
    object lblOrcamento: TLabel
      Left = 16
      Top = 16
      Width = 53
      Height = 13
      Caption = 'Or'#231'amento'
    end
    object lblCentroCusto: TLabel
      Left = 112
      Top = 16
      Width = 79
      Height = 13
      Caption = 'Centro de Custo'
    end
    object lblValor: TLabel
      Left = 216
      Top = 16
      Width = 24
      Height = 13
      Caption = 'Valor'
    end
    object edtValor: TEdit
      Left = 216
      Top = 32
      Width = 89
      Height = 21
      TabOrder = 2
      OnKeyPress = edtValorKeyPress
    end
    object edtCentroCusto: TEdit
      Left = 112
      Top = 32
      Width = 79
      Height = 21
      MaxLength = 6
      TabOrder = 1
      OnKeyPress = edtCentroCustoKeyPress
    end
    object edtOrcamento: TEdit
      Left = 16
      Top = 32
      Width = 73
      Height = 21
      MaxLength = 6
      TabOrder = 0
      OnKeyPress = edtOrcamentoKeyPress
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 74
    Width = 324
    Height = 39
    Align = alBottom
    TabOrder = 1
    object btnSalvar: TSpeedButton
      Left = 16
      Top = 8
      Width = 82
      Height = 21
      Caption = 'Salvar'
      OnClick = btnSalvarClick
    end
    object btnCancelar: TSpeedButton
      Left = 216
      Top = 8
      Width = 89
      Height = 21
      Caption = 'Cancelar'
      OnClick = btnCancelarClick
    end
  end
end
