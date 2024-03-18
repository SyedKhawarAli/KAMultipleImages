//
//  ContentView.swift
//  Example
//
//  Created by shah on 13.3.2024.
//

import SwiftUI
import KAMultipleImages

struct ContentView: View {
    var body: some View {
        VStack {
            KAMultipleImages(imagesUrls: [
            URL(string: "https://www.gstatic.com/webp/gallery3/1.sm.png")!,
            URL(string: "https://pixabay.com/images/download/people-2944065_640.jpg?attachment")!,
            URL(string: "http://placehold.it/120x120&text=image1")!
//                http://placehold.it/120x120&text=image2
//                http://placehold.it/120x120&text=image3
//                http://placehold.it/120x120&text=image4")!
            ])
            
            AsyncImage(url: URL(string: "http://placehold.it/120x120&text=image1")!) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
                
            Text("Hello, world!")
                .padding()
        }
        .padding()
    }

    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                completion(UIImage(data: data))
                }
        }.resume()
    }
}

#Preview {
    ContentView()
}
