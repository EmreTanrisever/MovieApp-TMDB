//
//  MoviesTableViewCellViewModel.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 18.03.2023.
//

import Foundation

protocol MoviesTableViewCellViewModelInterface {
    var view: MoviesTableViewCellInterface? { get set }
    var genres: [Genre] { get set }

    func layoutSubviews()
    func performGenre(movie: Movie, genres: [Genre])
}

class MoviesTableViewCellViewModel {
    weak var view: MoviesTableViewCellInterface?
    var genres = [Genre]()
    
    init(_ view: MoviesTableViewCellInterface) {
        self.view = view
    }
}

extension MoviesTableViewCellViewModel: MoviesTableViewCellViewModelInterface {
    
    func layoutSubviews() {
        view?.prepareCollectionView()
    }
    
    func performGenre(movie: Movie, genres: [Genre]) {
        var equalGenres = [Genre]()
        for i in genres {
            if movie.genreIDs.contains(i.id) {
                equalGenres.append(i)
            }
        }
        self.genres = equalGenres
        view?.collectionViewReloadData()
    }
}
