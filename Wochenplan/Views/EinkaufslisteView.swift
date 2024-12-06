//
//  EinkaufslisteView.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 10.11.24.
//

import Foundation
import SwiftUI

struct EinkaufslisteView: View {
    @ObservedObject var gerichteViewModel: GerichteViewModel // Wechselt zu einem spezifizierten ViewModel
    @State private var checkedItems: [UUID: Bool] = [:]
    
    var progress: Double {
        let totalItems = gerichteViewModel.alleZutaten.count
        let checkedCount = checkedItems.values.filter { $0 }.count
        return totalItems > 0 ? Double(checkedCount) / Double(totalItems) : 0
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if gerichteViewModel.alleZutaten.isEmpty {
                    EmptyEinkaufslisteView()
                } else {
                    VStack(spacing: -15) {
                        // Fortschrittsanzeige für den Einkaufsstatus
                        ProgressView(value: progress, total: 1)
                            .progressViewStyle(LinearProgressViewStyle())
                            .padding()
                            .accentColor(Color.primary)
                        
                        // Zeige alle Zutaten in der Einkaufsliste
                        List(gerichteViewModel.alleZutaten, id: \.id) { zutat in
                            EinkaufslisteRow(
                                zutat: zutat,
                                isChecked: checkedItems[zutat.id] ?? zutat.erledigt, // Erledigt-Zustand berücksichtigen
                                toggleAction: {
                                    checkedItems[zutat.id] = !(checkedItems[zutat.id] ?? false)
                                    gerichteViewModel.toggleZutatErledigt(zutat: zutat)
                                }
                            )
                            .listRowBackground(Color.secondary)
                        }
                    }
                    .navigationTitle("Einkaufsliste")
                    .scrollContentBackground(.hidden)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button() {
                        gerichteViewModel.markiereAllesErledigt()
                        checkedItems = Dictionary(uniqueKeysWithValues: gerichteViewModel.alleZutaten.map { ($0.id, true) })
                    }
                    label: {
                        Label("Alles erledigt", systemImage: "checkmark.square")
                            .foregroundColor(.red)
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}






