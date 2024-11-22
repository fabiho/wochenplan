//
//  WochenplanApp.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 02.11.24.
//

import SwiftUI
import SwiftData

@main
struct WochenplanApp: App {
    var modelContainer: ModelContainer = {
        do {
            return try ModelContainer(for: Gericht.self, Wochentag.self)
        } catch {
            fatalError("Fehler beim Initialisieren des ModelContainers: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(WochenplanViewModel(context: modelContainer.mainContext))
                .modelContainer(modelContainer)
        }
    }
}


