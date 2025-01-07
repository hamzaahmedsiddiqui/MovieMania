//
//  MovieHeaderView.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-12-31.
//

import SwiftUI

struct MovieHeaderView: View {
    var movieTitle: String
    var ageRating: Bool = true
    var posterPath: String
    
    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: Constants.baseUrlImage500 + (posterPath))){ image in
                if let image = image.image{
                    image
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                        .padding()
                } else {
                    Color.blue // Acts as a placeholder.
                }
            }
            VStack {
                if ageRating {
                    HStack {
                        Text("18+")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                            .padding(30)
                        Spacer()
                    }
                }
                Spacer()
                Text(movieTitle)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color.red, Color.orange, Color.yellow],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .shadow(color: .black.opacity(0.7), radius: 5, x: 0, y: 10)
                    .padding(.horizontal)
                    .padding(.vertical, 20)
            }
        }
    }
}

//#Preview {
//    MovieHeaderView(movieTitle: "Movie Title", ageRating: "18+", imageName: "demoImage")
//}
