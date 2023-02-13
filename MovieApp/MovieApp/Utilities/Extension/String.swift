//
//  String.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 13.02.2023.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
