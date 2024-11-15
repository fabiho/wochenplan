//
//  WochenplanApp.swift
//  Wochenplan
//
//  Created by Fabian Hofer on 02.11.24.
//

import SwiftUI

@main
struct WochenplanApp: App {
    @StateObject var viewModel = WochenplanViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
