//
//  MovieCardView.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-09-25.
//

import SwiftUI

struct MovieCardView: View {
    //    let posterPath: String?
    //    let movieTitle: String
    let movie:Movie
    @State private var fetchedImage: Image? = nil
    
    var body: some View {
        ZStack{
            VStack(spacing: 10) {
                AsyncImage(url: URL(string: Constants.baseUrlImage500 + (movie.posterPath))){ image in
                    if let image = image.image{
                        image
                            .resizable()// Make the image resizable
                            .scaledToFit()
                            .frame(width: 100, height: 150)
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
                    } else {
                        Color.blue // Acts as a placeholder.
                    }
                }
                Text(movie.title)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .lineLimit(2) // Limits the text to two lines
                    .fixedSize(horizontal: false, vertical: true) // Ensures the text grows vertically
                    .frame(width: 100)
                    .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y:0)
            }
        }
    }
}


#Preview {
    MovieCardView(movie: mockMovies[0])
}
