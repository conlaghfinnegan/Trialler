//
//  WelcomeView.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 07/02/2023.
//

import SwiftUI
import CloudKit
import AuthenticationServices
import CoreData

fileprivate enum Constants : String {
    case users = "Users"
    case userID
    case emailAddress
    case forename
    case surname
}

struct WelcomeView: View {
    
    var rootView: RootView?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                BackgroundView()
                VStack {
                    WelcomeTextView()
                        .padding([.top], (geometry.size.height * 0.75))
                    SignInButton(rootView: rootView)
                        .frame(height: 50, alignment: .center)
                        .padding()
                }
            }
        }
        .onAppear {
            if UserDefaults.standard.bool(forKey: Config.userDefaultsLoggedInKey) {
                Task {
                    do {
                        try await Account.shared.login()
                    } catch let error {
                        //TODO: Present error (Please login again)
                        print("Error loggin in! - \(error.localizedDescription)")
                    }
                    if Account.shared.isLoggedIn {
                        rootView?.viewShown = .home
                    }
                }
            }
        }
    }
}

private struct BackgroundView: View {
    var body: some View {
        Colors.background.color
            .ignoresSafeArea()
    }
}

private struct WelcomeTextView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(Strings.welcomeTitle.string)
                    .font(Fonts.bold.font(FontSize.title.rawValue))
                    .foregroundColor(Colors.text.color)
                Text(Strings.welcomeBody.string)
                    .lineLimit(2)
                    .font(Fonts.regular.font(FontSize.subtitle.rawValue))
                    .foregroundColor(Colors.text.color)
            }
            Spacer()
        }
        .padding([.leading, .trailing])
    }
}

private struct SignInButton: View {
    
    var rootView: RootView?
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        if colorScheme.self == .dark {
            signInWithApple(SignInWithAppleButton.Style.whiteOutline)
        }
        else {
            signInWithApple(SignInWithAppleButton.Style.black)
        }
    }
    
    private func signInWithApple(_ style: SignInWithAppleButton.Style) -> some View {
        SignInWithAppleButton(
            onRequest: { request in
                request.requestedScopes = [.email, .fullName]
            },
            onCompletion: { result in
                switch result {
                case .success(let authResults):
                    switch authResults.credential {
                    case let appleIDCredential as ASAuthorizationAppleIDCredential:
                        let userID = appleIDCredential.user
                        if let forename = appleIDCredential.fullName?.givenName,
                           let surname = appleIDCredential.fullName?.familyName,
                           let emailAddress = appleIDCredential.email {
                            //New user
                            Task {
                                do {
                                    try await Account.shared.registerAndLogin(user: User(emailAddress: emailAddress,
                                                                               forename: forename,
                                                                               surname: surname))
                                    DispatchQueue.main.async {
                                        if Account.shared.isLoggedIn {
                                            rootView?.viewShown = .home
                                        }
                                    }
                                } catch let error {
                                    //TODO: Present error
                                    print("Error loggin in! - \(error.localizedDescription)")
                                }
                                
                            }
                            
                        } else {
                            //Returning user
                            Task {
                                do {
                                    try await Account.shared.login()
                                    DispatchQueue.main.async {
                                        if Account.shared.isLoggedIn {
                                            rootView?.viewShown = .home
                                        }
                                    }
                                } catch let error {
                                    //TODO: Present error
                                    print("Error loggin in! - \(error.localizedDescription)")
                                }
                                
                            }
                        }
                    default:
                        break
                    }
                case .failure(let error):
                    print("failure", error)
                }
            }
        )
        .signInWithAppleButtonStyle(.white)
    }
}

extension User {
    public init(_ record: CKRecord) {
        self.emailAddress = record[Constants.emailAddress.rawValue] as! String
        self.forename = record[Constants.forename.rawValue] as! String
        self.surname = record[Constants.surname.rawValue] as! String
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
