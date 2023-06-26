//
//  DetailController.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 14.02.2023.
//

import UIKit
import Kingfisher

protocol DetailViewInterface: AnyObject {
    func configure()
    func fetchTheMovie(id: Int)
    func fillUI()
}

class DetailController: UIViewController, DetailViewInterface {

    private let movieImageview: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var viewModel = DetailViewModel(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.navigationItem.title = "AppName".localized
    }
}

extension DetailController {
    
    func configure() {
        self.view.backgroundColor = .white
        self.tabBarController?.navigationItem.title?.removeAll()
        
        view.addSubviews(movieImageview)
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            movieImageview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieImageview.topAnchor.constraint(equalTo: view.topAnchor),
            movieImageview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieImageview.heightAnchor.constraint(equalToConstant: 500),
        ])
    }
}

extension DetailController {
    
    func fillUI() {
        guard let movieDetail = viewModel.movie else { return }
        DispatchQueue.main.async {
            print(movieDetail.poster)
            let url = "https://image.tmdb.org/t/p/w500" + movieDetail.poster
            self.movieImageview.kf.setImage(with: URL(string: url))
        }
        
    }
    
    func fetchTheMovie(id: Int) {
        viewModel.fetchTheMovie(id: id)
    }
}
