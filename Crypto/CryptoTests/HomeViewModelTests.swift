//
//  HomeViewModelTests.swift
//  CryptoTests
//
//  Created by Łukasz Łuczak on 15/09/2021.
//

import XCTest
import Combine
@testable import Crypto

class HomeViewModelTests: XCTestCase {
    func testAllCoinsShouldBeSortedByRankAsDefaultFilter(){
        let coin1 = CoinModelHelper.createCoinModel(id: "1", marketCapRank: 1, currentPrice: 1)
        let coin2 = CoinModelHelper.createCoinModel(id: "2", marketCapRank: 2, currentPrice: 2)
        let coin3 = CoinModelHelper.createCoinModel(id: "3", marketCapRank: 3, currentPrice: 3)
        
        let coinDataService = CoinDataServiceMock(coins: [coin2, coin1, coin3])
        let marketDataService = MarketDataServiceMock()
        let vm = HomeViewModel(coinDataService: coinDataService, marketDataService: marketDataService)
        
        var cancellable = Set<AnyCancellable>()
        let exp = expectation(description: "Wait for result")
        
        vm.$allCoins.sink { returnedCoins in
            guard returnedCoins.count == 3 else { return }
            XCTAssertEqual("1", returnedCoins[0].id)
            XCTAssertEqual("2", returnedCoins[1].id)
            XCTAssertEqual("3", returnedCoins[2].id)
            exp.fulfill()
        }.store(in: &cancellable)
        
        coinDataService.getCoins()
        
        wait(for: [exp], timeout: 1)
    }
    
    func test
    
    class CoinDataServiceMock: CoinDataServiceBase, CoinDataServiceProtocol  {
        private let data: [CoinModel]
        
        init(coins: [CoinModel]) {
            self.data = coins
            super.init()
        }
        
        func getCoins() {
            self.allCoins = data
        }
    }
    
    class MarketDataServiceMock: MarketDataServiceBase, MarketDataServiceProtocol {
        func getData() {
            print("MarketDataServiceMock.getData")
        }
    }
}
