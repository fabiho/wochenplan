//
//  GerichtDetailView.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 02.11.24.
//

import SwiftUI
import SwiftData

struct GerichtDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: WochenplanViewModel
    @State private var selectedWochentagIndex: Int
    @State private var gerichtName: String
    @State private var zutaten: [Zutat]
    @FocusState private var focusedField: Int?
    let gericht: Gericht

    init(viewModel: WochenplanViewModel, gericht: Gericht) {
        self.viewModel = viewModel
        self.gericht = gericht
        _selectedWochentagIndex = State(initialValue: Wochentag.allCases.firstIndex(of: gericht.wochentag ?? .montag) ?? 0)
        _gerichtName = State(initialValue: gericht.name)
        _zutaten = State(initialValue: gericht.zutaten)
    }

    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section(header: Text("Gericht")) {
                        TextField("Gerichtname", text: $gerichtName)
                            .foregroundColor(.white)
                            .focused($focusedField, equals: -1)
                            .onSubmit {
                                if !gerichtName.isEmpty {
                                    focusedField = 0
                                }
                            }
                        WochentagSelector(
                            wochentage: Wochentag.allCases,
                            selectedIndex: $selectedWochentagIndex
                        )
                    }
                    .listRowBackground(Color.primary)
                    
                    Section(header: Text("Zutaten")) {
                        ZutatenListView(
                            zutaten: $zutaten,
                            focusedField: $focusedField,
                            viewModel: viewModel
                        )
                    }
                    .listRowBackground(Color.primary)
                    
                    HStack {
                        CancelButton {
                            presentationMode.wrappedValue.dismiss()
                        }
                        
                        Spacer()
                        
                        SaveButton(
                            action: {
                                let neueZutaten = zutaten
                                    .filter { !$0.name.isEmpty }
                                    .map { zutat in
                                        Zutat(name: zutat.name, erledigt: zutat.erledigt, kategorie: zutat.kategorie)
                                    }
                                let updatedWochentag = Wochentag.allCases[selectedWochentagIndex]
                                
                                viewModel.updateGericht(
                                    gericht: gericht,
                                    name: gerichtName,
                                    wochentag: updatedWochentag,
                                    zutaten: neueZutaten
                                )
                                presentationMode.wrappedValue.dismiss()
                            },
                            isDisabled: gerichtName.isEmpty
                        )
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Gericht bearbeiten")
        }
    }
}









