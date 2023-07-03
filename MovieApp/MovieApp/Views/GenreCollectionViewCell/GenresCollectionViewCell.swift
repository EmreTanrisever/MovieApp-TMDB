//
//  GenresCollectionViewCell.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 20.03.2023.
//

import UIKit

class GenresCollectionViewCell: UICollectionViewCell {
    static let identifier = "GenresCollectionViewCell"
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "homegenrecolor")
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
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

extension GenresCollectionViewCell {
    
    func configure() {
        contentView.layer.cornerRadius = 8
        contentView.addSubview(genreLabel)
        contentView.backgroundColor = UIColor(named: "homegenrebackground")
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            genreLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            genreLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

        ])
    }
}

extension GenresCollectionViewCell {
    func setData(genre: Genre) {
        genreLabel.text = genre.name.uppercased()
    }
}
