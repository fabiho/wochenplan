//
//  ModelData.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 02.11.24.
//

import Foundation
import SwiftData

@Model
class Gericht {
    @Attribute(.unique) var id: UUID
    var name: String
    var zutaten: [String]

    init(name: String, zutaten: [String]) {
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

