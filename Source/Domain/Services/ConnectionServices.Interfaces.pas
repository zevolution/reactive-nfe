unit ConnectionServices.Interfaces;

interface

type

  iConnectionServices = interface
    ['{59B753BC-C6D4-4B9F-8B48-D1732F0030E2}']
    function IP: String;
    function Port: Integer;
    function Password: String;
  end;

implementation

end.
