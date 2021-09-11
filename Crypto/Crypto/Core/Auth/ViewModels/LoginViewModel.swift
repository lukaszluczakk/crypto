//
//  LoginViewModel.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 09/09/2021.
//

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
    
    @Published var state: LoginState = .na
    @Published var hasError: Bool = false
    var email: String = ""
    var password: String = ""
    
    init(authenticationService: AuthenticationServiceProtocol) {
        self.authenticationService = authenticationService
        setupErrorSubscriptions()
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

extension LoginViewModel {
    func setupErrorSubscriptions() {
        $state.map { state -> Bool in
            switch state {
            case .successful, .na:
                return false
            case .failed:
                return true
            }
        }.assign(to: &$hasError)
    }
}
