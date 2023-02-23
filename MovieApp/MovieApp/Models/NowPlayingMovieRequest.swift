//
//  NowPlayingMovieRequest.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 23.02.2023.
//

import Foundation

final class NowPlayingMovieRequest: BaseRequestModel {
    override var path: String {
        "/3/movie/now_playing"
    }
    
    override var queryItems: [String : Any] {
        [
            "language":"en-US",
            "page": 1
        ]
    }
}
