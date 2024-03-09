//
//  MovieStorageService.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 6.03.2024.
//

import Foundation

protocol MovieStorageServiceInterface {
    func saveMovie(movie: MoviePersistance)
    func getMovies() -> [MoviePersistance]
}

final class MovieStorageService: MovieStorageServiceInterface {

    var storedMovies: [MoviePersistance] = []
    
    func saveMovie(movie: MoviePersistance) {
        let savedMovies = getMovies()
        var isMovieSaved = false
        savedMovies.forEach { savedMovie in
            if savedMovie.imdbId == movie.imdbId {
                isMovieSaved = true
            }
        }
        isMovieSaved == false ? RealmManager.shared.save(movie) : print("Movie has been saved before.")
    }
    
    func getMovies() -> [MoviePersistance] {
        return RealmManager.shared.read(MoviePersistance.self)
    }
    
    func deleteTheMovie(movie: MoviePersistance) {
        RealmManager.shared.delete(movie)
    }
}
