# Patterns

SwiftUI tiling black and white patterns.

This project contains `Patterns`, which are built out of `Tiles` with a given
`TileDesign`.

It also includes a `TilePicker` that can be used to control the selected
design.

## Available Tile Designs

The `TileDesign` enum contains the following patterns (shown in the image from
top left to bottom right)

![Image showing the included patterns]

* `.grid`
* `.dottedGrid`
* `.stitch`
* `.curvedTile`
* `.brick`
* `.tile`
* `.shadowGrid`
* `.circles`
* `.trees`
* `.shingles`
* `.wicker`
* `.rhombus`
* `.balls`

## Usage

The `Pattern` view will tile the selected design in its frame. It has the
following properties:

* `design: TileDesign`: **required, @Binding**, which design to tile the frame with.
* `pixelSize: CGFloat`: **defaults to 2.0**, the size of a pixel in the tile.
* `foregroundColor: Color`: **defaults to `Color.black`**, the foreground color.
* `backgroundColor: Color`: **defaults to `Color.white`**, the background color.

```
// Pattern using default settings
Pattern(design: .constant(TileDesign.shadowGrid))

// Pattern using overrides
Pattern(design: $tileDesign, pixelSize: 4.0, foregroundColor: .pink, backgroundColor: .cyan)
```

## Using the PatternPicker

The pattern picker view is intended to be used when you want to allow users to
change the design of the pattern.

* `selectedDesign: TileDesign`: **required, @Binding**, the current selected
  tile design.
* `selectedColor: Color`: **defaults to `Color.accentColor`**, the color of the
  border around the selected tile design.

It also has `pixelSize`, `foregroundColor`, and `backgroundColor` with the
same effect as `Pattern` mentioned above


```
@State var design: TileDesign = .brick
@State var shouldShowPatternPicker = false

...

Pattern(design: $pattern)
  .frame(width: 32.0).border(.black)
  .onTapGesture {
    shouldShowPatternPicker = !shouldShowPatternPicker;
  }
  .popover(isPresented: $shouldShowPatternPicker) {
    PatternPicker(selectedDesign: $design)
  }
  .onChange(of: pattern) { _ in
    shouldShowPatternPicker = false;
  }
```
