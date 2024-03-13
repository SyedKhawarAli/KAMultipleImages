import SwiftUI

struct GridImageView: View {
    @State private var images: [Image] = []

    init(images: [Image]) {
        self.images = images
    }

    var body: some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]

        return LazyVGrid(columns: columns, spacing: 0) {
            ForEach(0..<images.count, id: \.self) { index in
                if index < 5 || (index == 4 && images.count > 5) {
                    images[index]
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .overlay(
                            Group {
                                if index == 4 && images.count > 5 {
                                    Image(systemName: "plus")
                                }
                            }
                        )
                }
            }
        }
    }

    mutating func setImages(_ images: [Image]) {
        self.images = images
    }
}

struct GridImageView_Previews: PreviewProvider {
    static var previews: some View {
        GridImageView(
            images: [
                Image.init(systemName: "folder"),
                Image.init(systemName: "folder"),
                Image.init(systemName: "folder"),
            ])
    }
}
