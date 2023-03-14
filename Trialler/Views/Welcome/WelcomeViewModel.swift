//
//  WelcomeViewModel.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 10/02/2023.
//

import Foundation

extension WelcomeView {
    
    class ViewModel: ObservableObject {
        
        @Published var loggedInUser: User?
    }
}
