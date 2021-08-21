//
//  RegisterView.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 20/08/2021.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var vm: RegisterViewModel = RegisterViewModel(authenticationService: FirebaseAuthenticationService())
    
    var body: some View {
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
                    HStack {
                        TextField("Password", text: $vm.password)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.theme.background)
                            .shadow(color: Color.theme.accent.opacity(0.15), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                    )
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        HStack {
                            Text("Register")
                                .foregroundColor(Color.black)
                        }
                        .frame(width: 200)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                    })
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        HStack {
                            Text("Back to login")
                                .foregroundColor(Color.black)
                        }
                        .frame(width: 200)
                        .padding()
                        .background(Color.white.opacity(0.7))
                        .cornerRadius(25)
                    })
                }
                
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .padding()
                
                
            }
            
            
        }
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .preferredColorScheme(.dark)
    }
}
