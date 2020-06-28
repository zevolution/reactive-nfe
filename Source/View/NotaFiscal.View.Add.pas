unit NotaFiscal.View.Add;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Edit,
  FMX.StdCtrls,
  FMX.Controls.Presentation,
  FMX.Layouts,
  FMX.Objects,

  NotaFiscal.Controller,
  NotaFiscal.Controller.Interfaces,
  NotaFiscal.DTO;

type
  TViewNotaFiscalAdd = class(TForm)
    RedisViewFrameAddNFe: TRectangle;
    LayoutTopButtons: TLayout;
    buttonAddNFe: TButton;
    buttonExit: TButton;
    LayoutDestinatario: TLayout;
    labelDestinatario: TLabel;
    editDestinatario: TEdit;
    LayoutEmitente: TLayout;
    labelEmitente: TLabel;
    editEmitente: TEdit;
    RectangleBackground: TRectangle;
    LayoutPrincipal: TLayout;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure buttonExitClick(Sender: TObject);
    procedure buttonAddNFeClick(Sender: TObject);
  private
    { Private declarations }
    FParentLayout: TLayout;
    FNotaFiscalController: iNotaFiscalController;
    procedure AddNFe;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; AParentLayout: TLayout);
    destructor Destroy; override;
  end;

var
  ViewNotaFiscalAdd: TViewNotaFiscalAdd;

implementation

{$R *.fmx}

{ TNotaFiscalAdd }

procedure TViewNotaFiscalAdd.AddNFe;
var
  LNotaFiscalDTO: TNotaFiscalDTO;
begin
  try
    LNotaFiscalDTO              := TNotaFiscalDTO.Create;
    LNotaFiscalDTO.Emitente     := editEmitente.Text;
    LNotaFiscalDTO.Destinatario := editDestinatario.Text;
    FNotaFiscalController.Methods.AddNFe(LNotaFiscalDTO);
  finally
    FreeAndNil(LNotaFiscalDTO);
  end;
end;

procedure TViewNotaFiscalAdd.buttonAddNFeClick(Sender: TObject);
begin
  AddNFe;
end;

procedure TViewNotaFiscalAdd.buttonExitClick(Sender: TObject);
begin
  Close;
end;

constructor TViewNotaFiscalAdd.Create(AOwner: TComponent; AParentLayout: TLayout);
begin
  inherited Create(AOwner);
  FParentLayout := AParentLayout;
  FParentLayout.AddObject(LayoutPrincipal);
  FNotaFiscalController := TNotaFiscalController.New;
end;

destructor TViewNotaFiscalAdd.Destroy;
begin
  FParentLayout.RemoveObject(LayoutPrincipal);
  inherited;
end;

procedure TViewNotaFiscalAdd.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

end.
