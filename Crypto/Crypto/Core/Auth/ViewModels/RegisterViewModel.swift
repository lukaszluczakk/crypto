//
//  RegisterViewModel.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 20/08/2021.
//

import Foundation

final class RegisterViewModel: ObservableObject {
    private let authenticationService: AuthenticationingService
    
    init(authenticationService: AuthenticationingService) {
        self.authenticationService = authenticationService
    }
    
    func Register(email: String, password: String) {
        authenticationService.register(email: email, password: password)
    }
}
