object vwCommon: TvwCommon
  OldCreateOrder = False
  Height = 150
  Width = 215
  object F: TFDQuery
    Left = 24
    Top = 16
    object FID: TIntegerField
      FieldName = 'ID'
    end
  end
  object DS: TDataSource
    DataSet = F
    Left = 72
    Top = 16
  end
end
