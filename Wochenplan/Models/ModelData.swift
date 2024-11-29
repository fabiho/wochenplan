//
//  ModelData.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 02.11.24.
//

import Foundation
import SwiftData

@Model
class Zutat {
    @Attribute(.unique) var id: UUID
    var name: String
    var erledigt: Bool
    
    init(name: String, erledigt: Bool = false) {
        self.id = UUID()
        self.name = name
        self.erledigt = erledigt
    }
}

@Model
class Gericht {
    @Attribute(.unique) var id: UUID
    var name: String
    var zutaten: [Zutat]

    init(name: String, zutaten: [Zutat]) {
        self.id = UUID()
        self.name = name
        self.zutaten = zutaten
    }
}

@Model
class Wochentag {
    @Attribute(.unique) var id: UUID
    var name: String
    var gerichte: [Gericht]

    init(name: String, gerichte: [Gericht] = []) {
        self.id = UUID()
        self.name = name
        self.gerichte = gerichte
    }
}

