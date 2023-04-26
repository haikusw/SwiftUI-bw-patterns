import SwiftUI

public struct PatternPicker: View {
  
  @Binding public var selectedDesign: TileDesign;
  
  public var selectedColor: Color
  public var pixelSize: CGFloat
  public var foregroundColor: Color
  public var backgroundColor: Color
  
  public init(selectedDesign: Binding<TileDesign>, selectedColor: Color = .accentColor, pixelSize: CGFloat = 2.0, foregroundColor: Color = .black, backgroundColor: Color = .white) {
    self._selectedDesign = selectedDesign
    self.selectedColor = selectedColor
    self.pixelSize = pixelSize
    self.foregroundColor = foregroundColor
    self.backgroundColor = backgroundColor
  }
  
  private let patterns = TileDesign.allCases
  private let verticalTileCount = Int(ceil(Double(TileDesign.allCases.count) / 5.0))
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      ForEach(0 ..< verticalTileCount, id: \.self) { i in
        HStack(alignment: .top, spacing: 0) {
          ForEach(0 ..< 5) { j in
            if i * 5 + j < patterns.count {
              PatternView(design: .constant(patterns[i * 5 + j]), pixelSize: pixelSize, foregroundColor: foregroundColor, backgroundColor: backgroundColor)
                .frame(width: pixelSize * 16, height: pixelSize * 12)
                .border(selectedDesign == patterns[i * 5 + j] ? selectedColor : foregroundColor, width: pixelSize / 2.0)
                .onTapGesture(perform: {
                  selectedDesign = patterns[i * 5 + j]
                })
            }
          }
        }
      }
    }.background(foregroundColor)
  }
}

struct PatternPicker_Previews: PreviewProvider {
    static var previews: some View {
      VStack {
        Text("Default")
        PatternPicker(selectedDesign: .constant(TileDesign.shadowGrid))
        Text("Selected color override")
        PatternPicker(selectedDesign: .constant(TileDesign.shadowGrid),
                      selectedColor: .red)
        Text("Color override")
        PatternPicker(selectedDesign: .constant(TileDesign.shadowGrid),
                      foregroundColor: .pink, backgroundColor: .cyan)
        Text("Pixel size override")
        PatternPicker(selectedDesign: .constant(TileDesign.shadowGrid), pixelSize: 8.0)
      }
    }
}
