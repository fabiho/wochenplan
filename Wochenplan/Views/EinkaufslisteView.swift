//
//  EinkaufslisteView.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 10.11.24.
//

import Foundation
import SwiftUI

struct EinkaufslisteView: View {
    @ObservedObject var viewModel: WochenplanViewModel
    @State private var checkedItems: [UUID: Bool] = [:]
    
    var progress: Double {
        let totalItems = viewModel.alleZutaten.count
        let checkedCount = checkedItems.values.filter { $0 }.count
        return totalItems > 0 ? Double(checkedCount) / Double(totalItems) : 0
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.alleZutaten.isEmpty {
                    EmptyEinkaufslisteView()
                } else {
                    VStack(spacing: -15) {
                        ProgressView(value: progress, total: 1)
                            .progressViewStyle(LinearProgressViewStyle())
                            .padding()
                            .accentColor(Color.primary)
                        
                        List(viewModel.alleZutaten, id: \.id) { zutat in
                            EinkaufslisteRow(
                                zutat: zutat,
                                isChecked: zutat.erledigt,
                                toggleAction: {
                                    viewModel.toggleZutatErledigt(zutat: zutat)
                                }
                            )
                            .listRowBackground(Color.secondary)
                        }
                        
//                        ForEach(viewModel.zutatenNachKategorien().keys.sorted(by: { $0.name < $1.name }), id: \.id) { kategorie in
//                            Section(header: Text(kategorie.name)) {
//                                ForEach(viewModel.zutatenNachKategorien()[kategorie] ?? []) { zutat in
//                                    EinkaufslisteRow(
//                                        zutat: zutat,
//                                        isChecked: checkedItems[zutat.id] ?? false,
//                                        toggleAction: {
//                                            checkedItems[zutat.id] = !(checkedItems[zutat.id] ?? false)
//                                            viewModel.toggleZutatErledigt(zutat: zutat)
//                                        }
//                                    )
//                                }
//                            }
//                        }
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
                        viewModel.markiereAllesErledigt()
                        checkedItems = Dictionary(uniqueKeysWithValues: viewModel.alleZutaten.map { ($0.id, true) })
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





