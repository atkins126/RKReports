inherited frDBFilter: TfrDBFilter
  inherited paMain: TPanel
    inherited paFilterClear: TPanel
      inherited buFilterClear: TcxButton
        OnClick = buFilterClearClick
      end
    end
    object cbFilter: TDBLookupComboBox
      AlignWithMargins = True
      Left = 5
      Top = 0
      Width = 181
      Height = 24
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alClient
      Ctl3D = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 1
      OnClick = cbFilterClick
    end
  end
end
