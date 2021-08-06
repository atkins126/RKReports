{*******************************************************}
{                                                       }
{       Cards Report                                    }
{                                                       }
{       Copyright (c) 2018 - 2021 Sergey Lubkov         }
{                                                       }
{*******************************************************}

unit CR.Application;

interface

uses
  System.Classes, System.SysUtils, System.Variants,
  App.Constants, App.Options, App.DB.Options, App.DB.Application, CR.Options,
  App.DB.Connection, App.MSSQL.Connection;

type
  TCRApplication = class(TCLDBApplication)
  private
    function GetDBConnection: TCLMSConnection;
    function GetOptions: TCROptions;
    function GetLogicDate: TDate;
  protected
    function OptionsClass(): TCLOptionsClass; override;
    function DBConnectionClass(): TCLDBConnectionClass; override;
    function GetApplicationName(): string; override;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy(); override;

    procedure ApplyConnectionParams;

    property Options: TCROptions read GetOptions;
    property DBConnection: TCLMSConnection read GetDBConnection;
    property LogicDate: TDate read GetLogicDate;
  end;

var
  CRApplication: TCRApplication;

implementation

{ TCRApplication }

constructor TCRApplication.Create(Owner: TComponent);
begin
  inherited;

  AppVersion := '1.0.0';
end;

destructor TCRApplication.Destroy;
begin

  inherited;
end;

function TCRApplication.GetDBConnection: TCLMSConnection;
begin
  Result := TCLMSConnection(FDBConnection);
end;

function TCRApplication.GetOptions: TCROptions;
begin
  Result := TCROptions(FOptions);
end;

function TCRApplication.GetLogicDate: TDate;
begin
  Result := Options.LogicDate;
end;

function TCRApplication.OptionsClass: TCLOptionsClass;
begin
  Result := TCROptions;
end;

function TCRApplication.DBConnectionClass: TCLDBConnectionClass;
begin
  Result := TCLMSConnection;
end;

function TCRApplication.GetApplicationName: string;
begin
  Result := 'Card Reports';
end;

procedure TCRApplication.ApplyConnectionParams;
begin
  DBConnection.Server := Options.Server;
  DBConnection.UserName := Options.UserName;
  DBConnection.Password := Options.Password;
  DBConnection.Database := Options.Database;
  DBConnection.Port := Options.Port;
end;

end.
