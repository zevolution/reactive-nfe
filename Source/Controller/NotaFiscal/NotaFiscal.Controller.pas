unit NotaFiscal.Controller;

interface

uses
  System.SysUtils,
  System.Generics.Collections,

  NotaFiscal.DTO,
  NotaFiscal.Entity,
  NotaFiscal.Service,
  NotaFiscal.Controller.Interfaces,

  ConnectionServices.Interfaces,
  PubSub.Interfaces,
  Redis.Config,
  Redis.PubSub.Service,

  REST.JSON,
  System.JSON;

type

  TNotaFiscalController = class(TInterfacedObject, iNotaFiscalController, iNotaFiscalControllerMethods)
  private
    class var FInstance: iNotaFiscalController;
    FNotaFiscalService: TNotaFiscalService;
    FConnetionServices: iConnectionServices;
    FPubSub           : iPubSub;
    constructor InternalCreate;
  public
    constructor Create;
    destructor Destroy; override;
    class function New                      : iNotaFiscalController;
    function Methods                        : iNotaFiscalControllerMethods;
    function AddNFe(ANFe: TNotaFiscalDTO)   : iNotaFiscalControllerMethods;
    function SendNFe(ANFe: TNotaFiscalDTO)  : iNotaFiscalControllerMethods;
    function CancelNFe(ANFe: TNotaFiscalDTO): iNotaFiscalControllerMethods;
    function &End                           : iNotaFiscalController;
  end;

implementation

{ TNotaFiscalController }

function TNotaFiscalController.AddNFe(
  ANFe: TNotaFiscalDTO): iNotaFiscalControllerMethods;
var
  LNFe   : TNotaFiscal;
  LNFeDTO: TNotaFiscalDTO;
begin
  if not Assigned(ANFe) then
    raise Exception.Create('Como vou adicionar uma NFe, sem uma NFe?');

  try
    LNFe              := TNotaFiscal.Create;
    LNFe.Emitente     := ANFe.Emitente;
    LNFe.Destinatario := ANFe.Destinatario;

    LNFe := FNotaFiscalService.AddNFe(LNFe);

    LNFeDTO              := TNotaFiscalDTO.Create;
    LNFeDTO.UUID         := LNFe.Uuid;
    LNFeDTO.Emitente     := LNFe.Emitente;
    LNFeDTO.Destinatario := LNFe.Destinatario;
    LNFeDTO.NumeroNfe    := LNFe.NumeroNfe;
    LNFeDTO.Status       := LNFe.Status;

    FPubSub.Publish(rcAddNFe.Name, TJSON.ObjectToJsonString(LNFeDTO));
  finally
    FreeAndNil(LNFe);
    FreeAndNil(LNFeDTO);
  end;

  Result := Self;
end;

constructor TNotaFiscalController.Create;
begin
  raise Exception.Create('TRedisConfig.Create() invalidado. Utilize o método New().');
end;

function TNotaFiscalController.CancelNFe(
  ANFe: TNotaFiscalDTO): iNotaFiscalControllerMethods;
var
  LNFe   : TNotaFiscal;
  LNFeDTO: TNotaFiscalDTO;
begin
  if not Assigned(ANFe) then
    raise Exception.Create('Como vou excluir uma NFe, sem uma NFe?');

  try
    LNFe              := TNotaFiscal.Create;
    LNFe.Uuid         := ANFe.UUID;

    LNFe              := FNotaFiscalService.CancelNFe(LNFe);

    LNFeDTO              := TNotaFiscalDTO.Create;
    LNFeDTO.UUID         := LNFe.Uuid;
    LNFeDTO.Status       := LNFe.Status;

    FPubSub.Publish(rcCancelNFe.Name, TJSON.ObjectToJsonString(LNFeDTO))
  finally
    FreeAndNil(LNFe);
    FreeAndNil(LNFeDTO);
  end;

  Result := Self;
end;

destructor TNotaFiscalController.Destroy;
begin
  FreeAndNil(FNotaFiscalService);
  inherited;
end;

function TNotaFiscalController.&End: iNotaFiscalController;
begin
  Result := Self;
end;

constructor TNotaFiscalController.InternalCreate;
begin
  inherited;
  FNotaFiscalService := TNotaFiscalService.Create;
  FConnetionServices := TRedisConfig.New;
  FPubSub            := TRedisPubSubService.New(FConnetionServices);
end;

function TNotaFiscalController.Methods: iNotaFiscalControllerMethods;
begin
  Result := Self;
end;

class function TNotaFiscalController.New: iNotaFiscalController;
begin
  if not Assigned(FInstance) then
    FInstance := Self.InternalCreate;
  Result := FInstance;
end;

function TNotaFiscalController.SendNFe(
  ANFe: TNotaFiscalDTO): iNotaFiscalControllerMethods;
var
  LNFe   : TNotaFiscal;
  LNFeDTO: TNotaFiscalDTO;
begin
  if not Assigned(ANFe) then
    raise Exception.Create('Como vou enviar uma NFe, sem uma NFe?');

  try
    LNFe              := TNotaFiscal.Create;
    LNFe.Uuid         := ANFe.UUID;

    LNFe              := FNotaFiscalService.SendNFe(LNFe);

    LNFeDTO              := TNotaFiscalDTO.Create;
    LNFeDTO.UUID         := LNFe.Uuid;
    LNFeDTO.Status       := LNFe.Status;

    FPubSub.Publish(rcSendNFe.Name, TJSON.ObjectToJsonString(LNFeDTO))
  finally
    FreeAndNil(LNFe);
    FreeAndNil(LNFeDTO);
  end;

  Result := Self;
end;

end.
