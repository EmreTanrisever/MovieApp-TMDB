//
//  BookMarkTableViewCell.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 10.03.2024.
//

import UIKit
import Kingfisher

protocol BookmarkTableViewCellProtocol: AnyObject {
    
    func configure()
}

protocol BookmarkTableViewCellDelegate {
    
    func refreshTableView()
}

final class BookmarkTableViewCell: UITableViewCell {

    static let identifier = "BookMarkTableViewCell"
    var delegate: BookmarkTableViewCellDelegate?
    private lazy var viewModel = BookmarkTableViewCellViewModel(view: self)
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let deleteMovieButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        return button
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0))
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: 85),
            
            deleteMovieButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            deleteMovieButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            movieNameLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 8),
            movieNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            movieNameLabel.trailingAnchor.constraint(equalTo: deleteMovieButton.leadingAnchor, constant: 8),
        ])
    }
    
    @objc
    private func deleteButtonTapped(_ sender: UIButton) {
        guard let movie = viewModel.movie else {
            return
        }
        viewModel.deleteMovie(movie: movie)
        delegate?.refreshTableView()
    }
}

extension BookmarkTableViewCell: BookmarkTableViewCellProtocol {

    func configure() {

        contentView.addSubviews(
            movieImageView,
            deleteMovieButton
        )
        
        deleteMovieButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        setConstraints()
    }
}

extension BookmarkTableViewCell {
    
    func setData(movie: MoviePersistance) {
        viewModel.movie = movie
        DispatchQueue.main.async {
            let url = "https://image.tmdb.org/t/p/w500" + movie.poster
            self.movieImageView.kf.setImage(with: URL(string: url))
        }
    }
}
