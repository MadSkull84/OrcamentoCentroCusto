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
    Height = 193
    Align = alTop
    TabOrder = 0
    object Panel3: TPanel
      Left = 1
      Top = 155
      Width = 778
      Height = 37
      Align = alBottom
      TabOrder = 0
      object btnNovo: TSpeedButton
        Left = 8
        Top = 8
        Width = 82
        Height = 21
        Caption = '&Novo'
        OnClick = btnNovoClick
      end
      object btnAlterar: TSpeedButton
        Left = 104
        Top = 8
        Width = 82
        Height = 21
        Caption = '&Alterar'
        OnClick = btnAlterarClick
      end
      object btnExcluir: TSpeedButton
        Left = 200
        Top = 8
        Width = 82
        Height = 21
        Caption = '&Excluir'
        OnClick = btnExcluirClick
      end
    end
    object grdOrcamentoCentroCusto: TDBGrid
      Left = 1
      Top = 1
      Width = 778
      Height = 154
      Align = alClient
      DataSource = dsOrcamentoCC
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
          FieldName = 'ORCAMENTO'
          Width = 236
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CENTRO_CUSTO'
          Width = 261
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VALOR'
          Width = 243
          Visible = True
        end>
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 193
    Width = 780
    Height = 234
    Align = alClient
    TabOrder = 1
    ExplicitTop = 198
    object Splitter1: TSplitter
      Left = 256
      Top = 1
      Height = 232
      ExplicitLeft = 193
      ExplicitTop = 6
    end
    object Splitter2: TSplitter
      Left = 521
      Top = 1
      Height = 232
      Align = alRight
      ExplicitLeft = 593
      ExplicitTop = 0
    end
    object GroupBox1: TGroupBox
      Left = 259
      Top = 1
      Width = 262
      Height = 232
      Align = alClient
      Caption = 'Resumo por Centro Custo Pai '
      TabOrder = 0
      ExplicitLeft = 296
      ExplicitTop = 24
      ExplicitWidth = 185
      ExplicitHeight = 105
      object grdResumoCentroCustoPai: TDBGrid
        Left = 2
        Top = 15
        Width = 258
        Height = 215
        Align = alClient
        DataSource = dsResumoCentroCustoPai
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
            FieldName = 'CENTRO_CUSTO_PAI'
            Width = 124
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALOR'
            Width = 93
            Visible = True
          end>
      end
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 1
      Width = 255
      Height = 232
      Align = alLeft
      Caption = 'Resumo por Or'#231'amento '
      TabOrder = 1
      object grdResumoOrcamento: TDBGrid
        Left = 2
        Top = 15
        Width = 251
        Height = 215
        Align = alClient
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
            Width = 107
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALOR'
            Width = 105
            Visible = True
          end>
      end
    end
    object GroupBox3: TGroupBox
      Left = 524
      Top = 1
      Width = 255
      Height = 232
      Align = alRight
      Caption = 'Resumo por Centro Custo Filho '
      TabOrder = 2
      object grdResumoCentroCustoFilho: TDBGrid
        Left = 2
        Top = 15
        Width = 251
        Height = 215
        Align = alClient
        DataSource = dsResumoCentroCustoFilho
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
            FieldName = 'CENTRO_CUSTO_FILHO'
            Width = 115
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
  end
  object cdsOrcamentoCC: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'idxOrcamentoCentroCusto'
        Fields = 'ORCAMENTO;CENTRO_CUSTO'
      end>
    IndexName = 'idxOrcamentoCentroCusto'
    Params = <>
    StoreDefs = True
    Left = 424
    Top = 17
    object cdsOrcamentoCCID: TIntegerField
      DisplayLabel = 'Id'
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
      DisplayLabel = 'Centro Custo'
      FieldName = 'CENTRO_CUSTO'
      Size = 6
    end
    object cdsOrcamentoCCCENTRO_CUSTO_PAI: TStringField
      DisplayLabel = 'Centro Custo Pai'
      FieldName = 'CENTRO_CUSTO_PAI'
      Size = 2
    end
    object cdsOrcamentoCCCENTRO_CUSTO_FILHO: TStringField
      DisplayLabel = 'Centro Custo Filho'
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
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'idxOrcamento'
        Fields = 'ORCAMENTO'
      end>
    IndexName = 'idxOrcamento'
    Params = <>
    StoreDefs = True
    Left = 40
    Top = 313
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
    Left = 40
    Top = 353
  end
  object cdsResumoCentroCustoPai: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'idxCentroCustoPai'
        Fields = 'CENTRO_CUSTO_PAI'
      end>
    IndexName = 'idxCentroCustoPai'
    Params = <>
    StoreDefs = True
    Left = 280
    Top = 313
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
    Left = 280
    Top = 353
  end
  object cdsResumoCentroCustoFilho: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'idxCentroCustoFilho'
        Fields = 'CENTRO_CUSTO_FILHO'
      end>
    IndexName = 'idxCentroCustoFilho'
    Params = <>
    StoreDefs = True
    Left = 560
    Top = 321
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
    Left = 560
    Top = 361
  end
end
