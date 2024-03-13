//
//  NowPlayingMovieRequest.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 23.02.2023.
//

import Foundation

final class NowPlayingMovieRequest: BaseRequestModel {
    static let shared = NowPlayingMovieRequest()
    var pageNumber = 1
    
    override var path: String {
        "/3/movie/now_playing"
    }
    
    override var queryItems: [String : Any] {
        [
            "language":"en-US",
            "page": pageNumber
        ]
    }
}
