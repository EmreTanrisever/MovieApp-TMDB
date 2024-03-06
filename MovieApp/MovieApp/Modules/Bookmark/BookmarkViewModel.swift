//
//  BookmarkViewModel.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 6.03.2024.
//

import Foundation

protocol BookmarkViewModelInterface {
    
    func viewDidLoad()
}

final class BookmarkViewModel {
    private weak var view: BookmarkViewControllerInterface?
    private let movieStorageService = MovieStorageService()
    
    var movies: [DetailsOfMovie] = []
    
    init(view: BookmarkViewControllerInterface? = nil) {
        self.view = view
    }
}

extension BookmarkViewModel: BookmarkViewModelInterface {
    
    func viewDidLoad() {
        view?.configure()
        getSavedMovies()
    }
}

extension BookmarkViewModel {
    
    func getSavedMovies() {
        let savedMovies = movieStorageService.getMovies()
        movies = savedMovies.map({ savedMovies in
            var genre: [Genre] = []
            for i in 0..<(savedMovies.genresId.count-1) {
                genre.append(.init(id: savedMovies.genresId[i], name: savedMovies.genres[i]))
            }
            
            return DetailsOfMovie(
                adult: savedMovies.adult,
                backdrop_path: savedMovies.backdrop_path,
                budget: savedMovies.budget,
                genres: genre,
                homepage: savedMovies.homepage,
                id: 0,
                imdbId: savedMovies.imdbId,
                language: savedMovies.language,
                originalTitle: savedMovies.originalTitle,
                overview: savedMovies.overview,
                popularity: savedMovies.popularity,
                poster: savedMovies.poster,
                release: savedMovies.release,
                revenue: savedMovies.revenue,
                voteAvarage: savedMovies.voteAvarage,
                voteCount: savedMovies.voteCount
            )
        })
    }
}
