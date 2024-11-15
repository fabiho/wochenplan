//
//  ContentView.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 02.11.24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: WochenplanViewModel
    @State private var isShowingAddGericht = false
    @State private var selectedGericht: Gericht?
    @State private var selectedWochentag: Wochentag?
    @State private var showEinkaufsliste = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Color(Color(red: 236 / 255, green: 244 / 255, blue: 214 / 255))
                    .ignoresSafeArea()
                
                List {
                    ForEach(viewModel.wochentage) { tag in
                        if !tag.gerichte.isEmpty {
                            Section(header: Text(tag.name)) {
                                ForEach(tag.gerichte) { gericht in
                                    NavigationLink(destination: GerichtDetailView(gericht: gericht, wochentag: tag)) {
                                        Text(gericht.name)
                                    }
                                    .listRowBackground(Color(red: 45 / 255, green: 149 / 255, blue: 150 / 255))
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
                
                VStack {
                    Spacer()
                    HStack {
                        CartButtonView {
                            self.showEinkaufsliste = true
                        }
                        
                        Spacer()
                        
                        PlusButtonView {
                            self.isShowingAddGericht = true
                        }
                    }
                    .padding(.horizontal)
                }
                .sheet(isPresented: $isShowingAddGericht) {
                    AddGerichtView(viewModel: viewModel)
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
    let previewViewModel = WochenplanViewModel()
    previewViewModel.wochentage = exampleWochentage

    return ContentView()
        .environmentObject(previewViewModel)
}


#Preview("Ohne Inhalt") {
    ContentView()
        .environmentObject(WochenplanViewModel())
}


