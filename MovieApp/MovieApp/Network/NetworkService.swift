//
//  NetworkService.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 1.03.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getNowPlayingMovies(completion: @escaping(Swift.Result<Movies, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {

    func getNowPlayingMovies(completion: @escaping(Result<Movies, Error>) -> Void) {
        guard let urlRequest = NowPlayingMovieRequest.shared.createURL() else { return }
        NetworkManager.shared.sendRequest(urlRequest: urlRequest) { response in
            completion(response)
        }
    }
}
