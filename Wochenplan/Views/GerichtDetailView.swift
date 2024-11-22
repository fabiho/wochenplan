//
//  GerichtDetailView.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 02.11.24.
//

import SwiftUI

struct GerichtDetailView: View {
    @EnvironmentObject var viewModel: WochenplanViewModel
    var gericht: Gericht
    var wochentag: Wochentag
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .leading, spacing: 10) {
                
                Text(gericht.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                HStack{
                    Image(systemName: "calendar")
                    Text((wochentag.name))
                        .font(.title3)
                }
                .foregroundStyle(Color.gray)
                
                List {
                    Section(header: Text("Zutaten")
                        .font(.headline)
                    ) {
                        ForEach(gericht.zutaten, id: \.self) { zutat in
                            HStack {
                                Text(zutat)
                                Spacer()
                                Image("bread") // Icon der Kategorie
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 30)
                            }
                            .listRowBackground(Color.primary)
                            .foregroundColor(Color.white)
                        }
                        .onDelete { indexSet in
                            if let index = indexSet.first {
                                let zutatToDelete = gericht.zutaten[index]
                                viewModel.deleteZutat(from: gericht, in: wochentag, zutat: zutatToDelete)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .padding()
            .navigationTitle("Gerichtdetails")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


