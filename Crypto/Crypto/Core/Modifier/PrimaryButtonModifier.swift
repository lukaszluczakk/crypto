//
//  ButtonModifier.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 09/09/2021.
//

import SwiftUI

struct PrimaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.theme.accent)
            .foregroundColor(Color.theme.background)
            .cornerRadius(25)
    }
}

extension View {
    func primaryButton() -> some View {
        
        self.modifier(PrimaryButtonModifier())
    }
}
