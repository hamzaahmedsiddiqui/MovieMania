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
    
    func url(page:Int) -> URL? {
        var path: String
        let queryItems = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        switch self {
        case .nowPlayingMovies:
            path = "/now_playing"
        case .popularMovies:
            path = "/popular"
        case .topRatedMovies:
            path = "/top_rated"
        case .upcomingMovies:
            path = "/upcoming"
        }
        
        var components = URLComponents(string: Constants.baseUrl + path)
        components?.queryItems = queryItems
        
        return components?.url
    }
}

