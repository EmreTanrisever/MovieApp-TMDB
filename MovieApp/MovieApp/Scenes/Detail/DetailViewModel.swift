//
//  DetailViewModel.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 31.05.2023.
//

import Foundation

protocol DetailViewModelInterface {
    var view: DetailViewInterface? { get set }
    var movie: DetailsOfMovie? { get set }
    
    func viewDidLoad()
    func fetchTheMovie(id: Int)
}

final class DetailViewModel {
    weak var view: DetailViewInterface?
    var movie: DetailsOfMovie?
    
    private let service = NetworkService()
    
    init(_ view: DetailViewInterface) {
        self.view = view
    }
}

extension DetailViewModel: DetailViewModelInterface {
    
    func viewDidLoad() {
        view?.configure()
    }
    
    func fetchTheMovie(id: Int) {
        service.getTheMovieDetail(id: "\(id)", completion: { response in
            switch response {
            case .success(let movie):
                self.movie = movie
                self.view?.fillUI()
            case .failure(let error):
                print(error)
            }
        })
    }
}
