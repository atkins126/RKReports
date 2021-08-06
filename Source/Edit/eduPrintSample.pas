unit eduPrintSample;

interface

uses
  Winapi.Windows, Messages, SysUtils, Classes, Variants, Graphics, Controls, Forms, Dialogs,
  eduDialog, StdCtrls, ExtCtrls, frxDesgn, frxClass, jpeg,
  frxExportRTF, frxExportHTML, frxExportText, frxExportXLS, frxExportPDF,
  frxExportImage, System.Actions, Vcl.ActnList, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinOffice2013White,
  cxControls, cxContainer, cxEdit, cxClasses, dxSkinsForm, cxLabel, cxCheckBox,
  cxGroupBox, dxGDIPlusClasses, cxImage, cxButtons, dmuFastReportExport;

type
  TProcAfterLoad = procedure (aReport: TfrxReport) of object;
  TExportFileFormat = (effWord, effExcelOLE, effExcelXML, effPDF, effHTML,
                       effTXT, effJPEG, effExcelByTemplate);

  TedPrintSample = class(TedDialog)
    cbReportPath: TComboBox;
    laReportPath: TLabel;
    OpenDialog: TOpenDialog;
    frxReport: TfrxReport;
    frxDesigner: TfrxDesigner;
    imLogo: TcxImage;
    cbConfigure: TcxCheckBox;
    buPrint: TcxButton;
    buOpenReport: TcxButton;
    buEditReport: TcxButton;
    acEditReport: TAction;
    acOpenReport: TAction;
    acUpdateView: TAction;
    acShowReport: TAction;
    acPrintReport: TAction;
    acPrintWithSettings: TAction;
    gbConfigure: TcxGroupBox;
    paConfigure: TPanel;
    paConfigureMain: TPanel;
    laConfigure: TcxLabel;
    poPrint: TPopupMenu;
    miPrintReport: TMenuItem;
    miPrintWithSettings: TMenuItem;
    buShowReport: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure acEditReportExecute(Sender: TObject);
    procedure acOpenReportExecute(Sender: TObject);
    procedure acUpdateViewExecute(Sender: TObject);
    procedure acShowReportExecute(Sender: TObject);
    procedure acPrintReportExecute(Sender: TObject);
    procedure acPrintWithSettingsExecute(Sender: TObject);
  private
     FReportRef: TfrxReport;
     FProcAfterLoad: TProcAfterLoad;
     FReportName: String;
     FReportExport: TdmFastReportExport;

     function GetFileName: string;
     procedure UpdateList(aFileName: string);
     procedure DoPrint(aShowDialog: Boolean);
     procedure CopyReport(aReport: TfrxReport);

     function Validate(var vMessage: String): Boolean;  override;
     procedure CenterButtons(); override;

     {печать отчета}
     procedure PrintPrim(aReport: TfrxReport;
                         aProcedure: TProcAfterLoad;
                         aShowDlg: Boolean;
                         aPreview: Boolean);

     {получение узла реестра для отчета}
     function GetRegistryRootKey(): String;

     function GetCurrentReportFileName(): String;
     procedure SetCurrentReportFileName(aValue: String);

     function GetReportFileNameList(): String;
     procedure SetReportFileNameList(aValue: String);

     function HasCurrent(): Boolean;

     function ExportReportToRTFPrim(aReport: TfrxReport;
                                    aKey, aPathName, aFileName: String): Boolean;

     function ExportReportToFilePrim(aReport: TfrxReport;
                                     aKey, aPathName, aFileName: String;
                                     aFileFormat: TExportFileFormat): Boolean;

     {скопировать файл отчета в папку}
     function CopyReportToFolder(aFileName: String): String;

     {путь к папке с ответами}
     function GetReportFolder(): String;
  public
     property ReportName: String read FReportName;
     property CurrentReportFileName: String read GetCurrentReportFileName write SetCurrentReportFileName;
     property ReportFileNameList: String read GetReportFileNameList write SetReportFileNameList;

     {печать отчета}
     class procedure Print(aReport: TfrxReport;
                           aName: String;
                           aShowDlg: Boolean;
                           aPreview: Boolean);

     class procedure PrintTemplate(aReport: TfrxReport;
                                   aName: String;
                                   aProcedure: TProcAfterLoad;
                                   aShowDlg: Boolean;
                                   aPreview: Boolean);

     class function ExportReportToRTF(aReport: TfrxReport;
                                      aKey, aPathName, aFileName: String): Boolean;

     class function ExportReportToFile(aReport: TfrxReport;
                                       aKey, aPathName, aFileName: String;
                                       aFileFormat: TExportFileFormat): Boolean;

     {добавдение переменной в отчет}
     class procedure AddNewVariable(aReport: TfrxReport; aCategory, aVarName: String);
  end;


implementation

uses
  App.Constants, App.SysUtils;

{$R *.DFM}

procedure TedPrintSample.FormCreate(Sender: TObject);
begin
  inherited;

  FReportExport := TdmFastReportExport.Create(Self);

  {создаем временный каталог для файлов}
  ForceDirectories(GetReportFolder);

  OpenDialog.InitialDir:= GetReportFolder;
  frxDesigner.TemplateDir:= GetReportFolder;
  frxDesigner.OpenDir:= GetReportFolder;
  frxDesigner.SaveDir:= GetReportFolder;

  cbReportPath.Visible:= False;
  buEditReport.Visible:= False;
  buOpenReport.Visible:= False;
end;

class procedure TedPrintSample.Print;
var oForm: TedPrintSample;
begin
   oForm:= TedPrintSample.Create(nil);
   try
      oForm.FReportName:= aName;
      oForm.PrintPrim(aReport, nil, aShowDlg, aPreview);
   finally
      oForm.Free;
   end;
end;

procedure TedPrintSample.acEditReportExecute(Sender: TObject);
var sNewFileName: String;
    sError: String;
begin
   if Validate(sError)
   then
   begin
      frxReport.LoadFromFile(GetFileName);
      frxReport.FileName:= GetFileName;
   end
   else
   begin
      frxReport.FileName:= '';
      CopyReport(FReportRef);
   end;

   frxDesignerComp.SaveDir:= GetReportFolder;
   if Assigned(FProcAfterLoad)
   then {если передана процедура}
   begin
      FProcAfterLoad(frxReport);
   end;
   frxReport.DesignReport;
   if (frxReport.FileName <> '') and
      (frxReport.FileName <> GetFileName)
   then {другой файл после дизайнера}
   begin
      sNewFileName:= CopyReportToFolder(frxReport.FileName);;
      cbReportPath.Text:= ExtractFileName(sNewFileName);
      UpdateList(cbReportPath.Text);
   end;
end;

procedure TedPrintSample.acOpenReportExecute(Sender: TObject);
begin
   if OpenDialog.Execute
   then
   begin
      cbReportPath.Text:= ExtractFileName(OpenDialog.FileName);
      UpdateList(cbReportPath.Text);

      CopyReportToFolder(OpenDialog.FileName);
   end;
end;

procedure TedPrintSample.acPrintReportExecute(Sender: TObject);
begin
   DoPrint(False);
end;

procedure TedPrintSample.acPrintWithSettingsExecute(Sender: TObject);
begin
   DoPrint(True);
end;

procedure TedPrintSample.acShowReportExecute(Sender: TObject);
var sError: String;
begin
   if Validate(sError)
   then
   begin
      frxReport.LoadFromFile(GetFileName);
   end;
   if Assigned(FProcAfterLoad)
   then {если передана процедура}
   begin
      FProcAfterLoad(frxReport);
   end;
   frxReport.ShowReport;
end;

procedure TedPrintSample.acUpdateViewExecute(Sender: TObject);
begin
   laReportPath.Visible:= cbConfigure.Checked;
   buEditReport.Visible:= cbConfigure.Checked;
   buOpenReport.Visible:= cbConfigure.Checked;
   cbReportPath.Visible:= cbConfigure.Checked;
   laConfigure.Visible:= not cbConfigure.Checked;
end;

class procedure TedPrintSample.AddNewVariable(aReport: TfrxReport; aCategory, aVarName: String);
var oTemplateName: String;
    oForm: TedPrintSample;
begin
   {ищем переменную в отчете}
   if aReport.Variables.IndexOf(aVarName) = -1
   then
   begin
      aReport.Variables.AddVariable(aCategory, aVarName, Null);
   end;
   {для перестраховки, если изменена категория, ищем только что добавленную переменную}
   if aReport.Variables.IndexOf(aVarName) = -1
   then {переменная не добавилась, возможно категория была изменена в шаблоне}
   begin
      {добавляем переменную без категории}
      aReport.Variables.Add.Name:= aVarName;
   end;
end;

function TedPrintSample.GetFileName: String;
begin
   Result:= GetReportFolder + '\' + cbReportPath.Text;
end;

function TedPrintSample.GetRegistryRootKey: String;
begin
   Result := GetApplicationRootKey + '\' + FReportName;
end;

procedure TedPrintSample.UpdateList(aFileName: String);
var oIndex: Integer;
begin
   if aFileName <> ''
   then
   begin
      oIndex:= cbReportPath.Items.IndexOf(aFileName);
      if oIndex <> -1
      then
      begin
         cbReportPath.Items.Delete(oIndex);
      end;
      cbReportPath.Items.Insert(0, aFileName);
   end;
end;

function TedPrintSample.Validate(var vMessage: String): Boolean;
begin
   Result:= FileExists(GetFileName);

   vMessage:= 'Файл отчета не найден';
end;

procedure TedPrintSample.DoPrint(aShowDialog: Boolean);
var sError: String;
begin
   if Validate(sError)
   then
   begin
      frxReport.LoadFromFile(GetFileName);
   end;

   if Assigned(FProcAfterLoad)
   then {если передана процедура}
   begin
      FProcAfterLoad(frxReport);
   end;

   frxReport.PrintOptions.ShowDialog:= aShowDialog;
   frxReport.PrepareReport;
   frxReport.Print;
end;

procedure TedPrintSample.CenterButtons;
begin

end;

procedure TedPrintSample.CopyReport(aReport: TfrxReport);
var oStream: TMemoryStream;
begin
   oStream:= TMemoryStream.Create;
   try
      aReport.SaveToStream(oStream);
      oStream.Position:= 0;
      frxReport.LoadFromStream(oStream);
      frxReport.OnGetValue:= aReport.OnGetValue;
   finally
      oStream.Free;
   end;
end;

function TedPrintSample.CopyReportToFolder(aFileName: String): String;
begin
   Result:= aFileName;

   if ExtractFileDir(aFileName) <> GetReportFolder
   then
   begin
      {создаем временный каталог для файлов}
      ForceDirectories(GetReportFolder);

      {путь к файлу в каталоге отчетов}
      Result:= GetReportFolder + '\' + ExtractFileName(aFileName);

      {копируем файл с заменой}
      CopyFile(PWideChar(aFileName), PWideChar(Result), False);
   end;
end;

procedure TedPrintSample.SetCurrentReportFileName(aValue: String);
begin
   SaveStr(GetRegistryRootKey + '\CurrentReportFileName', aValue);
end;

procedure TedPrintSample.SetReportFileNameList(aValue: String);
begin
   SaveStr(GetRegistryRootKey + '\ReportFileNameList', aValue);
end;

function TedPrintSample.GetCurrentReportFileName(): String;
begin
   Result:= ReadStr(GetRegistryRootKey + '\CurrentReportFileName', '');
end;

function TedPrintSample.HasCurrent(): Boolean;
begin
   Result:= CurrentReportFileName <> '';
end;

procedure TedPrintSample.PrintPrim;
begin
   {установить текущим каталог исполняемого файла для сохранения шаблона}
   cbReportPath.Text:= CurrentReportFileName;
   cbReportPath.Items.CommaText:= ReportFileNameList;
   FReportRef:= aReport;
   FProcAfterLoad:= aProcedure;
   CopyReport(aReport);
   OpenDialog.InitialDir:= GetReportFolder;

   if aShowDlg
   then {показать диалог пользователю для настройки}
   begin
      ShowModal;
      CurrentReportFileName:= cbReportPath.Text;
      ReportFileNameList:= cbReportPath.Items.CommaText;
   end
   else {показать текущий отчет}
   begin
      if aPreview
      then
      begin
         acShowReport.Execute;
      end
      else
      begin
         DoPrint(False);
      end;
   end;
end;

class procedure TedPrintSample.PrintTemplate;
var oForm: TedPrintSample;
begin
   oForm:= TedPrintSample.Create(nil);
   try
      oForm.FReportName:= aName;
      oForm.PrintPrim(aReport, aProcedure, aShowDlg, aPreview);
   finally
      oForm.Free;
   end;
end;

function TedPrintSample.GetReportFileNameList: String;
begin
   Result:= ReadStr(GetRegistryRootKey + '\ReportFileNameList','');
end;

function TedPrintSample.GetReportFolder: String;
const
  ReportFolder = 'Report';
begin
   Result := AppPath + '\' + ReportFolder;
end;

class function TedPrintSample.ExportReportToRTF(aReport: TfrxReport; aKey,
  aPathName, aFileName: string): Boolean;
var oForm: TedPrintSample;
begin
   oForm:= TedPrintSample.Create(nil);
   try
      Result:= oForm.ExportReportToRTFPrim(aReport, aKey, aPathName, aFileName);
   finally
      oForm.Free;
   end;
end;

function TedPrintSample.ExportReportToRTFPrim(aReport: TfrxReport; aKey,
                                              aPathName, aFileName: String): Boolean;
var sError: String;
begin
   {установить текущим каталог исполняемого файла для сохранения шаблона}
   cbReportPath.Text:= CurrentReportFileName;
   cbReportPath.Items.CommaText:= ReportFileNameList;

   {копируем отчет}
   CopyReport(aReport);

   if Validate(sError)
   then {указан шаблон отчета}
   begin
      {загружаем шаблон}
      frxReport.LoadFromFile(GetFileName);
   end;

   if not DirectoryExists(aPathName)
   then {не существует директория}
   begin
      CreateDir(aPathName);
   end;

   FReportExport.frxRTFExport.FileName:= aPathName + '\' + aFileName;
   FReportExport.frxRTFExport.ShowDialog:= False;
   FReportExport.frxRTFExport.OpenAfterExport:= False;
   FReportExport.frxRTFExport.ShowProgress:= False;

   {подготавливаем отчет}
   frxReport.PrepareReport;
   Result:= frxReport.Export(FReportExport.frxRTFExport);
end;

class function TedPrintSample.ExportReportToFile(aReport: TfrxReport; aKey,
  aPathName, aFileName: string; aFileFormat: TExportFileFormat): Boolean;
var oForm: TedPrintSample;
begin
   oForm:= TedPrintSample.Create(nil);
   try
      Result:= oForm.ExportReportToFilePrim(aReport, aKey, aPathName, aFileName,aFileFormat);
   finally
      oForm.Free;
   end;
end;

function TedPrintSample.ExportReportToFilePrim(aReport: TfrxReport; aKey,
  aPathName, aFileName: string; aFileFormat: TExportFileFormat): Boolean;
var sError: String;
begin
   {установить текущим каталог исполняемого файла для сохранения шаблона}
   cbReportPath.Text:= ReportFileNameList;
   cbReportPath.Items.CommaText:= ReportFileNameList;

   {копируем отчет}
   CopyReport(aReport);

   if Validate(sError)
   then {указан шаблон отчета}
   begin
      {загружаем шаблон}
      frxReport.LoadFromFile(GetFileName);
   end;

   if not DirectoryExists(aPathName)
   then {не существует директория}
   begin
      CreateDir(aPathName);
   end;

   {подготавливаем отчет}
   frxReport.PrepareReport;

   {выбираем в какой тип файла экспортировать отчет}
   case aFileFormat of
      effWord:
      begin
         FReportExport.frxRTFExport.FileName:= aPathName + '\' + aFileName;
         FReportExport.frxRTFExport.ShowDialog:= False;
         FReportExport.frxRTFExport.OpenAfterExport:= False;
         FReportExport.frxRTFExport.ShowProgress:= False;
         Result:= frxReport.Export(FReportExport.frxRTFExport);
      end;
      effExcelOLE:
      begin
         FReportExport.frxXLSExport.FileName:= aPathName + '\' + aFileName;
         FReportExport.frxXLSExport.ShowDialog:= False;
         FReportExport.frxXLSExport.OpenExcelAfterExport:= False;
         FReportExport.frxXLSExport.ShowProgress:= False;
         Result:= frxReport.Export(FReportExport.frxXLSExport);
      end;
      effExcelXML:
      begin
         FReportExport.frxXMLExport.FileName:= aPathName + '\' + aFileName;
         FReportExport.frxXMLExport.ShowDialog:= False;
         FReportExport.frxXMLExport.OpenExcelAfterExport:= False;
         FReportExport.frxXMLExport.ShowProgress:= False;
         Result:= frxReport.Export(FReportExport.frxXMLExport);
      end;
      effPDF:
      begin
         FReportExport.frxPDFExport.FileName:= aPathName + '\' + aFileName;
         FReportExport.frxPDFExport.ShowDialog:= False;
         FReportExport.frxPDFExport.OpenAfterExport:= False;
         FReportExport.frxPDFExport.ShowProgress:= False;
         Result:= frxReport.Export(FReportExport.frxPDFExport);
      end;
      effHTML:
      begin
         FReportExport.frxHTMLExport.FileName:= aPathName + '\' + aFileName;
         FReportExport.frxHTMLExport.ShowDialog:= False;
         FReportExport.frxHTMLExport.OpenAfterExport:= False;
         FReportExport.frxHTMLExport.ShowProgress:= False;
         Result:= frxReport.Export(FReportExport.frxHTMLExport);
      end;
      effTXT:
      begin
         FReportExport.frxSimpleTextExport.FileName:= aPathName + '\' + aFileName;
         FReportExport.frxSimpleTextExport.ShowDialog:= False;
         FReportExport.frxSimpleTextExport.OpenAfterExport:= False;
         FReportExport.frxSimpleTextExport.ShowProgress:= False;
         Result:= frxReport.Export(FReportExport.frxSimpleTextExport);
      end;
      effJPEG:
      begin
         FReportExport.frxJPEGExport.FileName:= aPathName + '\' + aFileName;
         FReportExport.frxJPEGExport.ShowDialog:= False;
         FReportExport.frxJPEGExport.ShowProgress:= False;
         FReportExport.frxJPEGExport.SeparateFiles:= False;
         Result:= frxReport.Export(FReportExport.frxJPEGExport);
      end;
      effExcelByTemplate:
      begin
         {не экспортировать отсюда}
         Result:= False;
      end;
   end;
end;

end.
