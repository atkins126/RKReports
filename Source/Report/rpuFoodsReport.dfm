object rpFoodsReport: TrpFoodsReport
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 200
  Width = 344
  object frDataset: TfrxDBDataset
    UserName = #1057#1087#1080#1089#1086#1082' '#1095#1077#1082#1086#1074
    CloseDataSource = False
    FieldAliases.Strings = (
      '-ID=ID'
      '-Visit=Visit'
      '-MidServer=MidServer'
      '-IdentInVisit=IdentInVisit'
      'LogicDate='#1050#1072#1089#1089#1086#1074#1072#1103' '#1076#1072#1090#1072
      'CheckNum='#1053#1086#1084#1077#1088' '#1095#1077#1082#1072
      'TableName='#1057#1090#1086#1083
      'SumMoney='#1057#1091#1084#1084#1072
      'DiscountSum='#1057#1091#1084#1084#1072' '#1089#1082#1080#1076#1082#1080
      'PaidSum='#1054#1087#1083#1072#1095#1077#1085#1086
      'CardCode='#1053#1086#1084#1077#1088' '#1082#1072#1088#1090#1099
      'CustomerName='#1042#1083#1072#1076#1077#1083#1077#1094
      'OpenTable='#1042#1088#1077#1084#1103' '#1086#1090#1082#1088#1099#1090#1080#1103
      'CloseTable='#1042#1088#1077#1084#1103' '#1079#1072#1082#1088#1099#1090#1080#1103
      'DiscountName='#1053#1072#1079#1074#1072#1085#1080#1077' '#1089#1082#1080#1076#1082#1080
      'CurrencyName='#1042#1072#1083#1102#1090#1072
      'NetName='#1057#1077#1088#1074#1077#1088
      'RestaurantName='#1053#1072#1079#1074#1072#1085#1080#1077' '#1088#1077#1089#1090#1086#1088#1072#1085#1072)
    DataSet = F
    BCDToCurrency = False
    Left = 104
    Top = 24
  end
  object frDatasetOper: TfrxDBDataset
    UserName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1095#1077#1082#1072
    CloseDataSource = False
    FieldAliases.Strings = (
      '-ID=ID'
      '-MidServer=MidServer'
      '-Visit=Visit'
      '-IdentInVisit=IdentInVisit'
      'Name='#1041#1083#1102#1076#1086
      'Price='#1062#1077#1085#1072
      'Quantity='#1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
      'SumMoney='#1057#1091#1084#1084#1072
      'DiscountSum='#1057#1091#1084#1084#1072' '#1089#1082#1080#1076#1082#1080
      'PaySum='#1054#1087#1083#1072#1095#1077#1085#1086)
    DataSet = FComposition
    BCDToCurrency = False
    Left = 104
    Top = 80
  end
  object F: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'ID'
        DataType = ftInteger
      end
      item
        Name = 'Visit'
        DataType = ftInteger
      end
      item
        Name = 'MidServer'
        DataType = ftInteger
      end
      item
        Name = 'IdentInVisit'
        DataType = ftInteger
      end
      item
        Name = 'LogicDate'
        DataType = ftTimeStamp
      end
      item
        Name = 'CheckNum'
        DataType = ftInteger
      end
      item
        Name = 'TableName'
        DataType = ftWideString
        Size = 15
      end
      item
        Name = 'SumMoney'
        DataType = ftFloat
      end
      item
        Name = 'DiscountSum'
        DataType = ftFloat
      end
      item
        Name = 'PaidSum'
        DataType = ftFloat
      end
      item
        Name = 'CardCode'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'CustomerName'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'OpenTable'
        DataType = ftTimeStamp
      end
      item
        Name = 'CloseTable'
        DataType = ftTimeStamp
      end
      item
        Name = 'DiscountName'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'CurrencyName'
        DataType = ftWideString
        Size = 40
      end
      item
        Name = 'NetName'
        DataType = ftWideString
        Size = 32
      end
      item
        Name = 'RestaurantName'
        DataType = ftWideString
        Size = 40
      end>
    IndexDefs = <>
    IndexFieldNames = 'IdentInVisit;MidServer;Visit'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 192
    Top = 24
    object FID: TIntegerField
      FieldName = 'ID'
    end
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
  object FComposition: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'IdentInVisit;MidServer;Visit'
    MasterSource = DS
    MasterFields = 'IdentInVisit;MidServer;Visit'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 192
    Top = 80
    object FCompositionID: TIntegerField
      FieldName = 'ID'
    end
    object FCompositionMidServer: TIntegerField
      FieldName = 'MidServer'
    end
    object FCompositionVisit: TIntegerField
      FieldName = 'Visit'
    end
    object FCompositionName: TWideStringField
      FieldName = 'Name'
      Size = 40
    end
    object FCompositionPrice: TFloatField
      FieldName = 'Price'
    end
    object FCompositionQuantity: TFloatField
      FieldName = 'Quantity'
    end
    object FCompositionSumMoney: TFloatField
      FieldName = 'SumMoney'
    end
    object FCompositionDiscountSum: TFloatField
      FieldName = 'DiscountSum'
    end
    object FCompositionPaySum: TFloatField
      FieldName = 'PaySum'
    end
    object FCompositionIdentInVisit: TIntegerField
      FieldName = 'IdentInVisit'
    end
  end
  object DS: TDataSource
    DataSet = F
    Left = 248
    Top = 24
  end
  object frReport: TfrxReport
    Version = '4.15.10'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42611.912288182900000000
    ReportOptions.LastChange = 43342.883617303200000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnGetValue = frReportGetValue
    Left = 40
    Top = 24
    Datasets = <
      item
        DataSet = frDatasetOper
        DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1095#1077#1082#1072
      end
      item
        DataSet = frDataset
        DataSetName = #1057#1087#1080#1089#1086#1082' '#1095#1077#1082#1086#1074
      end>
    Variables = <
      item
        Name = ' '#1060#1080#1083#1100#1090#1088#1099
        Value = ''
      end
      item
        Name = #1042#1083#1072#1076#1077#1083#1077#1094' '#1082#1072#1088#1090#1099' '#1092#1080#1083#1100#1090#1088
        Value = ''
      end
      item
        Name = #1055#1077#1088#1080#1086#1076' '#1092#1080#1083#1100#1090#1088
        Value = ''
      end
      item
        Name = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#1089#1082#1080#1077' '#1092#1080#1083#1100#1090#1088#1099
        Value = ''
      end>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      LargeDesignHeight = True
      object ReportTitle1: TfrxReportTitle
        Height = 49.133890000000000000
        Top = 18.897650000000000000
        Width = 718.110700000000000000
        Child = frReport.Child1
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 101.007885000000000000
          Top = 10.559060000000000000
          Width = 516.094930000000000000
          Height = 30.236220472440940000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #1056#1072#1089#1093#1086#1076' '#1073#1083#1102#1076' '#1087#1086' '#1082#1083#1080#1077#1085#1090#1072#1084' ('#1088#1072#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1087#1086' '#1095#1077#1082#1072#1084')')
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        Height = 80.472480000000000000
        Top = 173.858380000000000000
        Width = 718.110700000000000000
        DataSet = frDataset
        DataSetName = #1057#1087#1080#1089#1086#1082' '#1095#1077#1082#1086#1074
        RowCount = 0
        Stretched = True
        object Memo2: TfrxMemoView
          ShiftMode = smDontShift
          Top = 26.456692913385800000
          Width = 100.000000000000000000
          Height = 22.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frDataset
          DataSetName = #1057#1087#1080#1089#1086#1082' '#1095#1077#1082#1086#1074
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '['#1057#1087#1080#1089#1086#1082' '#1095#1077#1082#1086#1074'."'#1050#1072#1089#1089#1086#1074#1072#1103' '#1076#1072#1090#1072'"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo7: TfrxMemoView
          Width = 100.000000000000000000
          Height = 26.456692913385800000
          ShowHint = False
          Color = 13434828
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1050#1072#1089#1089#1086#1074#1072#1103' '#1076#1072#1090#1072)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo33: TfrxMemoView
          ShiftMode = smDontShift
          Left = 100.000000000000000000
          Width = 60.472440940000000000
          Height = 26.456692913385800000
          ShowHint = False
          Color = 13434828
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #8470' '#1095#1077#1082#1072)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo34: TfrxMemoView
          ShiftMode = smDontShift
          Left = 100.000000000000000000
          Top = 26.456692913385800000
          Width = 60.472440940000000000
          Height = 22.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frDataset
          DataSetName = #1057#1087#1080#1089#1086#1082' '#1095#1077#1082#1086#1074
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '['#1057#1087#1080#1089#1086#1082' '#1095#1077#1082#1086#1074'."'#1053#1086#1084#1077#1088' '#1095#1077#1082#1072'"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo35: TfrxMemoView
          ShiftMode = smDontShift
          Left = 160.629921260000000000
          Width = 56.692913390000000000
          Height = 26.456692910000000000
          ShowHint = False
          Color = 13434828
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1057#1090#1086#1083)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo36: TfrxMemoView
          ShiftMode = smDontShift
          Left = 160.629921260000000000
          Top = 26.456692913385800000
          Width = 56.692913390000000000
          Height = 22.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = #1057#1090#1086#1083
          DataSet = frDataset
          DataSetName = #1057#1087#1080#1089#1086#1082' '#1095#1077#1082#1086#1074
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '['#1057#1087#1080#1089#1086#1082' '#1095#1077#1082#1086#1074'."'#1057#1090#1086#1083'"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo37: TfrxMemoView
          ShiftMode = smDontShift
          Left = 217.322834650000000000
          Width = 68.031496060000000000
          Height = 26.456692910000000000
          ShowHint = False
          Color = 13434828
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ID '#1075#1086#1089#1090#1103)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo38: TfrxMemoView
          ShiftMode = smDontShift
          Left = 217.322834650000000000
          Top = 26.456692910000000000
          Width = 68.031496062992100000
          Height = 22.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = #1053#1086#1084#1077#1088' '#1082#1072#1088#1090#1099
          DataSet = frDataset
          DataSetName = #1057#1087#1080#1089#1086#1082' '#1095#1077#1082#1086#1074
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '['#1057#1087#1080#1089#1086#1082' '#1095#1077#1082#1086#1074'."'#1053#1086#1084#1077#1088' '#1082#1072#1088#1090#1099'"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          ShiftMode = smDontShift
          Left = 285.354330710000000000
          Width = 75.590551180000000000
          Height = 26.456692910000000000
          ShowHint = False
          Color = 13434828
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '%')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo9: TfrxMemoView
          ShiftMode = smDontShift
          Left = 285.354330710000000000
          Top = 26.456692910000000000
          Width = 75.590551180000000000
          Height = 22.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = #1053#1072#1079#1074#1072#1085#1080#1077' '#1089#1082#1080#1076#1082#1080
          DataSet = frDataset
          DataSetName = #1057#1087#1080#1089#1086#1082' '#1095#1077#1082#1086#1074
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '['#1057#1087#1080#1089#1086#1082' '#1095#1077#1082#1086#1074'."'#1053#1072#1079#1074#1072#1085#1080#1077' '#1089#1082#1080#1076#1082#1080'"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          ShiftMode = smDontShift
          Left = 360.944881890000000000
          Width = 281.574803150000000000
          Height = 26.456692910000000000
          ShowHint = False
          Color = 13434828
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1060#1048#1054)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          ShiftMode = smDontShift
          Left = 360.944881890000000000
          Top = 26.456692910000000000
          Width = 281.574803150000000000
          Height = 22.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frDataset
          DataSetName = #1057#1087#1080#1089#1086#1082' '#1095#1077#1082#1086#1074
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            ' ['#1057#1087#1080#1089#1086#1082' '#1095#1077#1082#1086#1074'."'#1042#1083#1072#1076#1077#1083#1077#1094'"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo39: TfrxMemoView
          ShiftMode = smDontShift
          Left = 642.519685040000000000
          Width = 75.590551180000000000
          Height = 26.456692913385800000
          ShowHint = False
          Color = 13434828
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1042#1072#1083#1102#1090#1072)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo40: TfrxMemoView
          ShiftMode = smDontShift
          Left = 642.519685040000000000
          Top = 26.456692913385800000
          Width = 75.590551180000000000
          Height = 22.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frDataset
          DataSetName = #1057#1087#1080#1089#1086#1082' '#1095#1077#1082#1086#1074
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '['#1057#1087#1080#1089#1086#1082' '#1095#1077#1082#1086#1074'."'#1042#1072#1083#1102#1090#1072'"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageFooter1: TfrxPageFooter
        Height = 22.677180000000000000
        Top = 461.102660000000000000
        Width = 718.110700000000000000
        object Memo14: TfrxMemoView
          Left = 506.457020000000000000
          Width = 207.874150000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsItalic]
          HAlign = haRight
          Memo.UTF8W = (
            #1057#1090#1088#1072#1085#1080#1094#1072' [Page#] '#1080#1079' [TotalPages#]')
          ParentFont = False
        end
      end
      object DetailData1: TfrxDetailData
        Height = 22.677180000000000000
        Top = 325.039580000000000000
        Width = 718.110700000000000000
        DataSet = frDatasetOper
        DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1095#1077#1082#1072
        RowCount = 0
        Stretched = True
        object Memo16: TfrxMemoView
          Left = 15.118120000000000000
          Width = 287.244094490000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frDatasetOper
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1095#1077#1082#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            ' ['#1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1095#1077#1082#1072'."'#1041#1083#1102#1076#1086'"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 302.362204720000000000
          Width = 83.149606300000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frDatasetOper
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1095#1077#1082#1072
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '['#1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1095#1077#1082#1072'."'#1050#1086#1083#1080#1095#1077#1089#1090#1074#1086'"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo15: TfrxMemoView
          Left = 385.511811020000000000
          Width = 83.149606300000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = #1062#1077#1085#1072
          DataSet = frDatasetOper
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1095#1077#1082#1072
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '['#1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1095#1077#1082#1072'."'#1062#1077#1085#1072'"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 468.661417320000000000
          Width = 83.149606300000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = #1057#1091#1084#1084#1072
          DataSet = frDatasetOper
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1095#1077#1082#1072
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '['#1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1095#1077#1082#1072'."'#1057#1091#1084#1084#1072'"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 551.811023620000000000
          Width = 83.149606300000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = #1057#1091#1084#1084#1072' '#1089#1082#1080#1076#1082#1080
          DataSet = frDatasetOper
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1095#1077#1082#1072
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '['#1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1095#1077#1082#1072'."'#1057#1091#1084#1084#1072' '#1089#1082#1080#1076#1082#1080'"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 634.960629920000000000
          Width = 83.149606300000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = #1054#1087#1083#1072#1095#1077#1085#1086
          DataSet = frDatasetOper
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1095#1077#1082#1072
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '['#1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1095#1077#1082#1072'."'#1054#1087#1083#1072#1095#1077#1085#1086'"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Header2: TfrxHeader
        Height = 28.000000000000000000
        Top = 275.905690000000000000
        Width = 718.110700000000000000
        Stretched = True
        object Memo22: TfrxMemoView
          Left = 15.118120000000000000
          Top = 4.000000000000000000
          Width = 287.244094488189000000
          Height = 20.000000000000000000
          ShowHint = False
          Color = 15790320
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1041#1083#1102#1076#1086)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo26: TfrxMemoView
          Left = 302.362204724409000000
          Top = 4.000000000000000000
          Width = 83.149606300000000000
          Height = 20.000000000000000000
          ShowHint = False
          Color = 15790320
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo17: TfrxMemoView
          Left = 385.511811023622000000
          Top = 4.000000000000000000
          Width = 83.149606300000000000
          Height = 20.000000000000000000
          ShowHint = False
          Color = 15790320
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1062#1077#1085#1072)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo20: TfrxMemoView
          Left = 468.661417322835000000
          Top = 4.000000000000000000
          Width = 83.149606300000000000
          Height = 20.000000000000000000
          ShowHint = False
          Color = 15790320
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1057#1091#1084#1084#1072)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo23: TfrxMemoView
          Left = 551.811023622047000000
          Top = 4.000000000000000000
          Width = 83.149606300000000000
          Height = 20.000000000000000000
          ShowHint = False
          Color = 15790320
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1057#1082#1080#1076#1082#1072)
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo25: TfrxMemoView
          Left = 634.960629920000000000
          Top = 4.000000000000000000
          Width = 83.149606300000000000
          Height = 20.000000000000000000
          ShowHint = False
          Color = 15790320
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1054#1087#1083#1072#1095#1077#1085#1086)
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Footer1: TfrxFooter
        Height = 30.015770000000000000
        Top = 370.393940000000000000
        Width = 718.110700000000000000
        object Memo31: TfrxMemoView
          Left = 15.118120000000000000
          Width = 287.244094490000000000
          Height = 22.000000000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            #1042#1089#1077#1075#1086': ')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo27: TfrxMemoView
          Left = 302.362400000000000000
          Width = 83.149606300000000000
          Height = 21.921259840000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frDatasetOper
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1095#1077#1082#1072
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<'#1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1095#1077#1082#1072'."'#1050#1086#1083#1080#1095#1077#1089#1090#1074#1086'">,DetailData1)]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo28: TfrxMemoView
          Left = 385.512006300000000000
          Width = 83.149606300000000000
          Height = 21.921259840000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frDatasetOper
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1095#1077#1082#1072
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo29: TfrxMemoView
          Left = 468.661612600000000000
          Width = 83.149606300000000000
          Height = 21.921259840000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frDatasetOper
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1095#1077#1082#1072
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '['#1057#1087#1080#1089#1086#1082' '#1095#1077#1082#1086#1074'."'#1057#1091#1084#1084#1072'"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo30: TfrxMemoView
          Left = 551.811218900000000000
          Width = 83.149606300000000000
          Height = 21.921259840000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frDatasetOper
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1095#1077#1082#1072
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '['#1057#1087#1080#1089#1086#1082' '#1095#1077#1082#1086#1074'."'#1057#1091#1084#1084#1072' '#1089#1082#1080#1076#1082#1080'"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo32: TfrxMemoView
          Left = 634.960825200000000000
          Width = 83.149606300000000000
          Height = 21.921259840000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frDatasetOper
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1095#1077#1082#1072
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '['#1057#1087#1080#1089#1086#1082' '#1095#1077#1082#1086#1074'."'#1054#1087#1083#1072#1095#1077#1085#1086'"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Child1: TfrxChild
        Height = 22.677180000000000000
        Top = 90.708720000000000000
        Width = 718.110700000000000000
        Stretched = True
        object Memo10: TfrxMemoView
          Left = 7.559060000000000000
          Width = 706.772110000000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smActualHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Width = 0.100000000000000000
          Memo.UTF8W = (
            '['#1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#1089#1082#1080#1077' '#1092#1080#1083#1100#1090#1088#1099']')
          ParentFont = False
        end
      end
    end
  end
end
