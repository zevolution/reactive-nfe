unit Database.Connection.Interfaces;

interface

uses
  System.Generics.Collections;

type
  iDatabaseConnection = interface
    function Persist(AObject: TObject): Boolean;
    function Delete(AObject: TObject): Boolean;
    function FindById(AID: Integer): Boolean;
  end;

implementation

end.
