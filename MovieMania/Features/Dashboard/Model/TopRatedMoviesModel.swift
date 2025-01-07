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
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

