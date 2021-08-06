unit fruCusomerRKFilter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fruDBFilter, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinOffice2013White,
  Vcl.DBCtrls, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrCusomerRKFilter = class(TfrDBFilter)
  private
    function GetKeyValue: Variant; override;
  public
    constructor Create(aOwner: TComponent); override;
  end;

implementation

uses
  vwuCustomerRK, CR.Application;

{$R *.dfm}

{ TfrCusomerRKFilter }

constructor TfrCusomerRKFilter.Create(aOwner: TComponent);
begin
  inherited;

  DataList := TvwCustomerRK.Create(Self);
  DataList.F.Connection := CRApplication.DBConnection.Connection;
  cbFilter.ListSource := DataList.DS;
end;


function TfrCusomerRKFilter.GetKeyValue: Variant;
begin
  Result := cbFilter.KeyValue;
  if Result <> Null then
    Result := TvwCustomerRK(DataList).FHolder.AsString;
end;

end.
