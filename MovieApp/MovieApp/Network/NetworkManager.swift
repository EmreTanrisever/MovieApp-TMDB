//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 23.02.2023.
//

import Foundation

protocol NetworkManagerInterce {
    func sendRequest<T: Codable>(urlRequest: URLRequest, completion: @escaping(Result<T, Error>)-> Void)
}

final class NetworkManager: NetworkManagerInterce {
    
    private let urlSession = URLSession.shared
    static let shared = NetworkManager()
    
    private init() {  }
}

extension NetworkManager {
    
    func sendRequest<T>(
        urlRequest: URLRequest,
        completion: @escaping(Result<T, Error>) -> ()) where T : Decodable, T : Encodable
    {
        self.urlSession.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else { return }
            guard let decodedData = self.convertData(T.self, data: data) else { return }
            completion(.success(decodedData))
            // data geliyor guard la çıkar custom error type yaz private init e bak
        }.resume()
    }
    
    private func convertData<T: Decodable>(_ type: T.Type, data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let data = try decoder.decode(type, from: data)
            return data
        } catch {
            return nil
        }
    }
}
