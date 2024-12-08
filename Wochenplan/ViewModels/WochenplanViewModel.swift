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
    @Published var kategorien: [Kategorie] = []
    private var modelContext: ModelContext?
    
    let standardWochentage = [
        Wochentag(name: "Montag", gerichte: []),
        Wochentag(name: "Dienstag", gerichte: []),
        Wochentag(name: "Mittwoch", gerichte: []),
        Wochentag(name: "Donnerstag", gerichte: []),
        Wochentag(name: "Freitag", gerichte: []),
        Wochentag(name: "Samstag", gerichte: []),
        Wochentag(name: "Sonntag", gerichte: [])
    ]
    
    let wochentagReihenfolge: [String] = [
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
//        loadKategorien()
    }
    
    // Initialisierer für Preview oder Test
    convenience init(previewData: [Wochentag] = []) {
        self.init(context: nil)
        self.wochentage = previewData
        //kategorien in previewData einbauen und abrufen
    }
    
    func loadWochentage() {
        guard let modelContext = modelContext else {
            print("ModelContext ist nicht verfügbar.")
            return
        }
        
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
        for tag in standardWochentage {
            modelContext?.insert(tag)
        }
        try? modelContext?.save()
        self.wochentage = standardWochentage
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
    
    //Refactoring und verschieben über Tage hinweg
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
        for tag in wochentage {
            if let gericht = tag.gerichte.first(where: { $0.zutaten.contains(where: { $0.id == zutat.id }) }),
               let zutatIndex = gericht.zutaten.firstIndex(where: { $0.id == zutat.id }) {
                gericht.zutaten[zutatIndex].erledigt.toggle()
                saveTag(tag: tag)
                return
            }
        }
    }
    
    func markiereAllesErledigt() {
        let alleZutaten = wochentage.flatMap { $0.gerichte.flatMap { $0.zutaten } }
        alleZutaten.forEach { $0.erledigt = true }
        try? modelContext?.save()
    }

    
    func deleteAllGerichte() {
        guard let modelContext = modelContext else {
            print("ModelContext ist nicht verfügbar.")
            return
        }
        
        for wochentag in wochentage {
            for gericht in wochentag.gerichte {
                modelContext.delete(gericht)
            }
            wochentag.gerichte.removeAll()
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Fehler beim Speichern nach dem Löschen der Gerichte: \(error)")
        }
    }

    
    func deleteZutat(from gericht: Gericht, in tag: Wochentag, zutat: Zutat) {
        if let tagIndex = wochentage.firstIndex(where: { $0.id == tag.id }),
           let gerichtIndex = wochentage[tagIndex].gerichte.firstIndex(where: { $0.id == gericht.id }) {
            wochentage[tagIndex].gerichte[gerichtIndex].zutaten.removeAll { $0 == zutat }
            saveTag(tag: wochentage[tagIndex])
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
