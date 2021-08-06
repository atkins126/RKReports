unit eduDialog;

interface

uses
  Windows, Messages, SysUtils, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Vcl.ImgList, System.Actions, Vcl.ActnList,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore,
  dxSkinOffice2013White, cxButtons, cxClasses;

type
  TedDialog = class(TForm)
    paBottom: TPanel;
    ActionCommon: TActionList;
    acClose: TAction;
    acSuccess: TAction;
    buCancel: TcxButton;
    buOK: TcxButton;
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure acCloseExecute(Sender: TObject);
    procedure acSuccessExecute(Sender: TObject);
  private
  protected
    function Validate(var vMessage: String): Boolean; virtual;
    procedure ErrorMessage(const Error: string);
    procedure OKAction; virtual;

    {означивание редактируемых переменных}
    procedure SetValues(); virtual;

    {запись отредактированных значений}
    procedure PostValues(); virtual;

    procedure CenterButtons(); virtual;
  public
    constructor Create(Owner: TComponent); override;

    function Execute(): Boolean; virtual;
  end;

implementation

uses
  uServiceUtils, dmuSysImages;

{$R *.DFM}

constructor TedDialog.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  {означивание редактируемых переменных}
  SetValues;
end;

procedure TedDialog.FormResize(Sender: TObject);
begin
  CenterButtons;
end;

procedure TedDialog.FormShow(Sender: TObject);
begin
   FormResize(Sender);
end;

procedure TedDialog.acCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TedDialog.acSuccessExecute(Sender: TObject);
var
  ErrorText: String;
begin
  if not Validate(ErrorText) then
  begin
    ErrorMessage(ErrorText);
    ModalResult := mrNone;
    Exit;
  end;

  {запись отредактированных значений}
  PostValues();
  OKAction;
end;

function TedDialog.Validate(var vMessage: String): Boolean;
begin
  Result := False;
  vMessage := 'Has error';

{$IFDEF ASProtect}
  {$I include\aspr_crypt_begin1.inc}
  if not Result then
  begin
    Result := True;
    vMessage := '';
  end;
  {$I include\aspr_crypt_end1.inc}

  {$I include\aspr_crypt_begin5.inc}
  if not Result then
  begin
    Result := True;
    vMessage := '';
  end;
  {$I include\aspr_crypt_end5.inc}

  {$I include\aspr_crypt_begin15.inc}
  if Result then
  begin
    Result := False;
    vMessage := '';
  end;
  {$I include\aspr_crypt_end15.inc}
{$ELSE}
  Result := True;
  vMessage := '';
{$ENDIF}
end;

procedure TedDialog.ErrorMessage(const Error: string);
begin
  uServiceUtils.ErrorMessage(Error);
end;

procedure TedDialog.OKAction;
begin

end;

procedure TedDialog.SetValues;
begin

end;

procedure TedDialog.PostValues;
begin

end;

procedure TedDialog.CenterButtons;
begin
  uServiceUtils.CenterButtons(Self.Width, buOK, buCancel);
end;

function TedDialog.Execute: Boolean;
begin
  Result := ShowModal = mrOK;
end;

end.
