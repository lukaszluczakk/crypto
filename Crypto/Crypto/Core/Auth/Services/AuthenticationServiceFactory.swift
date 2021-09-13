//
//  AuthenticationServiceFactory.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 12/09/2021.
//

import Foundation

class AuthenticationServiceFactory {
    static func getService() -> AuthenticationServiceProtocol {
        if CommandLine.hasUITestMockAuthenticationArgument() {
            return TestAuthenticationService()
        }
        
        return FirebaseAuthenticationService()
    }
}
