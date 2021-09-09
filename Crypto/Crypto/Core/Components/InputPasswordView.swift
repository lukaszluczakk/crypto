//
//  InputPasswordView.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 09/09/2021.
//

import SwiftUI

struct InputPasswordView: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        SecureField(placeholder, text: $text)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.theme.background)
                    .shadow(color: Color.theme.accent.opacity(0.15), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
            )
    }
}

struct InputPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        InputPasswordView(text: .constant(""), placeholder: "Password")
            .preview(with: "Password input")
    }
}
