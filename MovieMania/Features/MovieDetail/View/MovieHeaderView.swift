//
//  MovieHeaderView.swift
//  MovieMania
//
//  Created by Hamza Ahmed on 2024-12-31.
//

import SwiftUI

struct MovieHeaderView: View {
    var movieTitle: String
    var ageRating: Bool
    var backdropPath: String
    var runtime: Int
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Background Image
            
            AsyncImage(url: URL(string: Constants.baseUrlImage500 + backdropPath)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill() // Ensures the image covers the entire frame
                        .clipped()
                case .failure:
                    Color.gray // Placeholder if image fails to load
                case .empty:
                    ProgressView() // Loading indicator
                @unknown default:
                    Color.gray
                }
            }            
            // Content Overlay
            VStack(spacing: 10) {
                if ageRating {
                    HStack {
                        Text("18+")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.red)
                            .cornerRadius(5)
                            .padding(.leading, 16)
                        Spacer()
                    }
                }
                Spacer()
                HStack {
//                    Label(String(runtime) + "minutes", systemImage: "timer")
//                        .font(.caption)
//                        .fontWeight(.bold)
//                        .foregroundColor(.red)
                    
                    Spacer()
                    Button {
                        //print("Like button pressed for movieID: \(movieID)")
                    } label: {
                        Image(systemName: "heart")
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 16)
        }
        .frame(maxWidth: .infinity)
        .background(Color.black.opacity(0.8)) // Fallback background
    }
}

#Preview {
    MovieHeaderView(
        movieTitle: "Movie Title",
        ageRating: true,
        backdropPath: "/vr6n6ZFUZvedvIlhfYcbCWcaKyW.jpg",
        runtime: 123
    )
}
