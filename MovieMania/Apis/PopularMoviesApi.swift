//
//  NowPlayingApi.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-09-24.
//

import Foundation
import Combine


protocol PopularMoviesApi{
    func popularMoviesData(pageNo page:Int?) -> Future<[PopularMovies]?, Error>
}

final class PopularMoviesApiImplementation:PopularMoviesApi{
    private var cancellables = Set<AnyCancellable>()

    func popularMoviesData(pageNo page:Int?) -> Future<[PopularMovies]?, any Error> {
        return Future<[PopularMovies]?, Error> { [weak self] promise in
            guard let self = self  else {
                return promise(.failure(NetworkError.unknown))
            }
            NetworkManager.shared.getRequest(endpoint: .popularMovies, type: PopularMoviesModel.self, httpMethod: "GET")
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
