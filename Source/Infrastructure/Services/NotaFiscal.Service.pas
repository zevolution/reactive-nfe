unit NotaFiscal.Service;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  System.Math,

  NotaFiscal.Entity,
  NotaFiscal.Status.Entity,
  NotaFiscal.Repository,

  Database.Connection.Interfaces,
  ZevolutionConnection.Database;

type

  TNotaFiscalService = class
  private
    FDBConnection        : iDatabaseConnection;
    FNotaFiscalRepository: TNotaFiscalRepository;
  public          
    constructor Create;
    destructor Destroy; override;
    function AddNFe(ANFe: TNotaFiscal): TNotaFiscal;
    function SendNFe(ANFe: TNotaFiscal): TNotaFiscal;
    function CancelNFe(ANFe: TNotaFiscal): TNotaFiscal;
  end;

implementation

{ TNotaFiscalService }

function TNotaFiscalService.AddNFe(ANFe: TNotaFiscal): TNotaFiscal;
begin
  if not Assigned(ANFe) then
    raise Exception.Create('Cadê a nota?');

  if ANFe.Emitente.IsEmpty then
    raise Exception.Create('Poem quem tá fazendo essa papelada toda ae');

  if ANFe.Destinatario.IsEmpty then
    raise Exception.Create('Sou vidente agora? Poem ae pra quem vou gerar isso');

  ANFe.Status    := TStatusNFe.snAguardandoEnvio;
  ANFe.NumeroNfe := RandomRange(1, 100).ToString;
    
  Result := FNotaFiscalRepository.Save(ANFe);
end;

constructor TNotaFiscalService.Create;
begin
  FDBConnection         := TZevolutionConnection.New;
  FNotaFiscalRepository := TNotaFiscalRepository.Create(FDBConnection);
end;

function TNotaFiscalService.CancelNFe(ANFe: TNotaFiscal): TNotaFiscal;
begin
  if not Assigned(ANFe) then
    raise Exception.Create('Cadê a nota?');

  ANFe.Status := TStatusNFe.snCancelada;

  Result := FNotaFiscalRepository.Update(ANFe);
end;

destructor TNotaFiscalService.Destroy;
begin
  FreeAndNil(FNotaFiscalRepository);
  inherited;
end;

function TNotaFiscalService.SendNFe(ANFe: TNotaFiscal): TNotaFiscal;
begin
  if not Assigned(ANFe) then
    raise Exception.Create('Cadê a nota?');

  ANFe.Status := snEnviada;

  Result := FNotaFiscalRepository.Update(ANFe);
end;

end.
