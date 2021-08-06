{*******************************************************}
{                                                       }
{       Cards Report                                    }
{                                                       }
{       Copyright (c) 2018 - 2021 Sergey Lubkov         }
{                                                       }
{*******************************************************}

unit CR.Options;

interface

uses
  System.Classes, System.SysUtils, System.Variants, App.Options, App.Params,
  App.DB.Options, {$IFDEF REG_STORAGE}System.Win.Registry{$ELSE}System.IniFiles{$ENDIF};

type
  TCROptions = class(TCLDBOptions)
  private
  {$IFDEF REG_STORAGE}
    FDayStart: TRegStringParam;
  {$ELSE}
    FDayStart: TIniStringParam;
  {$ENDIF}

    function GetLogicDate: TDate;
    function GetDayStart: string;
  public
    constructor Create(Owner: TComponent); override;
    destructor Destroy(); override;

    procedure Load(const Context: {$IFDEF REG_STORAGE}TRegistry{$ELSE}TIniFile{$ENDIF}); override;
    procedure Save(const Context: {$IFDEF REG_STORAGE}TRegistry{$ELSE}TIniFile{$ENDIF}); override;

    procedure LoadSettingsFromDB(); override;

    property DayStart: string read GetDayStart;
    property LogicDate: TDate read GetLogicDate;
  end;

implementation

const
  SettingsGroup = 'Settings';
  DayStartParamName = 'DayStart';
  DeyStartDefault = '08:00';

{ TCROptions }

constructor TCROptions.Create(Owner: TComponent);
begin
  inherited;

{$IFDEF REG_STORAGE}
  FDayStart := TRegStringParam.Create(DayStartParamName, SettingsGroup, DeyStartDefault);
{$ELSE}
  FDayStart := TIniStringParam.Create(DayStartParamName, SettingsGroup, DeyStartDefault);
{$ENDIF}
end;

destructor TCROptions.Destroy;
begin
  FDayStart.Free;

  inherited;
end;

procedure TCROptions.Load(const Context: {$IFDEF REG_STORAGE}TRegistry{$ELSE}TIniFile{$ENDIF});
begin
  inherited;

  FPassword.Load(Context);
  FDayStart.Load(Context);
end;

procedure TCROptions.Save(const Context: {$IFDEF REG_STORAGE}TRegistry{$ELSE}TIniFile{$ENDIF});
begin
  inherited;

  FPassword.Save(Context);
  FDayStart.Save(Context);
end;

function TCROptions.GetDayStart: string;
begin
  Result := FDayStart.Value;
end;

function TCROptions.GetLogicDate: TDate;
var
  DaySrartTime: TDateTime;
begin
  Result := Date;
  if not TryStrToTime(DayStart, DaySrartTime) then
    DaySrartTime := StrToTime(DeyStartDefault);

  if Time < DaySrartTime then
    Result := Date - 1;
end;

procedure TCROptions.LoadSettingsFromDB;
begin
  inherited;

end;

end.
