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
    func testAllCoinsShouldBeSorted(){
        let coin1 = CoinModelHelper.createCoinModel(id: "1", marketCapRank: 1, currentPrice: 1)
        let coin2 = CoinModelHelper.createCoinModel(id: "2", marketCapRank: 2, currentPrice: 2)
        let coin3 = CoinModelHelper.createCoinModel(id: "3", marketCapRank: 3, currentPrice: 3)
        
        let coinDataService: CoinDataServiceProtocol = CoinDataServiceMock(coins: [coin2, coin1, coin3])
        let marketDataService = MarketDataServiceMock()
        let vm = HomeViewModel(coinDataService: coinDataService, marketDataService: marketDataService)
        
    }
    
    class CoinDataServiceMock: CoinDataServiceBase, CoinDataServiceProtocol {
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
