inherited vwFoodsAllComposition: TvwFoodsAllComposition
  OldCreateOrder = True
  inherited F: TFDQuery
    object FCardCode: TWideStringField
      FieldName = 'CardCode'
      Size = 50
    end
    object FCustomerName: TWideStringField
      FieldName = 'CustomerName'
      Size = 40
    end
    object FName: TWideStringField
      FieldName = 'Name'
      Size = 40
    end
    object FPrice: TFloatField
      FieldName = 'Price'
    end
    object FQuantity: TFloatField
      FieldName = 'Quantity'
    end
    object FSumMoney: TFloatField
      FieldName = 'SumMoney'
    end
    object FDiscountSum: TFloatField
      FieldName = 'DiscountSum'
    end
    object FPaySum: TFloatField
      FieldName = 'PaySum'
    end
  end
end
