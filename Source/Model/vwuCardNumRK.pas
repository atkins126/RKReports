unit vwuCardNumRK;

interface

uses
  System.SysUtils, System.Classes, vwuCommon, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TvwCardNumRK = class(TvwCommon)
    FCardCode: TWideStringField;
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

{ TvwCardNumRK }

constructor TvwCardNumRK.Create(Owner: TComponent);
begin
  inherited;

end;

function TvwCardNumRK.GetViewText(aFilter: String): String;
begin
  Result :=
    ' SELECT ' +
    '       CAST(ROW_NUMBER() OVER(ORDER BY CardCode) as INT) as ID, ' +
    '       CardCode ' +
    ' FROM DishDiscounts ' +
    ' WHERE (NOT CardCode = '''') AND (CardCode IS NOT NULL) ' +
    ' GROUP BY CardCode ' +
    ' ORDER BY CardCode ';
end;

class function TvwCardNumRK.ViewName: String;
begin
  Result := 'VW_CUSOMER_RK';
end;

end.
