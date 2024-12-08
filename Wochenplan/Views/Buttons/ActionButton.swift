//
//  ActionButtonView.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 15.11.24.
//

import Foundation
import SwiftUI

public struct ActionButton: View {
    @EnvironmentObject var viewModel: WochenplanViewModel
    
    let action:()->Void
    
    public var body: some View {
        
        HStack(spacing:0){
            
            // Linke Seite (Cart)
            NavigationLink(destination: EinkaufslisteView(viewModel: viewModel)) {
                Image(systemName: "cart.fill")
                    .font(.title)
                    .padding()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.secondary)
            }
            .buttonStyle(PlainButtonStyle())
            
            Rectangle()
                .frame(width: 1)
                .foregroundColor(.white)
            
            // Rechte Seite (Plus)
            Button(action: {
                action()
            }) {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .padding()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.secondary)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 180, height: 50)
        .clipShape(Capsule())
        .shadow(radius: 5)
        
    }
}



