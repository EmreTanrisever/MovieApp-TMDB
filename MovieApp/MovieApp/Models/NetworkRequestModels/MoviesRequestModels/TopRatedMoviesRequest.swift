//
//  TopRatedRequest.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 7.03.2023.
//

import Foundation

final class TopRatedMoviesRequest: BaseRequestModel {
    static let shared = TopRatedMoviesRequest()
    var pageNumber = 1
    
    override var path: String {
        "/3/movie/top_rated"
    }
    
    override var queryItems: [String : Any] {
        [
            "language":"en-US",
            "page": pageNumber
        ]
    }
}
