//
//  MovieDetailViewModel.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-12-30.
//

import Foundation
import Combine

struct MovieDetailsViewState {
    var movieDetail: MovieDetailModel?
    var movieId: Int?
    var noMovieFound: Bool = false
}

class MovieDetailViewModel: ObservableObject {
    
    @Published var state: MovieDetailsViewState = MovieDetailsViewState()
    private var api:MovieDetailApi
    private var cancellables = Set<AnyCancellable>()
    
    init(movieId: Int?,api: MovieDetailApi)
    {
        self.api = api
        self.state.movieId = movieId
    }
    
    func fetchMovieDetails() {
        if let movieId = state.movieId {
            fetchData(from: api.getData(movieId: movieId)) { [weak self] movieDetails in
                self?.state.movieDetail = movieDetails
            }
        }
    }
    
    /// Generic method to fetch movies using Combine
    /// - Parameters:
    ///   - apiCall: The API call returning a `Future` with the movie list
    ///   - completion: Closure to handle the fetched movies
    private func fetchData<T: Codable>(from apiCall: Future<T?, Error>, completion: @escaping (T) -> Void) {
        apiCall
            .sink { [self] completionResult in
                switch completionResult {
                case .failure(let error):
                    print("❌ Error fetching movies: \(error.localizedDescription)")
                    state.noMovieFound = true
                case .finished:
                    print("✅ Successfully fetched movies")
                }
            } receiveValue: { data in
                if let data = data {
                    completion(data)
                }else {
                    print("⚠️ Received nil data")
                }
            }
            .store(in: &cancellables)
    }
}
