//
//  RegisterViewModel.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 20/08/2021.
//

import Foundation
import Combine

enum RegistrationState {
    case successful
    case failed(error: Error)
    case na
}

final class RegisterViewModel: ObservableObject {
    private let authenticationService: AuthenticationServiceProtocol
    
    private var cancellable = Set<AnyCancellable>()
    
    var email: String = ""
    var password: String = ""
    var state: RegistrationState = .na
    
    init(authenticationService: AuthenticationServiceProtocol) {
        self.authenticationService = authenticationService
    }
    
    func register() {
        authenticationService
            .register(email: email, password: password)
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
