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
    @Published var selectedWochentagIndex: Int = 0
    private var modelContext: ModelContext?

    var alleZutaten: [Zutat] {
        wochentage.values.flatMap { $0.flatMap { $0.zutaten } }
    }

    init(context: ModelContext?) {
        self.modelContext = context
        self.wochentage = Wochentag.allCases.reduce(into: [:]) { $0[$1] = [] }
        loadSavedGerichte()
    }

    convenience init(previewData: [Wochentag: [Gericht]]) {
        self.init(context: nil)
        self.wochentage = previewData
    }

    private func loadSavedGerichte() {
        guard let modelContext = modelContext else { return }
        
        do {
            let gespeicherteGerichte: [Gericht] = try modelContext.fetch(FetchDescriptor<Gericht>())
            gespeicherteGerichte.forEach { gericht in
                if let tag = gericht.wochentag, !(wochentage[tag]?.contains(where: { $0.id == gericht.id }) ?? false) {
                    wochentage[tag]?.append(gericht)
                }
            }
        } catch {
            print("Fehler beim Laden der gespeicherten Gerichte: \(error)")
        }
    }

    func addGericht(to tag: Wochentag, gericht: Gericht) {
        guard !(wochentage[tag]?.contains(where: { $0.id == gericht.id }) ?? false) else { return }
        wochentage[tag]?.append(gericht)
        saveGericht(gericht: gericht)
    }

    func updateGericht(gericht: Gericht, name: String, wochentag: Wochentag, zutaten: [Zutat]) {
        guard let context = modelContext else { return }

        let altesWochentag = gericht.wochentag
        gericht.name = name
        gericht.zutaten = zutaten
        gericht.wochentag = wochentag

        do {
            try context.save()

            if let alterTag = altesWochentag, alterTag != wochentag {
                wochentage[alterTag]?.removeAll(where: { $0.id == gericht.id })
            }

            if !(wochentage[wochentag]?.contains(where: { $0.id == gericht.id }) ?? false) {
                wochentage[wochentag]?.append(gericht)
            }
        } catch {
            print("Fehler beim Speichern des Gerichts: \(error)")
        }
    }

    func moveGericht(within tag: Wochentag, from indices: IndexSet, to newOffset: Int) {
        guard let sourceIndex = indices.first, var gerichte = wochentage[tag], !gerichte.isEmpty else { return }
        let gericht = gerichte.remove(at: sourceIndex)
        let targetIndex = newOffset > sourceIndex ? newOffset - 1 : newOffset
        gerichte.insert(gericht, at: targetIndex)
        wochentage[tag] = gerichte
        saveGericht(gericht: gericht)
    }

    func deleteGericht(at indices: IndexSet, from tag: Wochentag) {
        guard let gerichte = wochentage[tag] else { return }
        indices.compactMap { gerichte[$0] }.forEach { modelContext?.delete($0) }
        wochentage[tag]?.remove(atOffsets: indices)
    }

    func toggleZutatErledigt(zutat: Zutat) {
        guard let (tag, gerichtIndex, zutatIndex) = findZutat(zutat) else { return }
        wochentage[tag]?[gerichtIndex].zutaten[zutatIndex].erledigt.toggle()
        if let gericht = wochentage[tag]?[gerichtIndex] {
            saveGericht(gericht: gericht)
        }
    }

    func updateZutaten(for gericht: Gericht, zutaten: [Zutat]) {
        guard let tag = gericht.wochentag, let index = wochentage[tag]?.firstIndex(where: { $0.id == gericht.id }) else { return }
        wochentage[tag]?[index].zutaten = zutaten
    }

    func markiereAllesErledigt() {
        Wochentag.allCases.forEach { tag in
            wochentage[tag]?.indices.forEach { gerichtIndex in
                wochentage[tag]?[gerichtIndex].zutaten.indices.forEach { zutatIndex in
                    wochentage[tag]?[gerichtIndex].zutaten[zutatIndex].erledigt = true
                }
                if let gericht = wochentage[tag]?[gerichtIndex] {
                    saveGericht(gericht: gericht)
                }
            }
        }
        try? modelContext?.save()
    }

    func deleteAllGerichte() {
        guard let modelContext = modelContext else { return }
        
        Wochentag.allCases.forEach { tag in
            wochentage[tag]?.forEach { modelContext.delete($0) }
            wochentage[tag] = []
        }

        do {
            try modelContext.save()
        } catch {
            print("Fehler beim Speichern nach dem Löschen der Gerichte: \(error)")
        }
    }

    func deleteZutat(from gericht: Gericht, in tag: Wochentag, zutat: Zutat) {
        guard let gerichtIndex = wochentage[tag]?.firstIndex(where: { $0.id == gericht.id }),
              let zutatIndex = wochentage[tag]?[gerichtIndex].zutaten.firstIndex(where: { $0 == zutat }) else { return }
        wochentage[tag]?[gerichtIndex].zutaten.remove(at: zutatIndex)
        if let gericht = wochentage[tag]?[gerichtIndex] {
            saveGericht(gericht: gericht)
        }
    }

    private func saveGericht(gericht: Gericht) {
        modelContext?.insert(gericht)
        try? modelContext?.save()
    }

    private func findZutat(_ zutat: Zutat) -> (tag: Wochentag, gerichtIndex: Int, zutatIndex: Int)? {
        for (tag, gerichte) in wochentage {
            for (gerichtIndex, gericht) in gerichte.enumerated() {
                if let zutatIndex = gericht.zutaten.firstIndex(where: { $0.id == zutat.id }) {
                    return (tag, gerichtIndex, zutatIndex)
                }
            }
        }
        return nil
    }
}

