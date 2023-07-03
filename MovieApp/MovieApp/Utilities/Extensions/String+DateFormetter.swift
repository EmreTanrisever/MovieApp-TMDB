//
//  String+DateFormetter.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 2.07.2023.
//

import Foundation

extension String {
    
    func dateFormetter() -> String {
        let dateFormetter = DateFormatter()
        dateFormetter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormetter.date(from: self) else {
            return ""
        }
        let newDateFormetter = DateFormatter()
        newDateFormetter.dateFormat = "dd/MM/yyyy"
        return newDateFormetter.string(from: date)
    }
}
