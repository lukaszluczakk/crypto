//
//  RegisterView.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 20/08/2021.
//

import SwiftUI

struct LoginView: View {
    @State var showRegistration: Bool = false
    @State var showResetPasswordView: Bool = false
    
    @StateObject var vm: LoginViewModel = LoginViewModel(authenticationService: FirebaseAuthenticationService())
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.theme.background.ignoresSafeArea()
                VStack {
                    logo
                    VStack(spacing: 20) {
                        InputTextFieldView(text: $vm.email, placeholder: "E-mail", keyboardType: .emailAddress)
                        InputPasswordView(text: $vm.password, placeholder: "Password")
                        HStack() {
                            Spacer()
                            forgotPasswordButton
                        }
                        loginButton
                        registerButton
                    }
                    .sheet(isPresented: $showRegistration, content: {
                        NavigationView {
                            RegisterView()
                        }
                    })
                    .sheet(isPresented: $showResetPasswordView, content: {
                        NavigationView {
                            ForgorPasswordView()
                        }
                    })
                    .font(.headline)
                    .foregroundColor(Color.theme.accent)
                    .padding()
                }
            }
        }
        .navigationTitle("Login")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
                .preferredColorScheme(.dark)
        }
    }
}

extension LoginView {
    private var logo: some View {
        Image("logo-transparent")
            .resizable()
            .frame(width: 100, height: 100)
    }
    
    private var loginButton: some View {
        Button(action: {
            vm.login()
        }, label: {
            HStack {
                Text("Login")
                    .foregroundColor(Color.black)
            }
            .frame(width: 200)
            .padding()
            .background(Color.white.opacity(0.7))
            .cornerRadius(25)
        })
    }
    
    private var registerButton: some View {
        Button(action: {
            showRegistration.toggle()
        }, label: {
            HStack {
                Text("Register")
                    .foregroundColor(Color.black)
            }
            .frame(width: 200)
            .padding()
            .background(Color.white.opacity(0.7))
            .cornerRadius(25)
        })
    }
    
    private var forgotPasswordButton: some View {
        Button(action: {
            showResetPasswordView.toggle()
        }, label: {
            Text("Forgot password?")
        })
    }
}
