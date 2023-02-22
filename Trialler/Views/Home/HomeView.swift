//
//  HomeView.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 28/01/2023.
//

//MARK: Previws
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(HomeView.ViewModel())
    }
}

//MARK: View
import SwiftUI

struct HomeView: View {
    
    var rootView: RootView?
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                VStack {
                    TopBarView()
                        .frame(height: 40)
                    WelcomeSectionView()
                        .frame(height:300)
                    BackBoxView()
                        .padding()
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $viewModel.showAccount) {
            AccountView().environmentObject(AccountView.ViewModel())
               }
    }
    
    private struct BackgroundView: View {
        var body: some View {
            Colors.background.color
                .ignoresSafeArea()
        }
    }

    private struct TopBarView: View {
        
        @EnvironmentObject var viewModel: ViewModel
        
        var body: some View {
            HStack {
                Spacer()
                Image(systemName: "person.circle")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                    .padding([.trailing, .top], 20)
                    .onTapGesture {
                        viewModel.showAccount.toggle()
                    }
            }
        }
    }

    private struct WelcomeSectionView: View {
        
        @EnvironmentObject var viewModel: ViewModel

        let activeTrials = [1,2,3]
        
        var body: some View {
            ZStack {
                VStack(alignment: .leading, spacing: 8){
                    Text("Hey \(viewModel.user?.forename ?? "there"),")
                        .font(Fonts.bold.font(FontSize.title.rawValue))
                        .foregroundColor(Colors.text.color)
                        .padding([.trailing])
                    Text("You've got 3 subscriptions expiring soon!")
                        .font(Fonts.regular.font(FontSize.subtitle.rawValue))
                        .foregroundColor(Colors.text.color)
                        .padding([.trailing, .bottom], 8)
                    HStack {
                        Text(Strings.heroCardsSectionTitle.string)
                            .font(Fonts.bold.font(FontSize.heading.rawValue))
                            .foregroundColor(Colors.text.color)
                        Spacer()
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(activeTrials, id: \.self) { trial in
                                CardView()
                                    .frame(width: 300)
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }

    private struct CardView: View {
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: RoundedCornerStyle.circular)
                    .foregroundColor(Colors.backBox.color)
            }
        }
    }
}
