//
//  TestSessionService.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 12/09/2021.
//

import Foundation
import Combine

final class TestSessionService: SessionService {
    private var cancellable = Set<AnyCancellable>()
    
    override init() {
        super.init()
        self.setupTestAuthHandler()
    }
    
    override func logout() {
        state = .loggedOut
    }
}

extension TestSessionService {
    func setupTestAuthHandler() {
        TestAuthenticationService.addStateDidChangeListener.sink { response in
            print(response)
        } receiveValue: { [weak self] in
            guard let self = self else { return }
            self.state = .loggedIn
        }.store(in: &cancellable)
    }
}
