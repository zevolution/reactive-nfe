unit MemCached.Cache.Service;

interface

uses
  System.SysUtils,
  System.Generics.Collections,

  Cache.Interfaces,
  ConnectionServices.Interfaces;

type
  {* An example of another cache service. Try to implement it in Delphi. :D *}
  TMemCachedCacheService = class(TInterfacedObject, iCache)
  private
    class var FInstance: iCache;
    FConnService: iConnectionServices;
    constructor InternalCreate(AConnService: iConnectionServices);
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

{ TMemCachedCacheService }

constructor TMemCachedCacheService.Create(AConnService: iConnectionServices);
begin
  raise Exception.Create('TMemCachedCacheService.Create() invalidado. Utilize o método New().');
end;

function TMemCachedCacheService.Exists(AKey: String): Boolean;
begin
  Result := True;
end;

function TMemCachedCacheService.Get(AKey: String): String;
begin
  Result := '700000';
end;

constructor TMemCachedCacheService.InternalCreate(AConnService: iConnectionServices);
begin
  inherited;
  if not Assigned(AConnService) then
    raise Exception.Create(
      'Para inicialização do serviço de MemCachedService, é imprescindível um objeto de configurações para conexão.'
    );

  FConnService := AConnService;

  OutputDebugString('Inicializando serviço de cache utilizando MemCached.');
end;

function TMemCachedCacheService.Keys(APattern: String): TArray<String>;
begin
  Result := TArray<String>.Create();
end;

class function TMemCachedCacheService.New(AConnService: iConnectionServices): iCache;
begin
  if not Assigned(FInstance) then
    FInstance := Self.InternalCreate(AConnService);
  Result := FInstance;
end;

function TMemCachedCacheService.SetCache(AKey, AValue: String): Boolean;
begin
  Result := True;
end;

end.
