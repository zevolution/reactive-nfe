unit PubSub.Interfaces;

interface

uses
  System.SysUtils;

type

  TPubSubContinueCallback = reference to function: boolean;

  iPubSub = interface
    ['{B45A6078-022F-47D5-93D8-F825B5FBBFAC}']
    function Publish(ACanal, AMensagem: String): Integer;
    procedure Subscribe(
      const ACanais: array of String;
      ACallback: TProc<String, String>;
      AContinuaCallback: TPubSubContinueCallback = nil;
      ADepoisDeSeInscrever: TProc = nil);
  end;

implementation

end.
