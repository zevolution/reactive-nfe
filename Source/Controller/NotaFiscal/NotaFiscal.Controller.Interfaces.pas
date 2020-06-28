unit NotaFiscal.Controller.Interfaces;

interface

uses
  System.Generics.Collections,

  NotaFiscal.DTO;

type

  iNotaFiscalController = interface;
  iNotaFiscalControllerMethods = interface;

  iNotaFiscalController = interface
    ['{B46787FC-A050-4A66-9969-68C90D08F525}']
    function Methods: iNotaFiscalControllerMethods;
  end;

  iNotaFiscalControllerMethods = interface
    function AddNFe(ANFe: TNotaFiscalDTO)   : iNotaFiscalControllerMethods;
    function SendNFe(ANFe: TNotaFiscalDTO)  : iNotaFiscalControllerMethods;
    function CancelNFe(ANFe: TNotaFiscalDTO): iNotaFiscalControllerMethods;
    function &End                           : iNotaFiscalController;
  end;

implementation

end.
