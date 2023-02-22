//
//  HomeViewModel.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 01/02/2023.
//

import SwiftUI

extension HomeView {
    
    class ViewModel: ObservableObject {
        
        let user = Account.shared.loggedInUser
     
        @Published var activeTrials = [Trial]()
        
        @Published var showAccount = false
    }
}
