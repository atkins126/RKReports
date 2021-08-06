inherited vwFoodsComposition: TvwFoodsComposition
  OldCreateOrder = True
  inherited F: TFDQuery
    object FMidServer: TIntegerField
      FieldName = 'MidServer'
    end
    object FVisit: TIntegerField
      FieldName = 'Visit'
    end
    object FIdentInVisit: TIntegerField
      FieldName = 'IdentInVisit'
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
