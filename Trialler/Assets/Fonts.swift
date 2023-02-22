//
//  Fonts.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 28/01/2023.
//

import Foundation
import SwiftUI

public enum FontSize: CGFloat {
    case title = 18
    case subtitle = 16
    case heading = 14
    case body = 12
}

public enum Fonts: String {
    
    case regular = "ArialRoundedMT"
    case bold = "ArialRoundedMTBold"
    case extraBold = "ArialRoundedMT-ExtraBold"
    case light = "ArialRoundedMT-Light"
    
    public func font(_ size: CGFloat) -> Font {
        Font.custom(rawValue, size: size)
    }
}
