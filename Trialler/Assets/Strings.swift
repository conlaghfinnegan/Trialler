//
//  Strings.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 28/01/2023.
//

import Foundation

public enum Strings: String {
    
    //Welcome View
    case welcomeTitle = "Welcome to Trialler."
    case welcomeBody = "To begin, tell us a few things about yourself by signing in..."
    
    //Home View
    case heroCardsSectionTitle = "Expiring soon"
    
    public var string: String {
        rawValue
    }
}
