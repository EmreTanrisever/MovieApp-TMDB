//
//  MoviesTableViewCell.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 4.03.2023.
//

import UIKit
import Kingfisher
import SwiftUI

protocol MoviesTableViewCellInterface: AnyObject {
    func collectionViewReloadData()
    func prepareCollectionView()
}

class MoviesTableViewCell: UITableViewCell, MoviesTableViewCellInterface {
    
    static let identifier = "MovieTableViewCell"
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = UIColor(named: "starbackgroundcolor")
        return imageView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "ratingtextcolor")
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let genresCollectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionViewLayout.itemSize = CGSize(width: 72, height: 24)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionViewLayout.collectionView?.backgroundColor = UIColor.clear.withAlphaComponent(0)
        return collectionView
    }()

    private lazy var viewModel = MoviesTableViewCellViewModel(self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewModel.layoutSubviews()
        configure()
    }
}

// MARK: - Configure UI
extension MoviesTableViewCell {
    func configure() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
        
        contentView.addSubviews(movieImageView, movieNameLabel, starImageView, ratingLabel, genresCollectionView)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: 85),
            
            movieNameLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            movieNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            starImageView.leadingAnchor.constraint(equalTo: movieNameLabel.leadingAnchor),
            starImageView.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 4),
            
            ratingLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 4),
            ratingLabel.topAnchor.constraint(equalTo: starImageView.topAnchor, constant: 4),
            
            genresCollectionView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            genresCollectionView.topAnchor.constraint(equalTo: starImageView.bottomAnchor, constant: 4)
        ])
    }
}

// MARK: - Genres Collection View Configure
extension MoviesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        return cell
    }
    
    func collectionViewReloadData() {
        genresCollectionView.reloadData()
    }
    
    func prepareCollectionView() {
        genresCollectionView.dataSource = self
        genresCollectionView.delegate = self
    }
}

// MARK: - Set Data
extension MoviesTableViewCell {
    func setData(movie: Movie, genres: [Genre]) {
        movieNameLabel.text = movie.title
        ratingLabel.text = "\(movie.voteAvarage)/10 IMDB"
        DispatchQueue.main.async {
            let url = "https://image.tmdb.org/t/p/w500" + movie.posterPath!
            self.movieImageView.kf.setImage(with: URL(string: url))
        }
        viewModel.performGenre(movie: movie, genres: genres)
    }
}
