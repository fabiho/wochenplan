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
    @Published var wochentage: [Wochentag: [Gericht]] = [:]
    @Published var gerichte: [Gericht] = []
    @Published var kategorien: [Kategorie] = []
    private var modelContext: ModelContext?
    
    var alleZutaten: [Zutat] {
        return wochentage
            .flatMap { (_, gerichte) in gerichte.flatMap { $0.zutaten } }
    }

    // Standard-Initialisierer
    init(context: ModelContext?) {
        self.modelContext = context
        self.wochentage = Dictionary(uniqueKeysWithValues: Wochentag.allCases.map { ($0, []) })
        loadSavedGerichte()
    }
    
    // Initialisierer für Preview oder Test
    convenience init(previewData: [Wochentag: [Gericht]]) {
        self.init(context: nil)
        self.wochentage = previewData
    }
    
    private func loadSavedGerichte() {
        do {
            let fetchDescriptor = FetchDescriptor<Gericht>()
            let gespeicherteGerichte: [Gericht] = try modelContext?.fetch(fetchDescriptor) ?? []
            
            for gericht in gespeicherteGerichte {
                if let tag = gericht.wochentag {
                    wochentage[tag]?.append(gericht)
                }
            }
        } catch {
            print("Fehler beim Laden der gespeicherten Gerichte: \(error)")
        }
    }

    func addGericht(to tag: Wochentag, gericht: Gericht) {
        guard wochentage[tag] != nil else { return }
        
        wochentage[tag]?.append(gericht)
        saveGericht(gericht: gericht)
    }
    
    func moveGericht(within tag: Wochentag, from indices: IndexSet, to newOffset: Int) {
        guard let sourceIndex = indices.first else { return }
        guard var gerichte = wochentage[tag], !gerichte.isEmpty else { return }
        let gericht = gerichte.remove(at: sourceIndex)
        let targetIndex = newOffset > sourceIndex ? newOffset - 1 : newOffset
        gerichte.insert(gericht, at: targetIndex)
        
        wochentage[tag] = gerichte
        saveGericht(gericht: gericht)
    }
    
    func deleteGericht(at indices: IndexSet, from tag: Wochentag) {
        guard let gerichte = wochentage[tag] else { return }
        
        for index in indices {
            let gericht = gerichte[index]
            modelContext?.delete(gericht)
        }
        
        wochentage[tag]?.remove(atOffsets: indices)
    }
    
    func toggleZutatErledigt(zutat: Zutat) {
        for (tag, gerichte) in wochentage {
            if let gerichtIndex = gerichte.firstIndex(where: { $0.zutaten.contains(where: { $0.id == zutat.id }) }),
               let zutatIndex = gerichte[gerichtIndex].zutaten.firstIndex(where: { $0.id == zutat.id }) {
                
                wochentage[tag]?[gerichtIndex].zutaten[zutatIndex].erledigt.toggle()
                saveGericht(gericht: wochentage[tag]![gerichtIndex])
                return
            }
        }
    }
    
    func markiereAllesErledigt() {
        for tag in Wochentag.allCases {
            if let gerichte = wochentage[tag] {
                for gerichtIndex in gerichte.indices {
                    for zutatIndex in gerichte[gerichtIndex].zutaten.indices {
                        wochentage[tag]?[gerichtIndex].zutaten[zutatIndex].erledigt = true
                    }
                    saveGericht(gericht: wochentage[tag]![gerichtIndex])
                }
            }
        }
        try? modelContext?.save()
    }
  
    func deleteAllGerichte() {
        guard let modelContext = modelContext else {
            print("ModelContext ist nicht verfügbar.")
            return
        }
        
        for tag in Wochentag.allCases {
            if let gerichte = wochentage[tag] {
                for gericht in gerichte {
                    modelContext.delete(gericht)
                }
            }
            wochentage[tag] = []
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Fehler beim Speichern nach dem Löschen der Gerichte: \(error)")
        }
    }
  
    func deleteZutat(from gericht: Gericht, in tag: Wochentag, zutat: Zutat) {
        guard let gerichte = wochentage[tag],
              let gerichtIndex = gerichte.firstIndex(where: { $0.id == gericht.id }),
              let zutatIndex = gerichte[gerichtIndex].zutaten.firstIndex(where: { $0 == zutat }) else { return }
        
        wochentage[tag]?[gerichtIndex].zutaten.remove(at: zutatIndex)
        saveGericht(gericht: wochentage[tag]![gerichtIndex])
    }
    
    private func saveGericht(gericht: Gericht) {
        modelContext?.insert(gericht)
        try? modelContext?.save()
    }
}
