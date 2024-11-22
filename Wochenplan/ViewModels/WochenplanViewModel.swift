//
//  WochenplanViewModel.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 02.11.24.
//

import Foundation
import SwiftUI
import SwiftData

class WochenplanViewModel: ObservableObject {
    @Published var wochentage: [Wochentag] = []
    @Published var gerichte: [Gericht] = []
    private var modelContext: ModelContext?
    
    private let wochentagReihenfolge: [String] = [
        "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"
    ]
    
    // Standard-Initialisierer
    init(context: ModelContext?) {
        self.modelContext = context
        loadWochentage()
    }
    
    // Initialisierer für Preview oder Test
    convenience init(previewData: [Wochentag] = []) {
        self.init(context: nil)
        self.wochentage = previewData
    }
    
    func loadWochentage() {
        guard let modelContext = modelContext else {
            // Keine Datenbank: Beispielwochentage für Preview
            let tage = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"]
            self.wochentage = tage.map { Wochentag(name: $0, gerichte: []) }
            return
        }
        
        // Daten aus der Datenbank laden
        let request = FetchDescriptor<Wochentag>()
        if let fetchedWochentage = try? modelContext.fetch(request) {
            if fetchedWochentage.isEmpty {
                addDefaultWochentage()
            } else {
                self.wochentage = fetchedWochentage
                sortWochentage()
            }
        }
    }
    
    func addDefaultWochentage() {
        let tage = ["Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"]
        let defaultWochentage = tage.map { Wochentag(name: $0, gerichte: []) }
        for tag in defaultWochentage {
            modelContext?.insert(tag)
        }
        try? modelContext?.save()
        self.wochentage = defaultWochentage
        sortWochentage()
    }
    
    func sortWochentage() {
        self.wochentage.sort {
            guard let index1 = wochentagReihenfolge.firstIndex(of: $0.name),
                  let index2 = wochentagReihenfolge.firstIndex(of: $1.name) else {
                return false
            }
            return index1 < index2
        }
    }
    
    func addGericht(to tag: Wochentag, gericht: Gericht) {
        if let index = wochentage.firstIndex(where: { $0.id == tag.id }) {
            wochentage[index].gerichte.append(gericht)
            save(tag: wochentage[index])
        }
    }
    
    func moveGericht(within tag: Wochentag, from indices: IndexSet, to newOffset: Int) {
        guard let sourceIndex = indices.first,
              let tagIndex = wochentage.firstIndex(where: { $0.id == tag.id }) else { return }
        
        let gericht = wochentage[tagIndex].gerichte.remove(at: sourceIndex)
        let targetIndex = newOffset > sourceIndex ? newOffset - 1 : newOffset
        wochentage[tagIndex].gerichte.insert(gericht, at: targetIndex)
        save(tag: wochentage[tagIndex])
    }
    
    func deleteGericht(at indices: IndexSet, from tag: Wochentag) {
        if let tagIndex = wochentage.firstIndex(where: { $0.id == tag.id }) {
            for index in indices {
                let gericht = wochentage[tagIndex].gerichte[index]
                modelContext?.delete(gericht)
            }
            wochentage[tagIndex].gerichte.remove(atOffsets: indices)
            save(tag: wochentage[tagIndex])
        }
    }
    
    func deleteAllGerichte() {
        for wochentag in wochentage {
            for gericht in wochentag.gerichte {
                modelContext?.delete(gericht)
            }
            wochentag.gerichte.removeAll()
        }
        try? modelContext?.save()
    }
    
    func deleteZutat(from gericht: Gericht, in tag: Wochentag, zutat: String) {
        if let tagIndex = wochentage.firstIndex(where: { $0.id == tag.id }),
           let gerichtIndex = wochentage[tagIndex].gerichte.firstIndex(where: { $0.id == gericht.id }) {
            wochentage[tagIndex].gerichte[gerichtIndex].zutaten.removeAll { $0 == zutat }
            save(tag: wochentage[tagIndex])
        }
    }
    
    
    
    private func save(tag: Wochentag) {
        modelContext?.insert(tag)
        try? modelContext?.save()
    }
    
    var alleZutaten: [String] {
        let ingredients = wochentage.flatMap { $0.gerichte.flatMap { $0.zutaten } }
        return Array(Set(ingredients)) // Duplikate entfernen
    }
    
    
}
