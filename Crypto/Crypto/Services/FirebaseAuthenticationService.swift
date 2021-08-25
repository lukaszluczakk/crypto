//
//  FirebaseAuthenticationService.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 20/08/2021.
//

import Foundation
import FirebaseAuth

final class FirebaseAuthenticationService: AuthenticationingService {
    @Published var signedIn = true

    func register(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard authResult != nil, error == nil else {
                completion(false)
                return
            }
            
            completion(true)
        }
    }
}
