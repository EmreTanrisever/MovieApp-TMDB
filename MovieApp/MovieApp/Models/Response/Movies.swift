//
//  Movies.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 1.03.2023.
//

import Foundation

struct Movies: Decodable {
    let page: Int
    let results: [Movie]
//    let date: MovieDate
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
