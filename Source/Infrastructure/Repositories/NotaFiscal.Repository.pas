unit NotaFiscal.Repository;

interface

uses
  Base.Repository,
  NotaFiscal.Entity,

  Database.Connection.Interfaces;

type

  TNotaFiscalRepository = class(TBaseRepository<TNotaFiscal>)

  end;

implementation

{ TNotaFiscalRepository }

end.
