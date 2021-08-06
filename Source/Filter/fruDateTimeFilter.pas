unit fruDateTimeFilter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls,
  dxCore, cxDateUtils, dxSkinsCore, dxSkinOffice2013White, cxSpinEdit,
  cxTimeEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  System.Actions, Vcl.ActnList, cxCheckBox, Vcl.Menus, Vcl.StdCtrls, cxButtons,
  Vcl.ImgList, dxBevel, Vcl.ExtCtrls, App.Params, Registry;

type
  TfrDateTimeFilter = class(TFrame)
    edFromDate: TcxDateEdit;
    edTillDate: TcxDateEdit;
    edFromTime: TcxTimeEdit;
    edTillTime: TcxTimeEdit;
    ActionList: TActionList;
    acShowTime: TAction;
    ImageList: TcxImageList;
    buFilterOptions: TcxButton;
    poDateMenu: TPopupMenu;
    miShowTime: TMenuItem;
    buClearFromDate: TcxButton;
    buClearTillDate: TcxButton;
    acClearFromDate: TAction;
    acClearTillDate: TAction;
    paTop: TPanel;
    paMain: TPanel;
    miLogicDate: TMenuItem;
    miClearFilter: TMenuItem;
    N3: TMenuItem;
    acClearFilter: TAction;
    acRefresh: TAction;
    mRefresh: TMenuItem;
    acLogicDate: TAction;
    laLogicDate: TLabel;
    procedure acShowTimeExecute(Sender: TObject);
    procedure acClearFromDateExecute(Sender: TObject);
    procedure acClearTillDateExecute(Sender: TObject);
    procedure acClearFilterExecute(Sender: TObject);
    procedure acRefreshExecute(Sender: TObject);
    procedure acLogicDateExecute(Sender: TObject);
    procedure edFromDatePropertiesEditValueChanged(Sender: TObject);
    procedure edTillDatePropertiesEditValueChanged(Sender: TObject);
    procedure edFromTimePropertiesEditValueChanged(Sender: TObject);
    procedure edTillTimePropertiesEditValueChanged(Sender: TObject);
  private
    FOnRefresh: TNotifyEvent;
    FShowTime: TRegBooleanParam;
    FLogicDate: TRegBooleanParam;
    FOnlyDate: Boolean;
    FForMSSql: Boolean;

    procedure DoRefresh(); dynamic;
    procedure Loaded; override;

    procedure SetOnlyDate(const Value: Boolean);
    function GetWithTime: Boolean;
    function GetFromDate: Variant;
    function GetTillDate: Variant;
    function GetFromTime: Variant;
    function GetTillTime: Variant;

    procedure Load();
    procedure Save();
  protected
    function GetFieldName(const FieldName, LogicField: String): String;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy(); override;

    function GetSqlFilter(const FieldName, LogicField: String): String; virtual;
    procedure Refresh();

    property OnlyDate: Boolean read FOnlyDate write SetOnlyDate;
    property WithTime: Boolean read GetWithTime;
    property FromDate: Variant read GetFromDate;
    property FromTime: Variant read GetFromTime;
    property TillDate: Variant read GetTillDate;
    property TillTime: Variant read GetTillTime;

    property OnRefresh: TNotifyEvent read FOnRefresh write FOnRefresh;
  end;

implementation

{$R *.dfm}

uses
  uServiceUtils;

constructor TfrDateTimeFilter.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  FOnlyDate := False;
  FForMSSql := False;
  FShowTime := TRegBooleanParam.Create('ShowTime', aOwner.ClassName + '\' + Self.Name, True);
  FLogicDate := TRegBooleanParam.Create('LogicDate', aOwner.ClassName + '\' + Self.Name, False);
  Load;
end;

destructor TfrDateTimeFilter.Destroy();
begin
  Save;

  FShowTime.Value := miShowTime.Checked;
  FLogicDate.Value := miLogicDate.Checked;
  FreeWithCheckExist(FShowTime);
  FreeWithCheckExist(FLogicDate);

  inherited;
end;

procedure TfrDateTimeFilter.DoRefresh;
begin
  if Assigned(FOnRefresh) then
    FOnRefresh(Self);
end;

procedure TfrDateTimeFilter.Load;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey:= HKEY_CURRENT_USER;

    FShowTime.Load(Reg);
    FLogicDate.Load(Reg);
  finally
    Reg.Free;
  end;
end;

procedure TfrDateTimeFilter.Save;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey:= HKEY_CURRENT_USER;

    FShowTime.Save(Reg);
    FLogicDate.Save(Reg);
  finally
    Reg.Free;
  end;
end;

procedure TfrDateTimeFilter.Loaded;
begin
  inherited;

  edFromDate.EditValue := Null;
  edTillDate.EditValue := Null;
  Refresh;
end;

procedure TfrDateTimeFilter.acClearFilterExecute(Sender: TObject);
begin
  acClearFromDate.Execute;
  acClearTillDate.Execute;
end;

procedure TfrDateTimeFilter.acClearFromDateExecute(Sender: TObject);
begin
  edFromDate.Clear;
  edFromTime.Clear;
end;

procedure TfrDateTimeFilter.acClearTillDateExecute(Sender: TObject);
begin
  edTillDate.Clear;
  edTillTime.Clear;
end;

procedure TfrDateTimeFilter.acLogicDateExecute(Sender: TObject);
begin
  FLogicDate.Value := not FLogicDate.Value;

  {фильтрация по логической дате}
  if FLogicDate.Value then
    FShowTime.Value := False; //время не учитывается

  Refresh;
end;

procedure TfrDateTimeFilter.acRefreshExecute(Sender: TObject);
begin
  DoRefresh;
end;

procedure TfrDateTimeFilter.acShowTimeExecute(Sender: TObject);
begin
  FShowTime.Value := not FShowTime.Value;
  Refresh;
end;

procedure TfrDateTimeFilter.edFromDatePropertiesEditValueChanged(Sender: TObject);
begin
  DoRefresh;
end;

procedure TfrDateTimeFilter.edFromTimePropertiesEditValueChanged(Sender: TObject);
begin
  DoRefresh;
end;

procedure TfrDateTimeFilter.edTillDatePropertiesEditValueChanged(Sender: TObject);
begin
  DoRefresh;
end;

procedure TfrDateTimeFilter.edTillTimePropertiesEditValueChanged(Sender: TObject);
begin
  DoRefresh;
end;

function TfrDateTimeFilter.GetFieldName(const FieldName, LogicField: String): String;
begin
  if miLogicDate.Checked then
    Result := LogicField
  else
    Result := FieldName;
end;

function TfrDateTimeFilter.GetSqlFilter(const FieldName, LogicField: String): String;

  function GetFieldFilterPart(): String;
  begin
    Result := GetFieldName(FieldName, LogicField);

    if not WithTime then
      Result:= ' CAST(' + Result + ' as DATE) '; //отбрасываем время
  end;

  function GetValueFilterPart(const Value: TDateTime): String;
  begin
    if WithTime then
      Result := ' CAST(''' + FormatDateTime('yyyy-mm-dd hh:nn:ss', Value) + ''' as TIMESTAMP) '
    else
      Result := ' CAST(''' + FormatDateTime('yyyy-mm-dd', Value) + ''' as DATE) ';
  end;

begin
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

function TfrDateTimeFilter.GetWithTime: Boolean;
begin
  Result := FShowTime.Value and not FOnlyDate;
end;

function TfrDateTimeFilter.GetFromDate: Variant;
begin
  Result := edFromDate.EditingValue;
end;

function TfrDateTimeFilter.GetFromTime: Variant;
begin
  Result := edFromTime.EditingValue;
end;

function TfrDateTimeFilter.GetTillDate: Variant;
begin
  Result := edTillDate.EditingValue;
end;

function TfrDateTimeFilter.GetTillTime: Variant;
begin
  Result := edTillTime.EditingValue;
end;

procedure TfrDateTimeFilter.SetOnlyDate(const Value: Boolean);
begin
  FOnlyDate := Value;
  Refresh;
end;

procedure TfrDateTimeFilter.Refresh;
begin
  miShowTime.Checked := WithTime;
  miShowTime.Enabled := not FLogicDate.Value;
  miShowTime.Visible := not FOnlyDate;
  miLogicDate.Checked := FLogicDate.Value;
  laLogicDate.Visible := FLogicDate.Value;

  if FShowTime.Value then
  begin
    edFromTime.Visible := True;
    edTillTime.Visible := True;
    Self.Width := 332;
  end
  else
  begin
    edTillTime.Clear;
    edFromTime.Clear;
    edFromTime.Visible := False;
    edTillTime.Visible := False;
    Self.Width := 252;
  end;
end;

end.
