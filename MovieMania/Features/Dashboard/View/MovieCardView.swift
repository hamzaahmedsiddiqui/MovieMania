//
//  MovieCardView.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-09-25.
//

import SwiftUI

struct MovieCardView: View {
    let posterPath: String?
    let movieTitle: String
    @State private var fetchedImage: Image? = nil
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: Constants.baseUrlImage500 + posterPath!)){ image in
                image
                    .image?.resizable()// Make the image resizable
                    .scaledToFit()
                    .frame(width: 100, height: 150)
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
            }
            Text(movieTitle)
                .font(.caption)
                .multilineTextAlignment(.center)
                .lineLimit(2) // Limits the text to two lines
                .fixedSize(horizontal: false, vertical: true) // Ensures the text grows vertically
                .frame(width: 100)
                .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
        }
        .padding(10)
    }
}


//#Preview {
//    MovieCardView()
//}
