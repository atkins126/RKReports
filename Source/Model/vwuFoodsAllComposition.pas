unit vwuFoodsAllComposition;

interface

uses
  System.SysUtils, System.Classes, Variants, vwuCommon, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, fruDateTimeFilter;

type
  TvwFoodsAllComposition = class(TvwCommon)
    FCardCode: TWideStringField;
    FCustomerName: TWideStringField;
    FName: TWideStringField;
    FPrice: TFloatField;
    FQuantity: TFloatField;
    FSumMoney: TFloatField;
    FDiscountSum: TFloatField;
    FPaySum: TFloatField;
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

{ TvwFoodsAllComposition }

constructor TvwFoodsAllComposition.Create(Owner: TComponent);
begin
  inherited;

  FDateFilter := nil;
  FCustomerFilter := Null;
  FCardNumFilter := Null;
end;

function TvwFoodsAllComposition.GetSqlDateFilter: String;
begin
  if Assigned(FDateFilter) then
    Result := FDateFilter.GetSqlFilter('Orders.EndService', 'GlobalShifts.ShiftDate')
  else
    Result := '';
end;

function TvwFoodsAllComposition.GetSqlCustomerFilter: String;
begin
  if FCustomerFilter <> Null then
    Result := ' AND (DishDiscounts.Holder = N' + QuotedStr(FCustomerFilter) + ')'
  else
    Result := '';
end;

function TvwFoodsAllComposition.GetSqlCardNumFilter: String;
begin
  if FCardNumFilter <> Null then
    Result := ' AND (DishDiscounts.CardCode = N' + QuotedStr(FCardNumFilter) + ')'
  else
    Result := '';
end;

class function TvwFoodsAllComposition.ViewName: string;
begin
  Result := 'VW_FOODS_ALL_COMPOSITION';
end;

function TvwFoodsAllComposition.GetViewText(aFilter: string): string;
const
  NewLine = #13#10;
begin
   Result :=
      ' SELECT * ' + NewLine +
      ' FROM ( ' + NewLine +
      '       SELECT ' + NewLine +
      '             CAST(ROW_NUMBER() OVER(ORDER BY DishDiscounts.CardCode) as INT) as ID,  ' + NewLine +
      '              DishDiscounts.CardCode as CardCode, ' + NewLine +
	     '              DishDiscounts.Holder as CustomerName, ' + NewLine +
      '              SaleObjects.Name AS Name, ' + NewLine +
      '              AVG(SessionDishes.Price) as Price, ' + NewLine +
      '              SUM(PayBindings.Quantity) AS Quantity, ' + NewLine +
      '              SUM(SessiOnDishes.Price * PayBindings.Quantity) as SumMoney, ' + NewLine +
      '              SUM(CASE ' + NewLine +
      '                      WHEN Discparts.Sum IS NOT NULL ' + NewLine +
      '                      THEN Discparts.Sum ' + NewLine +
      '                      ELSE 0 ' + NewLine +
      '                  END) as DiscountSum, ' + NewLine +
      '              SUM(PayBindings.PaySum) AS PaySum ' + NewLine +

              {информация о сменах работы ресторана}
      '       FROM GlobalShifts ' + NewLine +
	                 {информацию о кассовых серверах}
	     '           INNER JOIN CashGroups ON (CashGroups.SIFR = GlobalShifts.Midserver) ' + NewLine +
                  {Информация о заказе, состоит из пакетов}
      '           INNER JOIN Orders ON (GlobalShifts.MidServer = Orders.MidServer) ' + NewLine +
      '                     AND (GlobalShifts.ShiftNum = Orders.iCommonShift) ' + NewLine +
			               {Содержит информацию о скидках}
      '           INNER JOIN Discparts ON (Orders.Visit = DiscParts.Visit) ' + NewLine +
	     '                     AND (Orders.MidServer = DiscParts.MidServer) ' + NewLine +
			   '                     AND (Orders.IdentInVisit = DiscParts.OrderIdent) ' + NewLine +
	                 {Содержит информацию о скидках/наценках}
      '           INNER JOIN DishDiscounts ON (DishDiscounts.Visit = DiscParts.Visit) ' + NewLine +
      '                     AND (DishDiscounts.MidServer = DiscParts.MidServer) ' + NewLine +
			   '                     AND (DishDiscounts.UNI = DiscParts.DiscLineUNI) ' + NewLine +
			   '                     AND (DishDiscounts.CardCode <> '''') ' + NewLine +
			   '                     AND (DishDiscounts.ChargeSource = 5) ' + NewLine +
                            GetSqlCardNumFilter() + NewLine +
                            GetSqlCustomerFilter() + NewLine +
                  {платежи}
      '           INNER JOIN PayBindings ON (PayBindings.Visit = DiscParts.Visit) ' + NewLine +
      '                     AND (PayBindings.MidServer = DiscParts.MidServer) ' + NewLine +
			   '                     AND (PayBindings.UNI = DiscParts.BindingUNI) ' + NewLine +
	                 {Содержит информацию о платежи с учетом валюты}
      '           INNER JOIN CurrLines ON (CurrLines.Visit = PayBindings.Visit) ' + NewLine +
      '                     AND (CurrLines.MidServer = PayBindings.MidServer) ' + NewLine +
			   '                     AND (CurrLines.UNI = PayBindings.CurrUNI) ' + NewLine +
                  {информацию о чеках}
      '           INNER JOIN PrintChecks ON (PrintChecks.Visit = CurrLines.Visit) ' + NewLine +
      '                     AND (PrintChecks.MidServer = CurrLines.MidServer) ' + NewLine +
			   '                     AND (PrintChecks.UNI = CurrLines.CheckUNI) ' + NewLine +
			   '                     AND ((PrintChecks.State = 6) OR (PrintChecks.State = 7)) ' + NewLine +
			   '                     AND (PrintChecks.Deleted = 0) ' + NewLine +
      '           INNER JOIN SaleObjects ON (SaleObjects.Visit = PayBindings.Visit) ' + NewLine +
      '                     AND (SaleObjects.MidServer = PayBindings.MidServer) ' + NewLine +
      '                     AND (SaleObjects.DishUNI = PayBindings.DishUNI) ' + NewLine +
      '                     AND (SaleObjects.ChargeUNI = PayBindings.ChargeUNI) ' + NewLine +
      '           INNER JOIN SessionDishes ON (SessionDishes.Visit = SaleObjects.Visit) ' + NewLine +
      '                     AND (SessionDishes.MidServer = SaleObjects.MidServer) ' + NewLine +
      '                     AND (SessionDishes.UNI = SaleObjects.DishUNI) ' + NewLine +
      '       GROUP BY ' +
      '               DishDiscounts.CardCode, ' + NewLine +
      '               DishDiscounts.Holder, ' + NewLine +
      '               SaleObjects.Name ' + NewLine +
      ' ) VW_FOODS_COMPOSITION ' + NewLine +
      ' WHERE (1 = 1)';
end;

end.
