unit Base.Repository.Interfaces;

interface

uses
  System.Generics.Collections;

type
  iBaseRepository<TEntity: class, constructor> = interface
    ['{632BE147-DA89-403C-84D6-D09F58470452}']
    function Save(AEntity: TEntity): TEntity;
    function Update(AEntity: TEntity): TEntity;
    function Delete(AEntity: TEntity): TEntity;
    function FindById(AID: Integer): TEntity;
  end;

implementation

end.
