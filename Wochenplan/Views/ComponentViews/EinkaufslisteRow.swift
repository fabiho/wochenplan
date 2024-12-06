//
//  EinkaufslisteRow.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 22.11.24.
//

import Foundation
import SwiftUI

struct EinkaufslisteRow: View {
    var zutat: Zutat
    var isChecked: Bool 
    var toggleAction: () -> Void

    var body: some View {
        HStack {
            Button(action: toggleAction) {
                Image(systemName: isChecked ? "checkmark.square" : "square")
                    .foregroundColor(isChecked ? Color.primary : .gray)
            }

            Text(zutat.name)
                .strikethrough(isChecked, color: .gray)
                .foregroundColor(isChecked ? .gray : .white)

            Spacer()

            Image("bread")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 30)
        }
    }
}




