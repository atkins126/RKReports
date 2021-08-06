program Reports;

uses
  Vcl.Forms,
  fmuMainForm in 'fmuMainForm.pas' {Form1},
  CR.Application in 'Source\CR.Application.pas',
  CR.Options in 'Source\CR.Options.pas',
  vwuCommon in 'Source\Common\vwuCommon.pas' {vwCommon: TDataModule},
  uServiceUtils in 'Source\uServiceUtils.pas',
  fruDBFilter in 'Source\Common\fruDBFilter.pas',
  fruFilter in 'Source\Common\fruFilter.pas' {frFilter: TFrame},
  fruDateTimeFilter in 'Source\Filter\fruDateTimeFilter.pas' {frDateTimeFilter: TFrame},
  fmuCommon in 'Source\Common\fmuCommon.pas' {fmCommon},
  fruMSDateTimeFilter in 'Source\Filter\fruMSDateTimeFilter.pas' {frMSDateTimeFilter: TFrame},
  fruCardNumRKFilter in 'Source\Filter\fruCardNumRKFilter.pas',
  fruCusomerRKFilter in 'Source\Filter\fruCusomerRKFilter.pas',
  Cards.GridHelper in 'Source\Common\Cards.GridHelper.pas',
  rpuFoodsReport in 'Source\Report\rpuFoodsReport.pas' {rpFoodsReport: TDataModule},
  eduDialog in 'Source\Common\eduDialog.pas' {edDialog},
  dmuSysImages in 'Source\Common\dmuSysImages.pas' {dmSysImages: TDataModule},
  dmuFastReportExport in 'Source\Print\dmuFastReportExport.pas' {dmFastReportExport: TDataModule},
  eduPrintSample in 'Source\Print\eduPrintSample.pas' {edPrintSample},
  fmuFoodsReport in 'Source\Forms\fmuFoodsReport.pas',
  vwuCardNumRK in 'Source\Model\vwuCardNumRK.pas' {vwCardNumRK: TDataModule},
  vwuCustomerRK in 'Source\Model\vwuCustomerRK.pas' {vwCustomerRK: TDataModule},
  vwuFoodsComposition in 'Source\Model\vwuFoodsComposition.pas' {vwFoodsComposition: TDataModule},
  vwuFoodsReport in 'Source\Model\vwuFoodsReport.pas' {vwFoodsReport: TDataModule},
  eduOptions in 'Source\Forms\eduOptions.pas' {edOptions},
  vwuFoodsAllReport in 'Source\Model\vwuFoodsAllReport.pas' {vwFoodsAllReport: TDataModule},
  vwuFoodsAllComposition in 'Source\Model\vwuFoodsAllComposition.pas' {vwFoodsAllComposition: TDataModule},
  rpuFoodsAllReport in 'Source\Report\rpuFoodsAllReport.pas' {rpFoodsAllReport: TDataModule};

{$R *.res}

var
  fmFoodsReport: TfmFoodsReport;
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

    {иинициализация приложения}
  CRApplication := TCRApplication.Create(Application);

//  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TdmSysImages, dmSysImages);
  Application.CreateForm(TfmFoodsReport, fmFoodsReport);
  Application.Run;
end.
