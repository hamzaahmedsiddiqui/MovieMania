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
        ZStack{
            VStack {
                AsyncImage(url: URL(string: Constants.baseUrlImage500 +     (posterPath ?? ""))){ image in
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
                Text(movieTitle)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .lineLimit(2) // Limits the text to two lines
                    .fixedSize(horizontal: false, vertical: true) // Ensures the text grows vertically
                    .frame(width: 100)
                    .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
                
            }.padding(10)
            Button(action: {
                // Action to perform when the button is tapped
                print("Button tapped")
            }) {
                // Empty content but still tappable
                Color.clear
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)        }
    }
}


#Preview {
    MovieCardView(posterPath: "/vr6n6ZFUZvedvIlhfYcbCWcaKyW.jpg", movieTitle: "avengers")
}
