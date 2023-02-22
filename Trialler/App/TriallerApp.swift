//
//  TriallerApp.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 28/01/2023.
//

import SwiftUI

@main
struct TriallerApp: App {
    
    var viewShown: ViewName = .welcome
    
    var body: some Scene {
        WindowGroup {
            RootView(viewShown: viewShown)
        }
    }
}
