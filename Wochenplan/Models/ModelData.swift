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
    var kategorie: Kategorie?
    
    init(name: String, erledigt: Bool = false, kategorie: Kategorie?) {
        self.id = UUID()
        self.name = name
        self.erledigt = erledigt
        self.kategorie = kategorie
    }
}

@Model
class Kategorie {
    @Attribute(.unique) var id: UUID
    var name: String
    
    init(name: String) {
        self.id = UUID()
        self.name = name
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

