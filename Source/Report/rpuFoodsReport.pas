unit rpuFoodsReport;

interface

uses
  System.SysUtils, System.Classes, Variants, frxClass, frxDBSet, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, vwuFoodsComposition, fruDateTimeFilter,
  fruCusomerRKFilter, CR.Application;

type
  TrpFoodsReport = class(TDataModule)
    frDataset: TfrxDBDataset;
    frDatasetOper: TfrxDBDataset;
    F: TFDMemTable;
    FID: TIntegerField;
    FVisit: TIntegerField;
    FMidServer: TIntegerField;
    FIdentInVisit: TIntegerField;
    FLogicDate: TSQLTimeStampField;
    FCheckNum: TIntegerField;
    FTableName: TWideStringField;
    FSumMoney: TFloatField;
    FDiscountSum: TFloatField;
    FPaidSum: TFloatField;
    FCardCode: TWideStringField;
    FCustomerName: TWideStringField;
    FOpenTable: TSQLTimeStampField;
    FCloseTable: TSQLTimeStampField;
    FDiscountName: TWideStringField;
    FCurrencyName: TWideStringField;
    FNetName: TWideStringField;
    FRestaurantName: TWideStringField;
    FComposition: TFDMemTable;
    FCompositionID: TIntegerField;
    FCompositionMidServer: TIntegerField;
    FCompositionVisit: TIntegerField;
    FCompositionName: TWideStringField;
    FCompositionPrice: TFloatField;
    FCompositionQuantity: TFloatField;
    FCompositionSumMoney: TFloatField;
    FCompositionDiscountSum: TFloatField;
    FCompositionPaySum: TFloatField;
    DS: TDataSource;
    frReport: TfrxReport;
    FCompositionIdentInVisit: TIntegerField;

    procedure DataModuleCreate(Sender: TObject);
    procedure frReportGetValue(const VarName: string; var Value: Variant);
  private
    FDateFilter: TfrDateTimeFilter;
    FCustomerFilter: TfrCusomerRKFilter;
    FCardNumFilter: Variant;
    FUserFilter: String;
    FFilterCaption: String;

    function GetUserFilter(): String;
    function GetCustomerFilterValue(): Variant;
    function GetCustomerFilterCaption(): String;
    function GetDateFilterCaption(): String;
    function GetUserFilterCaption(): String;
  public
    procedure Init(const CheckList: TDataSet);
    procedure Print();

    property DateFilter: TfrDateTimeFilter read FDateFilter write FDateFilter;
    property CustomerFilter: TfrCusomerRKFilter read FCustomerFilter write FCustomerFilter;
    property CardNumFilter: Variant read FCardNumFilter write FCardNumFilter;
    property UserFilter: String read FUserFilter write FUserFilter;
    property FilterCaption: String read FFilterCaption write FFilterCaption;
  end;

implementation

uses
  uServiceUtils, eduPrintSample;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TrpFoodsReport }

procedure TrpFoodsReport.DataModuleCreate(Sender: TObject);
begin
  F.Close;
  F.CreateDataSet;

  FComposition.Close;
  FComposition.CreateDataSet;
end;

procedure TrpFoodsReport.frReportGetValue(const VarName: string; var Value: Variant);
begin
  if AnsiCompareStr(VarName, 'Пользовательские фильтры') = 0 then
  begin
    Value := GetCustomerFilterCaption + GetDateFilterCaption() + GetUserFilterCaption();
    if Value = '' then
      Value := #13#10;
  end;
//
//  if AnsiCompareStr(VarName, 'Период фильтр') = 0 then
//    Value := GetDateFilterCaption();
end;

function TrpFoodsReport.GetCustomerFilterValue(): Variant;
begin
  Result := Null;
  if Assigned(CustomerFilter) then
    Result := CustomerFilter.KeyValue;
end;

function TrpFoodsReport.GetCustomerFilterCaption: String;
begin
  if GetCustomerFilterValue <> Null then
    Result := 'Владелец карты: ' + VarToStr(GetCustomerFilterValue) + #13#10
  else
    Result := '';
end;

function TrpFoodsReport.GetDateFilterCaption: String;

  function GetDate(const Value: Variant): String;
  begin
    Result := '';

    if Value <> Null then
      Result := FormatDateTime('dd.mm.yyyy', Value);
  end;

var
  FromDate: String;
  TillDate: String;
begin
  Result := '';

  if not Assigned(DateFilter) then
    Exit;

  FromDate := GetDate(DateFilter.FromDate);
  TillDate := GetDate(DateFilter.TillDate);

  if FromDate <> '' then
    Result := 'c ' + FromDate;

  if TillDate <> '' then
  begin
    if Result <> '' then
      Result := Result + '  ';

    Result := Result + 'по ' + TillDate;
  end;

  if Result <> '' then
    Result := 'Период: ' + Result + #13#10;
end;

function TrpFoodsReport.GetUserFilterCaption(): String;
begin
  Result := '';

  if FFilterCaption <> '' then
    Result := 'Пользовательские фильтры: ' + FFilterCaption + #13#10;
end;

function TrpFoodsReport.GetUserFilter: String;
begin
  Result := '';

  if FUserFilter <> '' then
    Result := ' AND ' + FUserFilter;
end;

procedure TrpFoodsReport.Init;
var
  KeyValue: Variant;
  Composition: TvwFoodsComposition;
begin
  if not CheckList.Active then
    Exit;

  KeyValue := CheckList.FieldByName('ID').Value;

  CheckList.DisableControls;
  try
    CheckList.Filter := FUserFilter;
    CheckList.Filtered := FUserFilter <> '';
    CheckList.First;

    while not CheckList.Eof do
    begin
      F.Append;
      FID.Value := CheckList.FieldByName('ID').Value;
      FVisit.Value := CheckList.FieldByName('Visit').Value;
      FMidServer.Value := CheckList.FieldByName('MidServer').Value;
      FIdentInVisit.Value := CheckList.FieldByName('IdentInVisit').Value;
      FLogicDate.AsDateTime := CheckList.FieldByName('LogicDate').AsDateTime;
      FCheckNum.Value := CheckList.FieldByName('CheckNum').Value;
      FTableName.Value := CheckList.FieldByName('TableName').Value;
      FSumMoney.Value := CheckList.FieldByName('SumMoney').Value;
      FDiscountSum.Value := CheckList.FieldByName('DiscountSum').Value;
      FPaidSum.Value := CheckList.FieldByName('PaidSum').Value;
      FCardCode.Value := CheckList.FieldByName('CardCode').Value;
      FCustomerName.Value := CheckList.FieldByName('CustomerName').Value;
      FOpenTable.AsDateTime := CheckList.FieldByName('OpenTable').AsDateTime;
      FCloseTable.AsDateTime := CheckList.FieldByName('CloseTable').AsDateTime;
      FDiscountName.Value := CheckList.FieldByName('DiscountName').Value;
      FCurrencyName.Value := CheckList.FieldByName('CurrencyName').Value;
      FNetName.Value := CheckList.FieldByName('NetName').Value;
      FRestaurantName.Value := CheckList.FieldByName('RestaurantName').Value;
      F.Post;

      CheckList.Next;
    end;
  finally
    CheckList.Filter := '';
    CheckList.Filtered := False;
    CheckList.EnableControls;

    if not IsNullID(KeyValue) then
      CheckList.Locate('ID', KeyValue, []);
  end;

  Composition := TvwFoodsComposition.Create(Self);
  try
    Composition.DateFilter := FDateFilter;
    Composition.CustomerFilter := Null;

    Composition.Connection := CRApplication.DBConnection;
    Composition.CustomerFilter := GetCustomerFilterValue();
    Composition.CardNumFilter := FCardNumFilter;
    Composition.AddCustomSqlFilter(GetUserFilter);
    Composition.RefreshData(Null);

    while not Composition.F.Eof do
    begin
      FComposition.Append;
      FCompositionID.Value := Composition.FID.Value;
      FCompositionMidServer.Value := Composition.FMidServer.Value;
      FCompositionVisit.Value := Composition.FVisit.Value;
      FCompositionName.Value := Composition.FName.Value;
      FCompositionPrice.Value := Composition.FPrice.Value;
      FCompositionQuantity.Value := Composition.FQuantity.Value;
      FCompositionSumMoney.Value := Composition.FSumMoney.Value;
      FCompositionDiscountSum.Value := Composition.FDiscountSum.Value;
      FCompositionPaySum.Value := Composition.FPaySum.Value;
      FComposition.Post;

      Composition.F.Next;
    end;
  finally
    Composition.Free;
  end;
end;

procedure TrpFoodsReport.Print();
begin
  TedPrintSample.Print(frReport, Self.ClassName, True, True);
end;

end.
