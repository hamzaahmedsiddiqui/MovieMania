//
//  NowPlayingMovies.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-11-22.
//

import Foundation


struct Movie: Codable,Identifiable {
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




let mockMovies = [
    Movie(id: 2, posterPath: "/vr6n6ZFUZvedvIlhfYcbCWcaKyW.jpg", title: "Interstellar Interstellar"),
    Movie(id: 6,  posterPath: "/vr6n6ZFUZvedvIlhfYcbCWcaKyW.jpg",title: "The Dark Knight")
]
