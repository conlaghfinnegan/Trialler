//
//  RootViewModel.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 01/03/2023.
//

import SwiftUI
import Combine

extension RootView {
    class ViewModel: ObservableObject {
        
        private var subscriptions: Set<AnyCancellable> = []
        
        @Published var viewShown: ViewName = .welcome {
            willSet {
                opacity = .zero
            }
            didSet {
                opacity = 1
            }
        }
        
        @Published var opacity: Double = .zero
        
        init() {
            guard let userPublisher = Account.shared.userPublisher else { return }
            userPublisher.receive(on: RunLoop.main)
                .sink { [weak self] in
                    if $0 == nil {
                        self?.viewShown = .welcome
                    }
                }
                .store(in: &subscriptions)
        }
        
    }
}
