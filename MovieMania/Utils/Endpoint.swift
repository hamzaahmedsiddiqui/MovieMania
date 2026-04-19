//
//  Enums.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-09-24.
//

import Foundation

enum Endpoint {
    case nowPlayingMovies(page: Int)
    case popularMovies(page: Int)
    case topRatedMovies(page: Int)
    case upcomingMovies(page: Int)
    case movieDetails(id: Int)

    private var path: String {
        switch self {
        case .nowPlayingMovies: return "/now_playing"
        case .popularMovies: return "/popular"
        case .topRatedMovies: return "/top_rated"
        case .upcomingMovies: return "/upcoming"
        case .movieDetails(let id): return "/\(id)"
        }
    }

    private var queryItems: [URLQueryItem] {
        switch self {
        case .movieDetails:
            return []
        case .nowPlayingMovies(let page),
             .popularMovies(let page),
             .topRatedMovies(let page),
             .upcomingMovies(let page):
            return [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        }
    }

    func url() -> URL? {
        var components = URLComponents(string: Constants.baseUrl)
        components?.path += path
        components?.queryItems = queryItems
        return components?.url
    }
}
