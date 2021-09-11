//
//  ForgorPassword.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 09/09/2021.
//

import SwiftUI

struct ForgotPasswordView: View {
    @StateObject var vm: ForgotPasswordViewModel = ForgotPasswordViewModel(authenticationService: FirebaseAuthenticationService())
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background.ignoresSafeArea()
                VStack {
                    logo
                    VStack() {
                        InputTextFieldView(text: $vm.email, placeholder: "E-mail", keyboardType: .emailAddress)
                        sendPasswordResetButton
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    }
                    .font(.headline)
                    .foregroundColor(Color.theme.accent)
                    .padding()
                }
            }
        }
        .navigationTitle("Reset password")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                XMarkButton()
            }
        }
    }
}

struct ForgorPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ForgotPasswordView()
                .preferredColorScheme(.dark)
        }
        .preferredColorScheme(.light)
    }
}

extension ForgotPasswordView {
    private var logo: some View {
        Image("logo-transparent")
            .resizable()
            .frame(width: 100, height: 100)
    }
    
    private var sendPasswordResetButton: some View {
        ButtonView(label: "Send password reset") {
            vm.forgotPassword()
        }
        .primaryButton()
    }
}
