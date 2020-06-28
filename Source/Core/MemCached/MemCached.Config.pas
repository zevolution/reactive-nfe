unit MemCached.Config;

interface

uses
  System.SysUtils,

  ConnectionServices.Interfaces;

const
  {$IFDEF DEBUG}
    MEMCACHED_IP       = '192.168.0.8';
    MEMCACHED_PORT     = 9752;
    MEMCACHED_PASSWORD = '';
  {$ELSE}
    MEMCACHED_IP       = 'memcached-12345.c99.br-leste-9-0.ec2.cloud.cachedlabs.com';
    MEMCACHED_PORT     = 26836;
    MEMCACHED_PASSWORD = '698dc19d489c4e4db73e28a713eab07b';
  {$ENDIF}

type
  {* An example of another cache service connection *}
  TMemCachedConfig = class(TInterfacedObject, iConnectionServices)
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

{ TMemCachedConfig }

constructor TMemCachedConfig.Create;
begin
  raise Exception.Create('TMemCachedConfig.Create() invalidado. Utilize o método New().');
end;

constructor TMemCachedConfig.InternalCreate;
begin
  inherited;
  FIP       := MEMCACHED_IP;
  FPort     := MEMCACHED_PORT;
  FPassword := MEMCACHED_PASSWORD;
end;

function TMemCachedConfig.IP: String;
begin
  Result := FIP;
end;

class function TMemCachedConfig.New: iConnectionServices;
begin
  if not Assigned(FInstance) then
    FInstance := Self.InternalCreate;
  Result := FInstance;
end;

function TMemCachedConfig.Password: String;
begin
  Result := FPassword;
end;

function TMemCachedConfig.Port: Integer;
begin
  Result := FPort;
end;

end.
