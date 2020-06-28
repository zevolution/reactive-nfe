unit NotaFiscal.Status.Entity;

interface

uses
  System.UITypes;

type
  TStatusNFe = (snCancelada, snEnviada, snAguardandoEnvio);

type
  TStatusNFeHelper = record Helper for TStatusNFe
  private
    const StatusDescription: array [TStatusNFe] of string = (
      'Cancelada', 'Enviada Com Sucesso!', 'Aguardando Envio'
    );
    const StatusColors: array [TStatusNFe] of Cardinal = (
      TAlphaColors.Tomato, TAlphaColors.Mediumseagreen, TAlphaColors.Gray
    );
  public
    function Description: String;
    function Color: Cardinal;
  end;
implementation

{ TStatusNFeHelper }

function TStatusNFeHelper.Color: Cardinal;
begin
  Result := StatusColors[Self];
end;

function TStatusNFeHelper.Description: String;
begin
  Result := StatusDescription[Self];
end;

end.
