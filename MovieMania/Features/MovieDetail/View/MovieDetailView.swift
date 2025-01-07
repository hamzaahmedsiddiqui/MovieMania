//
//  MovieDetailView.swift
//  MovieMania
//
//  Created by Hamza Ahmed on 2024-09-27.
//

import SwiftUI

struct MovieDetailView: View {
    let movieID: Int
    @StateObject var viewModel: MovieDetailViewModel
    
    // Custom initializer
    init(movieID: Int) {
        self.movieID = movieID
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movieId: movieID, api: MovieDetailApiImplementation()))
    }
    
    var body: some View {
        if viewModel.state.noMovieFound{
            Text("No movie details found")
        } else {
            ScrollView {
                VStack(alignment: .leading) {
                    MovieHeaderView(
                        movieTitle: viewModel.state.movieDetail?.title ?? "",
                        ageRating: viewModel.state.movieDetail?.adult ?? false,
                        posterPath: viewModel.state.movieDetail?.posterPath ?? ""
                    )
                    HStack {
                        Label(String(viewModel.state.movieDetail?.runtime ?? 0) + "minutes", systemImage: "timer")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        
                        Spacer()
                        Button {
                            print("Like button pressed for movieID: \(movieID)")
                        } label: {
                            Image(systemName: "heart")
                        }
                    }
                    .padding(.horizontal)
                    
                    HStack {
                        Text("Release Date: \(viewModel.state.movieDetail?.releaseDate ?? "")")
                            .font(.caption)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding()
                    
                    HStack {
                        Text("Genres:")
                            .font(.caption)
                            .fontWeight(.bold)
                        
                        // Genres displayed as vertical capsules
                        ForEach(viewModel.state.movieDetail?.genres ?? []) { genre in
                            Text(genre.name ?? "")
                                .font(.caption)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(20)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Overview Section
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Overview")
                            .font(.headline)
                            .fontWeight(.bold)
                        
                        Text(viewModel.state.movieDetail?.overview ?? "")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                }
            }
            .onAppear {
                viewModel.fetchMovieDetails()
            }
        }
    }
}
