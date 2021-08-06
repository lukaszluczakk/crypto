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
    
    var coinDetailSubscription: AnyCancellable?
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
        getCoinDetails()
    }
    
    func getCoinDetails()
    {
        guard let url = URL(string: " https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=true&market_data=false&community_data=false&developer_data=false&sparkline=false") else {
            return
        }
        
        coinDetailSubscription = NetworkingManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedData) in
                self?.coinDetails = returnedData
                self?.coinDetailSubscription?.cancel()
            })
    }
}
