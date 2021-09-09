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
                    Image("logo-transparent")
                        .resizable()
                        .frame(width: 100, height: 100)
                    VStack(spacing: 40) {
                        InputTextFieldView(text: $vm.email, placeholder: "E-mail", keyboardType: .emailAddress)
                        HStack {
                            TextField("Password", text: $vm.password)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.theme.background)
                                .shadow(color: Color.theme.accent.opacity(0.15), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                        )
                        HStack() {
                            Spacer()
                            Button(action: {
                                showResetPasswordView.toggle()
                            }, label: {
                                Text("Forgot password?")
                            })
                        }
                        Button(action: {
                            vm.login()
                        }, label: {
                            HStack {
                                Text("Login")
                                    .foregroundColor(Color.black)
                            }
                            .frame(width: 200)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(25)
                        })
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
