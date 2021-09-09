//
//  AuthenticatingService.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 20/08/2021.
//

import Foundation
import Combine

protocol AuthenticationServiceProtocol {
    func login(email: String, password: String) -> AnyPublisher<Void, Error>
    func register(email: String, password: String) -> AnyPublisher<Void, Error>
}
