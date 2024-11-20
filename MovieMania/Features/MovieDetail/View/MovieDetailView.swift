//
//  MovieDetailView.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-09-27.
//

import SwiftUI

struct MovieDetailView: View {
    var body: some View {
        ZStack{
            Image("https://image.tmdb.org/t/p/w500/vr6n6ZFUZvedvIlhfYcbCWcaKyW.jpg")
                .edgesIgnoringSafeArea(.all)
                .scaledToFit()
        }
    }
}

#Preview {
    MovieDetailView()
}
