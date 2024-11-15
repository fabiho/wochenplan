//
//  ActionButtonView.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 15.11.24.
//

import Foundation
import SwiftUI

public struct ActionButtonView: View {
    @EnvironmentObject var viewModel: WochenplanViewModel
    
    let action:()->Void
    
    public var body: some View {
        
        HStack(spacing:0){
            
            // Linke Seite (Cart)
            NavigationLink(destination: EinkaufslisteView(viewModel: viewModel)) {
                Image(systemName: "cart.fill")
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color(Color(red: 38 / 255, green: 80 / 255, blue: 115 / 255)))
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
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color(Color(red: 38 / 255, green: 80 / 255, blue: 115 / 255)))
            }
            .buttonStyle(PlainButtonStyle())
        }
        .frame(width: 180, height: 60)
        .clipShape(Capsule())
        
    }
}



