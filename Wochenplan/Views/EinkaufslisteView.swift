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
    @State private var checkedItems: [String: Bool] = [:]
    
    var progress: Double {
        let totalItems = viewModel.alleZutaten.count
        let checkedCount = checkedItems.values.filter { $0 }.count
        return totalItems > 0 ? Double(checkedCount) / Double(totalItems) : 0
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.alleZutaten.isEmpty {
                    VStack {
                        Spacer()
                        
                        Image(systemName: "cart.fill")
                            .font(.system(size: 50))
                            .foregroundColor(Color.gray)
                        
                        Text("Deine Einkaufsliste ist leer. Plane zuerst deine Woche.")
                            .font(.body)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .padding()
                        
                        Spacer()
                    }
                    .navigationTitle("Einkaufsliste")
                } else {
                    VStack(spacing: -15) {
                        ProgressView(value: progress, total: 1)
                            .progressViewStyle(LinearProgressViewStyle())
                            .padding()
                            .accentColor(Color.primary)
                        
                        List {
                            ForEach(viewModel.alleZutaten.sorted(), id: \.self) { zutat in
                                HStack {
                                    let isChecked = checkedItems[zutat] ?? false
                                    
                                    Button(action: {
                                        checkedItems[zutat] = !isChecked
                                    }) {
                                        Image(systemName: isChecked ? "checkmark.square" : "square")
                                            .foregroundColor(isChecked ? Color.primary : .gray)
                                    }
                                    
                                    Text(zutat)
                                        .strikethrough(isChecked, color: .gray)
                                        .foregroundColor(isChecked ? .gray : .white)
                                    Spacer()
                                    Image("bread") // Icon der Kategorie
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 30)
                                }
                                .onAppear {
                                    if checkedItems[zutat] == nil {
                                        checkedItems[zutat] = false
                                    }
                                }
                            }
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
                    Button(action: {
//                        viewModel.deleteAllGerichte()
                    }) {
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



