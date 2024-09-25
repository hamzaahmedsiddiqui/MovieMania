//
//  TopRatedMoviesApi.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-09-25.
//

import Foundation
import Combine


protocol TopRatedMoviesApi{
    func topRatedMoviesData(pageNo page:Int?) -> Future<[TopRatedMovies]?, Error>
}

final class TopRatedMoviesApiImplementation:TopRatedMoviesApi{
    private var cancellables = Set<AnyCancellable>()

    func topRatedMoviesData(pageNo page:Int?) -> Future<[TopRatedMovies]?, any Error> {
        return Future<[TopRatedMovies]?, Error> { [weak self] promise in
            guard let self = self  else {
                return promise(.failure(NetworkError.unknown))
            }
            NetworkManager.shared.getRequest(endpoint: .topRatedMovies, type: TopRatedMoviesModel.self)
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
