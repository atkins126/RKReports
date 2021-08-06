{*******************************************************}
{                                                       }
{       Cards (Desktop client)                          }
{                                                       }
{       Copyright (c) 2015 - 2019 Sergey Lubkov         }
{                                                       }
{*******************************************************}

unit Cards.GridHelper;

interface

uses
  Vcl.Forms, System.Classes, System.SysUtils, Vcl.Dialogs, Generics.Collections,
  cxGrid, cxGridExportLink, cxGridTableView;

type
  TIdentities = class(TPersistent)
  private
    FValues: TList<Integer>;
  public
    property Values: TList<Integer> read FValues;
  public
    constructor Create(); overload;
    constructor Create(const Grid: TcxGridTableView; const ColumnIndex: Integer); overload;
    destructor Destroy; override;

    procedure Add(const Key: Variant);
    procedure Clear();
    function Count(): Integer;
    procedure Delete(const Index: Integer);
    function GetAt(const Index: Integer): Integer;
    function GetCommaText(): string;
  end;

  TcxGridHelper = class
  public
    {Сохранить грид в Excel}
    class procedure SaveToExcel(const FileName: string; const Grid: TcxGrid);
  end;

implementation

uses
  uServiceUtils;

{ TIdentities }

constructor TIdentities.Create;
begin
  inherited Create();

  FValues := TList<Integer>.Create;
end;

constructor TIdentities.Create(const Grid: TcxGridTableView; const ColumnIndex: Integer);
var
  i: Integer;
begin
  Create();

  Grid.BeginUpdate;
  try
    for i := 0 to Grid.Controller.SelectedRowCount - 1 do
      Add(Grid.Controller.SelectedRows[i].Values[ColumnIndex]);
  finally
    Grid.EndUpdate;
  end;
end;

destructor TIdentities.Destroy;
begin
  FValues.Clear;
  FValues.Free;

  inherited;
end;

procedure TIdentities.Add(const Key: Variant);
begin
  if not IsNullID(Key) then
    FValues.Add(Key);
end;

function TIdentities.Count: Integer;
begin
  Result := FValues.Count;
end;

procedure TIdentities.Clear;
begin
  FValues.Clear;
end;

procedure TIdentities.Delete(const Index: Integer);
begin
  FValues.Delete(Index);
end;

function TIdentities.GetAt(const Index: Integer): Integer;
begin
  Result := FValues[Index];
end;

function TIdentities.GetCommaText: String;
var
  i: Integer;
begin
  Result := '';

  for i := 0 to FValues.Count - 1 do
  begin
    if (i > 0) then
      Result := Result + ',';

    Result := Result + IntToStr(FValues[i]);
  end;
end;

{ TGridHelper }

class procedure TcxGridHelper.SaveToExcel(const FileName: string; const Grid: TcxGrid);
var
  Dialog: TSaveDialog;
begin
  Dialog := TSaveDialog.Create(Application);
  try
    Dialog.DefaultExt := 'xls';
    Dialog.Filter := 'Excel files|*.xls';
    Dialog.FileName := FileName;

    if Dialog.Execute then
    begin
      ExportGridToExcel(Dialog.FileName, Grid, True, True, True);

      if FileExists(Dialog.FileName) then
        MessageDlg('Данные таблицы успешно сохранены в файл', mtInformation, [mbOK], 0);
    end;
  finally
    Dialog.Free;
  end;
end;

end.
