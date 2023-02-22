//
//  Colors.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 28/01/2023.
//

import Foundation
import SwiftUI

public enum Colors: String {
    
    case background
    case text
    case backBox
    case shadow
//    case backgroundColor
//    case backgroundColor
    ///
    public var color: Color {
        Color(self.rawValue)
    }
    
}
