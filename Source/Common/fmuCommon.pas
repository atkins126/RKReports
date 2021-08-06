unit fmuCommon;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  JvComponentBase, JvFormPlacement, JvAppStorage, JvAppRegistryStorage, cxClasses,
  cxPropertiesStore;

type
  TfmCommon = class(TForm)
    ActionList: TActionList;
    FormStorage: TJvFormStorage;
    AppRegistryStorage: TJvAppRegistryStorage;
    cxPropertiesStore: TcxPropertiesStore;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private

  protected
    procedure CreateViews(); virtual;

    {����������� � ��������� ������� � ����������� �����}
    procedure SetAccessValue(); virtual;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy; override;

    {��������� ������� ����������� ��� ������ �� ������ �������� �������}
    function GetShortCutImageIndex(): Integer; virtual;

    procedure Show;
  end;

implementation

{$R *.dfm}

uses
  dmuSysImages {$IFDEF CARDS}, fmuMain, uAccessManager{$ENDIF};

{ TfmCommon }

constructor TfmCommon.Create(Owner: TComponent);
begin
  inherited;

  CreateViews();

  {����������� � ��������� ������� � ����������� �����}
  SetAccessValue();

{$IFNDEF RESOURCE}
  {������������� ������ �����}
  dmSysImages.ImagesList16.GetIcon(GetShortCutImageIndex(), Self.Icon);

{$IFDEF CARDS}
  {������� ������ �� ������ �������� ������� ������� �����}
  fmMain.CreateShortCutBarButton(Self, GetShortCutImageIndex());

  {��������� ������������ ����� � ������ �������� ���� �������� ����}
  fmMain.AddWindowsToMenu(Self);
{$ENDIF}
{$ENDIF}
end;

destructor TfmCommon.Destroy;
begin

  inherited;
end;

procedure TfmCommon.FormClose(Sender: TObject; var Action: TCloseAction);
begin
{$IFNDEF RESOURCE}
{$IFDEF CARDS}
  {������� ������������ ����� �� ������� �������� ���� �������� ����}
  fmMain.DeleteWindowsFromMenu(Self);

  {������� ������ �� ������ �������� ������� ������� �����}
  fmMain.DeleteShortCutBarButton(Self);
{$ENDIF}
{$ENDIF}

  Action:= CaFree;
end;

procedure TfmCommon.FormActivate(Sender: TObject);
begin
{$IFDEF CARDS}
{$IFNDEF RESOURCE}
  fmMain.SetDownShortCutBarButton(Self);
{$ENDIF}
{$ENDIF}
end;

procedure TfmCommon.CreateViews;
begin

end;

procedure TfmCommon.SetAccessValue;
begin
{$IFDEF CARDS}
  {�������� ���������� ������� ���� � �������� ����������}
  AccessManager.CheckFormPermission(Self, True);
{$ENDIF}
end;

function TfmCommon.GetShortCutImageIndex: Integer;
begin
  Result := -1;
end;

procedure TfmCommon.Show;
begin
  if Self.WindowState = wsMinimized then
    Self.WindowState := wsNormal;

  inherited;
end;

end.
