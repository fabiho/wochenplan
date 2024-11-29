//
//  EmptyEinkaufslisteView.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 22.11.24.
//

import Foundation
import SwiftUI

struct EmptyEinkaufslisteView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "cart.fill")
                .font(.system(size: 50))
                .foregroundColor(Color.gray)
            
            Text("Deine Einkaufsliste ist leer. Plane zuerst deine Woche.")
                .font(.body)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding()
            
            Spacer()
        }
        .navigationTitle("Einkaufsliste")
    }
}
