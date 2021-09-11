//
//  SecondaryButtonModifier.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 11/09/2021.
//

import SwiftUI

struct SecondaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color.theme.accent)
            .background(Color.theme.background)
            .cornerRadius(20)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.theme.accent, lineWidth: 2))
    }
}

extension View {
    func secondaryButton() -> some View {
        self.modifier(SecondaryButtonModifier())
    }
}
