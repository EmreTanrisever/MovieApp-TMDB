//
//  MoviesTableViewCell.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 4.03.2023.
//

import UIKit
import Kingfisher

class MoviesTableViewCell: UITableViewCell {
    static let identifier = "MovieTableViewCell"
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Venom Let There Be Carnage"
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
        label.text = "9.1/10 IMDB"
        label.textColor = UIColor(named: "ratingtextcolor")
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }
}

extension MoviesTableViewCell {
    func configure() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
        
        contentView.addSubviews(movieImageView, movieNameLabel, starImageView, ratingLabel)
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
//            starImageView.widthAnchor.constraint(equalToConstant: 16),
//            starImageView.heightAnchor.constraint(equalToConstant: 16),
            
            
            ratingLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 4),
            ratingLabel.topAnchor.constraint(equalTo: starImageView.topAnchor, constant: 4),
            
        ])
    }
}

extension MoviesTableViewCell {
    func setData(movie: Movie) {
        movieNameLabel.text = movie.title
        ratingLabel.text = "\(movie.voteCount)/10 IMDB"
        DispatchQueue.main.async {
            let url = "https://image.tmdb.org/t/p/w500" + movie.posterPath!
            self.movieImageView.kf.setImage(with: URL(string: url))
        }
    }
}
