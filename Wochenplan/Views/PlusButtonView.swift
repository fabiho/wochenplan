//
//  PlusButtonView.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 13.11.24.
//

import Foundation
import SwiftUI

struct PlusButtonView:View {
    let action:()->Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: "plus")
                .font(.largeTitle)
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .clipShape(Circle())
                .shadow(radius: 10)
        }
        .padding(.trailing)
    }
}


