//
//  PlaceholderView.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 08/03/2023.
//

import SwiftUI

struct PlaceholderModifier<Placeholder>: ViewModifier where Placeholder : View {
    let isShowing: Bool
    @ViewBuilder let placeholder: () -> Placeholder
    
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            placeholder()
                .opacity(isShowing ? 1 : 0) // retains placeholder size even when it's hidden
            content
        }
    }
}

extension View {
    func placeholder<Placeholder>(isShowing: Bool,
                                  @ViewBuilder placeholder: @escaping () -> Placeholder) -> some View
    where Placeholder : View {
        modifier(PlaceholderModifier(isShowing: isShowing, placeholder: placeholder))
    }
}
