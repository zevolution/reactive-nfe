unit Redis.Config;

interface

uses
  System.SysUtils,

  ConnectionServices.Interfaces;

type
  TRedisChannel = (rcAddNFe, rcSendNFe, rcCancelNFe);

  TRedisChannelHelper = record Helper for TRedisChannel
  public
    function Name: String;
  end;

const
  {$IFDEF DEBUG}
    REDIS_IP       = '192.168.0.8';
    REDIS_PORT     = 6380;
    REDIS_PASSWORD = '';
  {$ELSE}
    REDIS_IP       = 'redis-12345.c99.br-leste-9-0.ec2.cloud.redislabs.com';
    REDIS_PORT     = 15725;
    REDIS_PASSWORD = '698dc19d489c4e4db73e28a713eab07b';
  {$ENDIF}
  REDIS_CHANNELS: array [TRedisChannel] of String =(
    'ADDNFE','SENDNFE','CANCELNFE'
  );

type
  TRedisConfig = class(TInterfacedObject, iConnectionServices)
  private
    class var FInstance: iConnectionServices;
    FIP      : String;
    FPort    : Integer;
    FPassword: String;
    constructor InternalCreate;
  public
    constructor Create;
    class function New: iConnectionServices;
    function IP: String;
    function Port: Integer;
    function Password: String;
  end;

implementation

{ TRedisConfig }

constructor TRedisConfig.Create;
begin
  raise Exception.Create('TRedisConfig.Create() invalidado. Utilize o método New().');
end;

constructor TRedisConfig.InternalCreate;
begin
  inherited;
  FIP       := REDIS_IP;
  FPort     := REDIS_PORT;
  FPassword := REDIS_PASSWORD;
end;

function TRedisConfig.IP: String;
begin
  Result := FIP;
end;

class function TRedisConfig.New: iConnectionServices;
begin
  if not Assigned(FInstance) then
    FInstance := Self.InternalCreate;
  Result := FInstance;
end;

function TRedisConfig.Password: String;
begin
  Result := FPassword;
end;

function TRedisConfig.Port: Integer;
begin
  Result := FPort;
end;

{ TRedisChannelHelper }

function TRedisChannelHelper.Name: String;
begin
  Result := REDIS_CHANNELS[Self];
end;

end.
