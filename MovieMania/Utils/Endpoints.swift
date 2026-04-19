//
//  Enums.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-09-24.
//

import Foundation

enum Endpoints {
    case nowPlayingMovies
    case popularMovies
    case topRatedMovies
    case upcomingMovies
    case movieDetails(id:Int)
    
    func url(page:Int = 0, moviedId:Int = 0) -> URL? {
        var path: String
        let baseUrl = Constants.baseUrl
        
        switch self {
        case .nowPlayingMovies:
            path = "/now_playing"
        case .popularMovies:
            path = "/popular"
        case .topRatedMovies:
            path = "/top_rated"
        case .upcomingMovies:
            path = "/upcoming"
        case .movieDetails(let id):
            path = "/\(id)"
        }
        
        var queryItems: [URLQueryItem] = []
        switch self {
        case .movieDetails(_):
            break
        default :
            queryItems = [
                  URLQueryItem(name: "language", value: "en-US"),
                  URLQueryItem(name: "page", value: "\(page)")
              ]
        }
            

        var components = URLComponents(string: baseUrl + path)
        components?.queryItems = queryItems
        
        return components?.url
    }
}
