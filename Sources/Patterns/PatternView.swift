import SwiftUI

public struct PatternView: View {

  @Binding public var design: TileDesign
  public var pixelSize: CGFloat
  public var foregroundColor: Color
  public var backgroundColor: Color
  
  private let image: CGImage
  private var patternSize: CGFloat {
    pixelSize * 8.0;
  }

  public init(design: Binding<TileDesign>, pixelSize: CGFloat = 2.0, foregroundColor: Color = .black, backgroundColor: Color = .white) {
    self._design = design
    self.pixelSize = pixelSize
    self.foregroundColor = foregroundColor
    self.backgroundColor = backgroundColor
    
    #if os(iOS) || os(watchOS) || os(tvOS)
      let foregroundCGColor = UIColor(foregroundColor).cgColor
      let backgroundCGColor = UIColor(backgroundColor).cgColor
    #else
      let foregroundCGColor = NSColor(foregroundColor).cgColor
    let backgroundCGColor = NSColor(backgroundColor).cgColor
    #endif
    
    self.image = TileImage.image(design.wrappedValue, pixelSize: pixelSize, foregroundColor: foregroundCGColor, backgroundColor: backgroundCGColor)
  }

  public var body: some View {
    GeometryReader { gr in
      Image(image, scale: 1, label: Text("Test")).resizable(resizingMode: .tile)
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
