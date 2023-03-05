//
//  MoviesTableViewCell.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 4.03.2023.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    static let identifier = "MovieTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}
