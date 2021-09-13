//
//  CryptoUITests.swift
//  CryptoUITests
//
//  Created by Łukasz Łuczak on 12/09/2021.
//

import XCTest
@testable import Crypto

class HomeViewTests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append(CommandLineArgument.uiTestMockAuthentication.rawValue)
        app.launch()
    }
    
    func testSearchHBTC() throws {
        app.logIn()
        let hbtc = "HBTC"
        let searchTextField = app.textFields["SearchTextField"]
        searchTextField.tap()
        searchTextField.typeText(hbtc)
        let coinSymbolTextsCount = app.staticTexts.matching(identifier: "CoinSymbolText").count
        let coinSymbolTextLabel = app.staticTexts["CoinSymbolText"].label
        XCTAssertEqual(1, coinSymbolTextsCount)
        XCTAssertEqual(hbtc, coinSymbolTextLabel)
    }
}
