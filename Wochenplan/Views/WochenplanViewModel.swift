//
//  WochenplanViewModel.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 02.11.24.
//

import Foundation
import SwiftUI

class WochenplanViewModel: ObservableObject {
    @Published var wochentage: [Wochentag] = []
    
    init() {
        let tage = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"]
        wochentage = tage.map { Wochentag(name: $0, gerichte: []) }
    }
    
    func addGericht(to tag: Wochentag, gericht: Gericht) {
        if let index = wochentage.firstIndex(where: { $0.id == tag.id }) {
            var updatedTag = wochentage[index]
            updatedTag.gerichte.append(gericht)
            wochentage[index] = updatedTag // Zuweisung, um die Veränderung korrekt zu propagieren
            print("Gericht \(gericht.name) hinzugefügt zu \(updatedTag.name)")
        }
    }
    
    // Funktion zum Verschieben eines Gerichts innerhalb eines Tages
    func moveGericht(within tag: Wochentag, from indices: IndexSet, to newOffset: Int) {
        guard let sourceIndex = indices.first else { return }
        
        // Finde den Index des Tags
        guard let tagIndex = wochentage.firstIndex(where: { $0.id == tag.id }) else { return }
        
        // Hole das Gericht, das verschoben werden soll
        let gericht = wochentage[tagIndex].gerichte[sourceIndex]
        
        // Entferne das Gericht aus dem aktuellen Index
        wochentage[tagIndex].gerichte.remove(at: sourceIndex)
        
        // Berechne den neuen Offset korrekt und füge das Gericht an der neuen Position hinzu
        let targetIndex = newOffset > sourceIndex ? newOffset - 1 : newOffset
        wochentage[tagIndex].gerichte.insert(gericht, at: targetIndex)
    }
    
    func deleteGericht(at indices: IndexSet, from tag: Wochentag) {
        if let tagIndex = wochentage.firstIndex(where: { $0.id == tag.id }) {
            wochentage[tagIndex].gerichte.remove(atOffsets: indices)
        }
    }
    
    var alleZutaten: [String] {
        let ingredients = wochentage.flatMap { $0.gerichte.flatMap { $0.zutaten } }
        return Array(Set(ingredients)) // Duplikate entfernen
    }

    
}
