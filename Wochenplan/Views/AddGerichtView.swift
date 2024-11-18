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
                        
                        TextField("Gerichtname", text: $gerichtName)
                            .foregroundColor(.white)
                            .focused($focusedField, equals: nil) // Setzt den Fokus auf das erste Textfeld
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(0..<viewModel.wochentage.count, id: \.self) { index in
                                    Button(action: {
                                        selectedWochentagIndex = index
                                    }) {
                                        Text(viewModel.wochentage[index].name)
                                            .padding(10)
                                            .background(selectedWochentagIndex == index ? (Color.secondary) : Color.secondary.opacity(0.4))
                                            .foregroundColor(Color.white)
                                            .cornerRadius(10)
                                            .frame(height: 10)
                                    }
                                }
                            }
                            .padding(.vertical)
                        }
                    }
                    .listRowBackground(Color.primary)
                    
                    Section(header: Text("Zutaten")) {
                        ForEach(zutaten.indices, id: \.self) { index in
                            TextField("Zutat \(index + 1)", text: Binding(
                                get: { zutaten[index] },
                                set: { newValue in
                                    zutaten[index] = newValue
                                    // Automatisches Hinzufügen einer neuen Zeile
                                    if index == zutaten.count - 1 && !newValue.isEmpty {
                                        zutaten.append("")
                                    }
                                }
                            ))
                            .foregroundColor(.white)
                            .focused($focusedField, equals: index)
                            .onSubmit {
                                // Wechsel zum nächsten Feld
                                if index < zutaten.count - 1 {
                                    focusedField = index + 1
                                } else if index == zutaten.count - 1 && !zutaten[index].isEmpty {
                                    // Füge eine neue Zeile hinzu, wenn die aktuelle die letzte ist
                                    zutaten.append("")
                                    focusedField = zutaten.count - 1
                                }
                            }
                        }
                        .onDelete { indexSet in
                            zutaten.remove(atOffsets: indexSet)
                            if zutaten.isEmpty {
                                zutaten.append("")  // Es bleibt mindest ein Feld vorhanden
                            }
                        }
                    }
                    .listRowBackground(Color.primary)
                    
                    HStack {
                        // Abbrechen-Button
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Abbrechen")
                                .padding()
                                .foregroundColor(Color.primary)
                                .background(
                                    RoundedRectangle(
                                        cornerRadius: 20,
                                        style: .continuous
                                    )
                                    .stroke(Color.primary, lineWidth: 2)
                                )
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .shadow(radius: 5)
                        
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
                                .background(Color.primary)
                                .cornerRadius(20)
                                .shadow(radius: 5)
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
