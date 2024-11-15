//
//  ModelData.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 02.11.24.
//

import Foundation

struct Gericht: Identifiable {
    let id = UUID()
    var name: String
    var zutaten: [String] 
}

struct Wochentag: Identifiable {
    let id = UUID()
    var name: String
    var gerichte: [Gericht]
}
