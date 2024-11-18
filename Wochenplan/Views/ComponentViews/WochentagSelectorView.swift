//
//  WochentagSelectorView.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 18.11.24.
//

import Foundation
import SwiftUI

struct WochentagSelectorView: View {
    let wochentage: [Wochentag]
    @Binding var selectedIndex: Int

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(0..<wochentage.count, id: \.self) { index in
                    Button(action: {
                        selectedIndex = index
                    }) {
                        Text(wochentage[index].name)
                            .padding(10)
                            .background(selectedIndex == index ? Color.secondary : Color.secondary.opacity(0.4))
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
    }
}
