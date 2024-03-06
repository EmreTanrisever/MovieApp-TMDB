//
//  SeeMoreViewModel.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 4.03.2024.
//

import Foundation

protocol SeeMoreViewModelInterface {
    
    func viewDidLoad()
    func setCategoryId(at id: Int)
}

final class SeeMoreViewModel {
    private weak var view: SeeMoreInterface?
    private var networkService = NetworkService()
    var movies: [Movie]?
    var genres: [Genre]?
    
    init(view: SeeMoreInterface? = nil) {
        self.view = view
        getGenres()
    }
}

// MARK: - SeeMoreViewModelInterface's Functions
extension SeeMoreViewModel: SeeMoreViewModelInterface {
    
    func viewDidLoad() {
        view?.configure()
        view?.prepareTableView()
    }
    
    func setCategoryId(at id: Int) {
        switch id {
        case 0:
            getNowShowingMovies()
        case 1:
            getPopularMovies()
        case 2:
            getTopRatedMovies()
        case 3:
            getUpComingMovies()
        default:
            print("err")
        }
    }
    
}

// MARK: - SeeMoreViewModel's Functions
extension SeeMoreViewModel {
    
    private func getNowShowingMovies() {
        
        networkService.getNowPlayingMovies { [weak self]result in
            switch result {
            case let .success(movies):
                self?.movies = movies.results
                self?.view?.tableViewReloadData()
            case let .failure(err):
                print(err)
            }
        }
    }
    
    private func getPopularMovies() {
        
        networkService.getPopularMovies { [weak self]result in
            switch result {
            case let .success(movies):
                self?.movies = movies.results
                self?.view?.tableViewReloadData()
            case let .failure(err):
                print(err)
            }
        }
    }
    
    private func getTopRatedMovies() {
        
        networkService.getTopRatedMovies { [weak self]result in
            switch result {
            case let .success(movies):
                self?.movies = movies.results
                self?.view?.tableViewReloadData()
            case let .failure(err):
                print(err)
            }
        }
    }
    
    private func getUpComingMovies() {
        
        networkService.getUpComingMovies { [weak self]result in
            switch result {
            case let .success(movies):
                self?.movies = movies.results
                self?.view?.tableViewReloadData()
            case let .failure(err):
                print(err)
            }
        }
    }
    
    private func getGenres() {
        
        networkService.getGenres { [weak self]result in
            switch result {
            case let .success(genres):
                self?.genres = genres.genres
                self?.view?.tableViewReloadData()
            case let .failure(err):
                print(err)
            }
        }
    }
}
