//
//  RegisterView.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 07/09/2021.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var vm: RegisterViewModel = RegisterViewModel(authenticationService: FirebaseAuthenticationService())
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background.ignoresSafeArea()
                VStack {
                    logo
                    VStack(spacing: 20) {
                        InputTextFieldView(text: $vm.email, placeholder: "E-mail", keyboardType: .emailAddress)
                        InputPasswordView(text: $vm.password, placeholder: "Password")
                        registerButton
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    }
                    .font(.headline)
                    .foregroundColor(Color.theme.accent)
                    .padding()
                }
            }
        }
        .navigationTitle("Register")
        .alert(isPresented: $vm.hasError, content: {
            if case .failed(let error) = vm.state {
                return Alert(title: Text("Error"), message: Text(error.localizedDescription))
            } else {
                return Alert(title: Text("Error"), message: Text("Something went wrong"))
            }
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                XMarkButton()
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegisterView()
                .preferredColorScheme(.dark)
        }
        .preferredColorScheme(.light)
        .navigationTitle("Register")
    }
}

extension RegisterView {
    private var logo: some View {
        Image("logo-transparent")
            .resizable()
            .frame(width: 100, height: 100)
    }
    
    private var registerButton: some View {
        ButtonView(label: "Register") {
            vm.register()
        }.primaryButton()
    }
}
