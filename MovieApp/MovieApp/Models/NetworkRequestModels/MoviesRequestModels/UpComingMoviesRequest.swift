//
//  UpComingMoviesRequest.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 7.03.2023.
//

import Foundation

final class UpComingMoviesRequest: BaseRequestModel {
    static let shared = UpComingMoviesRequest()
    var pageNumber = 1
    
    override var path: String {
        "/3/movie/upcoming"
    }
    
    override var queryItems: [String : Any] {
        [
            "language":"en-US",
            "page": pageNumber
        ]
    }
}
