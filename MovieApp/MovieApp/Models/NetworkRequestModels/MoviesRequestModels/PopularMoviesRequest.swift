//
//  PopularMoviesRequest.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 6.03.2023.
//

import Foundation

final class PopularMoviesRequest: BaseRequestModel {
    static let shared = PopularMoviesRequest()
    var pageNumber = 1
    
    override var path: String {
        "/3/movie/popular"
    }
    
    override var queryItems: [String : Any] {
        [
            "language":"en-US",
            "page": pageNumber
        ]
    }
}
