unit uServiceUtils;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.FileCtrl,
   JPEG, Data.DB, IniFiles, Generics.Collections, {$IFNDEF EXTDLL}JvZlibMultiple,{$ENDIF}
   FireDAC.Stan.Param;

   function MessageDlgExt(aMessage, aCaption: String; aDlgType: TMsgDlgType;
                          aButtons: TMsgDlgButtons): Integer;

   {сообщение об ошибке без возбуждения исключения}
   procedure ErrorMessage(aMessage: String; Args: array of const); overload;

   {сообщение об ошибке без возбуждения исключения}
   procedure ErrorMessage(aMessage: String); overload;

   {возбуждить исключенияe}
   procedure Error(aMessage: String);

   {запрос подтверждения (Да, Нет)}
   function Confirm(aMessage: String): Boolean;

   {сообщение}
   procedure Information(aMessage: String);

   {выравнивание кнопок по центру}
   procedure CenterButtons(aWidth: Integer; aButton1, aButton2: TWinControl); overload;

   {освобождение объекта с проверкой на существование}
   procedure FreeWithCheckExist(Instance: TObject);

   {проверяет входной параметр валидность ID}
   function IsNullID(aValue: Variant): Boolean;

   {Если Value=Null, то возвращаем ReplaceValue}
   function isNull(aValue, aReplaceValue: Variant): Variant;

   {Если Value=aNullValue, то возвращаем Null}
   function ifNull(aValue, aNullValue: Variant): Variant;

   {очистить список}
   procedure ClearList(aList: TList);

   {очистить и удалить список}
   procedure ClearAndFreeList(aList: TList);

   {очистить типизированный список}
   procedure ClearTypedList(aList: TList<TObject>);

   {очистить и удалить типизированный список}
   procedure ClearAndFreeTypedList(aList: TList<TObject>);

   {покать фото в имедже}
   function ShowPhoto(aPicture: TPicture; aPhoto: TJPEGImage): Boolean;

   {получить фото с Blob поля}
   function GetPhotoFromBlob(aField: TBlobField): TJPEGImage;

   {создать JPEG c Image-a}
   function CreateJEPG(aPicture: TPicture): TJPEGImage;

   {шифрование/дешифрование строки}
   function CodeString(sText: String; aCrypt: Boolean): String;

   {получение родительской формы для компонента}
   function GetParentForm(aControl: TWinControl): TForm;

 {$IFNDEF EXTDLL}
   {архивирование каталога}
   procedure CompressDirectory(aSource, aFileName: String);

   {разархивирование файла}
   procedure DecompressFile(aFileName, aOutput: String);
 {$ENDIF}

   {выбор каталога}
   function ChooseDirectory(aOwner: TWinControl; aCaption: String; var vFolder: String): Boolean;

   {{получить имя файла без расширения}
   function ExtractFileNameWithoutExt(aFileName: String): String;

   function VarEquals(const Value1, Value2: Variant): Boolean;

   {добавить разделители хэш сумме}
   function HashAddDelimiter(aValue: String): String;

   function LoadPhotoToParam(aPhoto: TJPEGImage; aParam: TFDParam): Boolean;

   function GetCurrentHID(aValue: Integer): String;

   procedure ControlSetFocus(aControl: TWinControl);

   //   RenameFile(Application.ExeName, ExtractFileDir(Application.ExeName)+'\Cards_old_Version.exe');

implementation

function MessageDlgExt(aMessage, aCaption: String; aDlgType: TMsgDlgType;
                       aButtons: TMsgDlgButtons): Integer;
var oIcon: Cardinal;
    oButton: Cardinal;
begin
   {иконка диалога сообщения}
   case aDlgType of
      mtWarning:
      begin
         oIcon:= MB_ICONERROR;
      end;
      mtError:
      begin
         oIcon:= MB_ICONERROR;
      end;
      mtInformation:
      begin
         oIcon:= MB_ICONINFORMATION;
      end;
      mtConfirmation:
      begin
         oIcon:= MB_ICONQUESTION;
      end;
      mtCustom:
      begin
         oIcon:= MB_USERICON;
      end
      else oIcon:= 0;
   end;

   if (mbYes in aButtons) or
      (mbOk in aButtons)
   then
   begin
      oButton:= MB_OK;
   end;

   if (mbYes in aButtons) and
      (mbNo in aButtons)
   then
   begin
      oButton:= MB_YESNO;
   end;

   if (mbOK in aButtons) and
      (mbCancel in aButtons)
   then
   begin
      oButton:= MB_OKCANCEL;
   end;

   {MB_OK
    MB_OKCANCEL
    MB_ABORTRETRYIGNORE
    MB_YESNOCANCEL
    MB_YESNO
    MB_RETRYCANCEL}

   Result:= Application.MessageBox(PWideChar(aMessage), PWideChar(aCaption), oIcon or oButton);
end;

procedure ErrorMessage(aMessage: String; Args: array of const);
begin
   MessageDlgExt(Format(aMessage, Args), 'ОШИБКА', mtError, [mbOK]);
end;

procedure ErrorMessage(aMessage: String); overload;
begin
   MessageDlgExt(aMessage, 'ОШИБКА', mtError, [mbOK]);
end;

procedure Error(aMessage: String);
begin
   raise Exception.Create(aMessage);
end;

function Confirm(aMessage: String): Boolean;
begin
   if (aMessage <> '') and (aMessage[Length(aMessage)] <> '?')
   then
   begin
      aMessage:= aMessage + '?';
   end;

   Result:= MessageDlgExt(aMessage, 'ПОДТВЕРЖДЕНИЕ', mtConfirmation, [mbYes, mbNo]) = mrYes;
   Application.ProcessMessages;
end;

procedure Information(aMessage: String);
begin
   MessageDlgExt(aMessage, 'ИНФОРМАЦИЯ', mtInformation, [mbOK]);
end;

procedure CenterButtons(aWidth: Integer; aButton1, aButton2: TWinControl);
var iWidth: Integer;
    iLeft: Integer;
begin
   iWidth:= 0;
   if aButton1.Visible
   then
   begin
      iWidth:= iWidth + AButton1.Width;
   end;

   if aButton2.Visible
   then
   begin
      iWidth:= iWidth + AButton2.Width;
   end;
   if aButton1.Visible and aButton2.Visible
   then
   begin
      Inc(iWidth, 10);
   end;

   iLeft:= (aWidth div 2) - (iWidth div 2);
   if (iLeft <= 0)
   then
   begin
      iLeft:= 1;
   end;

   if aButton1.Visible and aButton2.Visible
   then
   begin
      AButton1.Left:= iLeft;
      AButton2.Left:= iLeft + 10 + AButton1.Width + 1;
   end
   else
   if aButton1.Visible
   then
   begin
      AButton1.Left:= iLeft;
   end
   else
   if aButton2.Visible
   then
   begin
      AButton2.Left:= iLeft;
   end;
end;

procedure FreeWithCheckExist(Instance: TObject);
begin
  if Assigned(Instance) then
    Instance.Free;

  Instance := nil;
end;

function IsNullID(aValue: Variant): Boolean;
begin
   Result:= VarIsEmpty(aValue) or
            VarIsNull(aValue) or
            (VarToStr(aValue) = '') or
            (VarToStr(aValue) = '0');
end;

function isNull(aValue, aReplaceValue: Variant): Variant;
begin
   if aValue = Null
   then
   begin
      Result:= aReplaceValue;
   end
   else
   begin
      Result:= aValue;
   end;
end;

function ifNull(aValue, aNullValue: Variant): Variant;
begin
   if (aValue = aNullValue)
   then
   begin
      Result:= Null
   end
   else
   begin
      Result:= aValue;
   end;
end;

procedure ClearList(aList: TList);
var i: Integer;
begin
   if Assigned(aList) and
      not (aList = nil)
   then
   begin
      for i:= 0 to aList.Count - 1 do
      begin
         TObject(aList.Items[i]).Free;
      end;
      aList.Clear;
   end;
end;

procedure ClearAndFreeList(aList: TList);
begin
   if Assigned(aList) and
      not (aList = nil)
   then
   begin
      ClearList(aList);
      aList.Free;
      aList:= nil;
   end;
end;

function ShowPhoto(aPicture: TPicture; aPhoto: TJPEGImage): Boolean;
begin
   Result:= True;
   if Assigned(aPhoto) and
      (not (aPhoto = nil))
   then
   begin
      aPicture.Bitmap.Assign(aPhoto);
      Result:= True;
   end;
end;

function GetPhotoFromBlob(aField: TBlobField): TJPEGImage;
var oMemoryStream: TMemoryStream;
begin
   Result:= nil;
   if ((aField.DataSet.Active) and
       (not aField.IsNull) and
       not (aField.AsString = ''))
   then
   begin
      oMemoryStream:= TmemoryStream.Create;
      Result:= TJPEGImage.Create;
      try
         oMemoryStream.Position:= 0;
         aField.SaveToStream(oMemoryStream);
         oMemoryStream.Position:= 0;
         Result.LoadFromStream(oMemoryStream);
      finally
         oMemoryStream.Free;
      end;
   end;
end;

function CreateJEPG(aPicture: TPicture): TJPEGImage;
begin
   Result:= nil;
   if not (aPicture.Graphic = nil)
   then
   begin
      Result:= TJPEGImage.Create;
      Result.Assign(aPicture.Graphic);

      if (Result.Width > 512) or
         (Result.Height > 512)
      then
      begin
         Result.CompressionQuality:= 35;
         Result.Compress;
      end;
   end;
end;

function CodeString(sText: String; aCrypt: Boolean): String;
const
   Pas=10;
var
  i: Integer;
  iDelta: Integer;
  iRes: Integer;
begin
   Result:= '';
   for i:= 1 to Length(sText) do
   begin
      iDelta:= ((i xor Pas) mod (256 - 32));

      if aCrypt
      then
      begin
        iRes:= ((Ord(sText[i]) + iDelta) mod (256 - 32)) + 32;
      end
      else
      begin
        iRes:= Ord(sText[i]) - iDelta - 32;
        if (iRes < 32)
        then
        begin
           iRes:= iRes + 256 - 32;
        end;
      end;

      Result:= Result + Chr(iRes);
   end;
end;

function GetParentForm(aControl: TWinControl): TForm;
var oParent: TWinControl;
begin
   oParent:= aControl;
   while Assigned(oParent) and
        not (oParent.Parent is TForm) do
   begin
      oParent:= oParent.Parent;
   end;

   if Assigned(oParent) and
      (oParent is TForm)
   then
   begin
      Result:= TForm(oParent);
   end;
end;

procedure ClearTypedList(aList: TList<TObject>);
var i: Integer;
begin
   if Assigned(aList) and
      not (aList = nil)
   then
   begin
      for i:= 0 to aList.Count - 1 do
      begin
         TObject(aList.Items[i]).Free;
      end;
      aList.Clear;
   end;
end;

procedure ClearAndFreeTypedList(aList: TList<TObject>);
begin
   if Assigned(aList) and
      not (aList = nil)
   then
   begin
      ClearTypedList(aList);
      aList.Free;
      aList:= nil;
   end;
end;

{$IFNDEF EXTDLL}
procedure CompressDirectory(aSource, aFileName: String);
var
  oZip: TJvZlibMultiple;
begin
  oZip:= TJvZlibMultiple.Create(nil);
  try
     oZip.CompressDirectory(aSource, True, aFileName);
  finally
     oZip.Free;
  end;
end;

procedure DecompressFile(aFileName, aOutput: String);
var oZip: TJvZlibMultiple;
begin
   oZip:= TJvZlibMultiple.Create(nil);

   try
      oZip.DecompressFile(aFileName, aOutput, True);
   finally
      oZip.Free;
   end;
end;
{$ENDIF}

function ChooseDirectory(aOwner: TWinControl; aCaption: String; var vFolder: String): Boolean;
begin
   Result:= False;
   if aCaption = ''
   then
   begin
      aCaption:= 'Выберите каталог';
   end;

   if SelectDirectory(aCaption, '', vFolder, [sdNewUI], aOwner)
   then
   begin
      Result:= True;
   end;
end;

function ExtractFileNameWithoutExt(aFileName: String): String;
var sFileExt: String;
begin
   {имя файла с расширением}
   Result:= ExtractFileName(aFileName);
   {расширение файла}
   sFileExt:= ExtractFileExt(aFileName);
   {имя файла без расширения}
   Result:= Copy(Result, 1, Length(Result) - Length(sFileExt));
end;

function VarEquals(const Value1, Value2: Variant): Boolean;
begin
   Result:= False;
   try
      Result:= Value1 = Value2;
   except
   end;
end;

function HashAddDelimiter(aValue: String): String;
begin
   Result:= aValue;

   if Length(aValue) = 32
   then
   begin
      Result:= Copy(aValue, 1, 8) + '-' +
               Copy(aValue, 9, 8) + '-' +
               Copy(aValue, 17, 8) + '-' +
               Copy(aValue, 25, 8);
   end;
end;

function LoadPhotoToParam(aPhoto: TJPEGImage; aParam: TFDParam): Boolean;
var oStream: TStream;
begin
   Result:= False;

   if not Assigned(aPhoto) and
      aPhoto.Empty
   then
   begin
      //aParam.
      Exit;
   end;

   oStream:= TMemoryStream.Create;
   try
      aPhoto.SaveToStream(oStream);
      oStream.Position:= 0;
      oStream.Size;

      aParam.LoadFromStream(oStream, ftBlob);

      Result:= True;
   finally
      oStream.Free;
   end;
end;

function GetCurrentHID(aValue: Integer): String;
const HID_SIZE = 4;
begin
   Result:= IntToStr(aValue);
   Result:= StringOfChar('0', HID_SIZE - Length(Result)) + Result;
end;

procedure ControlSetFocus(aControl: TWinControl);
begin
   if (aControl.Visible) and (aControl.Enabled)
   then
   begin
      aControl.SetFocus;
   end;
end;

end.
