//
//  CryptoUITests.swift
//  CryptoUITests
//
//  Created by Łukasz Łuczak on 07/08/2021.
//

import XCTest
@testable import Crypto

class LoginViewTests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testTapOnRegisterButtonShouldOpenSheet(){
        app.buttons["Register"].tap()
        let registerView = app.otherElements["RegisterView"]
        XCTAssertTrue(registerView.exists)
    }
    
    func testTapOnForgotPasswordButtonShouldOpenSheet(){
        app.buttons["Forgot password?"].tap()
        let registerView = app.otherElements["ForgotPasswordView"]
        XCTAssertTrue(registerView.exists)
    }
    
    func testAlertShouldBeVisibleIfLoginAndPasswordAreEmpty() {
        app.logIn()
        let alert = app.alerts["Error"]
        XCTAssertTrue(alert.exists)
    }
    
//    func testSearchHBTC() throws {
//        let hbtc = "HBTC"
//        let searchTextField = app.textFields["SearchTextField"]
//        searchTextField.tap()
//        searchTextField.typeText(hbtc)
//        sleep(1)
//        let coinSymbolTextsCount = app.staticTexts.matching(identifier: "CoinSymbolText").count
//        let coinSymbolTextLabel = app.staticTexts["CoinSymbolText"].label
//        XCTAssertEqual(1, coinSymbolTextsCount)
//        XCTAssertEqual(hbtc, coinSymbolTextLabel)
//    }
}
