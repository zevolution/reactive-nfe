unit NotaFiscal.DTO;

interface

uses
  NotaFiscal.Status.Entity;

type
  TNotaFiscalDTO = class
  private
    FDestinatario: String;
    FUUID: String;
    FNumeroNfe: String;
    FEmitente: String;
    FStatus: TStatusNFe;
    procedure SetDestinatario(const Value: String);
    procedure SetEmitente(const Value: String);
    procedure SetNumeroNfe(const Value: String);
    procedure SetUUID(const Value: String);
    procedure SetStatus(const Value: TStatusNFe);
  public
    property UUID         : String read FUUID write SetUUID;
    property Emitente     : String read FEmitente write SetEmitente;
    property Destinatario : String read FDestinatario write SetDestinatario;
    property NumeroNfe    : String read FNumeroNfe write SetNumeroNfe;
    property Status       : TStatusNFe read FStatus write SetStatus;
  end;

implementation

{ TNotaFiscalDTO }

procedure TNotaFiscalDTO.SetDestinatario(const Value: String);
begin
  FDestinatario := Value;
end;

procedure TNotaFiscalDTO.SetEmitente(const Value: String);
begin
  FEmitente := Value;
end;

procedure TNotaFiscalDTO.SetNumeroNfe(const Value: String);
begin
  FNumeroNfe := Value;
end;

procedure TNotaFiscalDTO.SetStatus(const Value: TStatusNFe);
begin
  FStatus := Value;
end;

procedure TNotaFiscalDTO.SetUUID(const Value: String);
begin
  FUUID := Value;
end;

end.
