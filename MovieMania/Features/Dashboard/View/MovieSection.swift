//
//  MovieSection.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2026-04-19.
//

import SwiftUI

/// Movie Section View with Navigation
struct MovieSection: View {
    let title: MovieSectionType
    let movies: [Movie]
    let viewModel: DashboardViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            MovieSectionTitleView(title: title.rawValue, fontSize: 24)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(movies) { movie in
                        NavigationLink(destination: MovieDetailView(movieID: movie.id)) {
                            MovieCardView(movie: movie)
                        }
                    }
                }
            }
            .onChange(of: movies.last) { lastMovie in
                guard let lastMovie = lastMovie else { return }
                if movies.firstIndex(of: lastMovie) == movies.count - 1 {
                    viewModel.fetchNowPlayingMovies(pageNo: 2)
                }
            }
        }
    }
}
