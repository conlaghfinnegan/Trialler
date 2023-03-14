//
//  DetailsViewModel.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 22/02/2023.
//

import SwiftUI
import Combine

extension DetailsView {
    
    enum JourneyStage: CaseIterable {
        case forename
        case surname
        case email
        
        var detailsBodyString: String {
            switch self {
            case .forename:
                return Strings.detailsBodyForename.rawValue
            case .surname:
                return Strings.detailsBodySurname.rawValue
            case .email:
                return Strings.detailsBodyEmail.rawValue
            }
        }
    }
    
    class ViewModel: ObservableObject {
        
        var rootView: RootView?
        
        @Published var forename = String()
        @Published var surname = String()
        @Published var emailAddress = String()
        
        @Published var journeyStage: JourneyStage = .forename
        
        @FocusState var focusedField: JourneyStage?
        
        var user = Account.shared.loggedInUser
        
        init(rootView: RootView) {
            self.rootView = rootView
            forename = user?.forename ?? String()
            surname = user?.surname ?? String()
            emailAddress = user?.emailAddress ?? String()
        }
        
        func progressJourneyStage() {
            let stages = JourneyStage.allCases
            let currentStageIndex = stages.firstIndex(of: journeyStage)!
            let nextStageIndex = stages.index(after: currentStageIndex)
            journeyStage = stages[(nextStageIndex >= stages.endIndex) ? stages.endIndex : nextStageIndex]
        }
        
        func commitUserDetails() {
            Task {
                do {
                    try await Account.shared.registerAndLogin(user: User(emailAddress: emailAddress,
                                                               forename: forename,
                                                               surname: surname))
                    await rootView?.changeView(to: .home)
                } catch let error {
                    print("Error registering user - \(error)")
                    //TODO: Handle error
                }
            }
        }
    }
}
