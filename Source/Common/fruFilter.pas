unit fruFilter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinOffice2013White, cxLabel, Vcl.ExtCtrls, Vcl.Menus, Vcl.StdCtrls,
  cxButtons, Vcl.DBCtrls;

type
   TfrFilter = class(TFrame)
      Bevel: TBevel;
      buFilterClear: TcxButton;
      paMain: TPanel;
      paFilterClear: TPanel;
    laCaption: TLabel;
   private
      FKeyValue: Variant;
      FOnChange: TNotifyEvent;
   protected
      procedure DoChange();
      function GetKeyValue: Variant; virtual;
      procedure SetKeyValue(const Value: Variant); virtual;
   public
      property OnChange: TNotifyEvent read FOnChange write FOnChange;
      property KeyValue: Variant read GetKeyValue write SetKeyValue;
   end;

implementation

{$R *.dfm}

uses uServiceUtils;

{ TfrFilter }

procedure TfrFilter.DoChange;
begin
   if Assigned(FOnChange)
   then
   begin
      FOnChange(Self);
   end;
end;

function TfrFilter.GetKeyValue: Variant;
begin

end;

procedure TfrFilter.SetKeyValue(const Value: Variant);
begin
   if not VarEquals(FKeyValue, Value)
   then
   begin
      FKeyValue:= Value;
//      DoChange();
   end;
end;

end.
