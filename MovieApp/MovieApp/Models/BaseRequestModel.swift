//
//  BaseRequestModel.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 23.02.2023.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol BaseRequestModelInterface {
    var httpMethod: HttpMethod { get }
    var schema: String { get }
    var host: String { get }
    var path: String { get }
    var queryItems: [String: Any] { get }
}

class BaseRequestModel: BaseRequestModelInterface {
    var httpMethod: HttpMethod {
        .get
    }
    
    var schema: String {
        "https"
    }
    
    var host: String {
        "api.themoviedb.org"
    }
    
    var path: String {
        ""
    }
    
    var queryItems: [String : Any] {
        [:]
    }
    
    func createURL() -> URLRequest? {
        var component = URLComponents()
        component.scheme = schema
        component.host = host
        component.path = path
        var items: [URLQueryItem] = []
    
        for (key, value) in queryItems {
            let quertItem = URLQueryItem(name: key, value: "\(value)")
            items.append(quertItem)
        }
        
        let apiKey = URLQueryItem(name: "api_key", value: "ea3d05bfba9559d3ec11726fd7d6b61e")
        items.append(apiKey)
        component.queryItems = items
        
        if let url = component.url {
            return URLRequest(url: url)
        } else {
            return nil
        }
    }
}
