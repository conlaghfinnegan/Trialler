//
//  TriallerApp.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 28/01/2023.
//

import SwiftUI

@main
struct TriallerApp: App {
    
    let rootView = RootView()
    
    var body: some Scene {
        WindowGroup {
            rootView.environmentObject(RootView.ViewModel())
        }
    }
}
