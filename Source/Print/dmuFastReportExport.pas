unit dmuFastReportExport;

interface

uses
  Windows, Messages, SysUtils, Classes, Variants, Graphics, Controls, Forms, Dialogs,
  frxExportText, frxExportODF, frxExportXML, frxExportXLS, frxExportRTF,
  frxExportHTML, frxClass, frxExportPDF, frxExportImage, FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait, FireDAC.Stan.Intf, FireDAC.Comp.UI;

type
  TdmFastReportExport = class(TDataModule)
    frxPDFExport: TfrxPDFExport;
    frxHTMLExport: TfrxHTMLExport;
    frxRTFExport: TfrxRTFExport;     
    frxXLSExport: TfrxXLSExport;
    frxXMLExport: TfrxXMLExport;
    frxODSExport: TfrxODSExport;
    frxODTExport: TfrxODTExport;
    frxSimpleTextExport: TfrxSimpleTextExport;
    frxJPEGExport: TfrxJPEGExport;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.DFM}

end.
 
