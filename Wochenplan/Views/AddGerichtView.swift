//
//  AddGerichtView.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 02.11.24.
//

import SwiftUI

struct AddGerichtView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: WochenplanViewModel
    @State private var selectedWochentagIndex: Int = 0
    @State private var gerichtName: String = ""
    @State private var zutaten: [String] = [""]
    
    // Fokussiert den Fokus auf jedes Textfeld
    @FocusState private var focusedField: Int?
    
    var body: some View {
        NavigationView {
            
            ZStack {
                Form {
                    Section(header: Text("Gericht")) {
                        Picker("Wochentag", selection: $selectedWochentagIndex) {
                            ForEach(0..<viewModel.wochentage.count, id: \.self) { index in
                                Text(viewModel.wochentage[index].name)
                                    .tag(index)
                            }
                            .foregroundColor(.white)
                        }
                        .foregroundColor(.white)
                        
                        TextField("Gerichtname", text: $gerichtName)
                            .foregroundColor(.white)
                            .focused($focusedField, equals: nil) // Setzt den Fokus auf das erste Textfeld
                    }
                    .listRowBackground(Color(red: 45 / 255, green: 149 / 255, blue: 150 / 255))
                    
                    Section(header: Text("Zutaten")) {
                        ForEach(zutaten.indices, id: \.self) { index in
                            TextField("Zutat \(index + 1)", text: $zutaten[index])
                                .foregroundColor(.white)
                                .focused($focusedField, equals: index) // Setzt den Fokus auf Textfeld
                                .onSubmit {
                                    // Wenn Enter gedrückt nächsten Textfeld
                                    if index < zutaten.count - 1 {
                                        focusedField = index + 1
                                    } else if index == zutaten.count - 1 && !zutaten[index].isEmpty {
                                        // Füge ein neues Feld hinzu, wenn das letzte ausgefüllt ist
                                        zutaten.append("")
                                        focusedField = zutaten.count - 1
                                    }
                                }
                        }
                        .onDelete { indexSet in
                            zutaten.remove(atOffsets: indexSet)
                            if zutaten.isEmpty {
                                zutaten.append("")  // Stelle sicher, dass mindestens ein leeres Feld bleibt
                            }
                        }
                    }
                    .listRowBackground(Color(red: 45 / 255, green: 149 / 255, blue: 150 / 255))
                    
                    HStack {
                        // Abbrechen-Button
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Abbrechen")
                                .padding()
                                .foregroundColor(Color(red: 45 / 255, green: 149 / 255, blue: 150 / 255))
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 20,
                                        style: .continuous
                                    )
                                    .stroke(Color(red: 45 / 255, green: 149 / 255, blue: 150 / 255), lineWidth: 2)
                                )
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        
                        Spacer()
                        
                        // Speichern-Button
                        Button(action: {
                            let neueZutaten = zutaten.filter {!$0.isEmpty}
                            let neuesGericht = Gericht(name: gerichtName, zutaten: neueZutaten)
                            let selectedTag = viewModel.wochentage[selectedWochentagIndex]
                            viewModel.addGericht(to: selectedTag, gericht: neuesGericht)
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Speichern")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color(red: 45 / 255, green: 149 / 255, blue: 150 / 255))
                                .cornerRadius(20)
                        }
                        .disabled(gerichtName.isEmpty)
                    }
                }
                .scrollContentBackground(.hidden)
                
            }
            .navigationTitle("Gericht hinzufügen")
        }
    }
}



