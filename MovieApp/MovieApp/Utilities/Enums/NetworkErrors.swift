//
//  NetworkErrors.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 23.02.2023.
//

import Foundation

enum NetworkError: Error {
    case DecodeError
    case InvalidService
    case InvalidFormat
}

extension NetworkError {
    
    var localizedDescription: String  {
        switch self {
        case .DecodeError:
            return "Network.DecodeError".localized
        case .InvalidService:
            return "Network.InvalidService".localized
        case .InvalidFormat:
            return ""
        }
    }
}
