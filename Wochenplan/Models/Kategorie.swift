//
//  Kategorie.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 07.12.24.
//

import Foundation
import SwiftUI

enum Kategorie: String, Codable, CaseIterable {

    case Obst = "Obst & Gemüse"
    case Kühltheke = "Kühltheke"
    case Dosen = "Dosen"
    case Brot = "Brot & Backwaren"
    case Getränke = "Getränke"
    case Nudeln = "Nudeln & Reis"
    case ohneKategorie = "Ohne Kategorie"
    
    var image: Image {
        switch self {
        case .Obst:
            return Image("apple")
        case .Kühltheke:
            return Image("cheese")
        case .Dosen:
            return Image("can")
        case .Brot:
            return Image("bread")
        case .Getränke:
            return Image("milk")
        case .Nudeln:
            return Image("noodle")
        case .ohneKategorie:
            return Image(systemName: "questionmark")
        }
    }
}
