//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Ricky David Groner II on 11/3/23.
//

import SwiftUI

class Favorites: ObservableObject {
    private var resorts: Set<String>
    
    private let saveKey = "Favorites"
    
    init() {
        if let savedResorts = UserDefaults.standard.object(forKey: saveKey) as? Data {
            print(savedResorts)
            let decoder = JSONDecoder()
            if let loadedResorts = try? decoder.decode(Set<String>.self, from: savedResorts) {
                print(loadedResorts)
                resorts = loadedResorts
            } else {
                resorts = []
            }
        } else {
            resorts = []
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        print(resorts)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(resorts) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
}
