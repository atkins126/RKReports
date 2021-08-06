unit vwuFoodsAllReport;

interface

uses
  System.SysUtils, System.Classes, System.Variants, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, vwuCommon, fruDateTimeFilter;

type
  TvwFoodsAllReport = class(TvwCommon)
    FCardCode: TWideStringField;
    FCustomerName: TWideStringField;
    FSumMoney: TFloatField;
    FDiscountSum: TFloatField;
    FPaidSum: TFloatField;
  private
    FDateFilter: TfrDateTimeFilter;
    FCustomerFilter: Variant;
    FCardNumFilter: Variant;

    function GetSqlDateFilter(): string;
    function GetSqlCustomerFilter(): string;
    function GetSqlCardNumFilter(): string;
  public
    constructor Create(Owner: TComponent); override;

    class function ViewName(): string; override;

    function GetViewText(aFilter: string): string; override;

    property DateFilter: TfrDateTimeFilter read FDateFilter write FDateFilter;
    property CustomerFilter: Variant read FCustomerFilter write FCustomerFilter;
    property CardNumFilter: Variant read FCardNumFilter write FCardNumFilter;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TvwFoodsAllReport }

constructor TvwFoodsAllReport.Create(Owner: TComponent);
begin
  inherited;

  FDateFilter := nil;
  FCustomerFilter := Null;
  FCardNumFilter := Null;
end;

function TvwFoodsAllReport.GetSqlCardNumFilter: string;
begin
  if FCardNumFilter <> Null then
    Result := ' AND (DishDiscounts.CardCode = N' + QuotedStr(FCardNumFilter) + ')'
  else
    Result := '';
end;

function TvwFoodsAllReport.GetSqlCustomerFilter: string;
begin
  if FCustomerFilter <> Null then
    Result := ' AND (DishDiscounts.Holder = N' + QuotedStr(FCustomerFilter) + ')'
  else
    Result := '';
end;

function TvwFoodsAllReport.GetSqlDateFilter: string;
begin
  if Assigned(FDateFilter) then
    Result := FDateFilter.GetSqlFilter('Orders.EndService', 'GlobalShifts.ShiftDate')
  else
    Result := '';
end;

function TvwFoodsAllReport.GetViewText(aFilter: string): string;
const
  NewLine = #13#10;
begin
  Result :=
    ' SELECT ' + NewLine +
    '      CAST(ROW_NUMBER() OVER(ORDER BY DishDiscounts.CardCode) as INT) as ID, ' + NewLine +
    '      DishDiscounts.CardCode as CardCode, ' + NewLine +
//    '      Discounts.Name as DiscountName, ' + NewLine +
    '      DishDiscounts.Holder as CustomerName, ' + NewLine +
    '      SUM(Orders.PriceListSum) as SumMoney, ' + NewLine +
    '      SUM(DiscParts.Sum) as DiscountSum, ' + NewLine +
    '      SUM(PayBindings.Paysum) as PaidSum ' + NewLine +

    {информация о сменах работы ресторана}
    ' FROM GlobalShifts ' + NewLine +
    {Информация о заказе, состоит из пакетов}
    '     INNER JOIN Orders ON (GlobalShifts.MidServer = Orders.MidServer) ' + NewLine +
    '               AND (GlobalShifts.ShiftNum = Orders.iCommonShift) ' + NewLine +
                    GetSqlDateFilter() + NewLine +
    {Содержит информацию о скидках}
    '     INNER JOIN Discparts ON (Orders.Visit = DiscParts.Visit) ' + NewLine +
    '               AND (Orders.MidServer = DiscParts.MidServer) ' + NewLine +
    '               AND (Orders.IdentInVisit = DiscParts.OrderIdent) ' + NewLine +
    {Содержит информацию о скидках/наценках}
    '     INNER JOIN DishDiscounts ON (DishDiscounts.Visit = DiscParts.Visit) ' + NewLine +
    '               AND (DishDiscounts.MidServer = DiscParts.MidServer) ' + NewLine +
    '               AND (DishDiscounts.UNI = DiscParts.DiscLineUNI) ' + NewLine +
    '               AND (DishDiscounts.CardCode <> '''')  ' + NewLine +
    '               AND (DishDiscounts.ChargeSource = 5) ' + NewLine +
                    GetSqlCardNumFilter() + NewLine +
                    GetSqlCustomerFilter() + NewLine +
    {платежи}
    '     INNER JOIN PayBindings ON (PayBindings.Visit = DiscParts.Visit) ' + NewLine +
    '               AND (PayBindings.MidServer = DiscParts.MidServer) ' + NewLine +
    '               AND (PayBindings.UNI = DiscParts.BindingUNI) ' + NewLine +
    {Содержит информацию о платежи с учетом валюты}
    '     INNER JOIN CurrLines ON (CurrLines.Visit = PayBindings.Visit) ' + NewLine +
    '               AND (CurrLines.MidServer = PayBindings.MidServer) ' + NewLine +
    '               AND (CurrLines.UNI = PayBindings.CurrUNI) ' + NewLine +
    {информацию о чеках}
    '     INNER JOIN PrintChecks ON (PrintChecks.Visit = CurrLines.Visit) ' + NewLine +
    '               AND (PrintChecks.MidServer = CurrLines.MidServer) ' + NewLine +
    '               AND (PrintChecks.UNI = CurrLines.CheckUNI) ' + NewLine +
    '               AND ((PrintChecks.State = 6) OR (PrintChecks.State = 7)) ' + NewLine +
    '               AND (PrintChecks.Deleted = 0) ' + NewLine +
//    {Содержит информацию о скидках/наценках}
//    '     LEFT JOIN Discounts ON (Discounts.SIFR = DishDiscounts.Sifr) ' + NewLine +
    ' GROUP BY ' + NewLine +
    '         DishDiscounts.CardCode, ' + NewLine +
//    '         Discounts.Name, ' + NewLine +
    '         DishDiscounts.Holder ';
end;

class function TvwFoodsAllReport.ViewName: string;
begin
  Result:= 'VW_FOODS_ALL_REPORT';
end;

end.
