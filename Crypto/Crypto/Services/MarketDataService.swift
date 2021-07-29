//
//  MarketDataService.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 29/07/2021.
//

import Foundation
import Combine

class MarketDataService {
    @Published var marketData: MarketDataModel? = nil
    
    var marketDatasubscription: AnyCancellable?
    
    init() {
        getData()
    }

    private func getData()
    {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {
            return
        }
        
        marketDatasubscription = NetworkingManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
                self?.marketDatasubscription?.cancel()
            })
    }
}
