import Foundation

// MARK: - Welcome
struct UpcomingMoviesModel: Codable {
    let results: [UpcomingMovies]
}

// MARK: - UpcomingMovies
struct UpcomingMovies: Codable, Identifiable {
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
