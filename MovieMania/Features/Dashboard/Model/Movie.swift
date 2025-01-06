//
//  NowPlayingMovies.swift
//  MovieMania
//
//  Created by hamza Ahmed on 2024-11-22.
//


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




let movies = [
    Movie(id: UUID(), title: "Inception", description: "A mind-bending thriller."),
    Movie(id: UUID(), title: "Interstellar", description: "An epic space journey."),
    Movie(id: UUID(), title: "The Dark Knight", description: "A gritty superhero movie.")
]
