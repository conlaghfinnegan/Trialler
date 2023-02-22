//
//  RootView.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 08/02/2023.
//

import SwiftUI

public enum ViewName {
    case welcome
    case home
}

struct RootView: View {
    
    @ObservedObject var account = Account.shared
    
//    @State var isLoggedIn = Account.shared.isLoggedIn {
//        didSet {
//            print("Subscriber received \(isLoggedIn)")
//        }
//    }
    
    @State var viewShown: ViewName
    
    var body: some View {
        if !account.isLoggedIn {
            WelcomeView(rootView: self)
                .preferredColorScheme(.dark)
        } else {
            switch viewShown {
            case .welcome:
                WelcomeView(rootView: self)
                    .preferredColorScheme(.dark)
            case .home:
                TabView {
                    HomeView(rootView: self).environmentObject(HomeView.ViewModel())
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                    TrialsView()
                        .tabItem {
                            Label("Trials", systemImage: "clock.fill")
                        }
                }
                .preferredColorScheme(.dark)
                .accentColor(.white)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewShown: .home)
    }
}
