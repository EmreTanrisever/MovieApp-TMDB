//
//  DetailsOfMovie.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 22.06.2023.
//

import Foundation

struct DetailsOfMovie: Codable {
    let adult: Bool
    let backdrop_path: String
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbId: String
    let language: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let poster: String
    let release: String
    let revenue: Int
    let average: Double
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case adult, backdrop_path, budget, genres, homepage, id
        case imdbId = "imdb_id"
        case language = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case poster = "poster_path"
        case release = "release_date"
        case revenue
        case average = "vote_average"
        case count = "vote_count"
    }
}
