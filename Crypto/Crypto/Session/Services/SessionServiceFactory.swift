//
//  SessionServiceFactory.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 12/09/2021.
//

import Foundation

class SessionServiceFactory {
    static func getService() -> SessionService {
        if CommandLine.hasUITestMockAuthenticationArgument() {
            return TestSessionService()
        }
        
        return TestSessionService()
    }
}
