unit Main;

interface

procedure Register;

implementation

uses
  System.SysUtils, Winapi.Windows, ToolsAPI, ToolsAPI.Editor, System.Diagnostics, System.UITypes,
  System.Math, Vcl.Graphics;

type
  TIDEWizard = class(TNotifierObject, IOTAWizard)
  private
{$IFDEF DEBUG}
    _counter: Integer;
    sw: TStopwatch;
{$ENDIF}

    FEditorEventsNotifier: Integer;
    FEditorOptions: INTACodeEditorOptions;

    procedure PaintText(const Rect: TRect; const ColNum: SmallInt; const Text: string;
      const SyntaxCode: TOTASyntaxCode; const Hilight, BeforeEvent: Boolean;
      var AllowDefaultPainting: Boolean; const Context: INTACodeEditorPaintContext);
  protected
    function DrawTextLigated(ACanvas: HDC; const AText: string; const ARect: TRect): Boolean;
    function ColorLighter(Color: TColor; Percent: Byte = 70): TColor;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Execute;
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
  end;

  TCodeEditorNotifier = class(TNTACodeEditorNotifier)
  protected
    function AllowedEvents: TCodeEditorEvents; override;
  public
  end;

{$IFDEF DEBUG}
procedure PrintDebugFormat(const AFormat: string; const Args: array of const);
begin
  OutputDebugString(PChar(Format(AFormat, Args)));
end;
{$ENDIF}

procedure Register;
begin
  RegisterPackageWizard(TIDEWizard.Create);
end;

{ TIDEWizard }

function TIDEWizard.ColorLighter(Color: TColor; Percent: Byte): TColor;
var
  R, G, B: Byte;
begin
//  Color := ColorToRGB(Color);
  R := GetRValue(Color);
  G := GetGValue(Color);
  B := GetBValue(Color);

  // R := R + ((255 - R) * Percent) div 100; // 54674.69 op/ms - fast but less precise
  // R := R + MulDiv(255 - R, Percent, 100); // 11986.10 op/ms - slow
  R := R + Ceil((255 - R) * Percent / 100); // 20863.76 op/ms  - optimal
  G := G + Ceil((255 - G) * Percent / 100);
  B := B + Ceil((255 - B) * Percent / 100);

  Result := RGB(R, G, B);
end;

constructor TIDEWizard.Create;
begin
  inherited;
  var LNotifier := TCodeEditorNotifier.Create;

  var LEditorServices: INTACodeEditorServices;
  if Supports(BorlandIDEServices, INTACodeEditorServices, LEditorServices) then
    begin
      FEditorEventsNotifier := LEditorServices.AddEditorEventsNotifier(LNotifier);
      FEditorOptions := LEditorServices.Options;
    end
  else
    FEditorEventsNotifier := -1;

  LNotifier.OnEditorPaintText := PaintText;

  {$IFDEF DEBUG}
  sw := TStopwatch.Create;
  {$ENDIF}
end;

destructor TIDEWizard.Destroy;
begin
  var LEditorServices: INTACodeEditorServices;
  if Supports(BorlandIDEServices, INTACodeEditorServices, LEditorServices) and
    (FEditorEventsNotifier <> -1) and Assigned(LEditorServices) then
    LEditorServices.RemoveEditorEventsNotifier(FEditorEventsNotifier);
  inherited;
end;

function TIDEWizard.DrawTextLigated(ACanvas: HDC; const AText: string;
  const ARect: TRect): Boolean;
var
  glyphs: array of PChar; { Alexandria cannot digest such declaration when inline }
begin
  var textLen := Length(AText);

  SetLength(glyphs, textLen);

  var cpi: TGCPResults := default(TGCPResults);
  cpi.lStructSize := SizeOf(cpi);
  cpi.lpGlyphs := Pointer(Glyphs);
  cpi.nGlyphs := textLen;

  // Process characters that can ligate to corresponding glyphs
  // Note: 'true' doesn't mean that font contains ligations
  Result := GetCharacterPlacement(ACanvas, PChar(AText), textLen, 0, cpi, GCP_LIGATE) <> 0;
  if Result then
    begin
      var a := GetTextAlign(ACanvas);
      // we must align to the right in order to correctly draw text overlapped by gutter
      SetTextAlign(ACanvas, a or TA_RIGHT or TA_TOP);

      ExtTextOut(ACanvas, ARect.Right, ARect.Top, ETO_GLYPH_INDEX or ETO_CLIPPED, @ARect, PChar(glyphs), cpi.nGlyphs, nil);

      // restore alignment
      SetTextAlign(ACanvas, a);
    end;

  cpi := default(TGCPResults);
  Finalize(glyphs);
end;

procedure TIDEWizard.Execute;
begin
end;

function TIDEWizard.GetIDString: string;
begin
  Result := '[59E315B2-C150-4D30-B209-C15C6DBC2541]';
end;

function TIDEWizard.GetName: string;
begin
  Result := 'aynyuh.delphi.editorligatures';
end;

function TIDEWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

procedure TIDEWizard.PaintText(const Rect: TRect; const ColNum: SmallInt;
  const Text: string; const SyntaxCode: TOTASyntaxCode; const Hilight,
  BeforeEvent: Boolean; var AllowDefaultPainting: Boolean;
  const Context: INTACodeEditorPaintContext);
begin
  if BeforeEvent then
  begin
    {$IFDEF DEBUG}
    sw.Start;
    {$ENDIF}

    AllowDefaultPainting := False;
    var drawRect := Rect;
    var Canvas := Context.Canvas;

    // setup correct colors and style
    Canvas.Brush.Color := FEditorOptions.BackgroundColor[SyntaxCode];
    Canvas.Font.Color := FEditorOptions.FontColor[SyntaxCode];
    Canvas.Font.Style := FEditorOptions.FontStyles[SyntaxCode];

    // NOTE: LineState == nil in Options dialog, at least in Alexandria
    if Context.LineState <> nil then
    begin
      var lineState := Context.LineState;

      // adjust text rect if it's behind the gutter
      var gutterWidth := lineState.GutterRect.Width + lineState.GutterLineDataRect.Width;
      if drawRect.Left < gutterWidth then
        drawRect.Left := gutterWidth;

{ TCodeEditorLineState and INTACodeEditorLineState290.CellState exist starting from Athens }
{$IFDEF VER360}
      // fix "current line" background
      if TCodeEditorLineState.eleLineHighlight in LineState.State then
      begin
        Canvas.Font.Color := FEditorOptions.FontColor[SyntaxCode];
        Canvas.Brush.Color := FEditorOptions.BackgroundColor[atLineHighlight];
      end;

      if TCodeEditorCellState.eceSearchMatch in lineState.CellState[ColNum] then
      begin
        Canvas.Font.Color := FEditorOptions.FontColor[SearchMatch];
        Canvas.Font.Style := FEditorOptions.FontStyles[SearchMatch];
        Canvas.Brush.Color := FEditorOptions.BackgroundColor[SearchMatch];
      end;

      // draw unabled code correctly
      if TCodeEditorCellState.eceDisabledCode in lineState.CellState[ColNum] then
        Canvas.Font.Color := ColorLighter(Canvas.Font.Color);
{$ENDIF}
    end;

    Canvas.FillRect(drawRect);

    { DrawText can replace ExtTextOut and doesn't require GCP_LIGATE string preprocessing.
      The only problem that DrawText is ~2-3 times slower than ExtTextOut. }
    // DrawText(Canvas.Handle, Text, Length(Text), drawRect, DT_RIGHT);

    if not DrawTextLigated(Canvas.Handle, Text, drawRect) then
      raise Exception.Create('GetCharacterPlacement returned 0.');

    {$IFDEF DEBUG}
    sw.Stop;
    Inc(_counter);

    if (_counter = 10000) then
    begin
      PrintDebugFormat('DrawTextLigated: %f op/ms (1000 ops in %dms)', [_counter / sw.ElapsedMilliseconds, sw.ElapsedMilliseconds]);
      _counter := 0;
      sw.Reset;
    end;
    {$ENDIF}
  end;
end;

{ TCodeEditorNotifier }

function TCodeEditorNotifier.AllowedEvents: TCodeEditorEvents;
begin
  Result := [cevPaintTextEvents];
end;

end.
