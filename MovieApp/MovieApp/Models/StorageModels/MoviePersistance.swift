//
//  MoviePersistance.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 6.03.2024.
//

import Foundation
import RealmSwift

final class MoviePersistance: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var adult: Bool
    @Persisted var backdrop_path: String
    @Persisted var budget: Int
    @Persisted var genresId: List<Int>
    @Persisted var genres: List<String>
    @Persisted var homepage: String
    @Persisted var imdbId: String
    @Persisted var language: String
    @Persisted var originalTitle: String
    @Persisted var overview: String
    @Persisted var popularity: Double
    @Persisted var poster: String
    @Persisted var release: String
    @Persisted var revenue: Int
    @Persisted var voteAvarage: Double
    @Persisted var voteCount: Int
    
    convenience init(
        adult: Bool,
        backdrop_path: String,
        budget: Int,
        genresId: List<Int>,
        genres: List<String>,
        homepage: String,
        imdbId: String,
        language: String,
        originalTitle: String,
        overview: String,
        popularity: Double,
        poster: String,
        release: String,
        revenue: Int,
        voteAvarage: Double,
        voteCount: Int
    ) {
        self.init()
        
        self.adult = adult
        self.backdrop_path = backdrop_path
        self.budget = budget
        self.genresId = genresId
        self.genres = genres
        self.homepage = homepage
        self.imdbId = imdbId
        self.language = language
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.poster = poster
        self.release = release
        self.revenue = revenue
        self.voteAvarage = voteAvarage
        self.voteCount = voteCount
    }
}
