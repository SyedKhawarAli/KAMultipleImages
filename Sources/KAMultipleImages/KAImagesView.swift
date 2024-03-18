//
//  KAImagesView.swift
//  
//
//  Created by shah on 18.3.2024.
//

import SwiftUI

struct KAImagesView: View {
    var images: [IdentifiableImage] = []
    
    init(images: [Image]) {
        self.images = images.map { IdentifiableImage(image: $0) }
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach(images) { identifiableImage in
                    identifiableImage
                        .image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
            }
        }
    }
}

#Preview {
    KAImagesView(images: [Image("image1"), Image("image2"), Image("image3")])
}

struct IdentifiableImage: Identifiable {
    let id = UUID()
    let image: Image
}
