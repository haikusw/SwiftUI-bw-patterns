import SwiftUI

public struct Pattern: View {

  private let pixelSize: CGFloat = 2.0;
  
  private var patternSize: CGFloat {
    pixelSize * 8.0;
  }
  
  @Binding var design: TileDesign;
  
  public var body: some View {
    GeometryReader { gr in
      VStack(spacing: 0) {
        ForEach(0 ..< 1 + Int(ceil(gr.size.height / patternSize)), id: \.self) { i in
          HStack(spacing: 0) {
            ForEach(0 ..< Int(ceil(gr.size.width / patternSize)), id: \.self) { j in
              Tile(design: design)
            }
          }
        }
      }
    }.drawingGroup()
  }
}

struct Pattern_Previews: PreviewProvider {
    static var previews: some View {
      Pattern(design: .constant(TileDesign.grid))
    }
}
