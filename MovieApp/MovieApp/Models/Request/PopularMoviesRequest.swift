//
//  PopularMoviesRequest.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 6.03.2023.
//

import Foundation

final class PopularMoviesRequest: BaseRequestModel {
    static let shared = PopularMoviesRequest()
    
    override var path: String {
        "/3/movie/popular"
    }
    
    override var queryItems: [String : Any] {
        [
            "language":"en-US",
            "page": 1
        ]
    }
}
