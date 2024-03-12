//
//  BookMarkTableViewCell.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 10.03.2024.
//

import UIKit
import Kingfisher

class BookMarkTableViewCell: UITableViewCell {

    static let identifier = "BookMarkTableViewCell"
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
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
    
    private func configure() {
        
        
        contentView.addSubviews(
            movieImageView
        )
        
        setConstraints()
    }
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: 85),
        ])
    }
}

extension BookMarkTableViewCell {
    
    func setData(movie: MoviePersistance) {
        DispatchQueue.main.async {
            let url = "https://image.tmdb.org/t/p/w500" + movie.poster
            self.movieImageView.kf.setImage(with: URL(string: url))
        }
    }
}
