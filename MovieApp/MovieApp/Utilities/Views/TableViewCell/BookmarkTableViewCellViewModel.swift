//
//  BookMarkTableViewCellViewModel.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 12.03.2024.
//

import Foundation

protocol BookmarkTableViewCellViewModelProtocol {
    func viewDidLoad()
}

final class BookmarkTableViewCellViewModel {
    private weak var view: BookmarkTableViewCellProtocol?
    private let movieStorageService = MovieStorageService()
    var movie: MoviePersistance?
    
    init(view: BookmarkTableViewCellProtocol? = nil) {
        self.view = view
    }
    
    func deleteMovie(movie: MoviePersistance) {
        movieStorageService.deleteTheMovie(movie: movie)
    }
}

extension BookmarkTableViewCellViewModel: BookmarkTableViewCellViewModelProtocol {
    
    func viewDidLoad() {
        view?.configure()
    }
}
