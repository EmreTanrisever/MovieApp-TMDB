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
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            switch httpResponse.statusCode {
            case 200...299:
                guard let decodedData = self.convertData(T.self, data: data) else {
                    return self.returnCompletionHandler(with: .failure(NetworkError.DecodeError), completion: completion)
                }
                self.returnCompletionHandler(with: .success(decodedData), completion: completion)
            case 501:
                self.returnCompletionHandler(with: .failure(NetworkError.InvalidService), completion: completion)
            case 405:
                self.returnCompletionHandler(with: .failure(NetworkError.InvalidFormat), completion: completion)
            default:
                break
            }
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
    
    private func returnCompletionHandler<T:Codable>(with result: Result<T, Error>, completion: @escaping(Result<T, Error>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}
