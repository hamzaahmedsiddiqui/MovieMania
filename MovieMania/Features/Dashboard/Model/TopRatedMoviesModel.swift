//
//  TopRatedMoviesModel.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-09-24.
//

import Foundation

// MARK: - Welcome
struct TopRatedMoviesModel: Codable {
    let page: Int
    let results: [TopRatedMovies]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct TopRatedMovies: Codable,Identifiable {
  
    let id: Int
    let posterPath: String
    let title: String

    // Map the JSON keys to your struct properties
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path" // Maps "poster_path" from JSON to "posterPath"
        case title
    }
}
