//
//  FirebaseAuthenticationService.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 20/08/2021.
//

import Foundation
import FirebaseAuth

final class FirebaseAuthenticationService: AuthenticationServiceProtocol {
    private var authListener: AuthStateDidChangeListenerHandle?
    
    var IsLogged: Published<Bool>.Publisher { $IsLoggedInternal }
    
    @Published private(set) var IsLoggedInternal: Bool = false
    
    init() {
        authListener = Auth.auth().addStateDidChangeListener { [weak self] (auth, user) in
            if user != nil {
                self?.IsLoggedInternal = true
            } else {
                self?.IsLoggedInternal = false
            }
        }
    }
    
    deinit {
        if let listener = authListener {
            Auth.auth().removeStateDidChangeListener(listener)
        }
    }
    
    func register(email: String, password: String, completion: @escaping AuthenticationingServiceRegisterCompletion) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard authResult != nil, error == nil else {
                completion(.failed(errorMessage: "Something goes wrong"))
                return
            }
            
            completion(.successfully)
        }
    }
}
