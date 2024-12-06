//
//  WochenplanViewModel.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 02.11.24.
//

import Foundation
import SwiftData

class WochenplanViewModel: ObservableObject {
    @Published var wochentageViewModel: WochentageViewModel
    @Published var kategorienViewModel: KategorienViewModel
    @Published var gerichteViewModel: GerichteViewModel
    
    private var modelContext: ModelContext?

    // Initialisierer
    init(context: ModelContext?) {
        self.modelContext = context
        
        // Sub-ViewModels initialisieren
        self.wochentageViewModel = WochentageViewModel(context: context)
        self.kategorienViewModel = KategorienViewModel(context: context)
        self.gerichteViewModel = GerichteViewModel(context: context)
    }
    
    // Beispiel-Initialisierer für Previews
    convenience init(previewData: ([Wochentag], [Kategorie], [Gericht])) {
        self.init(context: nil)
        self.wochentageViewModel = WochentageViewModel(previewData: previewData.0)
        self.kategorienViewModel = KategorienViewModel(previewData: previewData.1)
        self.gerichteViewModel = GerichteViewModel(previewData: previewData.2)
    }
}

