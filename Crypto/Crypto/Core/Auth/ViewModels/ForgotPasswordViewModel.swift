//
//  ForgotPasswordViewModel.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 09/09/2021.
//

import Foundation
import Combine

final class ForgotPasswordViewModel: ObservableObject {
    private let authenticationService: AuthenticationServiceProtocol
    
    private var cancellable = Set<AnyCancellable>()
    
    var email: String = ""
    
    init(authenticationService: AuthenticationServiceProtocol) {
        self.authenticationService = authenticationService
    }
    
    func forgotPassword() {
        authenticationService
            .sendPasswordReset(email: email)
            .sink { response in
                switch response {
                case .failure(let error):
                    print("Error while reseting password. \(error)")
                default: break
                }
            } receiveValue: {
                print("Sent password reset request")
            }.store(in: &cancellable)
    }
}

