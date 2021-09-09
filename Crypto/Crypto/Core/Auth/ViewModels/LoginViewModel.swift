//
//  LoginViewModel.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 09/09/2021.
//

import Foundation

import Foundation
import Combine

enum LoginState {
    case successful
    case failed(error: Error)
    case na
}

final class LoginViewModel: ObservableObject {
    private let authenticationService: AuthenticationServiceProtocol
    
    private var cancellable = Set<AnyCancellable>()
    
    var email: String = ""
    var password: String = ""
    var state: LoginState = .na
    
    init(authenticationService: AuthenticationServiceProtocol) {
        self.authenticationService = authenticationService
    }
    
    func login() {
        authenticationService
            .login(email: email, password: password)
            .sink { [weak self] response in
                switch response {
                case .failure(let error):
                    self?.state = .failed(error: error)
                default: break
                }
            } receiveValue: { [weak self] in
                self?.state = .successful
            }.store(in: &cancellable)
    }
}
