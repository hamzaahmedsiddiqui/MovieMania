//
//  MovieDetailApi.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2025-01-04.
//

import Foundation
import Combine

protocol MovieDetailApi{
    func getData(movieId id:Int) -> Future<MovieDetailModel?, Error>
}

final class MovieDetailApiImplementation:MovieDetailApi{
    private var cancellables = Set<AnyCancellable>()

    func getData(movieId:Int) -> Future<MovieDetailModel?, Error>{
        return Future<MovieDetailModel?, Error> { [weak self] promise in
            guard let self = self  else {
                return promise(.failure(NetworkError.unknown))
            }
            
            
            NetworkManager.shared.getRequest(endpoint: .movieDetails(moviedId: movieId), type: MovieDetailModel.self, httpMethod: "GET")
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
            promise(.success($0))
        }
        .store(in: &self.cancellables)
        }
    }
}
