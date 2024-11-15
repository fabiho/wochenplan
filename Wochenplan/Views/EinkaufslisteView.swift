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
                            .padding(.bottom, 20)
                        
                        Text("Deine Einkaufsliste ist leer. Plane zuerst deine Woche.")
                            .font(.title3)
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
                            .accentColor(Color(red: 45 / 255, green: 149 / 255, blue: 150 / 255))
                        
                        List {
                            ForEach(viewModel.alleZutaten.sorted(), id: \.self) { zutat in
                                HStack {
                                    let isChecked = checkedItems[zutat] ?? false
                                    
                                    Button(action: {
                                        checkedItems[zutat] = !isChecked
                                    }) {
                                        Image(systemName: isChecked ? "checkmark.square" : "square")
                                            .foregroundColor(isChecked ? Color(red: 45 / 255, green: 149 / 255, blue: 150 / 255) : .gray)
                                    }
                                    
                                    Text(zutat)
                                        .strikethrough(isChecked, color: .gray)
                                        .foregroundColor(isChecked ? .gray : .white)
                                }
                                .onAppear {
                                    if checkedItems[zutat] == nil {
                                        checkedItems[zutat] = false
                                    }
                                }
                            }
                            .listRowBackground(Color(red: 38 / 255, green: 80 / 255, blue: 115 / 255))
                        }
                    }
                    .navigationTitle("Einkaufsliste")
                }
            }
        }
    }
}



