//
//  GenreRequestModel.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 12.03.2023.
//

import Foundation

final class GenreRequestModel: BaseRequestModel {
    override var path: String {
        "/3/genre/movie/list"
    }
    
    override var queryItems: [String : Any] {
        [
            "language":"en-US"
        ]
    }
}
