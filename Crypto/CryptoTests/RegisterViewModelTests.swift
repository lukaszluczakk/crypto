//
//  RegisterViewModelTests.swift
//  CryptoTests
//
//  Created by Łukasz Łuczak on 25/08/2021.
//

import XCTest
import Combine
@testable import Crypto

class RegisterViewModelTest: XCTestCase {
    
    func testSuccessfullyRegistration() {
        let authenticationService = AuthenticationServiceMock(completionValue: true)
        let vm = RegisterViewModel(authenticationService: authenticationService)
        let exp = expectation(description: "Wait for returns")
        var cancellable = Set<AnyCancellable>()
        
        vm.$registered.sink { value in
            guard value == true else { return }
            exp.fulfill()
        }.store(in: &cancellable)
        
        vm.Register(email: "asd", password: "asd")
        wait(for: [exp], timeout: 0.1)
        XCTAssertTrue(vm.registered!)
    }
    
    func testFailedRegistration() {
        let authenticationService = AuthenticationServiceMock(completionValue: false)
        let vm = RegisterViewModel(authenticationService: authenticationService)
        let exp = expectation(description: "Wait for returns")
        var cancellable = Set<AnyCancellable>()
        
        vm.$registered.sink { value in
            guard value == false else { return }
            exp.fulfill()
        }.store(in: &cancellable)
        
        vm.Register(email: "asd", password: "asd")
        wait(for: [exp], timeout: 0.1)
        XCTAssertFalse(vm.registered!)
    }
    
    class AuthenticationServiceMock: AuthenticationingService {
        private let completionValue: Bool
        
        init(completionValue: Bool) {
            self.completionValue = completionValue
        }
        
        func register(email: String, password: String, completion: @escaping (Bool) -> Void) {
            completion(completionValue)
        }
    }
}
