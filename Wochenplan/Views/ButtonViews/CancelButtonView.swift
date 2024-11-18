//
//  CancelButtonView.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 18.11.24.
//

import Foundation
import SwiftUI

struct CancelButtonView: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
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
    }
}
