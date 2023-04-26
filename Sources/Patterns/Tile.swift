import SwiftUI

public struct Tile: View {
  
  public let design: TileDesign
  public var pixelSize: CGFloat = 2.0;
  public var foregroundColor: Color = .black
  public var backgroundColor: Color = .white
  
  private var pixels: [Int] {
    design.pixels()
  }
  
    public var body: some View {
      VStack(spacing: 0) {
        ForEach(0 ..< 8) { i in
          HStack(spacing: 0) {
            ForEach(0 ..< 8) { j in
              Rectangle()
                .frame(width: pixelSize, height: pixelSize)
                .foregroundColor(pixels[(i % 8) * 8 + j % 8] == 0
                                  ? foregroundColor
                                  : backgroundColor
                )
            }
          }
        }
      }
    }
}

struct Tile_Previews: PreviewProvider {
    static var previews: some View {
      VStack {
        Text("Default")
        Tile(design: .grid)
        Text("Color override")
        Tile(design: .balls, foregroundColor: .pink, backgroundColor: .cyan)
        Text("Pixel size override")
        Tile(design: .shingles, pixelSize: 8.0)
      }
    }
}
