import Combine
import SwiftUI

final class ContentViewModel: ObservableObject {
    @Published var characters: [MarvelCharacter] = []
    var cancellable: AnyCancellable?
    
    init() {
        cancellable = URLSession.shared.dataTaskPublisher(for: API.charactersURL)
            .map { $0.data }
            .decode(type: CharacterResponseModel.self, decoder: JSONDecoder())
            .map { $0.data.characters }
            .receive(on: RunLoop.main)
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .assign(to: \.characters, on: self)
    }
}
