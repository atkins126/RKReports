inherited frCardNumRKFilter: TfrCardNumRKFilter
  Tag = 65535
  Hint = #1060#1080#1083#1100#1090#1088' "'#1053#1086#1084#1077#1088' '#1082#1072#1088#1090#1099'"'
  inherited laCaption: TLabel
    Width = 76
    Caption = #1053#1086#1084#1077#1088' '#1082#1072#1088#1090#1099
    ExplicitWidth = 76
  end
  inherited paMain: TPanel
    inherited cbFilter: TDBLookupComboBox
      KeyField = 'ID'
      ListField = 'CardCode'
      ListSource = vwCardNumRK.DS
    end
  end
end
