//
//  NetworkService.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 1.03.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getNowPlayingMovies(completion: @escaping(Swift.Result<Movies, Error>) -> Void)
    func getPopularMovies(completion: @escaping(Result<Movies, Error>) -> Void)
    func getTopRatedMovies(comletion: @escaping(Result<Movies, Error>) -> Void)
    func getUpComingMovies(comletion: @escaping(Result<Movies, Error>) -> Void)
    func getGenres(comletion: @escaping(Result<Genres, Error>) -> Void)
    func getTheMovieDetail(id: String, completion: @escaping (Result<DetailsOfMovie, Error>) -> Void)
    func getNowPlayingPagination(completion: @escaping (Result<Movies, Error>) -> Void)
    func getPopularPagination(completion: @escaping (Result<Movies, Error>) -> Void)
    func getTopRatedPagination(completion: @escaping (Result<Movies, Error>) -> Void)
    func getUpComingPagination(completion: @escaping (Result<Movies, Error>) -> Void)
    func returnFirstPage()
}

final class NetworkService: NetworkServiceProtocol {
    
    func getNowPlayingMovies(completion: @escaping(Result<Movies, Error>) -> Void) {
        guard let urlRequest = NowPlayingMovieRequest.shared.createURL() else { return }
        NetworkManager.shared.sendRequest(urlRequest: urlRequest) { response in
            completion(response)
        }
    }
    
    func getPopularMovies(completion: @escaping(Result<Movies, Error>) -> Void) {
        guard let urlRequest = PopularMoviesRequest.shared.createURL() else { return }
        NetworkManager.shared.sendRequest(urlRequest: urlRequest) { response in
            completion(response)
        }
    }
    
    func getTopRatedMovies(comletion: @escaping(Result<Movies, Error>) -> Void) {
        guard let urlRequest = TopRatedMoviesRequest.shared.createURL() else { return }
        NetworkManager.shared.sendRequest(urlRequest: urlRequest) { response in
            comletion(response)
        }
    }
    
    func getUpComingMovies(comletion: @escaping(Result<Movies, Error>) -> Void) {
        guard let urlRequest = UpComingMoviesRequest.shared.createURL() else { return }
        NetworkManager.shared.sendRequest(urlRequest: urlRequest) { response in
            comletion(response)
        }
    }
    
    func getGenres(comletion: @escaping (Result<Genres, Error>) -> Void) {
        guard let urlRequest = GenreRequestModel.shared.createURL() else { return }
        NetworkManager.shared.sendRequest(urlRequest: urlRequest) { response in
            comletion(response)
        }
    }
    
    func getTheMovieDetail(id: String, completion: @escaping (Result<DetailsOfMovie, Error>) -> Void) {
        guard let urlRequest = DetailMovieRequestModel.shared.createURLWithID(id: id) else { return }
        NetworkManager.shared.sendRequest(urlRequest: urlRequest) { response in
            completion(response)
        }
    }
    
    func getNowPlayingPagination(completion: @escaping (Result<Movies, Error>) -> Void) {
        NowPlayingMovieRequest.shared.pageNumber += 1
        guard let urlRequest = NowPlayingMovieRequest.shared.createURL() else { return }
        NetworkManager.shared.sendRequest(urlRequest: urlRequest) { response in
            completion(response)
        }
    }
    
    func getPopularPagination(completion: @escaping (Result<Movies, Error>) -> Void) {
        PopularMoviesRequest.shared.pageNumber += 1
        guard let urlRequest = PopularMoviesRequest.shared.createURL() else { return }
        NetworkManager.shared.sendRequest(urlRequest: urlRequest) { response in
            completion(response)
        }
    }
    
    func getTopRatedPagination(completion: @escaping (Result<Movies, Error>) -> Void) {
        TopRatedMoviesRequest.shared.pageNumber += 1
        guard let urlRequest = TopRatedMoviesRequest.shared.createURL() else { return }
        NetworkManager.shared.sendRequest(urlRequest: urlRequest) { response in
            completion(response)
        }
    }
    
    func getUpComingPagination(completion: @escaping (Result<Movies, Error>) -> Void) {
        UpComingMoviesRequest.shared.pageNumber += 1
        guard let urlRequest = UpComingMoviesRequest.shared.createURL() else { return }
        NetworkManager.shared.sendRequest(urlRequest: urlRequest) { response in
            completion(response)
        }
    }
    
    func returnFirstPage() {
        NowPlayingMovieRequest.shared.pageNumber = 1
        PopularMoviesRequest.shared.pageNumber = 1
        TopRatedMoviesRequest.shared.pageNumber = 1
        UpComingMoviesRequest.shared.pageNumber = 1
    }
}
