import SwiftUI

public struct PatternView: View {

  @Binding public var design: TileDesign
  public var pixelSize: CGFloat
  public var foregroundColor: Color
  public var backgroundColor: Color
  
  private var patternSize: CGFloat {
    pixelSize * 8.0;
  }
  
  public init(design: Binding<TileDesign>, pixelSize: CGFloat = 2.0, foregroundColor: Color = .black, backgroundColor: Color = .white) {
    self._design = design
    self.pixelSize = pixelSize
    self.foregroundColor = foregroundColor
    self.backgroundColor = backgroundColor
  }
  
  public var body: some View {
    GeometryReader { gr in
      VStack(spacing: 0) {
        ForEach(0 ..< 1 + Int(ceil(gr.size.height / patternSize)), id: \.self) { i in
          HStack(spacing: 0) {
            ForEach(0 ..< Int(ceil(gr.size.width / patternSize)), id: \.self) { j in
              Tile(design: design, pixelSize: pixelSize, foregroundColor: foregroundColor, backgroundColor: backgroundColor)
            }
          }
        }
      }
    }.drawingGroup()
  }
}

struct Pattern_Previews: PreviewProvider {
    static var previews: some View {
      VStack {
        Text("Default")
        PatternView(design: .constant(TileDesign.grid))
        Text("Color override")
        PatternView(design: .constant(TileDesign.balls), foregroundColor: .pink, backgroundColor: .cyan)
        Text("Pixel size override")
        PatternView(design: .constant(TileDesign.shingles), pixelSize: 8.0)
      }
    }
}
