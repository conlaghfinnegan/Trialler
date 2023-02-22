//
//  AccountView.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 15/02/2023.
//

import SwiftUI

struct AccountView: View {
    
    public enum MenuItem {
        case account
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                VStack {
                    SettingsAvatarView()
                    ZStack {
                        BackBoxView()
                        VStack {
                            
                            SettingsListView()
                        }
                    }
                    .padding(10)
                    .frame(height: 300)
                    Spacer()
                }
            }
            .navigationBarTitle("Account", displayMode: .inline)
        }
        
    }
    
    private struct SettingsAvatarView: View {
        var body: some View {
            VStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .padding([.leading, .trailing])
                    .padding([.top], 20)
                Text(Account.shared.loggedInUser?.fullName ?? "Your account")
                    .font(Fonts.bold.font(FontSize.title.rawValue))
                    .foregroundColor(Colors.text.color)
            }
        }
    }
    
    struct SettingsListView: View {
        
        @EnvironmentObject var viewModel: ViewModel

        var body: some View {
                List {
                    ForEach(viewModel.menuItems, id: \.self) { menuItem in
                        menuListItemView(for: menuItem)
                    }
                    .listRowBackground(Colors.background.color)
                }
                .listRowSeparator(.visible)
                .listRowSeparatorTint(.white, edges: .bottom)
                .scrollContentBackground(.hidden)
        }
        
        @ViewBuilder private func menuListItemView(for menuItem: MenuItem) -> some View {
            switch menuItem {
            case .account: MenuItemAccountListItem()
            }
        }
    }
    
    private struct BackgroundView: View {
        var body: some View {
            Colors.background.color
            .ignoresSafeArea(edges: [.leading, .trailing, .bottom])        }
    }
    
    struct MenuItemAccountListItem: View {
        var body: some View {
            VStack(spacing: 15) {
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.forward.fill")
                        .foregroundColor(.white)
                    Text("Sign out")
                        .foregroundColor(.white)
                        .font(Fonts.regular.font(FontSize.subtitle.rawValue))
                        .onTapGesture {
                            Task {
                                do {
                                    try await Account.shared.logout()
                                } catch {
                                    //TODO: Handle error
                                }
                            }
                        }
                    Spacer()
                }
                HStack {
                    Image(systemName: "exclamationmark.icloud.fill")
                        .foregroundColor(.white)
                    Text("Delete account")
                        .foregroundColor(.white)
                        .font(Fonts.regular.font(FontSize.subtitle.rawValue))
                    Spacer()
                }
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView().environmentObject(AccountView.ViewModel())
    }
}
