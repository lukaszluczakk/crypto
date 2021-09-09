//
//  FirebaseSessionService.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 09/09/2021.
//

import Foundation
import FirebaseAuth

enum SessionState {
    case loggedIn
    case loggedOut
}

protocol SessionServiceProtocol: ObservableObject {
    var state: SessionState { get }
    var userDetails: SessionUserDetails? { get }
    func logout()
}

class FirebaseSessionService: SessionServiceProtocol {
    @Published var state: SessionState = .loggedOut
    @Published var userDetails: SessionUserDetails?
    
    private var handler: AuthStateDidChangeListenerHandle?
    
    init() {
        setupFirebaseAuthHandler()
    }
    
    func logout() {
        try? Auth.auth().signOut()
    }
}

extension FirebaseSessionService {
    func setupFirebaseAuthHandler() {
        handler = Auth.auth().addStateDidChangeListener({ [weak self] res, user in
            guard let self = self else { return }
            guard let usr = user else {
                self.userDetails = nil
                self.state = .loggedOut
                return
            }
            
            self.state = .loggedIn
            self.userDetails = SessionUserDetails(email: usr.email!)
        })
    }
}
