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
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color(Color(red: 236 / 255, green: 244 / 255, blue: 214 / 255))
                    .ignoresSafeArea()
                
                List {
                    ForEach(viewModel.alleZutaten.sorted(), id: \.self) { zutat in
                        HStack {
                            let isChecked = checkedItems[zutat] ?? false
                            
                            Button(action: {
                                checkedItems[zutat] = !isChecked
                            }) {
                                Image(systemName: isChecked ? "checkmark.square" : "square")
                                    .foregroundColor(isChecked ? .green : .gray)
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
                .navigationTitle("Einkaufsliste")
                .scrollContentBackground(.hidden)
            }
        }
        
    }
}


