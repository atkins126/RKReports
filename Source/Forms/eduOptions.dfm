inherited edOptions: TedOptions
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103' '#1082' '#1089#1077#1088#1074#1077#1088#1091
  ClientHeight = 319
  ClientWidth = 426
  ExplicitWidth = 432
  ExplicitHeight = 347
  PixelsPerInch = 96
  TextHeight = 16
  object laServer: TLabel [0]
    Left = 40
    Top = 31
    Width = 50
    Height = 16
    Caption = #1057#1077#1088#1077#1074#1077#1088
  end
  object laPort: TLabel [1]
    Left = 40
    Top = 66
    Width = 28
    Height = 16
    Caption = #1055#1086#1088#1090
  end
  object laUsername: TLabel [2]
    Left = 40
    Top = 100
    Width = 83
    Height = 16
    Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
  end
  object laPassword: TLabel [3]
    Left = 40
    Top = 137
    Width = 43
    Height = 16
    Caption = #1055#1072#1088#1086#1083#1100
  end
  object laDatabase: TLabel [4]
    Left = 40
    Top = 171
    Width = 75
    Height = 16
    Caption = #1041#1072#1079#1072' '#1076#1072#1085#1085#1099#1093
  end
  inherited paBottom: TPanel
    Top = 273
    Width = 426
    ExplicitTop = 273
    ExplicitWidth = 426
  end
  object edServer: TEdit [6]
    Left = 160
    Top = 28
    Width = 225
    Height = 24
    TabOrder = 1
    Text = 'edServer'
  end
  object edPort: TEdit [7]
    Left = 160
    Top = 63
    Width = 121
    Height = 24
    NumbersOnly = True
    TabOrder = 2
    Text = 'edPort'
  end
  object edUsername: TEdit [8]
    Left = 160
    Top = 97
    Width = 225
    Height = 24
    TabOrder = 3
    Text = 'edUsername'
  end
  object edPassword: TEdit [9]
    Left = 160
    Top = 133
    Width = 225
    Height = 24
    PasswordChar = '*'
    TabOrder = 4
    Text = 'edPassword'
  end
  object edDatabase: TEdit [10]
    Left = 160
    Top = 168
    Width = 225
    Height = 24
    TabOrder = 5
    Text = 'edDatabase'
  end
  object buTestConnectionToRK: TcxButton [11]
    Left = 40
    Top = 210
    Width = 233
    Height = 41
    Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
    OptionsImage.Glyph.Data = {
      36100000424D3610000000000000360000002800000020000000200000000100
      2000000000000010000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000B13171915252D301E34
      3F443256697044768F995490AFBB61A6CAD86AB6DDED70C1EAFB70C1EAFB6AB6
      DDED61A6CAD85490AFBB44768F99325669701E343F4415252D300B1317190000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000233C494E3860757D5C9EBFCD72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF5C9EBFCD3860757D233C
      494E000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000233D4A4F5DA1C3D172C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF5DA1
      C3D1233D4A4F0000000000000000000000000000000000000000000000000000
      00000000000000000000000000005DA1C3D172C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF5DA1C3D10000000000000000000000000000000000000000000000000000
      00000000000000000000000000006DBBE3F372C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF6DBBE3F30000000000000000000000000000000000000000000000000000
      00000000000000000000000000006EBEE7F772C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF6EBEE7F70000000000000000000000000000000000000000000000000000
      00000000000000000000000000006EBEE7F772C4EEFF72C4EEFF6DBCE4F45694
      B3C0417088922E5061681F354045121F2528080E11120203040402030404080E
      1112121F25281F3540452E506168417088925694B3C06DBCE4F472C4EEFF72C4
      EEFF6EBEE7F70000000000000000000000000000000000000000000000000000
      00000000000000000000000000006DBBE3F35D9FC1CF3A6378811E343F441E33
      3E423256697044768F995490AFBB61A6CAD86AB6DDED70C1EAFB70C1EAFB6AB6
      DDED61A6CAD85490AFBB44768F99325669701E333E421E343F443A6378815D9F
      C1CF6DBBE3F30000000000000000000000000000000000000000000000000000
      0000000000000000000000000000365C7078233C494E3860757D5C9EBFCD72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF5C9EBFCD3860757D233C
      494E365C70780000000000000000000000000000000000000000000000000000
      0000000000000000000000000000233D4A4F5DA1C3D172C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF5DA1
      C3D1233D4A4F0000000000000000000000000000000000000000000000000000
      00000000000000000000000000005DA1C3D172C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF5DA1C3D10000000000000000000000000000000000000000000000000000
      000000000000000000000000000072C3EDFE72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C3EDFE0000000000000000000000000000000000000000000000000000
      00000000000000000000000000006EBEE7F772C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF6EBEE7F70000000000000000000000000000000000000000000000000000
      00000000000000000000000000006EBEE7F772C4EEFF72C4EEFF6DBCE4F45694
      B3C0417088922E5061681F354045121F2528080E11120203040402030404080E
      1112121F25281F3540452E506168417088925694B3C06DBCE4F472C4EEFF72C4
      EEFF6EBEE7F70000000000000000000000000000000000000000000000000000
      00000000000000000000000000006DBBE3F35D9FC1CF3A6378811E343F441E33
      3E423256697044768F995490AFBB61A6CAD86AB6DDED70C1EAFB70C1EAFB6AB6
      DDED61A6CAD85490AFBB44768F99325669701E333E421E343F443A6378815D9F
      C1CF6DBBE3F30000000000000000000000000000000000000000000000000000
      0000000000000000000000000000365C7078233C494E3860757D5C9EBFCD72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF5C9EBFCD3860757D233C
      494E365C70780000000000000000000000000000000000000000000000000000
      0000000000000000000000000000233D4A4F5DA1C3D172C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF5DA1
      C3D1233D4A4F0000000000000000000000000000000000000000000000000000
      00000000000000000000000000005DA1C3D172C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF5DA1C3D10000000000000000000000000000000000000000000000000000
      00000000000000000000000000006DBBE3F372C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF6DBBE3F30000000000000000000000000000000000000000000000000000
      00000000000000000000000000006EBEE7F772C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF6EBEE7F70000000000000000000000000000000000000000000000000000
      00000000000000000000000000006EBEE7F772C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF6EBEE7F70000000000000000000000000000000000000000000000000000
      00000000000000000000000000006DBBE3F372C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF6DBBE3F30000000000000000000000000000000000000000000000000000
      00000000000000000000000000005DA1C3D172C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF5DA1C3D10000000000000000000000000000000000000000000000000000
      0000000000000000000000000000233D4A4F5DA1C3D172C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF5DA1
      C3D1233D4A4F0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000001422292C3860757D5C9EBFCD72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4
      EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF72C4EEFF5C9EBFCD3860757D1422
      292C000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000070C0E0F1E33
      3E423256697044768F995490AFBB61A6CAD86AB6DDED70C1EAFB70C1EAFB6AB6
      DDED61A6CAD85490AFBB44768F99325669701E333E42070C0E0F000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000}
    OptionsImage.Margin = 15
    TabOrder = 6
    OnClick = buTestConnectionToRKClick
  end
end