// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct KAMultipleImages: View {
    public init() {}
    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
            Text("Hello, world!")
        }
        .padding()
    }
}
