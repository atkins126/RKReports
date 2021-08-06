unit fruCardNumRKFilter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fruDBFilter, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore,
  dxSkinOffice2013White, Vcl.DBCtrls, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls;

type
  TfrCardNumRKFilter = class(TfrDBFilter)
  private
    function GetKeyValue: Variant; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

implementation

uses
  vwuCardNumRK, CR.Application;

{$R *.dfm}

{ TfrCardNumRKFilter }

constructor TfrCardNumRKFilter.Create(aOwner: TComponent);
begin
  inherited;

  DataList := TvwCardNumRK.Create(Self);
  DataList.F.Connection := CRApplication.DBConnection.Connection;
  cbFilter.ListSource:= DataList.DS;
end;

function TfrCardNumRKFilter.GetKeyValue: Variant;
begin
  Result := cbFilter.KeyValue;
  if Result <> Null then
    Result:= TvwCardNumRK(DataList).FCardCode.AsString;
end;

end.
