inherited vwFoodsAllReport: TvwFoodsAllReport
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
    object FSumMoney: TFloatField
      FieldName = 'SumMoney'
    end
    object FDiscountSum: TFloatField
      FieldName = 'DiscountSum'
    end
    object FPaidSum: TFloatField
      FieldName = 'PaidSum'
    end
  end
end
