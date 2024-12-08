//
//  ZutatenListView.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 18.11.24.
//

import Foundation
import SwiftUI

struct ZutatenListView: View {
    @Binding var zutaten: [Zutat]
    var focusedField: FocusState<Int?>.Binding
//    var kategorien: [Kategorie]
    @ObservedObject var viewModel: WochenplanViewModel
    
    var body: some View {
        ForEach(zutaten.indices, id: \.self) { index in
            HStack {
                TextField("Zutat \(index + 1)", text: Binding(
                    get: { zutaten[index].name },
                    set: { newValue in
                        zutaten[index].name = newValue
                        if index == zutaten.count - 1 && !newValue.isEmpty {
                            zutaten.append(Zutat(name: "", erledigt: false, kategorie: nil))
                        }
                    }
                ))
                .foregroundColor(.white)
                .focused(focusedField, equals: index)
                .onSubmit {
                    if index < zutaten.count - 1 {
                        focusedField.wrappedValue = index + 1
                    }
                }
                
                Spacer()

                Menu {
                    ForEach(Kategorie.allCases, id: \.self) { kategorie in
                        Button(action: {
                            zutaten[index].kategorie = kategorie
                        })
                        {
                            Text("\(kategorie)")
                        }
                    }
                } label: {
                    HStack {
                        Text(zutaten[index].kategorie?.rawValue ?? "Kategorie")
                        Image(systemName: "chevron.down")
                    }
                    .foregroundColor(.white)
                }
            }
        }
        .onDelete { indexSet in
            zutaten.remove(atOffsets: indexSet)
            if zutaten.isEmpty {
                zutaten.append(Zutat(name: "", erledigt: false, kategorie: nil))
            }
        }
    }
}

