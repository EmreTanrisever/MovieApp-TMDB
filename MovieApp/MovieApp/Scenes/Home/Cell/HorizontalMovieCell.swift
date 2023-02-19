//
//  HorizontalMovieCell.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 19.02.2023.
//

import UIKit

class HorizontalMovieCell: UICollectionViewCell {
    static let identifier = "HorizontalMovieCell"
    
    private let moviePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "face.smiling")
        return imageView
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Spiderman: No Way Home"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byCharWrapping
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = UIColor(named: "starbackgroundcolor")
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }
}

extension HorizontalMovieCell {
    func configure() {
        contentView.layer.cornerRadius = 8
        
        contentView.addSubviews(moviePosterImageView, movieNameLabel, starImageView, ratingLabel)
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            moviePosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            moviePosterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            moviePosterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            moviePosterImageView.heightAnchor.constraint(equalToConstant: 216),
            
            movieNameLabel.topAnchor.constraint(equalTo: moviePosterImageView.bottomAnchor, constant: 8),
            movieNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            starImageView.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 4),
            starImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            ratingLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 4),
            ratingLabel.topAnchor.constraint(equalTo: starImageView.topAnchor, constant: 4)
        ])
    }
}
