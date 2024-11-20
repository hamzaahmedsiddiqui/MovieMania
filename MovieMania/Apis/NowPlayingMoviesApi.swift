//
//  NowPlayingApi.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-09-24.
//

import Foundation
import Combine


protocol NowPlayingMoviesApi{
    func nowPlayingMoviesData(pageNo page:Int?) -> Future<[NowPlayingMovies]?, Error>
}

final class NowPlayingMoviesApiImplementation:NowPlayingMoviesApi{
    private var cancellables = Set<AnyCancellable>()

    func nowPlayingMoviesData(pageNo page:Int?) -> Future<[NowPlayingMovies]?, any Error> {
        return Future<[NowPlayingMovies]?, Error> { [weak self] promise in
            guard let self = self  else {
                return promise(.failure(NetworkError.unknown))
            }
            
            NetworkManager.shared.getRequest(endpoint: .nowPlayingMovies, type: NowPlayingMoviesModel.self, httpMethod: "GET")
                .sink { completion in
                    switch completion{
                    case .failure(let err):
                        print("Error is \(err.localizedDescription)")
                        promise(.failure(err))
                    case .finished:
                        print("Finshed")
                    }
                }
        receiveValue: {
            promise(.success($0.results))
        }
        .store(in: &self.cancellables)
        }
    }
}
