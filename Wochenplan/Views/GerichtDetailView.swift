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
            
            Color(Color(red: 236 / 255, green: 244 / 255, blue: 214 / 255))
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 10) {
                
                Text(gericht.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Wochentag: \(wochentag.name)")
                    .font(.title3)
                    .foregroundColor(.gray)
                
                List {
                    Section(header: Text("Zutaten")
                        .font(.headline)
                        .foregroundColor(.primary)
                    ) {
                        ForEach(gericht.zutaten, id: \.self) { zutat in
                            Text(zutat)
                                .listRowBackground(Color(red: 45 / 255, green: 149 / 255, blue: 150 / 255))
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


