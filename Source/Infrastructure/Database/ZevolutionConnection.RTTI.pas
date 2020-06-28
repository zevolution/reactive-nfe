unit ZevolutionConnection.RTTI;

interface

uses
  RTTI,
  System.SysUtils,
  System.Generics.Collections;

type

  TZevolutionRTTI = class
  private
    FRTTIContext: TRttiContext;
  public
    constructor Create();
    destructor Destroy; override;
    function ObjectToDictionary(AObject: TObject): TDictionary<String, Variant>;
  end;

implementation

{ TObjectToDictionary }

function TZevolutionRTTI.ObjectToDictionary(AObject: TObject): TDictionary<String, Variant>;
var
  LRTTIType            : TRttiType;
  LRTTIProperty        : TRttiProperty;
  LDictionaryProperties: TDictionary<String, Variant>;
begin
  try
    LDictionaryProperties := TDictionary<String, Variant>.Create;
    LRTTIType := FRTTIContext.GetType(AObject.ClassInfo);
    for LRTTIProperty in LRTTIType.GetProperties do
    begin
      LDictionaryProperties.Add(LRTTIProperty.Name, LRTTIProperty.GetValue(AObject).AsVariant);
    end;
    Result := LDictionaryProperties;
  finally
    FreeAndNil(LRTTIType);
  end;
end;

constructor TZevolutionRTTI.Create;
begin
  FRTTIContext := TRttiContext.Create;
end;

destructor TZevolutionRTTI.Destroy;
begin
  FRTTIContext.Free;
  inherited;
end;

end.
