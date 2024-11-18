//
//  ZutatenListView.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 18.11.24.
//

import Foundation
import SwiftUI

struct ZutatenListView: View {
    @Binding var zutaten: [String]
    var focusedField: FocusState<Int?>.Binding

    var body: some View {
        ForEach(zutaten.indices, id: \.self) { index in
            TextField("Zutat \(index + 1)", text: Binding(
                get: { zutaten[index] },
                set: { newValue in
                    zutaten[index] = newValue
                    if index == zutaten.count - 1 && !newValue.isEmpty {
                        zutaten.append("")
                    }
                }
            ))
            .foregroundColor(.white)
            .focused(focusedField, equals: index)
            .onSubmit {
                if index < zutaten.count - 1 {
                    focusedField.wrappedValue = index + 1
                } else if index == zutaten.count - 1 && !zutaten[index].isEmpty {
                    zutaten.append("")
                    focusedField.wrappedValue = zutaten.count - 1
                }
            }
        }
        .onDelete { indexSet in
            zutaten.remove(atOffsets: indexSet)
            if zutaten.isEmpty {
                zutaten.append("")
            }
        }
    }
}

