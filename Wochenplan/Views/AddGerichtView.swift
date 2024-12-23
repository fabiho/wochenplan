//
//  AddGerichtView.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 02.11.24.
//

import SwiftUI
import SwiftData

struct AddGerichtView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: WochenplanViewModel
    @State private var selectedWochentagIndex: Int = 0
    @State private var gerichtName: String = ""
    @State private var zutaten: [Zutat] = [Zutat(name: "", erledigt: false, kategorie: nil )]
    @FocusState private var focusedField: Int?
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section(header: Text("Gericht")) {
                        TextField("Gerichtname", text: $gerichtName)
                            .foregroundColor(.white)
                            .focused($focusedField, equals: -1)
                            .onSubmit {
                                if gerichtName.isEmpty == false {
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
                                    .map {zutat in
                                        Zutat(name: zutat.name, erledigt: false, kategorie: zutat.kategorie)}
                                let neuesGericht = Gericht(name: gerichtName, zutaten: neueZutaten, wochentag: Wochentag.dienstag)
                                let selectedTag = Wochentag.allCases[selectedWochentagIndex]
                                viewModel.addGericht(to: selectedTag, gericht: neuesGericht)
                                presentationMode.wrappedValue.dismiss()
                            },
                            isDisabled: gerichtName.isEmpty
                        )
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Gericht hinzufügen")
        }
    }
}
