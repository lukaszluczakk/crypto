//
//  AuthenticatingService.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 20/08/2021.
//

import Foundation

protocol AuthenticationingService {
    func register(email: String, password: String)
}
