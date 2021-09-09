//
//  UserData.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 06/09/2021.
//

import Foundation

class UserData: ObservableObject {
    private let authenticationService: AuthenticationServiceProtocol
    
    @Published var IsLogged: Bool = false

    init(authenticationService: AuthenticationServiceProtocol) {
        self.authenticationService = authenticationService
    }
    
    
}
