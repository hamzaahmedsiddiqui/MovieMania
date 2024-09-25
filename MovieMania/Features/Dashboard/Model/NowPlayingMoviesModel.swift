//
//  NowPlayingMoviesModel.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-09-24.
//

import Foundation
import SwiftUI

// MARK: - Welcome
struct NowPlayingMoviesModel: Codable {
    let dates: Dates
    let page: Int
    let results: [NowPlayingMovies]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum, minimum: String
}

// MARK: - Now playing Movies Result
struct NowPlayingMovies: Codable,Identifiable {
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
