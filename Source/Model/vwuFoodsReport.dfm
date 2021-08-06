inherited vwFoodsReport: TvwFoodsReport
  OldCreateOrder = True
  inherited F: TFDQuery
    object FVisit: TIntegerField
      FieldName = 'Visit'
    end
    object FMidServer: TIntegerField
      FieldName = 'MidServer'
    end
    object FIdentInVisit: TIntegerField
      FieldName = 'IdentInVisit'
    end
    object FLogicDate: TSQLTimeStampField
      FieldName = 'LogicDate'
    end
    object FCheckNum: TIntegerField
      FieldName = 'CheckNum'
    end
    object FTableName: TWideStringField
      FieldName = 'TableName'
      Size = 15
    end
    object FSumMoney: TFloatField
      FieldName = 'SumMoney'
    end
    object FDiscountSum: TFloatField
      FieldName = 'DiscountSum'
    end
    object FPaidSum: TFloatField
      FieldName = 'PaidSum'
    end
    object FCardCode: TWideStringField
      FieldName = 'CardCode'
      Size = 50
    end
    object FCustomerName: TWideStringField
      FieldName = 'CustomerName'
      Size = 40
    end
    object FOpenTable: TSQLTimeStampField
      FieldName = 'OpenTable'
    end
    object FCloseTable: TSQLTimeStampField
      FieldName = 'CloseTable'
    end
    object FDiscountName: TWideStringField
      FieldName = 'DiscountName'
      Size = 40
    end
    object FCurrencyName: TWideStringField
      FieldName = 'CurrencyName'
      Size = 40
    end
    object FNetName: TWideStringField
      FieldName = 'NetName'
      Size = 32
    end
    object FRestaurantName: TWideStringField
      FieldName = 'RestaurantName'
      Size = 40
    end
  end
end
