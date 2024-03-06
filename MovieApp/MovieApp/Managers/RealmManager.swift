//
//  RealmManager.swift
//  MovieApp
//
//  Created by Emre Tanrısever on 6.03.2024.
//

import Foundation
import RealmSwift

protocol RealmManagerInterface {
    func save<T: Object>(_ object: T)
    func read<T: Object>(_ object: T.Type) -> [T]
}

class RealmManager {
    
    private let realm = try! Realm(configuration: .init(schemaVersion: 1))
    
    static let shared = RealmManager()
    
    private init() { }
}

extension RealmManager: RealmManagerInterface {
    
    func save<T: Object>(_ object: T) {
        do {
            try realm.write({
                realm.add(object)
            })
        } catch {
            print("Err")
        }
        
    }
    
    func read<T: Object>(_ object: T.Type) -> [T] {
        return Array(realm.objects(object.self))
    }
}
