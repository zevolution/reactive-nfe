unit Principal.View;

interface

uses
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Classes,
  System.Variants,
  System.Rtti,
  System.Threading,
  System.JSON,
  System.StrUtils,
  System.TimeSpan,

  FMX.Types,
  FMX.Controls,
  FMX.Forms,
  FMX.Graphics,
  FMX.Dialogs,
  FMX.Controls.Presentation,
  FMX.StdCtrls,
  FMX.Objects,
  FMX.Layouts,
  FMX.Effects,
  FMX.ListBox,
  FMX.MultiView,
  FMX.Ani,
  FMX.Filter.Effects,
  FMX.Edit,

  REST.JSON,

  Redis.Commons,
  Redis.Client,
  Redis.NetLib.INDY,
  Redis.Values,

  PubSub.Interfaces,
  Cache.Interfaces,

  Redis.PubSub.Service,
  Redis.Cache.Service,
  Redis.Config,

  MemCached.Config,
  MemCached.Cache.Service,

  NotaFiscal.Controller.Interfaces,
  NotaFiscal.Controller;

const
  COLOR_GRAY_LIGHT  = $FFE0E0E0;
  COLOR_GRAY_MEDIUM = TAlphaColors.Gray;
  COLOR_GRAY_DARK   = $FF464646;
  COLOR_TRANSPARENT = TAlphaColors.Null;

  HEIGHT_DEFAULT = 600;
  WIDTH_DEFAULT  = 800;

type

  TPrincipalView = class(TForm)
    LayoutPrincipal: TLayout;
    LayoutMenuLeft: TLayout;
    LayoutCenter: TLayout;
    LayoutCenterTop: TLayout;
    RectangleBackgroundCenterTop: TRectangle;
    Rectangle3: TRectangle;
    LayoutCenterClient: TLayout;
    RectangleNotasFiscais: TRectangle;
    ShadowEffect1: TShadowEffect;
    LabelPathActions: TLabel;
    LabelApplicationName: TLabel;
    LayoutCenterTopEmail: TLayout;
    LabelEmail: TLabel;
    ListBoxNFe: TListBox;
    StyleBook1: TStyleBook;
    LayoutNotasFiscaisMenu: TLayout;
    MultiView1: TMultiView;
    Rectangle2: TRectangle;
    Image1: TImage;
    LineSeparator: TLine;
    ButtonAddNFe: TButton;
    Button2: TButton;
    ButtonCancelNFe: TButton;
    ButtonSendNFe: TButton;
    LayoutNotasFiscais: TLayout;
    LayoutTelaInicial: TLayout;
    Rectangle5: TRectangle;
    Layout8: TLayout;
    Image2: TImage;
    Layout10: TLayout;
    Label4: TLabel;
    Layout11: TLayout;
    LabelNumeroClientes: TLabel;
    ShadowEffect2: TShadowEffect;
    ListBoxMultiView: TListBox;
    ListBoxItem1: TListBoxItem;
    LabelWelcome: TLabel;
    Rectangle6: TRectangle;
    Layout9: TLayout;
    Image3: TImage;
    Layout12: TLayout;
    Label2: TLabel;
    Layout13: TLayout;
    LabelValorTotalDeNotas: TLabel;
    ShadowEffect3: TShadowEffect;
    Rectangle7: TRectangle;
    Layout14: TLayout;
    Image4: TImage;
    Layout15: TLayout;
    Label7: TLabel;
    Layout16: TLayout;
    LabelNumeroUsuarios: TLabel;
    ShadowEffect4: TShadowEffect;
    GaussianBlurEffectMultiView: TGaussianBlurEffect;
    RectangleVisualizarNFe: TRectangle;
    Layout7: TLayout;
    LabelVisualizarNFe: TLabel;
    Layout17: TLayout;
    FloatAnimation1: TFloatAnimation;
    FloatKeyAnimation1: TFloatKeyAnimation;
    LayoutFloating: TLayout;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MultiView1StartShowing(Sender: TObject);
    procedure MultiView1StartHiding(Sender: TObject);
    procedure RectangleVisualizarNFeMouseEnter(Sender: TObject);
    procedure RectangleVisualizarNFeMouseLeave(Sender: TObject);
    procedure RectangleVisualizarNFeClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ButtonAddNFeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonCancelNFeClick(Sender: TObject);
    procedure ButtonSendNFeClick(Sender: TObject);
  private
    { Private declarations }
    FClosing             : Boolean;
    FTask                : iTask;
    FPubSub              : iPubSub;
    FCache               : iCache;
    FNotaFiscalController: iNotaFiscalController;
    procedure CallbackSubscribedAddNFe(AMessage: String);
    procedure CallbackSubscribedSendNFe(AMessage: String);
    procedure CallbackSubscribedCancelNFe(AMessage: String);
    procedure SubscribeToChannels;
    procedure GetUserDataMainPage;
    procedure ShutdownRedisSubscribers;
  public
    { Public declarations }
  end;

var
  PrincipalView: TPrincipalView;

implementation

uses
  NotaFiscal.Status.Entity,
  NotaFiscal.DTO,

  NotaFiscal.View.Add;

{$R *.fmx}

procedure TPrincipalView.CallbackSubscribedAddNFe(AMessage: String);
var
  ListBoxItemNFe: TListBoxItem;
  LNotaFiscalDTO: TNotaFiscalDTO;
begin
  try
    LNotaFiscalDTO := TJson.JsonToObject<TNotaFiscalDTO>(AMessage);

    ListBoxItemNFe                                             := TListBoxItem.Create(nil);
    ListBoxItemNFe.StyleLookup                                 := 'ListBoxItem1-StyleNFeNegrito';
    ListBoxItemNFe.ItemData.Detail                             := LNotaFiscalDTO.UUID;
    ListBoxItemNFe.Text                                        := 'Destinatário:';
    ListBoxItemNFe.StylesData['Destinatario.Text']             := LNotaFiscalDTO.Destinatario;
    ListBoxItemNFe.StylesData['emitente.Text']                 := LNotaFiscalDTO.Emitente;
    ListBoxItemNFe.StylesData['nfe.Text']                      := LNotaFiscalDTO.NumeroNfe;
    ListBoxItemNFe.StylesData['status.Text']                   := LNotaFiscalDTO.Status.Description;
    ListBoxItemNFe.StylesData['status.TextSettings.FontColor'] := LNotaFiscalDTO.Status.Color;
    ListBoxNFe.AddObject(ListBoxItemNFe);
    ListBoxNFe.ItemIndex := Pred(ListBoxNFe.Count);
  finally
    FreeAndNil(LNotaFiscalDTO);
  end;
end;

procedure TPrincipalView.Button6Click(Sender: TObject);
begin
  FloatKeyAnimation1.Enabled := True;
end;

procedure TPrincipalView.ButtonAddNFeClick(Sender: TObject);
begin
  TViewNotaFiscalAdd.Create(Self, LayoutFloating);
end;

procedure TPrincipalView.ButtonCancelNFeClick(Sender: TObject);
var
  LIndexNFeList: Integer;
  LNotaFiscalDTO: TNotaFiscalDTO;
begin
  LIndexNFeList := ListBoxNFe.Selected.Index;

  if LIndexNFeList >= 0 then
  begin
    try
      LNotaFiscalDTO := TNotaFiscalDTO.Create;
      LNotaFiscalDTO.UUID := ListBoxNFe.ListItems[LIndexNFeList].ItemData.Detail;
      FNotaFiscalController.Methods.CancelNFe(LNotaFiscalDTO);
    finally
      FreeAndNil(LNotaFiscalDTO);
    end;
  end
  else
  begin
    raise Exception.Create('Para prosseguir com o cancelamento, selecione uma NFe.');
  end;

end;

procedure TPrincipalView.ButtonSendNFeClick(Sender: TObject);
var
  LIndexNFeList: Integer;
  LNotaFiscalDTO: TNotaFiscalDTO;
begin
  LIndexNFeList := ListBoxNFe.Selected.Index;

  if LIndexNFeList >= 0 then
  begin
    try
      LNotaFiscalDTO := TNotaFiscalDTO.Create;
      LNotaFiscalDTO.UUID := ListBoxNFe.ListItems[LIndexNFeList].ItemData.Detail;
      FNotaFiscalController.Methods.SendNFe(LNotaFiscalDTO);
    finally
      FreeAndNil(LNotaFiscalDTO);
    end;
  end
  else
  begin
    raise Exception.Create('Para prosseguir com o envio, selecione uma NFe.');
  end;
end;

procedure TPrincipalView.CallbackSubscribedSendNFe(AMessage: String);
var
  I             : Integer;
  LUUID         : String;
  LNotaFiscalDTO: TNotaFiscalDTO;
begin
  try
    LNotaFiscalDTO := TJson.JsonToObject<TNotaFiscalDTO>(AMessage);
    LUUID          := LNotaFiscalDTO.UUID;
    for I := 0 to Pred(ListBoxNFe.Count) do
    begin
      if ListBoxNFe.ListItems[I].ItemData.Detail = LUUID then
      begin
        ListBoxNFe.ItemIndex := ListBoxNFe.ListItems[I].Index;

        ListBoxNFe.ListItems[I].Text                                        := 'Destinatário:';
        ListBoxNFe.ListItems[I].StyleLookup                                 := 'ListBoxItem1-StyleNFeNegrito';
        ListBoxNFe.ListItems[I].StylesData['status.Text']                   := LNotaFiscalDTO.Status.Description;
        ListBoxNFe.ListItems[I].StylesData['status.TextSettings.FontColor'] := LNotaFiscalDTO.Status.Color;

        ListBoxNFe.ItemIndex := ListBoxNFe.ListItems[I].Index;

        Exit;
      end;
    end;
  finally
    FreeAndNil(LNotaFiscalDTO);
  end;

end;

procedure TPrincipalView.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ShutdownRedisSubscribers;
end;

procedure TPrincipalView.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := True;

  FNotaFiscalController := TNotaFiscalController.New;

  FPubSub := TRedisPubSubService.New(TRedisConfig.New);

  {* You can choose between Redis and MemCached as a cache service *}
  //FCache := TRedisCacheService.New(TRedisConfig.New);
  FCache := TMemCachedCacheService.New(TMemCachedConfig.New);

  GetUserDataMainPage;

  SubscribeToChannels;
end;

procedure TPrincipalView.FormResize(Sender: TObject);
var
  HeightLessThanDefault : Boolean;
  WidthLessThanDefault: Boolean;
begin

  HeightLessThanDefault  := Self.Height < HEIGHT_DEFAULT;
  WidthLessThanDefault := Self.Width < WIDTH_DEFAULT;

  if HeightLessThanDefault then
    Self.Height := HEIGHT_DEFAULT;

  if WidthLessThanDefault then
    Self.Width := WIDTH_DEFAULT;
end;

procedure TPrincipalView.RectangleVisualizarNFeClick(Sender: TObject);
begin
  LayoutFloating.Visible    := not LayoutFloating.Visible;
  LayoutTelaInicial.Visible := not LayoutTelaInicial.Visible;
  LabelPathActions.Visible  := not LabelPathActions.Visible;
  LabelWelcome.Visible      := not LabelWelcome.Visible;

  MultiView1.HideMaster;
end;

procedure TPrincipalView.RectangleVisualizarNFeMouseEnter(Sender: TObject);
begin
  RectangleVisualizarNFe.Fill.Color         := COLOR_GRAY_MEDIUM;
  LabelVisualizarNFe.TextSettings.FontColor := TAlphaColors.White;
end;

procedure TPrincipalView.RectangleVisualizarNFeMouseLeave(Sender: TObject);
begin
  RectangleVisualizarNFe.Fill.Color         := COLOR_TRANSPARENT;
  LabelVisualizarNFe.TextSettings.FontColor := COLOR_GRAY_LIGHT;
end;

procedure TPrincipalView.CallbackSubscribedCancelNFe(AMessage: String);
var
  I             : Integer;
  LUUID         : String;
  LNotaFiscalDTO: TNotaFiscalDTO;
begin
  try
    LNotaFiscalDTO := TJson.JsonToObject<TNotaFiscalDTO>(AMessage);
    LUUID          := LNotaFiscalDTO.UUID;
    for I := 0 to Pred(ListBoxNFe.Count) do
    begin
      if ListBoxNFe.ListItems[I].ItemData.Detail = LUUID then
      begin
        ListBoxNFe.ItemIndex := ListBoxNFe.ListItems[I].Index;
        ListBoxNFe.ListItems[I].StylesData['status.Text']                   := LNotaFiscalDTO.Status.Description;
        ListBoxNFe.ListItems[I].StylesData['status.TextSettings.FontColor'] := LNotaFiscalDTO.Status.Color;
        ListBoxNFe.ItemIndex := ListBoxNFe.ListItems[I].Index;
        Exit;
      end;
    end;
  finally
    FreeAndNil(LNotaFiscalDTO);
  end;
end;

procedure TPrincipalView.GetUserDataMainPage;
var
  LNumeroDeClientes : Integer;
  LNumeroDeUsuarios : Integer;
  LValorTotalDeNotas: Integer;
begin
  LNumeroDeClientes  := FCache.Get('numerodeclientes').ToInteger;
  LNumeroDeUsuarios  := FCache.Get('numerodeusuarios').ToInteger;
  LValorTotalDeNotas := FCache.Get('valortotaldenotas').ToInteger;

  TTask.Create(
    procedure
    var
      I: Integer;
    begin
      if LNumeroDeClientes > 800 then
      begin
        for I := (LNumeroDeClientes - 800) to LNumeroDeClientes do
        begin
          TThread.Synchronize(
            nil,
            procedure
            begin
              LabelNumeroClientes.Text := FormatCurr('#,0.', I);
            end
          );
        end;
      end
      else
      begin
        TThread.Synchronize(
          nil,
          procedure
          begin
            LabelNumeroClientes.Text := FormatCurr('#,0.', LNumeroDeClientes);
          end
        );
      end;
    end
  ).Start;

  TTask.Create(
    procedure
    var
      I: Integer;
    begin
      if LNumeroDeUsuarios > 800 then
      begin
        for I := (LNumeroDeUsuarios - 800) to LNumeroDeUsuarios do
        begin
          TThread.Synchronize(
            nil,
            procedure
            begin
              LabelNumeroUsuarios.Text := FormatCurr('#,0.', I);
            end
          );
        end;
      end
      else
      begin
        TThread.Synchronize(
          nil,
          procedure
          begin
            LabelNumeroUsuarios.Text := FormatCurr('#,0.', LNumeroDeUsuarios);
          end
        );
      end;
    end
  ).Start;

  TTask.Create(
    procedure
    var
      I: Integer;
    begin
      if LValorTotalDeNotas > 500 then
      begin
      for I := (LValorTotalDeNotas - 500) to LValorTotalDeNotas do
        begin
          TThread.Synchronize(
            nil,
            procedure
            begin
              LabelValorTotalDeNotas.Text := FormatCurr(
                'R$ #,##0.00',
                I.ToString.Insert((I.ToString.Length - 2), ',').ToDouble
              );
            end
          );
        end;
      end
      else
      begin
        TThread.Synchronize(
          nil,
          procedure
          begin
            LabelValorTotalDeNotas.Text := FormatCurr(
              'R$ #,##0.00',
              LValorTotalDeNotas.ToString.Insert((I.ToString.Length - 2), ',').ToDouble
            );
          end
        );
      end;


    end
  ).Start;


end;

procedure TPrincipalView.ShutdownRedisSubscribers;
begin
  {*
    If not has this sleep to shutdown subscribers, will be returned error
    "EIdSocketError with message 'Socket Error # 10093'" when in DEBUG MODE.
  *}
  FClosing := True;
  Sleep(1000);
end;

procedure TPrincipalView.MultiView1StartHiding(Sender: TObject);
begin
  GaussianBlurEffectMultiView.Enabled := False;
end;

procedure TPrincipalView.MultiView1StartShowing(Sender: TObject);
begin
  GaussianBlurEffectMultiView.Enabled := True;
end;

procedure TPrincipalView.SubscribeToChannels;
begin
  FClosing := False;

  FTask := TTask.Run(
    procedure
    begin
      FPubSub.Subscribe(
        {* Array of channels*}
        REDIS_CHANNELS,

        {* Anonymous method that will execute the call *}
        procedure (AChannel, AMessage: String)
        begin
          TThread.Queue(nil,
          procedure
          begin
            case AnsiIndexText(AChannel, REDIS_CHANNELS) of
              Integer(rcAddNFe)   : CallbackSubscribedAddNFe(AMessage);
              Integer(rcCancelNFe): CallbackSubscribedCancelNFe(AMessage);
              Integer(rcSendNFe)  : CallbackSubscribedSendNFe(AMessage);
              else raise Exception.Create(
                Format('Nenhum método SUBSCRIBE correspondente ao CHANNEL %s', [AChannel])
              );
            end;
          end);
        end,

        {* Anonymous method that will determine the continuity of the SUBSCRIBE *}
        function: Boolean
        begin
          Result := Assigned(Self) and not Self.FClosing;
        end,

        {* Anonymous method to be performed after the subscription takes effect *}
        procedure
        begin
        end
      );
    end
  );
end;

end.
