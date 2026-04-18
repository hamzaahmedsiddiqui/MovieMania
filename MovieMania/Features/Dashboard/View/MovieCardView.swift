//
//  MovieCardView.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-09-25.
//

import SwiftUI

struct MovieCardView: View {
    let movie:Movie
    @State private var fetchedImage: Image? = nil
    
    var body: some View {
        ZStack{
         
            VStack(spacing: 10) {
                AsyncImage(url: URL(string: Constants.baseUrlImage500 + (movie.posterPath))){ image in
                    if let image = image.image{
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 150)
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
                    } else {
                        Color.blue //placeholder.
                    }
                }
                Text(movie.title)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .fontWeight(.bold)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true) // Ensures the text grows vertically
                    .frame(width: 100)
            }
        }
    }
}


#Preview {
    MovieCardView(movie: mockMovies[0])
}
