//
//  TriallerApp.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 28/01/2023.
//

import SwiftUI

@main
struct TriallerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
