object fmCommon: TfmCommon
  Left = 0
  Top = 0
  Caption = 'fmCommon'
  ClientHeight = 424
  ClientWidth = 731
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ActionList: TActionList
    Left = 352
    Top = 145
  end
  object AppRegistryStorage: TJvAppRegistryStorage
    StorageOptions.BooleanStringTrueValues = 'TRUE, YES, Y'
    StorageOptions.BooleanStringFalseValues = 'FALSE, NO, N'
    Root = '%NONE%'
    SubStorages = <>
    Left = 448
    Top = 176
  end
  object cxPropertiesStore: TcxPropertiesStore
    Components = <>
    StorageName = 'PropertiesStore'
    StorageType = stRegistry
    Left = 328
    Top = 224
  end
end
