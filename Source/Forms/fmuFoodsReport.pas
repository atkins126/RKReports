unit fmuFoodsReport;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fmuCommon, cxClasses, cxPropertiesStore,
  JvAppStorage, JvAppRegistryStorage, JvComponentBase, JvFormPlacement, System.Actions,
  Vcl.ActnList, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  dxSkinsCore, dxSkinOffice2013White, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, vwuFoodsReport,
  vwuFoodsComposition, fruMSDateTimeFilter, Vcl.ComCtrls, Vcl.ToolWin, dxGridPanel,
  Vcl.ExtCtrls, cxTextEdit, cxCalc, cxHeader, cxContainer, cxLabel, cxSplitter, fruFilter,
  fruDBFilter, fruCusomerRKFilter, fruCardNumRKFilter, Vcl.StdCtrls, cxCalendar,
  fruDateTimeFilter, CR.Application, Vcl.Menus;

type
  TfmFoodsReport = class(TfmCommon)
    Grid: TcxGrid;
    G: TcxGridDBTableView;
    GridLevel1: TcxGridLevel;
    GID: TcxGridDBColumn;
    GCheckNum: TcxGridDBColumn;
    GOpenTable: TcxGridDBColumn;
    GCloseTable: TcxGridDBColumn;
    GTableName: TcxGridDBColumn;
    GSumMoney: TcxGridDBColumn;
    GDiscountSum: TcxGridDBColumn;
    GPaidSum: TcxGridDBColumn;
    GCardCode: TcxGridDBColumn;
    GCustomerName: TcxGridDBColumn;
    paToolbar: TPanel;
    GridPanel: TdxGridPanel;
    tbCard: TToolBar;
    tbSeparator1: TToolButton;
    tbSeparator2: TToolButton;
    tbExportToExcel: TToolButton;
    paFilter: TPanel;
    frDateTimeFilter: TfrMSDateTimeFilter;
    acRefresh: TAction;
    acExportToExcel: TAction;
    Grid2: TcxGrid;
    GridLevel2: TcxGridLevel;
    gComposition: TcxGridDBTableView;
    gCompositionID: TcxGridDBColumn;
    gCompositionName: TcxGridDBColumn;
    gCompositionQuantity: TcxGridDBColumn;
    gCompositionPrice: TcxGridDBColumn;
    gCompositionSumMoney: TcxGridDBColumn;
    gCompositionVisit: TcxGridDBColumn;
    GVisit: TcxGridDBColumn;
    paComposition: TPanel;
    paToolbarComposition: TPanel;
    GridPanel2: TdxGridPanel;
    paCompositionHead: TPanel;
    laCompositionHead: TcxLabel;
    SplitterMain: TcxSplitter;
    paMain: TPanel;
    gCompositionColumnPaySum: TcxGridDBColumn;
    gCompositionDiscountSum: TcxGridDBColumn;
    frCusomerRKFilter: TfrCusomerRKFilter;
    frCardNumRKFilter: TfrCardNumRKFilter;
    GLogicDate: TcxGridDBColumn;
    GDiscountName: TcxGridDBColumn;
    GNetName: TcxGridDBColumn;
    GRestaurantName: TcxGridDBColumn;
    GMidServer: TcxGridDBColumn;
    GIdentInVisit: TcxGridDBColumn;
    GCurrencyName: TcxGridDBColumn;
    acPrintFoodsReport: TAction;
    tbSeparator3: TToolButton;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    meOptions: TMenuItem;
    acRefreshAll: TAction;
    N4: TMenuItem;
    N5: TMenuItem;
    ToolButton4: TToolButton;
    poPrintMenu: TPopupMenu;
    N6: TMenuItem;
    N7: TMenuItem;
    acPrintFoodsAllReport: TAction;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;

    procedure FormShow(Sender: TObject);
    procedure GFocusedRecordChanged(Sender: TcxCustomGridTableView;
                                    APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord;
                                    ANewItemRecordFocusingChanged: Boolean);
    procedure acExportToExcelExecute(Sender: TObject);
    procedure gCompositionTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems5GetText(
                      Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var AText: string);
    procedure acPrintFoodsReportExecute(Sender: TObject);
    procedure meOptionsClick(Sender: TObject);
    procedure acRefreshAllExecute(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure acPrintFoodsAllReportExecute(Sender: TObject);
  private
    FFoodsReportList: TvwFoodsReport;
    FFoodsComposition: TvwFoodsComposition;

    function GetShortCutImageIndex(): Integer; override;

    procedure CreateViews(); override;
  public
  end;

implementation

{$R *.dfm}

uses
  dmuSysImages, uServiceUtils, Cards.GridHelper, rpuFoodsReport, eduOptions,
  rpuFoodsAllReport;

{ TfmFoodsReport }

procedure TfmFoodsReport.acExportToExcelExecute(Sender: TObject);
begin
  TcxGridHelper.SaveToExcel(Self.Caption, Grid);
end;

procedure TfmFoodsReport.acPrintFoodsReportExecute(Sender: TObject);
var
  Report: TrpFoodsReport;
begin
  Report := TrpFoodsReport.Create(Owner);
  try
    Report.DateFilter := frDateTimeFilter;
    Report.CustomerFilter := frCusomerRKFilter;
    Report.CardNumFilter := frCardNumRKFilter.KeyValue;
    Report.UserFilter := G.DataController.Filter.FilterText;
    Report.FilterCaption := G.DataController.Filter.FilterCaption;
    Report.Init(FFoodsReportList.F);
    Report.Print;
  finally
    Report.Free;
  end;
end;

procedure TfmFoodsReport.acRefreshAllExecute(Sender: TObject);
begin
  frCusomerRKFilter.Refresh;
  frCardNumRKFilter.Refresh;

  FFoodsReportList.CustomerFilter := frCusomerRKFilter.KeyValue;
  FFoodsReportList.CardNumFilter := frCardNumRKFilter.KeyValue;
  //FFoodsComposition.CustomerFilter:= frCusomerRKFilter.KeyValue;
  //FFoodsComposition.CardNumFilter:= frCardNumRKFilter.KeyValue;

  FFoodsReportList.RefreshData(FFoodsReportList.FID.Value);
end;

procedure TfmFoodsReport.CreateViews;
begin
  inherited;

  CRApplication.ApplyConnectionParams;

  frDateTimeFilter.edFromDate.Date := Date;
  frDateTimeFilter.edTillDate.Date := Date;

  frDateTimeFilter.OnlyDate := True;
  frDateTimeFilter.OnRefresh := acRefreshAllExecute;

  FFoodsReportList := TvwFoodsReport.Create(Self);
  FFoodsReportList.F.Connection := CRApplication.DBConnection.Connection;
  FFoodsReportList.DateFilter := frDateTimeFilter;
  G.DataController.DataSource := FFoodsReportList.DS;

  FFoodsComposition := TvwFoodsComposition.Create(Self);
  FFoodsComposition.F.Connection := CRApplication.DBConnection.Connection;
  FFoodsComposition.DateFilter := frDateTimeFilter;
  gComposition.DataController.DataSource := FFoodsComposition.DS;

  frCusomerRKFilter.OnChange := acRefreshAllExecute;
  frCardNumRKFilter.OnChange := acRefreshAllExecute;

  if CRApplication.Options.Server = '' then
    meOptionsClick(Self);

  try
    CRApplication.DBConnection.Connect;
    frCusomerRKFilter.Refresh;
    frCardNumRKFilter.Refresh;
  except
    on E: Exception do
      ErrorMessage(E.Message);
  end;
end;

procedure TfmFoodsReport.FormShow(Sender: TObject);
begin
  inherited;

  if CRApplication.Connected then
    acRefresh.Execute;
end;

procedure TfmFoodsReport.gCompositionTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems5GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean; var AText: string);
begin
  aText := 'Количество записей: ' + VarToStr(aValue);
end;

function TfmFoodsReport.GetShortCutImageIndex: Integer;
begin
  Result := 45;
end;

procedure TfmFoodsReport.GFocusedRecordChanged(Sender: TcxCustomGridTableView;
  APrevFocusedRecord, AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  inherited;

  if Assigned(G.Controller.FocusedRecord) then
  begin
    FFoodsComposition.VisitFilter := G.Controller.FocusedRecord.Values[GVisit.Index];
    FFoodsComposition.MidServerFilter := G.Controller.FocusedRecord.Values[GMidServer.Index];
    FFoodsComposition.IdentInVisitFilter := G.Controller.FocusedRecord.Values[GIdentInVisit.Index];
    FFoodsComposition.RefreshData(Null);
  end;
end;

procedure TfmFoodsReport.meOptionsClick(Sender: TObject);
var
  Dialog: TedOptions;
begin
  Dialog := TedOptions.Create(Self);
  try
    if Dialog.Execute then begin
      CRApplication.ApplyConnectionParams;
      CRApplication.Connected := False;
      CRApplication.Connected := True;
    end;
  finally
    Dialog.Free;
  end;
end;

procedure TfmFoodsReport.N3Click(Sender: TObject);
begin
  Close;
end;

procedure TfmFoodsReport.acPrintFoodsAllReportExecute(Sender: TObject);
var
  Report: TrpFoodsAllReport;
begin
  Report := TrpFoodsAllReport.Create(Owner);
  try
    Report.DateFilter := frDateTimeFilter;
    Report.CustomerFilter := frCusomerRKFilter;
    Report.CardNumFilter := frCardNumRKFilter.KeyValue;
    Report.Init;
    Report.Print;
  finally
    Report.Free;
  end;
end;

end.
