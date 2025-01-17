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
    func getPagination()
}

final class SeeMoreViewModel {
    private weak var view: SeeMoreInterface?
    private var networkService = NetworkService()
    var movies: [Movie]?
    var genres: [Genre]?
    var currentSection: MovieSections?
    
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
        networkService.returnFirstPage()
        movies = []
    }
    
    func setCategoryId(at id: Int) {
        switch id {
        case 0:
            getNowShowingMovies()
            self.currentSection = .nowShowing
        case 1:
            getPopularMovies()
            self.currentSection = .popular
        case 2:
            getTopRatedMovies()
            self.currentSection = .topRated
        case 3:
            getUpComingMovies()
            self.currentSection = .upComing
        default:
            print("err")
        }
    }
    
    func getPagination() {
        switch currentSection {
        case .nowShowing:
            getNowPlayingNextPage()
        case .popular:
            getPopularNextPage()
        case .topRated:
            getTopRatedNextPage()
        case .upComing:
            getUpComingNextPage()
        case .none:
             print("Err")
        }
    }
}

// MARK: - SeeMoreViewModel's Functions
extension SeeMoreViewModel {
    
    private func getNowShowingMovies() {
        
        networkService.getNowPlayingMovies { [weak self] result in
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
        
        networkService.getPopularMovies { [weak self] result in
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
        
        networkService.getTopRatedMovies { [weak self] result in
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
        
        networkService.getUpComingMovies { [weak self] result in
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
        
        networkService.getGenres { [weak self] result in
            switch result {
            case let .success(genres):
                self?.genres = genres.genres
                self?.view?.tableViewReloadData()
            case let .failure(err):
                print(err)
            }
        }
    }
    
    private func getNowPlayingNextPage() {
        
        networkService.getNowPlayingPagination { [weak self] result in
            switch result {
            case let .success(movies):
                movies.results.forEach { movie in
                    self?.movies?.append(movie)
                }
                self?.view?.tableViewReloadData()
            case let .failure(err):
                print(err)
            }
        }
    }
    
    private func getPopularNextPage() {
        
        networkService.getPopularPagination { [weak self] result in
            switch result {
            case let .success(movies):
                movies.results.forEach { movie in
                    self?.movies?.append(movie)
                }
                self?.view?.tableViewReloadData()
            case let .failure(err):
                print(err)
            }
        }
    }
    
    private func getTopRatedNextPage() {
        networkService.getTopRatedPagination { [weak self] result in
            switch result {
            case let .success(movies):
                movies.results.forEach { movie in
                    self?.movies?.append(movie)
                }
                self?.view?.tableViewReloadData()
            case let .failure(err):
                print(err)
            }
        }
    }
    
    private func getUpComingNextPage() {
        
        networkService.getUpComingPagination { [weak self] result in
            switch result {
            case let .success(movies):
                movies.results.forEach { movie in
                    self?.movies?.append(movie)
                }
                self?.view?.tableViewReloadData()
            case let .failure(err):
                print(err)
            }
        }
    }
}
