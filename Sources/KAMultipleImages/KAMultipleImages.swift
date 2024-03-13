// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import Combine

public struct KAMultipleImages: View {
    @StateObject private var viewModel: KAMultipleImagesViewModel

    public init(imagesUrls: [URL]) {
        _viewModel = StateObject(wrappedValue: KAMultipleImagesViewModel(imagesUrls: imagesUrls))
    }
    
    public var body: some View {
        VStack {
            GridImageView(images: viewModel.downloadedImages)
        }
        .padding()
    }
}

extension KAMultipleImages {
    @MainActor class KAMultipleImagesViewModel: ObservableObject {
        @Published var imagesUrls: [URL]
        @Published var downloadedImages: [Image] = []
        var cancellables = Set<AnyCancellable>()
        
        init(imagesUrls: [URL]) {
            self.imagesUrls = imagesUrls
            fetchImages()
        }
        
        func fetchImages() {
            let images = imagesUrls.map { url in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map { UIImage(data: $0.data) }
                    .replaceError(with: nil)
                    .compactMap { $0 }
                    .map { Image(uiImage: $0) }
                    .eraseToAnyPublisher()
            }
            
            Publishers.MergeMany(images)
                .collect()
                .receive(on: DispatchQueue.main)
                .sink { [weak self] images in
                    self?.downloadedImages = images
                }
                .store(in: &cancellables)
        }
    }
}
