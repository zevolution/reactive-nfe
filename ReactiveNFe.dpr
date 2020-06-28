program ReactiveNFe;

uses
  System.StartUpCopy,
  FMX.Forms,
  Principal.View in 'Source\View\Principal.View.pas' {PrincipalView},
  NotaFiscal.Entity in 'Source\Domain\Entities\NotaFiscal.Entity.pas',
  Base.Repository in 'Source\Infrastructure\Repositories\Base.Repository.pas',
  Base.Repository.Interfaces in 'Source\Domain\Repositories\Base.Repository.Interfaces.pas',
  Base.Entity in 'Source\Domain\Entities\Base.Entity.pas',
  Redis.PubSub.Service in 'Source\Infrastructure\Services\PubSub\Redis.PubSub.Service.pas',
  Redis.Cache.Service in 'Source\Infrastructure\Services\Cache\Redis.Cache.Service.pas',
  Cache.Interfaces in 'Source\Domain\Services\Cache.Interfaces.pas',
  PubSub.Interfaces in 'Source\Domain\Services\PubSub.Interfaces.pas',
  MemCached.Cache.Service in 'Source\Infrastructure\Services\Cache\MemCached.Cache.Service.pas',
  ConnectionServices.Interfaces in 'Source\Domain\Services\ConnectionServices.Interfaces.pas',
  Redis.Config in 'Source\Core\Redis\Redis.Config.pas',
  NotaFiscal.Repository in 'Source\Infrastructure\Repositories\NotaFiscal.Repository.pas',
  ZevolutionConnection.Database in 'Source\Infrastructure\Database\ZevolutionConnection.Database.pas',
  Database.Connection.Interfaces in 'Source\Domain\Database\Database.Connection.Interfaces.pas',
  ZevolutionConnection.RTTI in 'Source\Infrastructure\Database\ZevolutionConnection.RTTI.pas',
  NotaFiscal.Controller in 'Source\Controller\NotaFiscal\NotaFiscal.Controller.pas',
  NotaFiscal.DTO in 'Source\Controller\DTO\NotaFiscal.DTO.pas',
  NotaFiscal.Controller.Interfaces in 'Source\Controller\NotaFiscal\NotaFiscal.Controller.Interfaces.pas',
  NotaFiscal.Service in 'Source\Infrastructure\Services\NotaFiscal.Service.pas',
  NotaFiscal.Status.Entity in 'Source\Domain\Entities\NotaFiscal.Status.Entity.pas',
  NotaFiscal.View.Add in 'Source\View\NotaFiscal.View.Add.pas' {ViewNotaFiscalAdd},
  MemCached.Config in 'Source\Core\MemCached\MemCached.Config.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TPrincipalView, PrincipalView);
  Application.Run;
end.
