//
//  FirebaseSessionService.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 09/09/2021.
//

import Foundation
import FirebaseAuth
import Combine

enum SessionState {
    case loggedIn
    case loggedOut
}

class SessionService: ObservableObject {
    @Published var state: SessionState = .loggedOut
    @Published var userDetails: SessionUserDetails?
    
    func logout() {
        fatalError("This method must be overridden")
    }
}

class FirebaseSessionService: SessionService {

    private var handler: AuthStateDidChangeListenerHandle?
    
    override init() {
        super.init()
        self.setupFirebaseAuthHandler()
    }
    
    override func logout() {
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
