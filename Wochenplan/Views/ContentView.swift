//
//  ContentView.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 02.11.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var viewModel: WochenplanViewModel
    @State private var isShowingAddGericht = false
    @State private var selectedGericht: Gericht?
    @State private var selectedWochentag: Wochentag?
    @State private var showEinkaufsliste = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.wochentage.allSatisfy({ $0.gerichte.isEmpty }) {
                    VStack {
                        Spacer()
                        
                        Image(systemName: "fork.knife")
                            .font(.system(size: 50))
                            .foregroundColor(Color.gray)
                        
                        Text("Erstelle jetzt über den Plus-Button dein erstes Gericht und plane deine Woche.")
                            .font(.body)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .padding()
                        
                        Spacer()
                    }
                    .navigationTitle("Dein Wochenplan")
                } else {
                    List {
                        ForEach(viewModel.wochentage) { tag in
                            if !tag.gerichte.isEmpty {
                                Section(header: Text(tag.name)) {
                                    ForEach(tag.gerichte) { gericht in
                                        NavigationLink(destination: GerichtDetailView(gericht: gericht, wochentag: tag)) {
                                            Image(systemName: "fork.knife")
                                            Text(gericht.name)
                                        }
                                        .listRowBackground(Color.primary)
                                        .foregroundColor(Color.white)
                                    }
                                    .onMove { indices, newOffset in
                                        viewModel.moveGericht(within: tag, from: indices, to: newOffset)
                                    }
                                    .onDelete { indices in
                                        viewModel.deleteGericht(at: indices, from: tag)
                                    }
                                }
                            }
                        }
                    }
                    .navigationTitle("Dein Wochenplan")
                    .scrollContentBackground(.hidden)
                }
                
                VStack {
                    Spacer()
                    HStack {
                        ActionButtonView {
                            self.isShowingAddGericht = true
                        }
                    }
                }
                .sheet(isPresented: $isShowingAddGericht) {
                    AddGerichtView(viewModel: viewModel)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {
                            viewModel.deleteAllGerichte()
                        }) {
                            Label("Alle Gerichte löschen", systemImage: "trash.fill")
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
}

#Preview("Mit Inhalt") {
    // Beispielgerichte und Wochentage
    let exampleGerichteMontag = [
        Gericht(name: "Spaghetti Bolognese", zutaten: ["Spaghetti", "Hackfleisch", "Tomatensauce", "Zwiebeln", "Knoblauch"]),
        Gericht(name: "Caesar Salad", zutaten: ["Römersalat", "Hähnchenbrust", "Croutons", "Parmesan", "Caesar Dressing"])
    ]
    
    let exampleGerichteDienstag = [
        Gericht(name: "Hähnchen Curry", zutaten: ["Hähnchenbrust", "Curry", "Kokosmilch", "Paprika", "Reis"]),
        Gericht(name: "Gemüse Lasagne", zutaten: ["Lasagneblätter", "Zucchini", "Auberginen", "Tomaten", "Béchamelsauce"])
    ]
    
    let exampleGerichteMittwoch = [
        Gericht(name: "Lachsfilet", zutaten: ["Lachs", "Zitronensaft", "Kräuter", "Kartoffeln", "Brokkoli"])
    ]
    
    let exampleGerichteDonnerstag = [
        Gericht(name: "Pizza Margherita", zutaten: ["Pizzateig", "Tomatensauce", "Mozzarella", "Basilikum"])
    ]
    
    let exampleGerichteFreitag = [
        Gericht(name: "Vegetarischer Burger", zutaten: ["Vegetarische Patties", "Burgerbrötchen", "Salat", "Tomaten", "Ketchup"])
    ]
    
    let exampleGerichteSamstag = [
        Gericht(name: "Tacos", zutaten: ["Taco-Schalen", "Hackfleisch", "Käse", "Tomaten", "Salat", "Salsa"])
    ]
    
    let exampleGerichteSonntag = [
        Gericht(name: "Braten mit Knödeln", zutaten: ["Schweinebraten", "Kartoffeln", "Mehl", "Eier", "Sauerkraut"]),
        Gericht(name: "Pfannkuchen", zutaten: ["Mehl", "Eier", "Milch", "Zucker", "Vanillezucker"])
    ]
    
    // Beispielwochentage mit Gerichten
    let exampleWochentage = [
        Wochentag(name: "Montag", gerichte: exampleGerichteMontag),
        Wochentag(name: "Dienstag", gerichte: exampleGerichteDienstag),
        Wochentag(name: "Mittwoch", gerichte: exampleGerichteMittwoch),
        Wochentag(name: "Donnerstag", gerichte: exampleGerichteDonnerstag),
        Wochentag(name: "Freitag", gerichte: exampleGerichteFreitag),
        Wochentag(name: "Samstag", gerichte: exampleGerichteSamstag),
        Wochentag(name: "Sonntag", gerichte: exampleGerichteSonntag)
    ]
    
    // Setze das ViewModel mit den Beispielwochentagen
    let previewViewModel = WochenplanViewModel(previewData: exampleWochentage)
    
    ContentView()
        .environmentObject(previewViewModel)
}


#Preview("Ohne Inhalt") {
    // Beispielgerichte und Wochentage für die leere Vorschau
    let exampleGerichte: [Gericht] = []
    let exampleWochentage: [Wochentag] = [
        Wochentag(name: "Montag", gerichte: exampleGerichte),
        Wochentag(name: "Dienstag", gerichte: exampleGerichte),
        Wochentag(name: "Mittwoch", gerichte: exampleGerichte),
        Wochentag(name: "Donnerstag", gerichte: exampleGerichte),
        Wochentag(name: "Freitag", gerichte: exampleGerichte),
        Wochentag(name: "Samstag", gerichte: exampleGerichte),
        Wochentag(name: "Sonntag", gerichte: exampleGerichte)
    ]
    
    let previewViewModel = WochenplanViewModel(previewData: exampleWochentage)
    
    ContentView()
        .environmentObject(previewViewModel)
}


