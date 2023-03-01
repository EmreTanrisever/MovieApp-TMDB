//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 23.02.2023.
//

import Foundation

protocol NetworkManagerInterce {
    func fetchData<T: Codable>(urlRequest: URLRequest, completion: @escaping(Result<T, Error>)-> ())
}

final class NetworkManager: NetworkManagerInterce {
    private let urlSession = URLSession.shared
    static let shared = NetworkManager()
}

extension NetworkManager {
    func fetchData<T>(
        urlRequest: URLRequest,
        completion: @escaping(Result<T, Error>) -> ()) where T : Decodable, T : Encodable
    {
        urlSession.dataTask(with: urlRequest) { data, response, error in
            print(data)
        }
    }
}
