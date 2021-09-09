//
//  RegisterViewModel.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 20/08/2021.
//

import Foundation

final class RegisterViewModel: ObservableObject {
    //@Published var state: RegistrationState? = nil
    @Published var email: String = ""
    @Published var password: String = ""
    
    private let authenticationService: AuthenticationServiceProtocol
    
    init(authenticationService: AuthenticationServiceProtocol) {
        self.authenticationService = authenticationService
    }
    
    func Register(email: String, password: String) {
        authenticationService.register(email: email, password: password) { [weak self] result in
            
            //self?.registered = result
        }
    }
}
