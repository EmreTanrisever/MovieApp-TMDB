    //
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 18.02.2023.
//

import Foundation

protocol HomeViewModelInterface {
    var view: HomeViewInterface? { get set }
    var nowPlayingMovies: [Movie] { get set }
    
    func viewDidLoad()
    func getNowPlayingMovies()
    func getPopularMovies()
}

final class HomeViewModel {
    weak var view: HomeViewInterface?
    private let service = NetworkService()
    
    var nowPlayingMovies: [Movie] = []
//    var moviesCategory = ["Popular": [Movie](), "Top Rated": [Movie](), "Up Coming": [Movie]()].sorted(by: {$0.0 < $1.0})
    var moviesCategory: [String: [Movie]] = [:]
    
    init(_ view: HomeViewInterface) {
        self.view = view
    }
    
}

extension HomeViewModel: HomeViewModelInterface {

    func viewDidLoad() {
        getNowPlayingMovies()
        getPopularMovies()
        view?.prepareCollectionView()
        view?.prepareTableView()
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
            case .success(let movies):
                DispatchQueue.main.async {
                    self.moviesCategory["Popular"] = movies.results
                    self.view?.tableViewReloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
