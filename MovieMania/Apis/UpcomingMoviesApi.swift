//
//  UpcomingMoviesApi.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-09-25.
//

import Foundation
import Combine


protocol UpcomingMoviesApi{
    func upcomingMoviesData(pageNo page:Int?) -> Future<[UpcomingMovies]?, Error>
}

final class UpcomingMoviesApiImplementation:UpcomingMoviesApi{
    private var cancellables = Set<AnyCancellable>()

    func upcomingMoviesData(pageNo page:Int?) -> Future<[UpcomingMovies]?, any Error> {
        return Future<[UpcomingMovies]?, Error> { [weak self] promise in
            guard let self = self  else {
                return promise(.failure(NetworkError.unknown))
            }
            NetworkManager.shared.getRequest(endpoint: .upcomingMovies, type: UpcomingMoviesModel.self, httpMethod: "GET")
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
