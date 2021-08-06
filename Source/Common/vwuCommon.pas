unit vwuCommon;

interface

uses
  System.SysUtils, System.Classes, System.Variants, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, App.DB.Connection;

const
  KEY_FIELD_NAME = 'ID';

type
  TvwCommon = class(TDataModule)
    F: TFDQuery;
    DS: TDataSource;
    FID: TIntegerField;
  private
    FDBConnection: TCLDBConnection;
    FFilter: string;
    FCanUpdate: Boolean;
    FOnAfterRefresh: TNotifyEvent;

    {событие - данные обновлены}
    procedure DoAfterRefresh(); dynamic;

    {получение значения ключевого поля}
    function GetKeyValue(): Variant;
    procedure SetCanUpdate(const Value: Boolean);
    function GetActive: Boolean;
    procedure SetConnection(const Value: TCLDBConnection);
  protected
    {формирование sql текста вью}
    function GetSqlText(): string; virtual;

    {получение фильтра}
    function GetFilter(): string;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy(); override;

    {наименования вью}
    class function ViewName(): string; virtual;

    {добавление фильтра в запрос}
    procedure AddCustomSqlFilter(aFilter: string);

    procedure Close;

    {обновление данных с запросом на сервер}
    procedure RefreshData(aLocateID: Variant);

    {позиционируемся на записи}
    procedure Locate(aInstanceID: Variant);

    {получить текст запроса набора данных}
    function GetViewText(aFilter: string): string; virtual;

    property Connection: TCLDBConnection read FDBConnection write SetConnection;
    property Active: Boolean read GetActive;
    property CanUpdate: Boolean read FCanUpdate write SetCanUpdate;
    property KeyValue: Variant read GetKeyValue;

    property OnAfterRefresh: TNotifyEvent read FOnAfterRefresh write FOnAfterRefresh;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  uServiceUtils;

{$R *.dfm}

{ TvwCommon }

constructor TvwCommon.Create(Owner: TComponent);
begin
  inherited;

//  F.Connection := FDBConnection.Connection;
  FCanUpdate := True;
end;

destructor TvwCommon.Destroy;
begin
  FDBConnection := nil;

  inherited;
end;

class function TvwCommon.ViewName: string;
begin
  Result := '';
end;

procedure TvwCommon.DoAfterRefresh;
begin
  {если обработчик назначен, то запускаем его}
  if Assigned(FOnAfterRefresh) then
    FOnAfterRefresh(Self);
end;

function TvwCommon.GetKeyValue: Variant;
begin
  Result := Null;

  if F.Active then
    Result := F.FieldByName(KEY_FIELD_NAME).Value;
end;

procedure TvwCommon.SetCanUpdate(const Value: Boolean);
begin
  FCanUpdate := Value;
end;

procedure TvwCommon.SetConnection(const Value: TCLDBConnection);
begin
  FDBConnection := Value;
  F.Connection := FDBConnection.Connection;
end;

function TvwCommon.GetSqlText;
begin
  Result := GetViewText(FFilter);
end;

function TvwCommon.GetActive: Boolean;
begin
  Result := F.Active;
end;

function TvwCommon.GetFilter: string;
begin
  Result := FFilter;
end;

procedure TvwCommon.AddCustomSqlFilter(aFilter: string);
begin
  FFilter := aFilter;
end;

procedure TvwCommon.Close;
begin
  F.Close;
end;

procedure TvwCommon.RefreshData;
var
  SqlText: string;
begin
  if not CanUpdate then
    Exit;

  F.DisableControls;
  try
    SqlText := GetSqlText();

    F.Close;
    F.SQL.Text := SqlText;
    F.Open;
  finally
    F.EnableControls;

    {позиционируемся на записи}
    if isNull(aLocateID, 0) > 0 then
      F.Locate(FID.FieldName, aLocateID, []);
  end;

  {генерируем событие - данные обновлены}
  DoAfterRefresh();
end;

procedure TvwCommon.Locate(aInstanceID: Variant);
begin
  F.Locate(FID.FieldName, aInstanceID, []);
end;

function TvwCommon.GetViewText(aFilter: string): string;
begin
  Result := ' SELECT FIRST 1 * FROM ' + ViewName;

{$IFDEF ASProtect}
  {$I include\aspr_crypt_begin1.inc}
  Result := ' SELECT FIRST 1000 * FROM ' + ViewName;
{$I include\aspr_crypt_end1.inc}

  {$I include\aspr_crypt_begin5.inc}
  Result := ' SELECT * FROM ' + ViewName;
  {$I include\aspr_crypt_end5.inc}

  {$I include\aspr_crypt_begin15.inc}
  Result := ' SELECT FIRST 1 * FROM ' + ViewName;
  {$I include\aspr_crypt_end15.inc}
{$ELSE}
  Result := ' SELECT * FROM ' + ViewName;
{$ENDIF}

  if not (Trim(aFilter) = '') then
    Result := Result + ' WHERE (1 = 1) ' + aFilter;
end;

end.
