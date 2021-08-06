object edDialog: TedDialog
  Left = 484
  Top = 229
  BorderStyle = bsDialog
  Caption = #1044#1080#1072#1083#1086#1075
  ClientHeight = 276
  ClientWidth = 481
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object paBottom: TPanel
    Left = 0
    Top = 230
    Width = 481
    Height = 46
    Align = alBottom
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object buCancel: TcxButton
      Left = 274
      Top = 3
      Width = 120
      Height = 38
      Action = acClose
      ModalResult = 2
      OptionsImage.Images = dmSysImages.ImagesBase
      OptionsImage.Margin = 5
      OptionsImage.Spacing = 10
      TabOrder = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object buOK: TcxButton
      Left = 136
      Top = 3
      Width = 120
      Height = 38
      Action = acSuccess
      Default = True
      ModalResult = 1
      OptionsImage.Images = dmSysImages.ImagesBase
      OptionsImage.Margin = 5
      OptionsImage.Spacing = 10
      TabOrder = 1
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  object ActionCommon: TActionList
    Images = dmSysImages.ImagesBase
    Left = 264
    Top = 88
    object acClose: TAction
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      ImageIndex = 1
      OnExecute = acCloseExecute
    end
    object acSuccess: TAction
      Caption = #1047#1072#1087#1080#1089#1072#1090#1100
      ImageIndex = 0
      OnExecute = acSuccessExecute
    end
  end
end
