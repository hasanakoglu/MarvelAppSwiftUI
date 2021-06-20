import Combine
import SwiftUI

final class ImageProvider: ObservableObject {
    @Published var image: Image?
    var cancellable: AnyCancellable?
    
    init(url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .compactMap { UIImage(data: $0) }
            .map { Image(uiImage: $0) }
            .receive(on: RunLoop.main)
            .replaceError(with: nil)
            .eraseToAnyPublisher()
            .assign(to: \.image, on: self)
    }
}

struct ImageLoader: View {
    @ObservedObject var imageProvider: ImageProvider
    
    init(url: URL) {
        imageProvider = ImageProvider(url: url)
    }
    
    var body: some View {
        if let image = imageProvider.image {
            return AnyView(
                image.resizable()
            )
        } else {
            return AnyView(
                Image(systemName: "multiply.circle")
            )
        }
    }
}
