unit Cache.Interfaces;

interface

type

  iCache = interface
    ['{5AD8FC21-4888-4FC3-A82C-393739F7B682}']
    function Get(AKey: String): String;
    function Exists(AKey: String): Boolean;
    function SetCache(AKey, AValue: String): Boolean;
    function Keys(APattern: String): TArray<String>;
  end;

implementation

end.
