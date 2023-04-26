import SwiftUI

struct Tile: View {
  
  let pixelSize: CGFloat = 2.0;
  
  let design: TileDesign
  
  private var pixels: [Int] {
    design.pixels()
  }
  
    var body: some View {
      VStack(spacing: 0) {
        ForEach(0 ..< 8) { i in
          HStack(spacing: 0) {
            ForEach(0 ..< 8) { j in
              Rectangle()
                .frame(width: pixelSize, height: pixelSize)
                .foregroundColor(pixels[(i % 8) * 8 + j % 8] == 0
                                  ? .black
                                  : .white
                )
            }
          }
        }
      }
    }
}

struct Tile_Previews: PreviewProvider {
    static var previews: some View {
      Tile(design: .grid)
    }
}
