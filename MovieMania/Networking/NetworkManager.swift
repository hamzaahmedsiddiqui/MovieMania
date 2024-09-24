//
//  NetworkManager.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-09-24.
//

import Foundation
import Combine

class NetworkManager{
    

    private var cancellables = Set<AnyCancellable>()
    static let shared = NetworkManager()
    private init() {}

    func getRequest<T: Codable>(endpoint:Endpoints, type: T.Type) -> Future<T, Error>{
        return Future<T, Error>{ [weak self] promise in
            guard let self = self, let url = endpoint.url(pageNo: 1)
            else{
                return promise(.failure(NetworkError.invalidURL))
            }
            print("URL is \(url.absoluteString)")
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: { promise(.success($0))})
                .store(in: &self.cancellables)
        }
    }
}
