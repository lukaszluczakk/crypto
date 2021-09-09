//
//  InputTextFieldView.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 09/09/2021.
//

import SwiftUI

struct InputTextFieldView: View {
    @Binding var text: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.theme.background)
                    .shadow(color: Color.theme.accent.opacity(0.15), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
            )
    }
}

struct InputTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            InputTextFieldView(text: .constant("Button"), placeholder: "Button placeholder", keyboardType: .default)
                .preview(with: "Test default input")
        }
        
    }
}
