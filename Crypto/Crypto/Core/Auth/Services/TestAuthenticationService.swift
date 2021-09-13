//
//  TestAuthenticationService.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 12/09/2021.
//

import Foundation
import Combine

final class TestAuthenticationService: AuthenticationServiceProtocol {
    
    private static var subject = PassthroughSubject<Void, Error>()
    
    static let addStateDidChangeListener: AnyPublisher<Void, Error> = subject.eraseToAnyPublisher()
    
    func login(email: String, password: String) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                promise(.success(()))
                Self.subject.send()
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    func register(email: String, password: String) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                promise(.success(()))
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    func sendPasswordReset(email: String) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                promise(.success(()))
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
