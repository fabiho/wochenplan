//
//  Kategorie.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 07.12.24.
//

import Foundation

enum Kategorie: String, Codable, CaseIterable {

    case Obst = "Obst & Gemüse"
    case Kühltheke = "Kühltheke"
    case Dosen = "Dosen"
    case Brot = "Brot & Backwaren"
    case Getränke = "Getränke"
}
