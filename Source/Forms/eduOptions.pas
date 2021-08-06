unit eduOptions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, eduDialog, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, dxSkinsCore, dxSkinOffice2013White,
  Vcl.StdCtrls, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, cxButtons;

type
  TedOptions = class(TedDialog)
    laServer: TLabel;
    edServer: TEdit;
    laPort: TLabel;
    edPort: TEdit;
    laUsername: TLabel;
    edUsername: TEdit;
    laPassword: TLabel;
    edPassword: TEdit;
    laDatabase: TLabel;
    edDatabase: TEdit;
    buTestConnectionToRK: TcxButton;
    procedure buTestConnectionToRKClick(Sender: TObject);
  private
  protected
    procedure SetValues(); override;
    procedure PostValues(); override;
  public
  end;

implementation

uses
  CR.Application, App.MSSQL.Connection, App.SysUtils;

{$R *.dfm}

{ TedOptions }

procedure TedOptions.SetValues;
begin
  edServer.Text := CRApplication.Options.Server;
  edPort.Text := IntToStr(CRApplication.Options.Port);
  edUserName.Text := CRApplication.Options.UserName;
  edPassword.Text := CRApplication.Options.Password;
  edDatabase.Text := CRApplication.Options.Database;
end;

procedure TedOptions.PostValues;
var
  Port: Integer;
begin
  if not TryStrToInt(edPort.Text, Port) then
    Port := 0;

  CRApplication.Options.Server := edServer.Text;
  CRApplication.Options.Port := Port;
  CRApplication.Options.UserName := edUserName.Text;
  CRApplication.Options.Password := edPassword.Text;
  CRApplication.Options.Database := edDatabase.Text;
end;

procedure TedOptions.buTestConnectionToRKClick(Sender: TObject);
var
  Connection: TCLMSConnection;
  Port: Integer;
begin
  if not TryStrToInt(edPort.Text, Port) then
    Port := 0;

  Connection := TCLMSConnection.Create(Self);
  try
    Connection.Server := edServer.Text;
    Connection.Port := Port;
    Connection.UserName := edUserName.Text;
    Connection.Password := edPassword.Text;
    Connection.Database := edDatabase.Text;

    try
      Connection.Connect;
      Information('Подключение выпролнено успешно');
    except
      on E: Exception do
        ErrorMessage('Подключение не выполнено. "' + E.Message + '"');
    end;
  finally
    Connection.Free;
  end;
end;

end.
