unit vwuFoodsReport;

interface

uses
  System.SysUtils, System.Classes, Variants, vwuCommon, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, fruDateTimeFilter;

type
  TvwFoodsReport = class(TvwCommon)
    FCheckNum: TIntegerField;
    FTableName: TWideStringField;
    FSumMoney: TFloatField;
    FPaidSum: TFloatField;
    FCardCode: TWideStringField;
    FCustomerName: TWideStringField;
    FOpenTable: TSQLTimeStampField;
    FCloseTable: TSQLTimeStampField;
    FDiscountSum: TFloatField;
    FVisit: TIntegerField;
    FLogicDate: TSQLTimeStampField;
    FDiscountName: TWideStringField;
    FCurrencyName: TWideStringField;
    FNetName: TWideStringField;
    FRestaurantName: TWideStringField;
    FMidServer: TIntegerField;
    FIdentInVisit: TIntegerField;
  private
     FDateFilter: TfrDateTimeFilter;
     FCustomerFilter: Variant;
     FCardNumFilter: Variant;

     function GetSqlDateFilter(): String;
     function GetSqlCustomerFilter(): String;
     function GetSqlCardNumFilter(): String;
  public
     constructor Create(Owner: TComponent); override;

     property DateFilter: TfrDateTimeFilter read FDateFilter write FDateFilter;
     property CustomerFilter: Variant read FCustomerFilter write FCustomerFilter;
     property CardNumFilter: Variant read FCardNumFilter write FCardNumFilter;

     {наименования вью}
     class function ViewName(): String; override;

     {получить текст базового запроса}
     function GetViewText(aFilter: String): String; override;
  end;

implementation

uses
  uServiceUtils;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TvwFoodsReport }

constructor TvwFoodsReport.Create(Owner: TComponent);
begin
  inherited;

end;

function TvwFoodsReport.GetSqlCardNumFilter: String;
begin
  Result:= '';

  if FCardNumFilter <> Null then
    Result:= ' AND (DishDiscounts.CardCode = N' + QuotedStr(FCardNumFilter) + ')';
end;

function TvwFoodsReport.GetSqlCustomerFilter: String;
begin
  Result:= '';

  if FCustomerFilter <> Null then
    Result:= ' AND (DishDiscounts.Holder = N' + QuotedStr(FCustomerFilter) + ')';
end;

function TvwFoodsReport.GetSqlDateFilter: String;
begin
  Result:= '';

  if Assigned(FDateFilter) then
    Result:= FDateFilter.GetSqlFilter('Orders.EndService', 'GlobalShifts.ShiftDate');
end;

function TvwFoodsReport.GetViewText(aFilter: String): String;
const
  NewLine = #13#10;
var
  List: TStringList;
begin
  Result:=
    ' SELECT ' + NewLine +
    '      CAST(ROW_NUMBER() OVER(ORDER BY Orders.Visit) as INT) as ID, ' + NewLine +
    '      GlobalShifts.ShiftDate as LogicDate, ' + NewLine +
    '      Orders.Visit as Visit, ' + NewLine +
    '      Orders.StartService as OpenTable, ' + NewLine +
    '      Orders.EndService as CloseTable, ' + NewLine +
    ' 	    Orders.MidServer as MidServer, ' + NewLine +
    ' 	    Orders.IdentInVisit as IdentInVisit, ' + NewLine +
    '      Orders.TableName as TableName, ' + NewLine +
    '      PrintChecks.CheckNum as CheckNum, ' + NewLine +
    '      DishDiscounts.CardCode as CardCode, ' + NewLine +
    '      Discounts.Name as DiscountName, ' + NewLine +
    '      DishDiscounts.Holder as CustomerName, ' + NewLine +
    '      Orders.PriceListSum as SumMoney, ' + NewLine +
    '      SUM(DiscParts.Sum) as DiscountSum, ' + NewLine +
    '      SUM(PayBindings.Paysum) as PaidSum, ' + NewLine +
    '      Currencies.Name as CurrencyName, ' + NewLine +
    '      CashGroups.Netname as NetName, ' + NewLine +
    '      Restaurants.Name as RestaurantName ' + NewLine +
    // CASHES.Name as CashName

    {информация о сменах работы ресторана}
    ' FROM GlobalShifts ' + NewLine +
    {информацию о кассовых серверах}
    '     INNER JOIN CashGroups ON (CashGroups.SIFR = GlobalShifts.Midserver) ' + NewLine +
    {Информация о заказе, состоит из пакетов}
    '     INNER JOIN Orders ON (GlobalShifts.MidServer = Orders.MidServer) ' + NewLine +
    '               AND (GlobalShifts.ShiftNum = Orders.iCommonShift) ' + NewLine +
                    GetSqlDateFilter() + NewLine +
    {Содержит информацию о скидках}
    '     INNER JOIN Discparts ON (Orders.Visit = DiscParts.Visit) ' +
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
    {информация о кассе закрытия чека}
    //INNER JOIN CASHES ON (CASHES.SIFR = PrintChecks.ICLOSESTATION)
    {Содержит информацию о скидках/наценках}
    '     LEFT JOIN Discounts ON (Discounts.SIFR = DishDiscounts.Sifr) ' + NewLine +
    {информацию о валюте}
    '     LEFT JOIN Currencies ON Currencies.SIFR = CurrLines.SIFR ' + NewLine +
    {информацию о ресторане}
    '     LEFT JOIN Restaurants ON (Restaurants.SIFR = CashGroups.Restaurant) ' + NewLine +
    ' GROUP BY ' + NewLine +
    '         GlobalShifts.ShiftDate, ' + NewLine +
    '         Orders.MidServer, ' + NewLine +
    '         Orders.Visit, ' + NewLine +
    '         Orders.StartService, ' + NewLine +
    '         Orders.EndService, ' + NewLine +
    '         Orders.TableName, ' + NewLine +
    '         Orders.PriceListSum, ' + NewLine +
    '         Orders.IdentInVisit, ' + NewLine +
    '         DishDiscounts.CardCode, ' + NewLine +
    '         DishDiscounts.Holder, ' + NewLine +
    '         PrintChecks.CheckNum, ' + NewLine +
    '         Discounts.Name, ' + NewLine +
    '         Currencies.Name, ' + NewLine +
    '         CashGroups.NetName, ' + NewLine +
    '         Restaurants.Name ';
    // CASHES.Name

  List := TStringList.Create;
  try
    List.Add(Result);
    List.SaveToFile('d:\sql.text');
  finally
    List.Free;
  end;
end;

class function TvwFoodsReport.ViewName: String;
begin
   Result:= 'VW_FOODS_REPORT';
end;

end.
