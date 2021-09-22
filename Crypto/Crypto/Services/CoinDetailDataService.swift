//
//  CoinDetailDataService.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 01/08/2021.
//

import Foundation
import Combine

class CoinDetailDataService {
    @Published var coinDetails: CoinDetailModel? = nil
    
    private let networkManager: NetworkingManager
    var coinDetailSubscription: AnyCancellable?
    let coin: CoinModel
    
    init(coin: CoinModel, networkManager: NetworkingManager) {
        self.coin = coin
        self.networkManager = networkManager
        getCoinDetails()
    }
    
    func getCoinDetails()
    {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=true&market_data=false&community_data=false&developer_data=false&sparkline=false") else {
            return
        }
        
        coinDetailSubscription = networkManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: networkManager.handleCompletion, receiveValue: { [weak self] (returnedData) in
                self?.coinDetails = returnedData
                print("DUPA")
                print(returnedData)
                self?.coinDetailSubscription?.cancel()
            })
    }
}
