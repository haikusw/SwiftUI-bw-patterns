import SwiftUI

public struct Pattern: View {
  
  private var patternSize: CGFloat {
    pixelSize * 8.0;
  }
  
  @Binding var design: TileDesign;
  var pixelSize: CGFloat = 2.0;
  var foregroundColor: Color = .black
  var backgroundColor: Color = .white
  
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
        Pattern(design: .constant(TileDesign.grid))
        Text("Color override")
        Pattern(design: .constant(TileDesign.balls), foregroundColor: .pink, backgroundColor: .cyan)
        Text("Pixel size override")
        Pattern(design: .constant(TileDesign.shingles), pixelSize: 8.0)
      }
    }
}
