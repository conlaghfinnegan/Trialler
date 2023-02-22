//
//  User.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 07/02/2023.
//

import Foundation

public struct User {
    public let emailAddress: String
    public let forename: String
    public let surname: String
    
    public var fullName: String {
        forename + " " + surname
    }
    
}
