//
//  RootView.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 08/02/2023.
//

import SwiftUI

public enum ViewName {
    case loading
    case welcome
    case home
    case userDetailView
}

struct RootView: View {
    
    @EnvironmentObject var viewModel: ViewModel
        
    var body: some View {
        ZStack {
            viewFor(viewModel.viewShown)
        }
        .preferredColorScheme(.dark)
    }
    
    @ViewBuilder func viewFor(_ viewName: ViewName) -> some View {
        switch viewModel.viewShown {
        case .loading:
            loadingView()
                .opacity(viewModel.opacity)
                .animation(.easeInOut(duration: 0.5), value: viewModel.opacity)
        case .welcome:
            WelcomeView(rootView: self)
        case .userDetailView:
            DetailsView().environmentObject(DetailsView.ViewModel(rootView: self))
        case .home:
            TabView {
                HomeView(rootView: self).environmentObject(HomeView.ViewModel())
                    .tabItem {
                        Label(Strings.tabBarLabelHome.rawValue,
                              systemImage: Images.tabBarIconHome.rawValue)
                    }
                TrialsView()
                    .tabItem {
                        Label(Strings.tabBarLabelTrials.rawValue,
                              systemImage: Images.tabBarIconTrials.rawValue)
                    }
            }
            .accentColor(.white)
        }
    }
    
    
    public func changeView(to view: ViewName) {
        DispatchQueue.main.async {
            viewModel.viewShown = view
        }
    }
    
    private struct BackgroundView: View {
        var body: some View {
            Colors.background.color
                .ignoresSafeArea()
        }
    }
    
    private struct loadingView: View {
        var body: some View {
            ZStack {
                BackgroundView()
                Text("Loading")
                    .font(Fonts.bold.font(FontSize.subtitle.rawValue))
                    .foregroundColor(Colors.text.color)
            }
        }
    }
}
