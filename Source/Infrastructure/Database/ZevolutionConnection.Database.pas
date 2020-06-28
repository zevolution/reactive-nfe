unit ZevolutionConnection.Database;

interface

uses
  System.Classes,
  System.SysUtils,
  System.Generics.Collections,

  Winapi.Windows,

  ZevolutionConnection.RTTI,

  Database.Connection.Interfaces;

type

  TZevolutionConnection = class(TInterfacedObject, iDatabaseConnection)
  private
    class var FInstance: iDatabaseConnection;
    FZevolutionRTTI: TZevolutionRTTI;
    constructor InternalCreate;
    function ObjectToString(AObject: TObject): String;
  public
    class function New: iDatabaseConnection;
    constructor Create;
    destructor Destroy; override;
    function Persist(AObject: TObject): Boolean;
    function Delete(AObject: TObject) : Boolean;
    function FindById(AID: Integer)   : Boolean;
  end;

implementation

{ TZevolutionConnection }

constructor TZevolutionConnection.Create;
begin
  raise Exception.Create('TZevolutionConnection.Create() invalidado. Utilize o método New().');
end;

function TZevolutionConnection.Delete(AObject: TObject): Boolean;
begin
  OutputDebugString(PWideChar(Format('Fazendo a limpa | %s', [ObjectToString(AObject)])));
  Result := False;
end;

destructor TZevolutionConnection.Destroy;
begin
  FreeAndNil(FZevolutionRTTI);
  inherited;
end;

function TZevolutionConnection.FindById(AID: Integer): Boolean;
begin
  OutputDebugString(PWideChar(Format('Pere, tamo na bota, já nois acha | %s', [AID])));
  Result := True;
end;

constructor TZevolutionConnection.InternalCreate;
begin
  inherited Create;
  FZevolutionRTTI := TZevolutionRTTI.Create;
end;

class function TZevolutionConnection.New: iDatabaseConnection;
begin
  if not Assigned(FInstance) then
    FInstance := Self.InternalCreate;
  Result := FInstance;
end;

function TZevolutionConnection.Persist(AObject: TObject): Boolean;
begin
  OutputDebugString(PWideChar(Format('Salvando no disquete | %s', [ObjectToString(AObject)])));
  Result := True;
end;

function TZevolutionConnection.ObjectToString(AObject: TObject): String;
var
  LStringBuilder: TStringBuilder;
  LProperties   : TDictionary<String, Variant>;
  LKeyProperty  : String;
begin
  try
    LStringBuilder := TStringBuilder.Create;
    LProperties    := FZevolutionRTTI.ObjectToDictionary(AObject);

    for LKeyProperty in LProperties.Keys do
    begin
      LStringBuilder
        .Append(LKeyProperty)
        .Append(': ')
        .Append(String(LProperties.Items[LKeyProperty]))
        .Append(' | ');
    end;

    Result := LStringBuilder.ToString;
  finally
    FreeAndNil(LStringBuilder);
    FreeAndNil(LProperties);
  end;
end;

end.
