//
//  EmptyWochenplanView.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 29.11.24.
//

import Foundation
import SwiftUI

struct EmptyWochenplanView: View {
    var body: some View {
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
    }
}
