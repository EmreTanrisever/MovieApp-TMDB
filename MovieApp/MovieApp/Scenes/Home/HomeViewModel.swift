//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 18.02.2023.
//

import Foundation

protocol HomeViewModelInterface {
    var view: HomeViewInterface? { get set }
    
    func viewDidLoad()
}

final class HomeViewModel {
    weak var view: HomeViewInterface?
    
}

extension HomeViewModel: HomeViewModelInterface {

    func viewDidLoad() {
        view?.prepareCollectionView()
    }
}
