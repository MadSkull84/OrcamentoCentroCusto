object dmDataBase: TdmDataBase
  OldCreateOrder = False
  Height = 253
  Width = 504
  object ConnectionPostgreSQL: TFDConnection
    Params.Strings = (
      'Database=postgres'
      'User_Name=postgres'
      'Password=postgres'
      'Server=localhost'
      'Port=7777'
      'MetaCurSchema=public'
      'DriverID=PG')
    LoginPrompt = False
    Left = 24
    Top = 16
  end
  object TransactionPostgreSQL: TFDTransaction
    Connection = ConnectionPostgreSQL
    Left = 80
    Top = 16
  end
  object GUIxWaitCursorPostgreSQL: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 24
    Top = 72
  end
  object PhysPgDriverLinkPostgreSQL: TFDPhysPgDriverLink
    Left = 24
    Top = 128
  end
  object OrcamentoCentroCusto: TFDTable
    IndexFieldNames = 'id'
    Connection = ConnectionPostgreSQL
    SchemaName = 'public'
    TableName = 'orcamento_centro_custo'
    Left = 152
    Top = 16
    object OrcamentoCentroCustocentro_custo: TWideStringField
      FieldName = 'centro_custo'
      Origin = 'centro_custo'
      Size = 6
    end
    object OrcamentoCentroCustocentro_custo_pai: TWideStringField
      FieldName = 'centro_custo_pai'
      Origin = 'centro_custo_pai'
      Size = 2
    end
    object OrcamentoCentroCustocentro_custo_filho: TWideStringField
      FieldName = 'centro_custo_filho'
      Origin = 'centro_custo_filho'
      Size = 4
    end
    object OrcamentoCentroCustovalor: TBCDField
      FieldName = 'valor'
      Origin = 'valor'
      Precision = 8
      Size = 2
    end
    object OrcamentoCentroCustoorcamento: TSmallintField
      FieldName = 'orcamento'
      Origin = 'orcamento'
    end
    object OrcamentoCentroCustoid: TIntegerField
      FieldName = 'id'
      Origin = 'id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
  end
end
