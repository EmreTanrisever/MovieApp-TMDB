//
//  Movie.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 23.02.2023.
//

import Foundation

struct Movie: Codable {
    let adult: Bool
    let backDropPath: String?
    let genreIDs: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overView: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAvarage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backDropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overView = "overview"
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAvarage = "vote_average"
        case voteCount = "vote_count"
    }
}
