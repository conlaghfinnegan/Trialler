//
//  Images.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 07/02/2023.
//

import Foundation
import SwiftUI

public enum Images: String {
    
    case homeBanner
    
    //TabBar
    case tabBarIconHome = "house.fill"
    case tabBarIconTrials = "clock.fill"
    
    //Details View
    case detailsTextFieldContinue = "arrow.right.circle"
    
    //Account View
    case accountDefaultImage = "person.circle"
    case accountUpdateInfo = "person.text.rectangle.fill"
    case accountDeleteAccount = "exclamationmark.icloud.fill"
    
    ///
    public var image: Image {
        Image(rawValue)
    }
}
