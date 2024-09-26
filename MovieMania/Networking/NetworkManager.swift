//
//  NetworkManager.swift
//  MovieMania
//
//  Created by Hamza Ahmed on 2024-09-24.
//

import Foundation
import Combine
import SwiftUI

final class NetworkManager {
    
    private var cancellables = Set<AnyCancellable>()
    static let shared = NetworkManager()
    private init() {}
    
    @Published var fetchedImage: Image? // Store the fetched image
    // Generic GET request with optional Authorization header
    func getRequest<T: Codable>(endpoint: Endpoints,
                                //parameters: [String: Any]? = nil,
                                type: T.Type,
                                httpMethod: String = "GET"
    ) -> Future<T, Error> {
        return Future<T, Error> { [weak self] promise in
            guard let self = self, let url = endpoint.url(page: 1) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            print("Requesting URL: \(url.absoluteString)")
            
            // Execute the dasta task
            URLSession.shared.dataTaskPublisher(for: getAuthenticateUrlRequest(url: url, HttpMethod: httpMethod))
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
    
    
    // New method to fetch an image
//       func fetchImage(from url: String) -> Future<Image, Error> {
//           return Future<Image, Error> { [weak self] promise in
//          
//               guard let self = self, let imageURL = URL(string: Constants.baseUrlImage500 + url) else {
//                   return promise(.failure(NetworkError.invalidURL))
//               }
//               print("Requesting URL: \(imageURL)")
//               URLSession.shared.dataTaskPublisher(for: getAuthenticateUrlRequest(url: imageURL, HttpMethod: "GET"))
//                   .map { $0.data } // Get the data from the response
//                   .tryMap { data in
//                       // Create UIImage from the data
//                       guard let uiImage = UIImage(data: data) else {
//                           throw NetworkError.responseError // Handle error if image cannot be created
//                       }
//                       return uiImage
//                   }
//                   .map { Image(uiImage: $0) } // Convert to SwiftUI Image
//                   .receive(on: DispatchQueue.main)
//                   .sink(receiveCompletion: { completion in
//                       if case let .failure(error) = completion {
//                           promise(.failure(error))
//                       }
//                   }, receiveValue: { image in
//                       promise(.success(image)) // Return the fetched image
//                   })
//                   .store(in: &self.cancellables)
//           }
  //     }
    
    
    private func getAuthenticateUrlRequest(url:URL, HttpMethod:String?) ->URLRequest {
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod ?? "GET"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("Bearer \(Constants.accessToken)", forHTTPHeaderField: "Authorization")
        return request
    }
}


