//
//  MovieDetailModel.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2025-01-04.
//

import Foundation

// MARK: - Welcome
struct MovieDetailModel: Codable {
    let adult: Bool
    let genres: [Genre]?
    let homepage: String?
    let id: Int
    let originCountry: [String]?
    let originalLanguage, originalTitle, overview: String?
    let posterPath: String?
    let releaseDate: String?
    let runtime: Int?
    let title: String
    let video: Bool

    enum CodingKeys: String, CodingKey {
        case adult
        case genres, homepage, id
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case title, video
    }
}

// MARK: - Genre
struct Genre: Codable, Identifiable {
    let id: Int?
    let name: String?
}
