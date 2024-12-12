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
        let checkedCount = viewModel.alleZutaten.filter { $0.erledigt }.count
        return totalItems > 0 ? Double(checkedCount) / Double(totalItems) : 0
    }

    var groupedZutaten: [Kategorie: [Zutat]] {
        Dictionary(grouping: viewModel.alleZutaten) { zutat in
            zutat.kategorie ?? .ohneKategorie
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.alleZutaten.isEmpty {
                    EmptyEinkaufslisteView()
                } else {
                    VStack {
                        ProgressView(value: progress, total: 1)
                            .progressViewStyle(LinearProgressViewStyle())
                            .padding()
                            .accentColor(Color.primary)

                        List {
                            ForEach(Kategorie.allCases + [.ohneKategorie], id: \.self) { kategorie in
                                if let zutaten = groupedZutaten[kategorie], !zutaten.isEmpty {
                                    Section(header: HStack {
                                        kategorie.image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 24, height: 24)
                                        Text(kategorie.rawValue)
                                    }) {
                                        ForEach(zutaten, id: \.id) { zutat in
                                            EinkaufslisteRow(
                                                zutat: zutat,
                                                isChecked: zutat.erledigt,
                                                toggleAction: {
                                                    viewModel.toggleZutatErledigt(zutat: zutat)
                                                }
                                            )
                                        }
                                    }
                                }
                            }
                            .listRowBackground(Color.secondary)
                        }
                        .listStyle(InsetGroupedListStyle())
                    }
                    .navigationTitle("Einkaufsliste")
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button {
                        viewModel.markiereAllesErledigt()
                        checkedItems = Dictionary(uniqueKeysWithValues: viewModel.alleZutaten.map { ($0.id, true) })
                    } label: {
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






