//
//  WochentageViewModel.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 06.12.24.
//

import Foundation
import SwiftUI
import SwiftData

class WochentageViewModel: ObservableObject {
    @Published var wochentage: [Wochentag] = []
    private var modelContext: ModelContext?
    
    private let wochentagReihenfolge: [String] = [
        "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag", "Sonntag"
    ]
    
    // Initialisierer
    init(context: ModelContext?) {
        self.modelContext = context
        loadWochentage()
    }
    
    // Initialisierer für Preview oder Test
    convenience init(previewData: [Wochentag] = []) {
        self.init(context: nil)
        self.wochentage = previewData
    }
    
    // Lädt Wochentage aus der Datenbank oder erstellt Standard-Wochentage
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
    
    // Fügt Standard-Wochentage hinzu, wenn keine vorhanden sind
    func addDefaultWochentage() {
        let defaultWochentage = wochentagReihenfolge.map { Wochentag(name: $0, gerichte: []) }
        for tag in defaultWochentage {
            modelContext?.insert(tag)
        }
        try? modelContext?.save()
        self.wochentage = defaultWochentage
        sortWochentage()
    }
    
    // Sortiert die Wochentage basierend auf der definierten Reihenfolge
    func sortWochentage() {
        self.wochentage.sort {
            guard let index1 = wochentagReihenfolge.firstIndex(of: $0.name),
                  let index2 = wochentagReihenfolge.firstIndex(of: $1.name) else {
                return false
            }
            return index1 < index2
        }
    }
    
    // Fügt ein Gericht zu einem Wochentag hinzu
    func addGericht(to tag: Wochentag, gericht: Gericht) {
        if let index = wochentage.firstIndex(where: { $0.id == tag.id }) {
            wochentage[index].gerichte.append(gericht)
            saveTag(tag: wochentage[index])
        }
    }
    
    // Verschiebt ein Gericht innerhalb eines Wochentags
    func moveGericht(within tag: Wochentag, from indices: IndexSet, to newOffset: Int) {
        guard let sourceIndex = indices.first,
              let tagIndex = wochentage.firstIndex(where: { $0.id == tag.id }) else { return }
        
        let gericht = wochentage[tagIndex].gerichte.remove(at: sourceIndex)
        let targetIndex = newOffset > sourceIndex ? newOffset - 1 : newOffset
        wochentage[tagIndex].gerichte.insert(gericht, at: targetIndex)
        saveTag(tag: wochentage[tagIndex])
    }
    
    // Entfernt ein Gericht aus einem Wochentag
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
    
    // Speichert Änderungen an einem Wochentag
    private func saveTag(tag: Wochentag) {
        modelContext?.insert(tag)
        try? modelContext?.save()
    }
}

