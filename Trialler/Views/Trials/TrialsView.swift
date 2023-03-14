//
//  TrialsView.swift
//  Trialler
//
//  Created by Conlagh Finnegan on 20/02/2023.
//

import SwiftUI

struct TrialsView: View {
    var body: some View {
        ZStack {
            BackgroundView()
        }
    }
    
    private struct BackgroundView: View {
        var body: some View {
            Colors.background.color
            .ignoresSafeArea()
        }
    }
}

struct TrialsView_Previews: PreviewProvider {
    static var previews: some View {
        TrialsView()
    }
}
