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
            .navigationBarTitle(Strings.accountNavBarTitle.rawValue, displayMode: .inline)
        }
        
    }
    
    private struct SettingsAvatarView: View {
        var body: some View {
            VStack {
                Image(systemName: Images.accountDefaultImage.rawValue)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.white)
                    .padding([.leading, .trailing])
                Text(Account.shared.loggedInUser?.fullName ?? Strings.accountDefaultName.rawValue)
                    .font(Fonts.bold.font(FontSize.heading.rawValue))
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
            .ignoresSafeArea(edges: [.leading, .trailing, .bottom])
        }
    }
    
    struct MenuItemAccountListItem: View {
        var body: some View {
            HStack {
                SettingsAvatarView()
                VStack(spacing: 15) {
                    HStack {
                        Spacer()
                        Text(Strings.accountCtaUpdateInfo.rawValue)
                            .foregroundColor(.white)
                            .font(Fonts.regular.font(FontSize.body.rawValue))
                        Image(systemName: Images.accountUpdateInfo.rawValue)
                            .foregroundColor(.white)
                    }
                    HStack {
                        Spacer()
                        
                        Text(Strings.accountCtaDeleteAccount.rawValue)
                            .foregroundColor(.white)
                            .font(Fonts.regular.font(FontSize.body.rawValue))
                        Image(systemName: Images.accountDeleteAccount.rawValue)
                            .foregroundColor(.white)
                    }
                    .onTapGesture {
                        Task {
                            do {
                                try await Account.shared.logout()
                            } catch {
                                //TODO: Handle error
                            }
                        }
                    }
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
