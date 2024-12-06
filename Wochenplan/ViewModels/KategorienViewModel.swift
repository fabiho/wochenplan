//
//  KategorienViewModel.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 06.12.24.
//

import Foundation
import SwiftData

class KategorienViewModel: ObservableObject {
    @Published var kategorien: [Kategorie] = []
    private var modelContext: ModelContext?
    
    let standardKategorien = [
        Kategorie(name: "Obst & Gemüse"),
        Kategorie(name: "Kühltheke"),
        Kategorie(name: "Dosen"),
        Kategorie(name: "Brot & Backwaren"),
        Kategorie(name: "Getränke")
    ]
    
    init(context: ModelContext?) {
        self.modelContext = context
        loadKategorien()
    }
    
    convenience init(previewData: [Kategorie] = []) {
        self.init(context: nil)
        self.kategorien = previewData
    }
    
    func loadKategorien() {
        guard let modelContext = modelContext else { return }
        let request = FetchDescriptor<Kategorie>()
        if let fetchedKategorien = try? modelContext.fetch(request), !fetchedKategorien.isEmpty {
            self.kategorien = fetchedKategorien
        } else {
            addDefaultKategorien()
        }
    }
    
    func addDefaultKategorien() {
        standardKategorien.forEach { modelContext?.insert($0) }
        try? modelContext?.save()
        self.kategorien = standardKategorien
    }
}
