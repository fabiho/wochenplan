//
//  ZutatenViewModel.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 06.12.24.
//

//
//  ZutatenViewModel.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 06.12.24.
//

import Foundation
import SwiftUI
import SwiftData

class ZutatenViewModel: ObservableObject {
    @Published var zutaten: [Zutat] = []
    private var modelContext: ModelContext?
    
    // Initialisierer
    init(context: ModelContext?) {
        self.modelContext = context
        loadZutaten()
    }
    
    // Initialisierer für Preview oder Test
    convenience init(previewData: [Zutat] = []) {
        self.init(context: nil)
        self.zutaten = previewData
    }
    
    func loadZutaten() {
        guard let modelContext = modelContext else {
            print("ModelContext ist nicht verfügbar.")
            return
        }
        
        let request = FetchDescriptor<Zutat>()
        if let fetchedZutaten = try? modelContext.fetch(request) {
            
                self.zutaten = fetchedZutaten
            
        }
    }
    
    func addZutat(_ zutat: Zutat) {
        zutaten.append(zutat)
        modelContext?.insert(zutat)
        try? modelContext?.save()
    }
    
    func removeZutat(at offsets: IndexSet) {
        for index in offsets {
            let zutat = zutaten[index]
            modelContext?.delete(zutat)
        }
        zutaten.remove(atOffsets: offsets)
        try? modelContext?.save()
    }
    
    func toggleZutatErledigt(zutat: Zutat) {
        if let index = zutaten.firstIndex(where: { $0.id == zutat.id }) {
            zutaten[index].erledigt.toggle()
            try? modelContext?.save()
        }
    }
    
    // Fügt einer Zutat eine Kategorie hinzu
    func setKategorie(for zutat: Zutat, kategorie: Kategorie) {
        if let index = zutaten.firstIndex(where: { $0.id == zutat.id }) {
            zutaten[index].kategorie = kategorie
            try? modelContext?.save()
        }
    }
}

