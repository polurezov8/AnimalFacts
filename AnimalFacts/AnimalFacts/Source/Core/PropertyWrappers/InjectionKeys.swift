import Foundation

// MARK: - ImageCacheKey

private struct ImageCacheKey: InjectionKey {
  static var currentValue: ImageCacheProtocol = ImageCache()
}

extension InjectedValues {
  var imageCache: ImageCacheProtocol {
    get { Self[ImageCacheKey.self] }
    set { Self[ImageCacheKey.self] = newValue }
  }
}
