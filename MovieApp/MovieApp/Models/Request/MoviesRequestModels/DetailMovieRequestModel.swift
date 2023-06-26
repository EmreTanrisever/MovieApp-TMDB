//
//  DetailMovieRequestModel.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 31.05.2023.
//

import Foundation

final class DetailMovieRequestModel:BaseRequestModel {
    static let shared = DetailMovieRequestModel()
    
    override var path: String {
        "/3/movie/"
    }
    
}
