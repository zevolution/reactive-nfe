unit NotaFiscal.Entity;

interface

uses
  Base.Entity,

  NotaFiscal.Status.Entity;

type
  TNotaFiscal = class(TBaseEntity)
  private
    FDestinatario: String;
    FNumeroNfe   : String;
    FEmitente    : String;
    FStatus      : TStatusNFe;
    procedure SetDestinatario(const Value: String);
    procedure SetEmitente(const Value: String);
    procedure SetNumeroNfe(const Value: String);
    procedure SetStatus(const Value: TStatusNFe);
  public
    property Emitente    : String read FEmitente write SetEmitente;
    property Destinatario: String read FDestinatario write SetDestinatario;
    property NumeroNfe   : String read FNumeroNfe write SetNumeroNfe;
    property Status      : TStatusNFe read FStatus write SetStatus;

  end;
implementation

{ TNotaFiscal }

procedure TNotaFiscal.SetDestinatario(const Value: String);
begin
  FDestinatario := Value;
end;

procedure TNotaFiscal.SetEmitente(const Value: String);
begin
  FEmitente := Value;
end;

procedure TNotaFiscal.SetNumeroNfe(const Value: String);
begin
  FNumeroNfe := Value;
end;

procedure TNotaFiscal.SetStatus(const Value: TStatusNFe);
begin
  FStatus := Value;
end;

end.
