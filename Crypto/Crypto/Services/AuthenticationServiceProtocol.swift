//
//  AuthenticatingService.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 20/08/2021.
//

import Foundation

typealias AuthenticationingServiceRegisterCompletion = (AuthenticationResult) -> Void

protocol AuthenticationServiceProtocol {
    var IsLogged: Published<Bool>.Publisher { get }
    func register(email: String, password: String, completion: @escaping AuthenticationingServiceRegisterCompletion)
}

enum AuthenticationResult {
    case successfully
    case failed(errorMessage: String)
}
