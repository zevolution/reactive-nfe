unit Base.Entity;

interface

uses
  System.SysUtils;

type
  TBaseEntity = class abstract
  private
    function GetUuid: String;
    procedure SetUuid(const Value: String);
  protected
    FUuid: String;
  public
    property Uuid: String read GetUuid write SetUuid;
  end;

implementation

{ TBaseEntity }

function TBaseEntity.GetUuid: String;
begin
  if FUuid.IsEmpty then
    FUuid := TGUID.NewGuid.ToString;
  Result := FUuid;
end;

procedure TBaseEntity.SetUuid(const Value: String);
begin
  if ((Length(Value) <> 36) and (Length(Value) <> 38)) then
    raise Exception.Create('Para prosseguir, o UUID informado deve conter 36 ou 38 caracteres');
  FUuid := Value;
end;

end.
