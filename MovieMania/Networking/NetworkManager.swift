//
//  NetworkManager.swift
//  MovieMania
//
//  Created by Hamza Ahmed on 2024-09-24.
//

import Foundation
import Combine
import SwiftUI

protocol NetworkManagerProtocol{
    func getRequest<T: Codable>(endpoint: Endpoints,type: T.Type,httpMethod: String?) -> Future<T, Error>
    func getAuthenticateUrlRequest(url:URL, HttpMethod:String?) ->URLRequest
}



final class NetworkManager:NetworkManagerProtocol {

    
    
    private var cancellables = Set<AnyCancellable>()
    static let shared = NetworkManager()
 //   private init() {}
    
 //   @Published var fetchedImage: Image? // Store the fetched image
    // Generic GET request with optional Authorization header
    func getRequest<T: Codable>(endpoint: Endpoints,
                                //parameters: [String: Any]? = nil,
                                type: T.Type,
                                httpMethod: String?
    ) -> Future<T, Error> {
        return Future<T, Error> { [weak self] promise in
            guard let self = self, let url = endpoint.url(page: 1) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            print("Requesting URL: \(url.absoluteString)")
            
            // Execute the dasta task
            URLSession.shared.dataTaskPublisher(for: getAuthenticateUrlRequest(url: url, HttpMethod: httpMethod ?? "GET"))
                .tryMap { (data, response) -> Data in
                    // Validate the HTTP response status
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder()) // Decode the JSON response into the provided type
                .receive(on: DispatchQueue.main) // Ensure updates happen on the main thread
                .sink(receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        // Handle errors properly by categorizing them
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: { decodedData in
                    // Pass the decoded data to the promise
                    promise(.success(decodedData))
                })
                .store(in: &self.cancellables) // Store the subscription to avoid cancellation
        }
    }
    
     func getAuthenticateUrlRequest(url:URL, HttpMethod:String?) ->URLRequest {
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod ?? "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("Bearer \(Constants.accessToken)", forHTTPHeaderField: "Authorization")
        return request
    }
}


