import CoreGraphics

struct TileImage {
  static func image(_ design: TileDesign, pixelSize: CGFloat, foregroundColor: CGColor? = nil, backgroundColor: CGColor? = nil) -> CGImage {
    
    let fg = foregroundColor ?? .init(red: 0, green: 0, blue: 0, alpha: 255)
    let bg = backgroundColor ?? .init(red: 255, green: 255, blue: 255, alpha: 255)
    
    // Convert the array to image data
    
    let pixels: [UInt8] = design.pixels().map({ x in
      var color = bg
      if x == 0 {
        color = fg
      }
      let components = color.components ?? [0,0,0,1]
      return components.map({ c in
        UInt8(round(c * 255))
      })
    }).reduce([], +)
    
    // Generate the image
    
    let pointer = UnsafeMutablePointer<UInt8>.allocate(capacity: pixels.count)
    pointer.initialize(from: pixels, count: pixels.count)
    let width = 8.0
    let height = 8.0
    let bitsPerComponent = 8
    let componentCount = 4
    let bitsPerPixel = bitsPerComponent * componentCount
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    
    let bitmapInfo = CGBitmapInfo([.byteOrderDefault, CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)])
    let provider = CGDataProvider(dataInfo: nil, data: pointer, size: Int(width * height * 4)) { _, _, _ in
      return
    }!
    
    let image = CGImage(
      width: Int(width),
      height: Int(height),
      bitsPerComponent: bitsPerComponent,
      bitsPerPixel: bitsPerPixel,
      bytesPerRow: Int(width) * componentCount,
      space: colorSpace,
      bitmapInfo: bitmapInfo,
      provider: provider,
      decode: nil, shouldInterpolate: false, intent: CGColorRenderingIntent.defaultIntent)!
    
    return image.resize(size: CGSize(width: width * pixelSize, height: height * pixelSize)) ?? image
  }
}
