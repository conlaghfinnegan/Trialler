//
//  HomeView.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 28/01/2023.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    var body: some View {
        Text("Home View")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
