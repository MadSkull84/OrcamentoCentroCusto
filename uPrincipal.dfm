object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Or'#231'amento por Centro de Custo'
  ClientHeight = 427
  ClientWidth = 780
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 780
    Height = 65
    Align = alTop
    TabOrder = 0
    object btnSalvar: TSpeedButton
      Left = 304
      Top = 24
      Width = 82
      Height = 21
      Caption = 'Salvar'
      OnClick = btnSalvarClick
    end
    object lblCentroCusto: TLabel
      Left = 120
      Top = 8
      Width = 79
      Height = 13
      Caption = 'Centro de Custo'
    end
    object lblValor: TLabel
      Left = 224
      Top = 8
      Width = 24
      Height = 13
      Caption = 'Valor'
    end
    object lblOrcamento: TLabel
      Left = 24
      Top = 8
      Width = 53
      Height = 13
      Caption = 'Or'#231'amento'
    end
    object edtValor: TEdit
      Left = 224
      Top = 24
      Width = 66
      Height = 21
      TabOrder = 2
      OnKeyPress = edtValorKeyPress
    end
    object edtOrcamento: TEdit
      Left = 24
      Top = 24
      Width = 73
      Height = 21
      MaxLength = 6
      TabOrder = 0
      OnKeyPress = edtOrcamentoKeyPress
    end
    object edtCentroCusto: TEdit
      Left = 120
      Top = 24
      Width = 79
      Height = 21
      MaxLength = 6
      TabOrder = 1
      OnKeyPress = edtCentroCustoKeyPress
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 65
    Width = 780
    Height = 362
    Align = alClient
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 248
      Top = 1
      Height = 360
      ExplicitLeft = 328
      ExplicitTop = 112
      ExplicitHeight = 100
    end
    object Splitter2: TSplitter
      Left = 517
      Top = 1
      Height = 360
      Align = alRight
      ExplicitLeft = 304
      ExplicitTop = 176
      ExplicitHeight = 100
    end
    object grdResumoOrcamento: TDBGrid
      Left = 1
      Top = 1
      Width = 247
      Height = 360
      Align = alLeft
      DataSource = dsResumoOrcamento
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'ORCAMENTO'
          Width = 102
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR'
          Width = 105
          Visible = True
        end>
    end
    object grdResumoCentroCustoPai: TDBGrid
      Left = 251
      Top = 1
      Width = 266
      Height = 360
      Align = alClient
      DataSource = dsResumoCentroCustoPai
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'CENTRO_CUSTO_PAI'
          Width = 130
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR'
          Width = 93
          Visible = True
        end>
    end
    object grdResumoCentroCustoFilho: TDBGrid
      Left = 520
      Top = 1
      Width = 259
      Height = 360
      Align = alRight
      DataSource = dsResumoCentroCustoFilho
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'CENTRO_CUSTO_FILHO'
          Width = 118
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR'
          Width = 96
          Visible = True
        end>
    end
  end
  object cdsOrcamentoCC: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 424
    Top = 17
    object cdsOrcamentoCCID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Visible = False
    end
    object cdsOrcamentoCCVALOR: TCurrencyField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
      DisplayFormat = '#,###,##0.00'
    end
    object cdsOrcamentoCCORCAMENTO: TSmallintField
      DisplayLabel = 'Or'#231'amento'
      FieldName = 'ORCAMENTO'
    end
    object cdsOrcamentoCCCENTRO_CUSTO: TStringField
      FieldName = 'CENTRO_CUSTO'
      Size = 6
    end
    object cdsOrcamentoCCCENTRO_CUSTO_PAI: TStringField
      FieldName = 'CENTRO_CUSTO_PAI'
      Size = 2
    end
    object cdsOrcamentoCCCENTRO_CUSTO_FILHO: TStringField
      FieldName = 'CENTRO_CUSTO_FILHO'
      Size = 4
    end
  end
  object dsOrcamentoCC: TDataSource
    AutoEdit = False
    DataSet = cdsOrcamentoCC
    Left = 464
    Top = 17
  end
  object cdsResumoOrcamento: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 48
    Top = 129
    object cdsResumoOrcamentoID: TSmallintField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
    end
    object cdsResumoOrcamentoORCAMENTO: TSmallintField
      DisplayLabel = 'Or'#231'amento'
      FieldName = 'ORCAMENTO'
    end
    object cdsResumoOrcamentoVALOR: TCurrencyField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
      DisplayFormat = '#,###,##0.00'
    end
  end
  object dsResumoOrcamento: TDataSource
    AutoEdit = False
    DataSet = cdsResumoOrcamento
    Left = 48
    Top = 177
  end
  object cdsResumoCentroCustoPai: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 296
    Top = 129
    object cdsResumoCentroCustoPaiVALOR: TCurrencyField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
      DisplayFormat = '#,###,##0.00'
    end
    object cdsResumoCentroCustoPaiCENTRO_CUSTO_PAI: TStringField
      DisplayLabel = 'Centro Custo Pai'
      FieldName = 'CENTRO_CUSTO_PAI'
      Size = 2
    end
  end
  object dsResumoCentroCustoPai: TDataSource
    AutoEdit = False
    DataSet = cdsResumoCentroCustoPai
    Left = 296
    Top = 177
  end
  object cdsResumoCentroCustoFilho: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 576
    Top = 145
    object cdsResumoCentroCustoFilhoCENTRO_CUSTO_FILHO: TStringField
      DisplayLabel = 'Centro Custo Filho'
      FieldName = 'CENTRO_CUSTO_FILHO'
      Size = 4
    end
    object cdsResumoCentroCustoFilhoVALOR: TCurrencyField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
      DisplayFormat = '#,###,##0.00'
    end
  end
  object dsResumoCentroCustoFilho: TDataSource
    AutoEdit = False
    DataSet = cdsResumoCentroCustoFilho
    Left = 576
    Top = 193
  end
end
