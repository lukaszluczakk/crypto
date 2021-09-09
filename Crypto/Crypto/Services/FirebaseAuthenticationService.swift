//
//  FirebaseAuthenticationService.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 20/08/2021.
//

import Foundation
import Combine
import FirebaseAuth

final class FirebaseAuthenticationService: AuthenticationServiceProtocol {
    func login(email: String, password: String) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                Auth.auth()
                    .signIn(withEmail: email, password: password) { res, error in
                        if let err = error {
                            promise(.failure(err))
                        } else {
                            promise(.success(()))
                        }
                    }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    func register(email: String, password: String) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let err = error {
                        promise(.failure(err))
                    }
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
