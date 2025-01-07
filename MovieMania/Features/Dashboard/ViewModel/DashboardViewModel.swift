//
//  DashboardViewModel.swift
//  MovieMania
//
//  Created by Hamza Ahmed on 2024-09-24.
//

import Foundation
import Combine
import SwiftUI

/// State to manage movies data for the Dashboard View
struct DashboardViewState {
    var nowPlayingMovies: [Movie] = []
    var popularMovies: [Movie] = []
    var topRatedMovies: [Movie] = []
    var upcomingMovies: [Movie] = []
    var fetchedImage: Image? // Optional: Can be used to store fetched images
}

/// ViewModel for the Dashboard View
class DashboardViewModel: ObservableObject {
    // Published state for the dashboard view
    @Published var state = DashboardViewState()
    
    // API dependencies
    private let nowPlayingMoviesApi: NowPlayingMoviesApi
    private let popularMoviesApi: PopularMoviesApi
    private let topRatedMoviesApi: TopRatedMoviesApi
    private let upcomingMoviesApi: UpcomingMoviesApi
    private var cancellables = Set<AnyCancellable>()
    
    /// Initializer with API dependencies
    init(
        nowPlayingMoviesApi: NowPlayingMoviesApi,
        popularMoviesApi: PopularMoviesApi,
        topRatedMoviesApi: TopRatedMoviesApi,
        upcomingMoviesApi: UpcomingMoviesApi
    ) {
        self.nowPlayingMoviesApi = nowPlayingMoviesApi
        self.popularMoviesApi = popularMoviesApi
        self.topRatedMoviesApi = topRatedMoviesApi
        self.upcomingMoviesApi = upcomingMoviesApi
        fetchAllMovies()
    }
    
    /// Fetch all movie categories
    private func fetchAllMovies() {
        fetchNowPlayingMovies()
        fetchPopularMovies()
        fetchTopRatedMovies()
        fetchUpcomingMovies()
    }
    
    /// Fetch now-playing movies
    private func fetchNowPlayingMovies() {
        fetchMovies(from: nowPlayingMoviesApi.nowPlayingMoviesData(pageNo: 1)) { [weak self] movies in
            self?.state.nowPlayingMovies = movies
        }
    }
    
    /// Fetch popular movies
    private func fetchPopularMovies() {
        fetchMovies(from: popularMoviesApi.popularMoviesData(pageNo: 1)) { [weak self] movies in
            self?.state.popularMovies = movies
        }
    }
    
    /// Fetch top-rated movies
    private func fetchTopRatedMovies() {
        fetchMovies(from: topRatedMoviesApi.topRatedMoviesData(pageNo: 1)) { [weak self] movies in
            self?.state.topRatedMovies = movies
        }
    }
    
    /// Fetch upcoming movies
    private func fetchUpcomingMovies() {
        fetchMovies(from: upcomingMoviesApi.upcomingMoviesData(pageNo: 1)) { [weak self] movies in
            self?.state.upcomingMovies = movies
        }
    }
    
    /// Generic method to fetch movies using Combine
    /// - Parameters:
    ///   - apiCall: The API call returning a `Future` with the movie list
    ///   - completion: Closure to handle the fetched movies
    private func fetchMovies<T: Codable>(from apiCall: Future<[T]?, Error>, completion: @escaping ([T]) -> Void) {
        apiCall
            .sink { completionResult in
                switch completionResult {
                case .failure(let error):
                    print("❌ Error fetching movies: \(error.localizedDescription)")
                case .finished:
                    print("✅ Successfully fetched movies")
                }
            } receiveValue: { moviesList in
                completion(moviesList ?? [])
            }
            .store(in: &cancellables)
    }
}
