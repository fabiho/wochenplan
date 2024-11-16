//
//  GerichtDetailView.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 02.11.24.
//

import SwiftUI

struct GerichtDetailView: View {
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
                            Text(zutat)
                                .listRowBackground(Color.primary)
                                .foregroundColor(Color.white)
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


