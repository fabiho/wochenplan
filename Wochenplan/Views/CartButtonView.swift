//
//  CartButtonView.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 13.11.24.
//

import Foundation
import SwiftUI

public struct CartButtonView: View {
    
    @EnvironmentObject var viewModel: WochenplanViewModel
    
    let action:()->Void
    
    public var body: some View {
        NavigationLink(destination: EinkaufslisteView(viewModel: viewModel)) {
            Image(systemName: "cart.fill")
                .font(.largeTitle)
                .padding()
                .background(Color(Color(red: 38 / 255, green: 80 / 255, blue: 115 / 255)
                                 ))
                .foregroundColor(.white)
                .clipShape(Circle())
                .shadow(radius: 10)
        }
        .padding(.leading)
    }
}
