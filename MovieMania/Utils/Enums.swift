//
//  Enums.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-09-24.
//

import Foundation


//enum Endpoints{
//    case nowPlayingMovies(page:Int)
//    case popularMovies(page:Int)
//    case topRatedMovies(page:Int)
//    case upcomingMovies(page:Int)
//    
//    func url(pageNo page:Int)-> URL?{
//        switch self {
//        case let .nowPlayingMovies(page: page):
//            return URL(string: Constants.baseUrl+"now_playing?language=en-US&page="+String(page))
//        case let .popularMovies(page: page):
//            return URL(string: Constants.baseUrl+"popular?language=en-US&page="+String(page))
//        case let .topRatedMovies(page: page):
//            return URL(string: Constants.baseUrl+"top_rated?language=en-US&page="+String(page))
//        case let .upcomingMovies(page: page):
//            return URL(string: Constants.baseUrl+"upcoming?language=en-US&page="+String(page))
//        default:
//            return URL(string: "")
//        }
//    }
//}

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

enum NetworkError: Error {
    case invalidURL
    case responseError
    case unknown
}
