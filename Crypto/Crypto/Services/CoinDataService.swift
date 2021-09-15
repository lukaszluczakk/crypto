//
//  CoinDataService.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 21/07/2021.
//

import Foundation
import Combine

class CoinDataServiceBase {
    @Published var allCoins: [CoinModel] = []
}

protocol CoinDataServiceProtocol: CoinDataServiceBase {
    func getCoins()
}

class CoinDataService: CoinDataServiceBase, CoinDataServiceProtocol {
    private var networkManager: NetworkingManager
    var subscription: AnyCancellable?
    
    init(networkManager: NetworkingManager) {
        self.networkManager = networkManager
        super.init()
        getCoins()
    }
    
    func getCoins()
    {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true&price_change_percentage=24h") else {
            return
        }
        
        subscription = networkManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: networkManager.handleCompletion, receiveValue: { [weak self] (returnedData) in
                self?.allCoins = returnedData
                self?.subscription?.cancel() 
            })
    }
}
