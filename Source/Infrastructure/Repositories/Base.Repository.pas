unit Base.Repository;

interface

uses
  System.SysUtils,
  System.Generics.Collections,

  Base.Repository.Interfaces,

  Database.Connection.Interfaces;

type
  TBaseRepository<TEntity: class, constructor> = class(TInterfacedObject, iBaseRepository<TEntity>)
  protected
    FDBConnection: iDatabaseConnection;
  public
    constructor Create(ADBConnection: iDatabaseConnection);
    function Save(AEntity: TEntity): TEntity;
    function Update(AEntity: TEntity): TEntity;
    function Delete(AEntity: TEntity): TEntity;
    function FindById(AID: Integer): TEntity;
  end;

implementation

uses
  System.TypInfo;

constructor TBaseRepository<TEntity>.Create(ADBConnection: iDatabaseConnection);
begin
  FDBConnection := ADBConnection;
end;

function TBaseRepository<TEntity>.Delete(AEntity: TEntity): TEntity;
begin
  {* TODO: Implements base method in ORM to delete *}
  FDBConnection.Delete(AEntity);
  Result := AEntity;
end;

function TBaseRepository<TEntity>.FindById(AID: Integer): TEntity;
begin
  {* TODO: Implements base method in ORM to find by id *}
  FDBConnection.FindById(AID);
  Result := Default(TEntity);
end;

function TBaseRepository<TEntity>.Save(AEntity: TEntity): TEntity;
begin
  {* TODO: Implements base method in ORM to save *}
  FDBConnection.Persist(AEntity);
  Result := AEntity;
end;

function TBaseRepository<TEntity>.Update(AEntity: TEntity): TEntity;
begin
  {* TODO: Implements base method in ORM to update *}
  Result := AEntity;
end;

end.
