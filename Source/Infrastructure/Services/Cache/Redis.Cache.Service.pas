unit Redis.Cache.Service;

interface

uses
  System.SysUtils,
  System.Generics.Collections,

  Cache.Interfaces,
  ConnectionServices.Interfaces,

  Redis.Commons,
  Redis.Client,
  Redis.NetLib.INDY,
  Redis.Values;

type
  TRedisCacheService = class(TInterfacedObject, iCache)
  private
    class var FInstance: iCache;
    FRedis: iRedisClient;
    FConnService: iConnectionServices;
    constructor InternalCreate(AConnService: iConnectionServices);
    function InstanciaRedis(AConnService: iConnectionServices): IRedisClient;
  public
    constructor Create(AConnService: iConnectionServices);
    class function New(AConnService: iConnectionServices): iCache;
    function Get(AKey: String): String;
    function Exists(AKey: String): Boolean;
    function SetCache(AKey, AValue: String): Boolean;
    function Keys(APattern: String): TArray<String>;
  end;

implementation

uses
  WinApi.Windows;

{ TRedisCacheService }

constructor TRedisCacheService.Create(AConnService: iConnectionServices);
begin
  raise Exception.Create('TRedisCacheService.Create() invalidado. Utilize o método New().');
end;

function TRedisCacheService.Exists(AKey: String): Boolean;
begin
  Result := FRedis.EXISTS(AKey);
end;

function TRedisCacheService.Get(AKey: String): String;
begin
  if FRedis.&GET(AKey).HasValue then
    Result := FRedis.&GET(AKey).Value
  else
  begin
    Result := '0';
    OutputDebugString(PWideChar('Falha na obtenção dos dados em cache a partir da chave: ' + AKey));
  end;
end;

function TRedisCacheService.InstanciaRedis(AConnService: iConnectionServices): IRedisClient;
begin
  Result := NewRedisClient(AConnService.IP, AConnService.Port);
  {$IFNDEF DEBUG}
    Result.AUTH(AConnService.Password);
  {$ENDIF}
end;

constructor TRedisCacheService.InternalCreate(AConnService: iConnectionServices);
begin
  if not Assigned(AConnService) then
    raise Exception.Create(
      'Para inicialização do serviço de RedisCache, é imprescindível um objeto de configurações para conexão.'
    );

  FConnService := AConnService;
  FRedis       := InstanciaRedis(FConnService);

  OutputDebugString('Inicializando serviço de cache utilizando Redis.');
end;

function TRedisCacheService.Keys(APattern: String): TArray<String>;
var
  LKeys: TArray<TRedisNullable<String>>;
  Index: Integer;
begin
  if FRedis.KEYS(APattern).HasValue then
  begin
    LKeys := FRedis.KEYS(APattern).Value;
    SetLength(Result, Length(LKeys));
    for Index := Ord(Low(LKeys)) to Ord(High(LKeys)) do
    begin
      Result[Index] := LKeys[Index];
    end;
  end;
end;

class function TRedisCacheService.New(AConnService: iConnectionServices): iCache;
begin
  if not Assigned(FInstance) then
    FInstance := Self.InternalCreate(AConnService);
  Result := FInstance;
end;

function TRedisCacheService.SetCache(AKey, AValue: String): Boolean;
begin
  Result := FRedis.&SET(AKey, AValue);
end;

end.
