unit rpuFoodsAllReport;

interface

uses
  System.SysUtils, System.Classes, System.Variants, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, frxClass, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, frxDBSet, fruDateTimeFilter, fruCusomerRKFilter,
  vwuFoodsAllReport, vwuFoodsAllComposition;

type
  TrpFoodsAllReport = class(TDataModule)
    frDataset: TfrxDBDataset;
    frDatasetOper: TfrxDBDataset;
    DS: TDataSource;
    frReport: TfrxReport;
    procedure frReportGetValue(const VarName: string; var Value: Variant);
  private
    FFoods: TvwFoodsAllReport;
    FFoodsComposition: TvwFoodsAllComposition;

    FDateFilter: TfrDateTimeFilter;
    FCustomerFilter: TfrCusomerRKFilter;
    FCardNumFilter: Variant;

    function GetSqlCustomerFilter: string;
    function GetCustomerFilterValue(): Variant;
    function GetCustomerFilterCaption(): string;
    function GetDateFilterCaption(): string;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;

    procedure Init;
    procedure Print;

    property DateFilter: TfrDateTimeFilter read FDateFilter write FDateFilter;
    property CustomerFilter: TfrCusomerRKFilter read FCustomerFilter write FCustomerFilter;
    property CardNumFilter: Variant read FCardNumFilter write FCardNumFilter;
  end;

implementation

uses
  CR.Application, eduPrintSample;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TrpFoodsAllReport }

constructor TrpFoodsAllReport.Create(Owner: TComponent);
begin
  inherited;

  FFoods := TvwFoodsAllReport.Create(Self);
  FFoods.Connection := CRApplication.DBConnection;
  FFoodsComposition := TvwFoodsAllComposition.Create(Self);
  FFoodsComposition.Connection := CRApplication.DBConnection;

  frDataset.DataSet := FFoods.F;
  frDataset.UserName := 'Клиенты';
  frDataset.FieldAliases.Clear;
  frDataset.FieldAliases.Add('-ID=ID');
  frDataset.FieldAliases.Add('CardCode=Номер карты');
//  frDataset.FieldAliases.Add('DiscountName=Название скидки');
  frDataset.FieldAliases.Add('CustomerName=Владелец');
  frDataset.FieldAliases.Add('SumMoney=Сумма');
  frDataset.FieldAliases.Add('DiscountSum=Сумма скидки');
  frDataset.FieldAliases.Add('PaidSum=Оплачено');

  frDatasetOper.DataSet := FFoodsComposition.F;
  frDatasetOper.UserName := 'Рассшифровка блюд';
  frDatasetOper.FieldAliases.Clear;
  frDatasetOper.FieldAliases.Add('-ID=ID');
  frDatasetOper.FieldAliases.Add('CardCode=Номер карты');
  frDatasetOper.FieldAliases.Add('CustomerName=Владелец');
  frDatasetOper.FieldAliases.Add('Name=Блюдо');
  frDatasetOper.FieldAliases.Add('Price=Цена');
  frDatasetOper.FieldAliases.Add('Quantity=Количество');
  frDatasetOper.FieldAliases.Add('SumMoney=Сумма');
  frDatasetOper.FieldAliases.Add('DiscountSum=Сумма скидки');
  frDatasetOper.FieldAliases.Add('PaySum=Оплачено');
end;

destructor TrpFoodsAllReport.Destroy;
begin
  FFoods.Free;
  FFoodsComposition.Free;

  inherited;
end;

procedure TrpFoodsAllReport.Init;
begin
  FFoods.DateFilter := DateFilter;
  FFoods.CardNumFilter := FCardNumFilter;
  FFoods.CustomerFilter := FCustomerFilter.KeyValue;
  FFoodsComposition.DateFilter := DateFilter;
  FFoodsComposition.CardNumFilter := FCardNumFilter;
  FFoodsComposition.CustomerFilter := FCustomerFilter.KeyValue;

  DS.DataSet := FFoods.F;
  FFoodsComposition.F.IndexFieldNames := 'CardCode';
  FFoodsComposition.F.MasterSource := DS;
  FFoodsComposition.F.MasterFields := 'CardCode';

  FFoods.RefreshData(Null);
  FFoodsComposition.RefreshData(Null);
end;

procedure TrpFoodsAllReport.Print;
begin
  TedPrintSample.Print(frReport, Self.ClassName, True, True);
end;

function TrpFoodsAllReport.GetCustomerFilterValue: Variant;
begin
  if Assigned(CustomerFilter) then
    Result := CustomerFilter.KeyValue
  else
    Result := Null;
end;

function TrpFoodsAllReport.GetCustomerFilterCaption: string;
begin
  if GetCustomerFilterValue <> Null then
    Result := 'Владелец карты: ' + VarToStr(GetCustomerFilterValue) + #13#10
  else
    Result := '';
end;

function TrpFoodsAllReport.GetDateFilterCaption: string;

  function GetDate(const Value: Variant): string;
  begin
    Result := '';

    if Value <> Null then
      Result := FormatDateTime('dd.mm.yyyy', Value);
  end;

var
  FromDate: string;
  TillDate: string;
begin
  Result := '';

  if not Assigned(DateFilter) then
    Exit;

  FromDate := GetDate(DateFilter.FromDate);
  TillDate := GetDate(DateFilter.TillDate);

  if FromDate <> '' then
    Result := 'c ' + FromDate;

  if TillDate <> '' then begin
    if Result <> '' then
      Result := Result + '  ';

    Result := Result + 'по ' + TillDate;
  end;

  if Result <> '' then
    Result := 'Период: ' + Result + #13#10;
end;


function TrpFoodsAllReport.GetSqlCustomerFilter: string;
begin

end;

procedure TrpFoodsAllReport.frReportGetValue(const VarName: string;
  var Value: Variant);
begin
  if AnsiCompareStr(VarName, 'Пользовательские фильтры') = 0 then
  begin
    Value := GetCustomerFilterCaption + GetDateFilterCaption();
    if Value = '' then
      Value := #13#10;
  end;
end;

end.
