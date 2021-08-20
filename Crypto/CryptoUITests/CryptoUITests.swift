//
//  CryptoUITests.swift
//  CryptoUITests
//
//  Created by Łukasz Łuczak on 07/08/2021.
//

import XCTest

class CryptoUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLivePricesAsInitialText() throws {
        let homeTitle = app.staticTexts["HomeTitle"]
        XCTAssertEqual("Live prices", homeTitle.label)
    }
    
    func testSearchHBTC() throws {
        let hbtc = "HBTC"
        let searchTextField = app.textFields["SearchTextField"]
        searchTextField.tap()
        searchTextField.typeText(hbtc)
        sleep(1)
        let coinSymbolTextsCount = app.staticTexts.matching(identifier: "CoinSymbolText").count
        let coinSymbolTextLabel = app.staticTexts["CoinSymbolText"].label
        XCTAssertEqual(1, coinSymbolTextsCount)
        XCTAssertEqual(hbtc, coinSymbolTextLabel)
    }
}
