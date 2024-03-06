    //
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 18.02.2023.
//

import Foundation
import Kingfisher

protocol HomeViewModelInterface {
    var view: HomeViewInterface? { get set }
    var nowPlayingMovies: [Movie] { get set }
    var moviesCategory: [String: [Movie]] { get set }
    var genres: [Genre] { get set }
    
    func viewDidLoad()
    func getGenres()
    func returnKey(section: Int) -> String?
    func getNowPlayingMovies()
    func getPopularMovies()
    func getTopRatedMovies()
    func getUpComingMovies()
}

final class HomeViewModel {
    weak var view: HomeViewInterface?
    private let service = NetworkService()
    
    var nowPlayingMovies: [Movie] = []
    var moviesCategory: [String: [Movie]] = [:]
    var genres: [Genre] = []
    
    init(_ view: HomeViewInterface) {
        self.view = view
    }
    
}

extension HomeViewModel: HomeViewModelInterface {

    func viewDidLoad() {
        view?.configureUI()
        getGenres()
        getNowPlayingMovies()
        getPopularMovies()
        getTopRatedMovies()
        getUpComingMovies()
        view?.prepareCollectionView()
        view?.prepareTableView()
    }
    
    func getGenres() {
        service.getGenres { response in
            switch response {
            case .success(let genres):
                self.genres = genres.genres
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func returnKey(section: Int) -> String? {
        var str: String?
        switch section {
        case 0:
            str = "Popular".localized
        case 1:
            str = "TopRated".localized
        case 2:
            str = "UpComing".localized
        default:
            str = nil
        }
        return str
    }
    
    func getNowPlayingMovies() {
        
        service.getNowPlayingMovies { response in
            switch response {
            case .success(let movies):
                DispatchQueue.main.async {
                    self.nowPlayingMovies = movies.results
                    self.view?.collectionViewReloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getPopularMovies() {
        
        service.getPopularMovies { response in
            switch response {
            case .success(let popularMovies):
                DispatchQueue.main.async {
                    self.moviesCategory["Popular".localized] = popularMovies.results
                    self.view?.tableViewReloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getTopRatedMovies() {
        
        service.getTopRatedMovies { response in
            switch response {
            case .success(let topRatedMovies):
                DispatchQueue.main.async {
                    self.moviesCategory["TopRated".localized] = topRatedMovies.results
                    self.view?.tableViewReloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getUpComingMovies() {
        
        service.getUpComingMovies { response in
            switch response {
            case .success(let upComingMovies):
                DispatchQueue.main.async {
                    self.moviesCategory["UpComing".localized] = upComingMovies.results
                    self.view?.tableViewReloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
