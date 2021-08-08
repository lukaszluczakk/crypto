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
    
    private let networkManager: NetworkingManager
    var marketDatasubscription: AnyCancellable?
    
    init(networkManager: NetworkingManager) {
        self.networkManager = networkManager
        getData()
    }

    func getData()
    {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else {
            return
        }
        
        marketDatasubscription = networkManager.download(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: networkManager.handleCompletion, receiveValue: { [weak self] (returnedGlobalData) in
                self?.marketData = returnedGlobalData.data
                self?.marketDatasubscription?.cancel()
            })
    }
}
