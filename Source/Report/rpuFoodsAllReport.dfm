object rpFoodsAllReport: TrpFoodsAllReport
  OldCreateOrder = False
  Height = 174
  Width = 292
  object frDataset: TfrxDBDataset
    UserName = #1050#1083#1080#1077#1085#1090#1099
    CloseDataSource = False
    FieldAliases.Strings = (
      'ID=ID'
      'CardCode='#1053#1086#1084#1077#1088' '#1082#1072#1088#1090#1099
      'CustomerName='#1042#1083#1072#1076#1077#1083#1077#1094
      'SumMoney='#1057#1091#1084#1084#1072
      'DiscountSum='#1057#1091#1084#1084#1072' '#1089#1082#1080#1076#1082#1080
      'PaidSum='#1054#1087#1083#1072#1095#1077#1085#1086)
    DataSet = vwFoodsAllReport.F
    BCDToCurrency = False
    Left = 104
    Top = 24
  end
  object frDatasetOper: TfrxDBDataset
    UserName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076
    CloseDataSource = False
    FieldAliases.Strings = (
      '-ID=ID'
      'CardCode='#1053#1086#1084#1077#1088' '#1082#1072#1088#1090#1099
      'CustomerName='#1042#1083#1072#1076#1077#1083#1077#1094
      'Name='#1041#1083#1102#1076#1086
      'Price='#1062#1077#1085#1072
      'Quantity='#1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
      'SumMoney='#1057#1091#1084#1084#1072
      'DiscountSum='#1057#1091#1084#1084#1072' '#1089#1082#1080#1076#1082#1080
      'PaySum='#1054#1087#1083#1072#1095#1077#1085#1086)
    BCDToCurrency = False
    Left = 104
    Top = 80
  end
  object DS: TDataSource
    Left = 231
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
    ReportOptions.LastChange = 44413.926115046300000000
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
        DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076
      end
      item
        DataSet = frDataset
        DataSetName = #1050#1083#1080#1077#1085#1090#1099
      end>
    Variables = <
      item
        Name = ' '#1060#1080#1083#1100#1090#1088#1099
        Value = Null
      end
      item
        Name = #1042#1083#1072#1076#1077#1083#1077#1094' '#1082#1072#1088#1090#1099' '#1092#1080#1083#1100#1090#1088
        Value = Null
      end
      item
        Name = #1055#1077#1088#1080#1086#1076' '#1092#1080#1083#1100#1090#1088
        Value = Null
      end
      item
        Name = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100#1089#1082#1080#1077' '#1092#1080#1083#1100#1090#1088#1099
        Value = Null
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
          Left = 189.826840000000000000
          Top = 10.559060000000000000
          Width = 338.457020000000000000
          Height = 30.236220470000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            #1054#1073#1097#1080#1081' '#1088#1072#1089#1093#1086#1076' '#1073#1083#1102#1076' '#1087#1086' '#1082#1083#1080#1077#1085#1090#1072#1084)
          ParentFont = False
        end
      end
      object MasterData1: TfrxMasterData
        Height = 80.472480000000000000
        Top = 173.858380000000000000
        Width = 718.110700000000000000
        DataSet = frDataset
        DataSetName = #1050#1083#1080#1077#1085#1090#1099
        RowCount = 0
        Stretched = True
        object Memo37: TfrxMemoView
          ShiftMode = smDontShift
          Left = 0.110094650000000000
          Width = 113.385826771654000000
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
          Left = 0.110094650000000000
          Top = 26.456692910000000000
          Width = 113.385826771654000000
          Height = 22.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = #1053#1086#1084#1077#1088' '#1082#1072#1088#1090#1099
          DataSet = frDataset
          DataSetName = #1050#1083#1080#1077#1085#1090#1099
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '['#1050#1083#1080#1077#1085#1090#1099'."'#1053#1086#1084#1077#1088' '#1082#1072#1088#1090#1099'"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          ShiftMode = smDontShift
          Left = 113.385826770000000000
          Width = 604.724409448818900000
          Height = 26.456692910000000000
          ShowHint = False
          Color = 13434828
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            #1060#1048#1054)
          VAlign = vaCenter
        end
        object Memo5: TfrxMemoView
          ShiftMode = smDontShift
          Left = 113.385826770000000000
          Top = 26.456692910000000000
          Width = 604.724409448818900000
          Height = 22.000000000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = #1042#1083#1072#1076#1077#1083#1077#1094
          DataSet = frDataset
          DataSetName = #1050#1083#1080#1077#1085#1090#1099
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '['#1050#1083#1080#1077#1085#1090#1099'."'#1042#1083#1072#1076#1077#1083#1077#1094'"]')
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
        DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076
        RowCount = 0
        Stretched = True
        object Memo16: TfrxMemoView
          Left = 15.118120000000000000
          Width = 287.244094490000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = #1041#1083#1102#1076#1086
          DataSet = frDatasetOper
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          Memo.UTF8W = (
            '['#1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076'."'#1041#1083#1102#1076#1086'"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo19: TfrxMemoView
          Left = 302.362204720000000000
          Width = 83.149606300000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086
          DataSet = frDatasetOper
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076
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
            '['#1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076'."'#1050#1086#1083#1080#1095#1077#1089#1090#1074#1086'"]')
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
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076
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
            '['#1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076'."'#1062#1077#1085#1072'"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 468.661417320000000000
          Width = 83.149606300000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frDatasetOper
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076
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
            '['#1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076'."'#1057#1091#1084#1084#1072'"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo21: TfrxMemoView
          Left = 551.811023620000000000
          Width = 83.149606300000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frDatasetOper
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076
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
            '['#1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076'."'#1057#1091#1084#1084#1072' '#1089#1082#1080#1076#1082#1080'"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo24: TfrxMemoView
          Left = 634.960629920000000000
          Width = 83.149606300000000000
          Height = 18.897650000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataSet = frDatasetOper
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076
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
            '['#1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076'."'#1054#1087#1083#1072#1095#1077#1085#1086'"]')
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
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076
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
            '[SUM(<'#1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076'."'#1050#1086#1083#1080#1095#1077#1089#1090#1074#1086'">,DetailData1)]')
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
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076
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
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076
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
            '[SUM(<'#1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076'."'#1057#1091#1084#1084#1072'">,DetailData1)]')
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
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076
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
            '[SUM(<'#1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076'."'#1057#1091#1084#1084#1072' '#1089#1082#1080#1076#1082#1080'">,DetailData1)]')
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
          DataSetName = #1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076
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
            '[SUM(<'#1056#1072#1089#1089#1096#1080#1092#1088#1086#1074#1082#1072' '#1073#1083#1102#1076'."'#1054#1087#1083#1072#1095#1077#1085#1086'">,DetailData1)]')
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
