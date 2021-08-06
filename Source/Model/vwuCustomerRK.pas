unit vwuCustomerRK;

interface

uses
  System.SysUtils, System.Classes, vwuCommon, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TvwCustomerRK = class(TvwCommon)
    FHolder: TWideStringField;
  private
  public
    constructor Create(Owner: TComponent); override;

    {наименования вью}
    class function ViewName(): String; override;

    {получить текст базового запроса}
    function GetViewText(aFilter: String): String; override;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TvwCustomerRK }

constructor TvwCustomerRK.Create(Owner: TComponent);
begin
  inherited;

end;

function TvwCustomerRK.GetViewText(aFilter: String): String;
begin
   Result:=
      ' SELECT ' +
      '       CAST(ROW_NUMBER() OVER(ORDER BY Holder) as INT) as ID, ' +
      '       Holder ' +
      ' FROM DishDiscounts ' +
      ' WHERE (NOT Holder = '''') AND (Holder IS NOT NULL) ' +
      ' GROUP BY Holder ' +
      ' ORDER BY Holder ';
end;

class function TvwCustomerRK.ViewName: String;
begin
   Result:= 'VW_CUSOMER_RK';
end;

end.
