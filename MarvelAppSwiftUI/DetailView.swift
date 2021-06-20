import SwiftUI

import SwiftUI

struct DetailView: View {
    let character: MarvelCharacter
    
    var body: some View {
        ScrollView {
            VStack(spacing: 5) {
                ImageLoader(url: character.imageURL)
                    .frame(width: 300, height: 300)
                Text(character.name)
                    .font(Font.system(size: 20, weight: .bold, design: .default))
                Text(character.description)
                    .font(Font.system(size: 12))
                    .lineLimit(nil)
                
                Button(action: {
                    UIApplication.shared.open(self.character.websiteURL!, options: [:], completionHandler: nil)
                }) {
                    Text("Website")
                        .font(Font.system(size: 16,
                                          weight: .semibold,
                                          design: .monospaced))
                }
                .padding()
                .background(Color.red)
                .cornerRadius(12)
            }
            .padding()
            .navigationBarTitle(character.name)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(character: MarvelCharacter(name: "THOR",
                                              description: "GOD OF THUNDER",
                                              thumbnail: Thumbnail(path: "", thumbnailExtension: .jpg),
                                              urls: []))
    }
}
