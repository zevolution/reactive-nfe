unit Redis.PubSub.Service;

interface

uses
  System.SysUtils,

  PubSub.Interfaces,
  ConnectionServices.Interfaces,

  Redis.Commons,
  Redis.Client,
  Redis.NetLib.INDY,
  Redis.Values;

type
  TRedisPubSubService = class(TInterfacedObject, iPubSub)
  private
    class var FInstance: iPubSub;
    FRedis: iRedisClient;
    FConnService: iConnectionServices;
    constructor InternalCreate(AConnService: iConnectionServices);
    function InstanciaRedis(AConnService: iConnectionServices): IRedisClient;
  public
    constructor Create(AConnService: iConnectionServices);
    class function New(AConnService: iConnectionServices): iPubSub;
    function Publish(ACanal, AMensagem: String): Integer;
    procedure Subscribe(
      const ACanais: array of String;
      ACallback: TProc<String, String>;
      AContinuaCallback: TPubSubContinueCallback = nil;
      ADepoisDeSeInscrever: TProc = nil);
  end;

implementation

{ TRedisPubSubService }

constructor TRedisPubSubService.Create(AConnService: iConnectionServices);
begin
  raise Exception.Create('TRedisPubSubService.Create() invalidado. Utilize o método New().');
end;

function TRedisPubSubService.InstanciaRedis(AConnService: iConnectionServices): IRedisClient;
begin
  {$IFDEF DEBUG}
    Result := NewRedisClient(AConnService.IP, AConnService.Port);
  {$ELSE IFDEF RELEASE}
    Result := NewRedisClient(AConnService.IP, AConnService.Port);
    Result.AUTH(AConnService.Password);
  {$ENDIF}
end;

constructor TRedisPubSubService.InternalCreate(AConnService: iConnectionServices);
begin
  if not Assigned(AConnService) then
    raise Exception.Create(
      'Para inicialização do serviço de RedisPubSub, é imprescindível um objeto de configurações para conexão.'
    );

  FConnService := AConnService;
  FRedis       := InstanciaRedis(FConnService);
end;

class function TRedisPubSubService.New(AConnService: iConnectionServices): iPubSub;
begin
  if not Assigned(FInstance) then
    FInstance := Self.InternalCreate(AConnService);
  Result := FInstance;
end;

function TRedisPubSubService.Publish(ACanal, AMensagem: String): Integer;
begin
  Result := FRedis.PUBLISH(ACanal, AMensagem);
end;

procedure TRedisPubSubService.Subscribe(
  const ACanais: array of String;
  ACallback: TProc<String, String>;
  AContinuaCallback: TPubSubContinueCallback;
  ADepoisDeSeInscrever: TProc);
var
  LRedis: IRedisClient;
begin
  LRedis := InstanciaRedis(FConnService);
  LRedis.SUBSCRIBE(ACanais, ACallback, TRedisTimeoutCallback(AContinuaCallback), ADepoisDeSeInscrever);
end;

end.
