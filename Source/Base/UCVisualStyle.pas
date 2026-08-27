unit UCVisualStyle;

interface

uses
  Buttons,
  Controls,
  DBGrids,
  ExtCtrls,
  Forms,
  Graphics,
  StdCtrls;

type
  { Central visual conventions for UserControl runtime screens. This is a
    regular helper class and does not register a design-time component. }
  TUCVisualStyle = class sealed
  public const
    DefaultFontName = 'Segoe UI';
    DefaultFontSize = 9;
    ActionButtonHeight = 32;
    FieldHeight = 23;
  public
    class procedure ApplyForm(Form: TCustomForm); static;
    class procedure ApplyFrame(Frame: TFrame); static;
    class procedure FitButtonWidth(Button: TBitBtn;
      MinWidth: Integer = 100); static;
    class procedure StyleActionPanel(Panel: TPanel); static;
    class procedure StyleActionButton(Button: TBitBtn); static;
    class procedure StylePrimaryButton(Button: TBitBtn); static;
    class procedure StyleSecondaryButton(Button: TBitBtn); static;
    class procedure StyleEdit(Edit: TEdit); static;
    class procedure StyleGrid(Grid: TDBGrid); static;
    class procedure StyleHeader(Panel: TPanel; Title: TLabel); static;
  end;

implementation

class procedure TUCVisualStyle.ApplyForm(Form: TCustomForm);
begin
  if not Assigned(Form) then
    Exit;

  Form.Font.Name := DefaultFontName;
  Form.Font.Size := DefaultFontSize;
  Form.KeyPreview := True;
end;

class procedure TUCVisualStyle.ApplyFrame(Frame: TFrame);
begin
  if not Assigned(Frame) then
    Exit;

  Frame.Font.Name := DefaultFontName;
  Frame.Font.Size := DefaultFontSize;
end;

class procedure TUCVisualStyle.FitButtonWidth(Button: TBitBtn;
  MinWidth: Integer);
var
  Bitmap: TBitmap;
  GlyphWidth: Integer;
  RequiredWidth: Integer;
begin
  if not Assigned(Button) then
    Exit;

  Bitmap := TBitmap.Create;
  try
    Bitmap.Canvas.Font.Assign(Button.Font);
    GlyphWidth := 0;
    if not Button.Glyph.Empty then
    begin
      GlyphWidth := Button.Glyph.Width;
      if Button.NumGlyphs > 1 then
        GlyphWidth := GlyphWidth div Button.NumGlyphs;
      Inc(GlyphWidth, 8);
    end;

    RequiredWidth := Bitmap.Canvas.TextWidth(Button.Caption) +
      GlyphWidth + 28;
    if RequiredWidth < MinWidth then
      RequiredWidth := MinWidth;
    Button.Width := RequiredWidth;
  finally
    Bitmap.Free;
  end;
end;

class procedure TUCVisualStyle.StyleActionButton(Button: TBitBtn);
begin
  if not Assigned(Button) then
    Exit;

  Button.Height := ActionButtonHeight;
  Button.Font.Name := DefaultFontName;
  Button.Font.Size := DefaultFontSize;
end;

class procedure TUCVisualStyle.StyleActionPanel(Panel: TPanel);
begin
  if not Assigned(Panel) then
    Exit;

  Panel.BevelOuter := bvNone;
  Panel.ParentBackground := True;
end;

class procedure TUCVisualStyle.StyleEdit(Edit: TEdit);
begin
  if not Assigned(Edit) then
    Exit;

  Edit.Font.Name := DefaultFontName;
  Edit.Font.Size := DefaultFontSize;
  Edit.Height := FieldHeight;
end;

class procedure TUCVisualStyle.StyleGrid(Grid: TDBGrid);
begin
  if not Assigned(Grid) then
    Exit;

  Grid.Font.Name := DefaultFontName;
  Grid.Font.Size := DefaultFontSize;
  Grid.TitleFont.Assign(Grid.Font);
  Grid.TitleFont.Style := [fsBold];
  Grid.Options := Grid.Options + [dgTitles, dgIndicator, dgColumnResize,
    dgColLines, dgRowLines, dgTabs, dgRowSelect] - [dgEditing];
end;

class procedure TUCVisualStyle.StyleHeader(Panel: TPanel; Title: TLabel);
begin
  StyleActionPanel(Panel);
  if not Assigned(Title) then
    Exit;

  Title.Font.Name := DefaultFontName;
  Title.Font.Size := 12;
  Title.Font.Style := [fsBold];
end;

class procedure TUCVisualStyle.StylePrimaryButton(Button: TBitBtn);
begin
  StyleActionButton(Button);
  if Assigned(Button) then
    Button.Default := True;
end;

class procedure TUCVisualStyle.StyleSecondaryButton(Button: TBitBtn);
begin
  StyleActionButton(Button);
  if Assigned(Button) then
    Button.Cancel := True;
end;

end.
