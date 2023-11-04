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
        resorts = []
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
        resorts.insert(resort.id)
        save()
    }
    
    func save() {
        
    }
}
