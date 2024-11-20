//
//  File.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-09-24.
//

import Foundation
import Combine
import SwiftUI

protocol DashboardViewModel{
    func fetchNowplayingMovies()
    func fetchPopularMovies()
    func fetchTopRatedMovies()
    func fetchUpcomingMovies()
 //   func fetchImage(from url: String)
}
// Here protocol is used for easier mocking for unit tests

class DashboardViewModelImplementation: DashboardViewModel,ObservableObject{
    @Published var nowPlayingMovies: [NowPlayingMovies] = []
    @Published var popularMovies: [PopularMovies] = []
    @Published var topRatedMovies: [TopRatedMovies] = []
    @Published var upcomingMovies: [UpcomingMovies] = []
    @Published var fetchedImage: Image? // Store the fetched image
    
    
    private var nowPlayingMoviesApi:NowPlayingMoviesApi
    private var popularMoviesApi:PopularMoviesApi
    private var topRatedMoviesApi:TopRatedMoviesApi
    private var upcomingMoviesApi:UpcomingMoviesApi
    private var cancellables = Set<AnyCancellable>()
    
    init( nowPlayingMoviesApi: NowPlayingMoviesApi, popularMoviesApi: PopularMoviesApi, topRatedMoviesApi: TopRatedMoviesApi, upcomingMoviesApi: UpcomingMoviesApi) {
        self.nowPlayingMoviesApi = nowPlayingMoviesApi
        self.popularMoviesApi = popularMoviesApi
        self.topRatedMoviesApi = topRatedMoviesApi
        self.upcomingMoviesApi = upcomingMoviesApi
    }
    
    func fetchNowplayingMovies(){
        fetchMovies(nowPlayingMoviesApi.nowPlayingMoviesData(pageNo: 1)) { [weak self] movies in
            self?.nowPlayingMovies = movies
        }
    }
    
    func fetchPopularMovies(){
        fetchMovies(popularMoviesApi.popularMoviesData(pageNo: 1)) {[weak self] movies in
            self?.popularMovies = movies
        }
    }
    
    func fetchTopRatedMovies() {
        fetchMovies(topRatedMoviesApi.topRatedMoviesData(pageNo: 1)) { [weak self] movies in
            self?.topRatedMovies = movies
        }
    }
    
    func fetchUpcomingMovies() {
        fetchMovies(upcomingMoviesApi.upcomingMoviesData(pageNo: 1)) { [weak self] movies in
            self?.upcomingMovies = movies
        }
    }
    

    // Generic API Fetching Method
    private func fetchMovies<T: Codable>(_ apiCall: Future<[T]?, Error>, completion: @escaping ([T]) -> Void) {
        apiCall
            .sink { completionResult in
                switch completionResult {
                case .failure(let err):
                    print("Error fetching movies: \(err.localizedDescription)")
                case .finished:
                    print("Finished fetching movies")
                }
            } receiveValue: { moviesList in
                completion(moviesList ?? [])
            }
            .store(in: &cancellables)
    }
}
