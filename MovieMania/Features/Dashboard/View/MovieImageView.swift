//
//  MovieImageView.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-09-25.
//

import SwiftUI

struct MovieImageView: View {
    let imagePath: String?
    @State private var fetchedImage: Image? = nil
    @StateObject var viewModel = DashboardViewModelImplementation(
        nowPlayingMoviesApi: NowPlayingMoviesApiImplementation(),
        popularMoviesApi: PopularMoviesApiImplementation(),
        topRatedMoviesApi: TopRatedMoviesApiImplementation(),
        upcomingMoviesApi: UpcomingMoviesApiImplementation()
    )
    var body: some View {
        VStack {
            if let image = viewModel.fetchedImage {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 150)
                
            } else {
                Text("Loading image...")
                    .onAppear {
                        viewModel.fetchImage(from: imagePath ?? "")
                    }
            }
        }
    }
}
//
//#Preview {
//    MovieImageView()
//}
