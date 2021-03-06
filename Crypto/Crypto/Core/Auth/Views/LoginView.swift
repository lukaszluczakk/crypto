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
    
    @StateObject var vm: LoginViewModel = LoginViewModel(authenticationService: AuthenticationServiceFactory.getService())
    
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
                        VStack(spacing: 20) {
                            loginButton
                            registerButton
                        }.padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                    }
                    .sheet(isPresented: $showRegistration, content: {
                        NavigationView {
                            RegisterView()
                                .accessibilityIdentifier("RegisterView")
                        }
                    })
                    .sheet(isPresented: $showResetPasswordView, content: {
                        NavigationView {
                            ForgotPasswordView()
                                .accessibilityIdentifier("ForgotPasswordView")
                        }
                    })
                    .font(.headline)
                    .foregroundColor(Color.theme.accent)
                    .padding()
                }
            }
        }
        .navigationTitle("Login")
        .alert(isPresented: $vm.hasError, content: {
            if case .failed(let error) = vm.state {
                return Alert(title: Text("Error"), message: Text(error.localizedDescription))
            } else {
                return Alert(title: Text("Error"), message: Text("Something went wrong"))
            }
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
                .preferredColorScheme(.dark)
        }
        .preferredColorScheme(.dark)
    }
}

extension LoginView {
    private var logo: some View {
        Image("logo-transparent")
            .resizable()
            .frame(width: 100, height: 100)
    }
    
    private var loginButton: some View {
        ButtonView(label: "Login") {
            vm.login()
        }
        .primaryButton()
    }
    
    private var registerButton: some View {
        ButtonView(label: "Register") {
            showRegistration.toggle()
        }
        .secondaryButton()
    }
    
    private var forgotPasswordButton: some View {
        Button(action: {
            showResetPasswordView.toggle()
        }, label: {
            Text("Forgot password?")
        })
    }
}
