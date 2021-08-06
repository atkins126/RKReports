unit vwuFoodsComposition;

interface

uses
  System.SysUtils, System.Classes, Variants, vwuCommon, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, fruDateTimeFilter;

type
   TvwFoodsComposition = class(TvwCommon)
      FName: TWideStringField;
      FQuantity: TFloatField;
      FPrice: TFloatField;
      FSumMoney: TFloatField;
      FVisit: TIntegerField;
      FPaySum: TFloatField;
      FDiscountSum: TFloatField;
      FMidServer: TIntegerField;
      FIdentInVisit: TIntegerField;
   private
      FDateFilter: TfrDateTimeFilter;
      FVisitFilter: Variant;
      FMidServerFilter: Variant;
      FIdentInVisitFilter: Variant;
      FCustomerFilter: Variant;
      FCardNumFilter: Variant;

      function GetSqlDateFilter(): String;
      function GetSqlVisitFilter(): String;
      function GetSqlMidServerFilter(): String;
      function GetSqlIdentInVisitFilter(): String;
      function GetSqlCustomerFilter(): String;
      function GetSqlCardNumFilter(): String;
   public
      constructor Create(Owner: TComponent); override;

      property DateFilter: TfrDateTimeFilter read FDateFilter write FDateFilter;
      property VisitFilter: Variant read FVisitFilter write FVisitFilter;
      property MidServerFilter: Variant read FMidServerFilter write FMidServerFilter;
      property IdentInVisitFilter: Variant read FIdentInVisitFilter write FIdentInVisitFilter;
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

{ TvwFoodsComposition }

constructor TvwFoodsComposition.Create(Owner: TComponent);
begin
  inherited;

  FVisitFilter := Null;
  FMidServerFilter := Null;
  FIdentInVisitFilter := Null;
  FCustomerFilter := Null;
  FCardNumFilter := Null;
end;

function TvwFoodsComposition.GetSqlIdentInVisitFilter: String;
begin
   Result:= '';
   if not IsNullID(IdentInVisitFilter)
   then
   begin
      Result:= ' AND (Orders.IdentInVisit = ' + VarToStr(IdentInVisitFilter) + ')';
   end;
end;

function TvwFoodsComposition.GetSqlMidServerFilter: String;
begin
   Result:= '';
   if not IsNullID(MidServerFilter)
   then
   begin
      Result:= ' AND (Orders.MidServer = ' + VarToStr(MidServerFilter) + ')';
   end;
end;

function TvwFoodsComposition.GetSqlCardNumFilter: String;
begin
   Result:= '';

   if FCardNumFilter <> Null
   then
   begin
      Result:= ' AND (DishDiscounts.CardCode = N' + QuotedStr(FCardNumFilter) + ')';
   end;
end;

function TvwFoodsComposition.GetSqlCustomerFilter: String;
begin
   Result:= '';

   if FCustomerFilter <> Null
   then
   begin
      Result:= ' AND (DishDiscounts.Holder = N' + QuotedStr(FCustomerFilter) + ')';
   end;
end;

function TvwFoodsComposition.GetSqlDateFilter: String;
begin
   Result:= '';

   if Assigned(FDateFilter)
   then
   begin
      Result:= FDateFilter.GetSqlFilter('Orders.EndService', 'GlobalShifts.ShiftDate');
   end;
end;

function TvwFoodsComposition.GetSqlVisitFilter: String;
begin
   Result:= '';
   if not IsNullID(VisitFilter)
   then
   begin
      Result:= ' AND Orders.Visit = ' + VarToStr(FVisitFilter);
   end;
end;

function TvwFoodsComposition.GetViewText(aFilter: String): String;
const
  NewLine = #13#10;
begin
   Result:=
      ' SELECT * ' + NewLine +
      ' FROM ( ' + NewLine +
      '       SELECT CAST(ROW_NUMBER() OVER(ORDER BY Orders.Visit) as INT) as ID, ' + NewLine +
      '              GlobalShifts.ShiftDate as LogicDate, ' + NewLine +
      '              Orders.MidServer as MidServer, ' + NewLine +
	     '              Orders.Visit as Visit, ' + NewLine +
      '       	      Orders.IdentInVisit as IdentInVisit, ' + NewLine +
      '              Orders.StartService as OpenTable, ' + NewLine +
      '              Orders.EndService as CloseTable, ' + NewLine +
      '              Orders.TableName as TableName, ' + NewLine +
	     '              Orders.PriceListSum as CheckSum, ' + NewLine +
	     '              PrintChecks.CheckNum as CheckNum, ' + NewLine +
	     '              DishDiscounts.CardCode as CardCode, ' + NewLine +
	     '              DishDiscounts.Holder as CustomerName, ' + NewLine +
	     '              Discounts.Name as DiscountName, ' + NewLine +
      '              SaleObjects.Name AS Name, ' + NewLine +
      '              SessionDishes.Price as Price, ' + NewLine +
      '              SUM(PayBindings.Quantity) AS Quantity, ' + NewLine +
      '              SUM(SessiOnDishes.Price * PayBindings.Quantity) as SumMoney, ' + NewLine +
      '              SUM(CASE ' + NewLine +
      '                      WHEN Discparts.Sum IS NOT NULL ' + NewLine +
      '                      THEN Discparts.Sum ' + NewLine +
      '                      ELSE 0 ' + NewLine +
      '                  END) as DiscountSum, ' + NewLine +
      '              SUM(PayBindings.PaySum) AS PaySum, ' + NewLine +
      '              Currencies.Name as CurrencyName, ' + NewLine +
	     '              CashGroups.NetName as NetName, ' + NewLine +
	     '              Restaurants.Name as RestaurantName ' + NewLine +
              {информация о сменах работы ресторана}
      '       FROM GlobalShifts ' + NewLine +
	                 {информацию о кассовых серверах}
	     '           INNER JOIN CashGroups ON (CashGroups.SIFR = GlobalShifts.Midserver) ' + NewLine +
                  {Информация о заказе, состоит из пакетов}
      '           INNER JOIN Orders ON (GlobalShifts.MidServer = Orders.MidServer) ' + NewLine +
      '                     AND (GlobalShifts.ShiftNum = Orders.iCommonShift) ' + NewLine +
      '                     ' + GetSqlVisitFilter() + NewLine +
      '                     ' + GetSqlIdentInVisitFilter() + NewLine +
      '                     ' + GetSqlMidServerFilter() + NewLine +
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
	                 {Содержит информацию о скидках/наценках}
      '           LEFT JOIN Discounts ON (Discounts.SIFR = DishDiscounts.Sifr) ' + NewLine +
	                 {информацию о валюте}
      '           LEFT JOIN Currencies ON Currencies.SIFR = CurrLines.SIFR ' + NewLine +
	                 {информацию о ресторане}
	     '           LEFT JOIN Restaurants ON (Restaurants.SIFR = CashGroups.Restaurant) ' + NewLine +
      '       GROUP BY ' +
      '               GlobalShifts.ShiftDate, ' + NewLine +
      '               Orders.MidServer, ' + NewLine +
      '               Orders.Visit, ' + NewLine +
      '       	       Orders.IdentInVisit, ' + NewLine +
      '               Orders.StartService, ' + NewLine +
      '               Orders.EndService, ' + NewLine +
      '               Orders.TableName, ' + NewLine +
      '               Orders.PriceListSum, ' + NewLine +
      '               DishDiscounts.CardCode, ' + NewLine +
      '               DishDiscounts.Holder, ' + NewLine +
      '               PrintChecks.CheckNum, ' + NewLine +
      '               Discounts.Name, ' + NewLine +
      '               Currencies.Name, ' + NewLine +
      '               CashGroups.NetName, ' + NewLine +
      '               Restaurants.Name, ' + NewLine +
      '               SaleObjects.Name, ' + NewLine +
      '               SessionDishes.Price ' + NewLine +
      ' ) VW_FOODS_COMPOSITION ' + NewLine +
      ' WHERE (1 = 1)';// + aFilter;

//   Result:=
//      ' SELECT ' +
//      '       CAST(ROW_NUMBER() OVER(ORDER BY Orders.Visit) as INT) as ID, ' +
//      '       GlobalShifts.ShiftDate as LogicDate, ' +
//      '       Orders.Visit as Visit, ' +
//      ' 	     Orders.MidServer as MidServer, ' +
//      ' 	     Orders.IdentInVisit as IdentInVisit, ' +
//      '       Orders.StartService as OpenTable, ' +
//      '       Orders.EndService as CloseTable, ' +
//      '       Orders.TableName as TableName, ' +
//      '       SaleObjects.Name AS Name, ' +
//      '       SessionDishes.Price as Price, ' +
//      ' 	     SUM(PayBindings.Quantity) AS Quantity, ' +
//      '       SUM(SessiOnDishes.Price * PayBindings.Quantity) as SumMoney, ' +
//      ' 	     SUM(CASE ' +
//      ' 	             WHEN Discparts.Sum IS NOT NULL ' +
//      ' 			           THEN Discparts.Sum ' +
//      ' 			           ELSE 0 ' +
//      ' 		        END) as DiscountSum, ' +
//      ' 	     SUM(PayBindings.PaySum) AS PaySum ' +
//      ' FROM PayBindings ' +
//            {Информация о заказе, состоит из пакетов}
//      '     INNER JOIN Orders ON (Orders.Visit = PayBindings.Visit) ' +
//      ' 	          AND (Orders.MidServer = PayBindings.MidServer) ' +
//      ' 			        AND (Orders.IdentInVisit = PayBindings.OrderIdent) ' +
//      '            ' + GetSqlVisitFilter() +
//      '            ' + GetSqlIdentInVisitFilter() +
//      '            ' + GetSqlMidServerFilter() +
//            {информация о сменах работы ресторана}
//      '     INNER JOIN GlobalShifts ON (GlobalShifts.MidServer = Orders.MidServer) ' +
//      ' 	          AND (GlobalShifts.ShiftNum = Orders.iCommonShift) ' +
//      ' 			        AND (GlobalShifts.STATUS = 3) ' +
//      '     INNER JOIN SaleObjects ON (SaleObjects.Visit = PayBindings.Visit) ' +
//      ' 	         AND (SaleObjects.MidServer = PayBindings.MidServer) ' +
//      ' 			       AND (SaleObjects.DishUNI = PayBindings.DishUNI) ' +
//      ' 			       AND (SaleObjects.ChargeUNI = PayBindings.ChargeUNI) ' +
//      '     INNER JOIN SessionDishes ON (SessionDishes.Visit = SaleObjects.Visit) ' +
//      ' 	         AND (SessionDishes.MidServer = SaleObjects.MidServer) ' +
//      ' 			       AND (SessionDishes.UNI = SaleObjects.DishUNI) ' +
//            {Содержит информацию о скидках}
//      '     LEFT JOIN Discparts ON (Discparts.Visit = Orders.Visit) ' +
//      ' 	         AND (Discparts.MidServer = Orders.MidServer) ' +
//      ' 			       AND (Discparts.OrderIdent = Orders.IdentInVisit) ' +
//      ' 			       AND (Discparts.BindingUNI = PayBindings.UNI) ' +
//      '  WHERE (1 = 1) ' +
//      '  GROUP BY ' +
//      '          Orders.Visit, ' +
//      '          Orders.MidServer, ' +
//      '          Orders.IdentInVisit, ' +
//      '          Orders.StartService, ' +
//      '          Orders.EndService, ' +
//      '          Orders.TableName, ' +
//      '          SaleObjects.Name, ' +
//      '          SessionDishes.Price, ' +
//      '          GlobalShifts.ShiftDate ';
end;

class function TvwFoodsComposition.ViewName: String;
begin
   Result:= 'VW_FOODS_COMPOSITION';
end;

end.
