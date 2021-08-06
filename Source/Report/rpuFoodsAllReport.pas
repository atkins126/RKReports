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
  frDataset.UserName := '�������';
  frDataset.FieldAliases.Clear;
  frDataset.FieldAliases.Add('-ID=ID');
  frDataset.FieldAliases.Add('CardCode=����� �����');
//  frDataset.FieldAliases.Add('DiscountName=�������� ������');
  frDataset.FieldAliases.Add('CustomerName=��������');
  frDataset.FieldAliases.Add('SumMoney=�����');
  frDataset.FieldAliases.Add('DiscountSum=����� ������');
  frDataset.FieldAliases.Add('PaidSum=��������');

  frDatasetOper.DataSet := FFoodsComposition.F;
  frDatasetOper.UserName := '������������ ����';
  frDatasetOper.FieldAliases.Clear;
  frDatasetOper.FieldAliases.Add('-ID=ID');
  frDatasetOper.FieldAliases.Add('CardCode=����� �����');
  frDatasetOper.FieldAliases.Add('CustomerName=��������');
  frDatasetOper.FieldAliases.Add('Name=�����');
  frDatasetOper.FieldAliases.Add('Price=����');
  frDatasetOper.FieldAliases.Add('Quantity=����������');
  frDatasetOper.FieldAliases.Add('SumMoney=�����');
  frDatasetOper.FieldAliases.Add('DiscountSum=����� ������');
  frDatasetOper.FieldAliases.Add('PaySum=��������');
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
    Result := '�������� �����: ' + VarToStr(GetCustomerFilterValue) + #13#10
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

    Result := Result + '�� ' + TillDate;
  end;

  if Result <> '' then
    Result := '������: ' + Result + #13#10;
end;


function TrpFoodsAllReport.GetSqlCustomerFilter: string;
begin

end;

procedure TrpFoodsAllReport.frReportGetValue(const VarName: string;
  var Value: Variant);
begin
  if AnsiCompareStr(VarName, '���������������� �������') = 0 then
  begin
    Value := GetCustomerFilterCaption + GetDateFilterCaption();
    if Value = '' then
      Value := #13#10;
  end;
end;

end.
