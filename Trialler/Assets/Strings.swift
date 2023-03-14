//
//  Strings.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 28/01/2023.
//

import Foundation

public enum Strings: String {
    
    //Tab Bar
    case tabBarLabelHome = "Home"
    case tabBarLabelTrials = "Trials"
    
    //Welcome View
    case welcomeTitle = "Welcome to Trialler."
    case welcomeBody = "To begin, tell us a few things about yourself by signing in..."
    
    //Home View
    case heroCardsSectionTitle = "Expiring soon"
    
    //User Details View
    case detailsTitle = "Tell us about yourself."
    case detailsBodyForename = "What do you prefer to be called?"
    case detailsBodySurname = "...And your surname?"
    case detailsBodyEmail = "Lastly, your email address?"
    case detailsCtaNext = "Continue"
    case detailsForenamePlaceholder = "Forename"
    case detailsSurnamePlaceholder = "Surname"
    case detailsEmailPlaceholder = "Email"
    
    //Account View
    case accountNavBarTitle = "Account"
    case accountDefaultName = "Your Account"
    case accountCtaUpdateInfo = "Update info"
    case accountCtaDeleteAccount = "Delete account"
    
    public var string: String {
        rawValue
    }
}
