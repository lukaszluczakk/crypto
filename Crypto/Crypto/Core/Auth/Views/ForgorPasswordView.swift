//
//  ForgorPassword.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 09/09/2021.
//

import SwiftUI

struct ForgorPasswordView: View {
    @StateObject var vm: ForgotPasswordViewModel = ForgotPasswordViewModel(authenticationService: FirebaseAuthenticationService())
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background.ignoresSafeArea()
                VStack {
                    Image("logo-transparent")
                        .resizable()
                        .frame(width: 100, height: 100)
                    VStack(spacing: 40) {
                        HStack {
                            TextField("E-mail", text: $vm.email)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.theme.background)
                                .shadow(color: Color.theme.accent.opacity(0.15), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                        )
                        
                        ButtonView(label: "Send password reset") {
                            vm.forgotPassword()
                        }
                        .primaryButton()
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
            ForgorPasswordView()
                .preferredColorScheme(.dark)
        }
        .preferredColorScheme(.light)
    }
}
