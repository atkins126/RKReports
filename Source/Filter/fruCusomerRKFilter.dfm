inherited frCusomerRKFilter: TfrCusomerRKFilter
  Tag = 65535
  Width = 326
  Hint = #1060#1080#1083#1100#1090#1088' "'#1042#1083#1072#1076#1077#1083#1077#1094' '#1082#1072#1088#1090#1099'"'
  ExplicitWidth = 326
  inherited Bevel: TBevel
    Width = 326
    ExplicitWidth = 326
  end
  inherited laCaption: TLabel
    Width = 95
    Caption = #1042#1083#1072#1076#1077#1083#1077#1094' '#1082#1072#1088#1090#1099
    ExplicitWidth = 95
  end
  inherited paMain: TPanel
    Width = 326
    ExplicitWidth = 326
    inherited paFilterClear: TPanel
      Left = 294
      ExplicitLeft = 294
    end
    inherited cbFilter: TDBLookupComboBox
      Width = 289
      KeyField = 'ID'
      ListField = 'Holder'
      ListSource = vwCustomerRK.DS
      ExplicitWidth = 289
    end
  end
end
