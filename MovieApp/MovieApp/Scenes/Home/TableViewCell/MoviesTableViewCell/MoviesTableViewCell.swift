//
//  MoviesTableViewCell.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 4.03.2023.
//

import UIKit
import Kingfisher

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
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 24)
        collectionViewLayout.itemSize = CGSize(width: 120, height: 24)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.register(GenresCollectionViewCell.self, forCellWithReuseIdentifier: GenresCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        return collectionView
    }()
    
    private let imdbImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "scribble")
        imageView.tintColor = .black
        return imageView
    }()

    private let imdbLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        configure()
        viewModel.layoutSubviews()
    }
}

// MARK: - Configure UI
extension MoviesTableViewCell {
    func configure() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
        
        contentView.addSubviews(movieImageView, movieNameLabel, starImageView, ratingLabel, genresCollectionView, imdbImageView, imdbLabel)
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
            genresCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            genresCollectionView.topAnchor.constraint(equalTo: starImageView.bottomAnchor, constant: 4),
            genresCollectionView.heightAnchor.constraint(equalToConstant: 24),
            
            imdbImageView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 16),
            imdbImageView.topAnchor.constraint(equalTo: genresCollectionView.bottomAnchor, constant: 4),
            
            imdbLabel.leadingAnchor.constraint(equalTo: imdbImageView.trailingAnchor, constant: 4),
            imdbLabel.topAnchor.constraint(equalTo: genresCollectionView.bottomAnchor, constant: 8)

        ])
    }
}


extension MoviesTableViewCell {

    func prepareCollectionView() {
        genresCollectionView.dataSource = self
    }

    func collectionViewReloadData() {
        genresCollectionView.reloadData()
    }
}

// MARK: - Genres Collection View Configure
extension MoviesTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = genresCollectionView.dequeueReusableCell(
            withReuseIdentifier: GenresCollectionViewCell.identifier,
            for: indexPath
        ) as? GenresCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setData(genre: viewModel.genres[indexPath.row])
        return cell
    }
    
}

// MARK: - Set Data
extension MoviesTableViewCell {
    func setData(movie: Movie, genres: [Genre]) {
        movieNameLabel.text = movie.title
        ratingLabel.text = "\(movie.voteAvarage)/10 IMDB"
        DispatchQueue.main.async {
            if let posterPath = movie.posterPath {
                let url = "https://image.tmdb.org/t/p/w500" + posterPath
                self.movieImageView.kf.setImage(with: URL(string: url))
            }
        }
        viewModel.performGenre(movie: movie, genres: genres)
        imdbLabel.text = "\(movie.voteCount)"
    }
}
