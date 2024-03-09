//
//  BookmarkViewModel.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 6.03.2024.
//

import Foundation

protocol BookmarkViewModelInterface {
    
    func viewDidLoad()
    func viewWillAppear()
}

final class BookmarkViewModel {
    private weak var view: BookmarkViewControllerInterface?
    private let movieStorageService = MovieStorageService()
    
    var movies: [MoviePersistance] = []
    
    init(view: BookmarkViewControllerInterface? = nil) {
        self.view = view
    }
}

extension BookmarkViewModel: BookmarkViewModelInterface {
    
    func viewDidLoad() {
        view?.configure()
    }
    
    func viewWillAppear() {
        getSavedMovies()
        view?.tableViewReloadData()
    }
}

extension BookmarkViewModel {
    
    func getSavedMovies() {
        movies = movieStorageService.getMovies()
    }
    
    func deleteMovie(movie: MoviePersistance) {
        movieStorageService.deleteTheMovie(movie: movie)
    }
}
