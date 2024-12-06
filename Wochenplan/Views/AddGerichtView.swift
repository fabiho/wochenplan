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
    @ObservedObject var gerichteViewModel: GerichteViewModel
    @ObservedObject var wochentageViewModel: WochentageViewModel
    @State private var selectedWochentagIndex: Int = 0
    @State private var selectedKategorie: Kategorie?
    @State private var gerichtName: String = ""
    @State private var zutaten: [Zutat] = [Zutat(name: "", erledigt: false, kategorie: nil)]
    
    @Query(sort: \Kategorie.name, order: .forward) private var alleKategorien: [Kategorie]
    
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
                        
                        // Wochentag auswählen
                        WochentagSelectorView(wochentage: wochentageViewModel.wochentage, selectedIndex: $selectedWochentagIndex)
                    }
                    .listRowBackground(Color.primary)
                    
                    Section(header: Text("Zutaten")) {
                        ZutatenListView(zutaten: $zutaten, focusedField: $focusedField, kategorien: alleKategorien, gerichteViewModel: gerichteViewModel)
                    }
                    .listRowBackground(Color.primary)
                    
                    HStack {
                        CancelButtonView {
                            presentationMode.wrappedValue.dismiss()
                        }
                        
                        Spacer()
                        
                        SaveButtonView(
                            action: {
                                // Neue Zutaten filtern und Gericht erstellen
                                let neueZutaten = zutaten
                                    .filter { !$0.name.isEmpty }
                                    .map { Zutat(name: $0.name, erledigt: false, kategorie: selectedKategorie) }
                                let neuesGericht = Gericht(name: gerichtName, zutaten: neueZutaten)
                                
                                // Gericht dem ausgewählten Wochentag hinzufügen
                                let selectedTag = wochentageViewModel.wochentage[selectedWochentagIndex]
                                wochentageViewModel.addGericht(to: selectedTag, gericht: neuesGericht)
                                
                                // Zurück zur vorherigen Ansicht
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

