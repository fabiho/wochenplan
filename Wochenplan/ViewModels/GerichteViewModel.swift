//
//  GerichteViewModel.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 06.12.24.
//

import Foundation
import SwiftData

class GerichteViewModel: ObservableObject {
    @Published var gerichte: [Gericht] = []
    private var modelContext: ModelContext?
    
    init(context: ModelContext?) {
        self.modelContext = context
        loadGerichte()
    }
    
    convenience init(previewData: [Gericht] = []) {
        self.init(context: nil)
        self.gerichte = previewData
    }
    
    func loadGerichte() {
        guard let modelContext = modelContext else { return }
        let request = FetchDescriptor<Gericht>()
        if let fetchedGerichte = try? modelContext.fetch(request) {
            self.gerichte = fetchedGerichte
        }
    }
    
    func addGericht(name: String, zutaten: [Zutat]) {
        let neuesGericht = Gericht(name: name, zutaten: zutaten)
        modelContext?.insert(neuesGericht)
        try? modelContext?.save()
        gerichte.append(neuesGericht)
    }
    
    func updateGericht(_ gericht: Gericht, neuerName: String, neueZutaten: [Zutat]) {
        guard let index = gerichte.firstIndex(where: { $0.id == gericht.id }) else { return }
        gerichte[index].name = neuerName
        gerichte[index].zutaten = neueZutaten
        
        saveGericht(gericht: gerichte[index])
    }
    
    func deleteGericht(_ gericht: Gericht) {
        guard let index = gerichte.firstIndex(where: { $0.id == gericht.id }) else { return }
        modelContext?.delete(gericht)
        try? modelContext?.save()
        gerichte.remove(at: index)
    }

    func addZutat(to gericht: Gericht, zutat: Zutat) {
        guard let index = gerichte.firstIndex(where: { $0.id == gericht.id }) else { return }
        gerichte[index].zutaten.append(zutat)
        saveGericht(gericht: gerichte[index])
    }
    
    func deleteZutat(from gericht: Gericht, zutat: Zutat) {
        guard let gerichtIndex = gerichte.firstIndex(where: { $0.id == gericht.id }) else { return }
        gerichte[gerichtIndex].zutaten.removeAll { $0.id == zutat.id }
        saveGericht(gericht: gerichte[gerichtIndex])
    }
    
    func toggleZutatErledigt(in gericht: Gericht, zutat: Zutat) {
        guard let gerichtIndex = gerichte.firstIndex(where: { $0.id == gericht.id }),
              let zutatIndex = gerichte[gerichtIndex].zutaten.firstIndex(where: { $0.id == zutat.id }) else { return }
        gerichte[gerichtIndex].zutaten[zutatIndex].erledigt.toggle()
        saveGericht(gericht: gerichte[gerichtIndex])
    }
    
    func markiereAlleZutatenErledigt(in gericht: Gericht) {
        guard let gerichtIndex = gerichte.firstIndex(where: { $0.id == gericht.id }) else { return }
        for index in 0..<gerichte[gerichtIndex].zutaten.count {
            gerichte[gerichtIndex].zutaten[index].erledigt = true
        }
        saveGericht(gericht: gerichte[gerichtIndex])
    }
    
    private func saveGericht(gericht: Gericht) {
        modelContext?.insert(gericht)
        try? modelContext?.save()
    }
}
