//
//  PrimaryButton.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 11/09/2021.
//

import SwiftUI

typealias ButtonAction = () -> Void

struct ButtonView: View {
    private let label: String
    private let action: ButtonAction
    
    init (label: String, action: @escaping ButtonAction) {
        self.label = label
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(label)
                .frame(maxWidth: .infinity, maxHeight: 50)
        })
    }
}

struct PrimaryButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ButtonView(label: "Open") { }
            .primaryButton()
            .preview(with: "Primary button")
            
            ButtonView(label: "Open") { }
            .secondaryButton()
            .preview(with: "Secondary button")
        }
        
    }
}
