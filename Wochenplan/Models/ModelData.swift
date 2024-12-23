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
class Gericht {
    @Attribute(.unique) var id: UUID 
    var name: String
    var zutaten: [Zutat]
    var wochentag: Wochentag?

    init(name: String, zutaten: [Zutat], wochentag: Wochentag?) {
        self.id = UUID()
        self.name = name
        self.zutaten = zutaten
        self.wochentag = wochentag
    }
}

