unit fruDBFilter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fruFilter, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinOffice2013White, cxLabel, Vcl.ExtCtrls, Vcl.Menus, Vcl.StdCtrls,
  cxButtons, Vcl.DBCtrls, vwuCommon;

type
  TfrDBFilter = class(TfrFilter)
     cbFilter: TDBLookupComboBox;
     procedure buFilterClearClick(Sender: TObject);
    procedure cbFilterClick(Sender: TObject);
  private
     FDataList: TvwCommon;
  protected
     function GetKeyValue: Variant; override;
     procedure SetKeyValue(const Value: Variant); override;
  public
     property DataList: TvwCommon read FDataList write FDataList;

     {обновление данных с запросом на сервер}
     procedure Refresh(); virtual;
  end;

implementation

{$R *.dfm}

{ TfrDBFilter }

procedure TfrDBFilter.buFilterClearClick(Sender: TObject);
begin
   KeyValue:= Null;
   DoChange();
end;

procedure TfrDBFilter.cbFilterClick(Sender: TObject);
begin
   DoChange();
end;

function TfrDBFilter.GetKeyValue: Variant;
begin
   Result:= cbFilter.KeyValue;
end;

procedure TfrDBFilter.Refresh;
begin
   FDataList.RefreshData(FDataList.FID.Value);
end;

procedure TfrDBFilter.SetKeyValue(const Value: Variant);
begin
   inherited;

   cbFilter.KeyValue:= Value;
end;

end.
