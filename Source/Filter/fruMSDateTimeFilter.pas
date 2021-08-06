unit fruMSDateTimeFilter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fruDateTimeFilter, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore,
  dxSkinOffice2013White, cxControls, cxContainer, cxEdit, Vcl.ComCtrls, dxCore,
  cxDateUtils, Vcl.ImgList, System.Actions, Vcl.ActnList, cxDropDownEdit,
  cxCalendar, cxTextEdit, cxMaskEdit, cxSpinEdit, cxTimeEdit, Vcl.StdCtrls,
  cxButtons, Vcl.ExtCtrls;

type
  TfrMSDateTimeFilter = class(TfrDateTimeFilter)
  private
  public
    function GetSqlFilter(const FieldName, LogicField: String): String; override;
  end;

implementation

{$R *.dfm}

{ TfrMSDateTimeFilter }

function TfrMSDateTimeFilter.GetSqlFilter(const FieldName, LogicField: String): String;

  function GetFieldFilterPart(): String;
  begin
    Result := GetFieldName(FieldName, LogicField);

    if WithTime then
      Result:= ' CONVERT(DateTime, CONVERT(NVARCHAR, ' + Result + ', 20), 20)'
    else
      Result:= ' CONVERT(DateTime, CONVERT(NVARCHAR, ' + Result + ', 104), 104) ';
  end;

  function GetValueFilterPart(const Value: TDateTime): String;
  begin
    {если дата с временем}
    if WithTime then
      Result := ' CONVERT(DateTime, ''' + FormatDateTime('yyyy-mm-dd hh:nn:ss', Value) + ''', 20) '
    else
      Result := ' CONVERT(DateTime, ''' + FormatDateTime('dd.mm.yyyy', Value) + ''' , 104) ';
  end;

begin
//  CONVERT(DateTime, CONVERT(VARCHAR, TheDate, 104), 104) = Convert(DateTime,'01.09.2016',104)

  Result := '';

  if not (edFromDate.EditingValue = Null) then
    Result := Result + '(' + GetFieldFilterPart() + ' >= ' +
      GetValueFilterPart(edFromDate.EditingValue + edFromTime.EditingValue) + ')';

  if not (edTillDate.EditingValue = Null) then
  begin
    if Result <> '' then
      Result := Result + ' AND ';

     Result := Result + '(' + GetFieldFilterPart() + ' <= ' +
       GetValueFilterPart(edTillDate.EditingValue + edTillTime.EditingValue) + ')';
  end;

  if Result <> '' then
    Result := ' AND (' + Result + ') ';
end;

end.
