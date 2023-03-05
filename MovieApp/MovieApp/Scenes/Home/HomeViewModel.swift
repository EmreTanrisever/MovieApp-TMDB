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
    func getData()
}

final class HomeViewModel {
    weak var view: HomeViewInterface?
    private let service = NetworkService()
    
    var nowPlayingMovies: [Movie] = []
    var moviesCategory = ["Popular": [Movie](), "Top Rated": [Movie](), "Up Coming": [Movie]()].sorted(by: {$0.0 < $1.0})
    
    init(_ view: HomeViewInterface) {
        self.view = view
    }
    
}

extension HomeViewModel: HomeViewModelInterface {

    func viewDidLoad() {
        getData()
        view?.prepareCollectionView()
        view?.prepareTableView()
    }
    
    func getData() {
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
}
