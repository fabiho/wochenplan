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
    
    var alleZutaten: [Zutat] {
        return wochentage
            .flatMap { $0.gerichte.flatMap { $0.zutaten } }
    }
    
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
            saveTag(tag: wochentage[index])
        }
    }
    
    func moveGericht(within tag: Wochentag, from indices: IndexSet, to newOffset: Int) {
        guard let sourceIndex = indices.first,
              let tagIndex = wochentage.firstIndex(where: { $0.id == tag.id }) else { return }
        
        let gericht = wochentage[tagIndex].gerichte.remove(at: sourceIndex)
        let targetIndex = newOffset > sourceIndex ? newOffset - 1 : newOffset
        wochentage[tagIndex].gerichte.insert(gericht, at: targetIndex)
        saveTag(tag: wochentage[tagIndex])
    }
    
    func deleteGericht(at indices: IndexSet, from tag: Wochentag) {
        if let tagIndex = wochentage.firstIndex(where: { $0.id == tag.id }) {
            for index in indices {
                let gericht = wochentage[tagIndex].gerichte[index]
                modelContext?.delete(gericht)
            }
            wochentage[tagIndex].gerichte.remove(atOffsets: indices)
            saveTag(tag: wochentage[tagIndex])
        }
    }
    
    func toggleZutatErledigt(zutat: Zutat) {
        // Suche den entsprechenden Wochentag
        if let tagIndex = wochentage.firstIndex(where: {
            $0.gerichte.contains(where: {
                $0.zutaten.contains(where: { $0.id == zutat.id })
            })
        }) {
            // Suche das Gericht innerhalb des Wochentages
            for (gerichtIndex, gericht) in wochentage[tagIndex].gerichte.enumerated() {
                if let zutatIndex = gericht.zutaten.firstIndex(where: { $0.id == zutat.id }) {
                    // Ändere den Status der gefundenen Zutat
                    wochentage[tagIndex].gerichte[gerichtIndex].zutaten[zutatIndex].erledigt.toggle()
                    
                    // Speichere die Änderungen im ModelContext
                    saveTag(tag: wochentage[tagIndex])
                    break
                }
            }
        }
    }

    
    // Funktion, um alle Zutaten als erledigt zu markieren
    func markiereAllesErledigt() {
        for tagIndex in 0..<wochentage.count {
            for gerichtIndex in 0..<wochentage[tagIndex].gerichte.count {
                for zutatIndex in 0..<wochentage[tagIndex].gerichte[gerichtIndex].zutaten.count {
                    wochentage[tagIndex].gerichte[gerichtIndex].zutaten[zutatIndex].erledigt = true
                }
            }
        }
        try? modelContext?.save()
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
    
    func deleteZutat(from gericht: Gericht, in tag: Wochentag, zutat: Zutat) {
        if let tagIndex = wochentage.firstIndex(where: { $0.id == tag.id }),
           let gerichtIndex = wochentage[tagIndex].gerichte.firstIndex(where: { $0.id == gericht.id }) {
            wochentage[tagIndex].gerichte[gerichtIndex].zutaten.removeAll { $0 == zutat }
            saveTag(tag: wochentage[tagIndex])
        }
    }
    
    func toggleZutatErledigt(zutat: Zutat, in gericht: Gericht) {
        if let gerichtIndex = gerichte.firstIndex(where: { $0.id == gericht.id }) {
            if let zutatIndex = gerichte[gerichtIndex].zutaten.firstIndex(where: { $0.id == zutat.id }) {
                gerichte[gerichtIndex].zutaten[zutatIndex].erledigt.toggle()
                saveGericht(gericht: gerichte[gerichtIndex])
            }
        }
    }
    
    private func saveTag(tag: Wochentag) {
        modelContext?.insert(tag)
        try? modelContext?.save()
    }
    
    private func saveGericht(gericht: Gericht) {
        modelContext?.insert(gericht)
        try? modelContext?.save()
    }
}
