//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 20/07/2021.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var statistics: [StatistictModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers(){
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] (coins) in
                self?.allCoins = coins
            }
            .store(in: &cancellable)
        
        marketDataService.$marketData
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
            }
            .store(in: &cancellable)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowerCaseText = text.lowercased()
        
        let filteredCoins = coins.filter { (coin) -> Bool in
            return coin.name.lowercased().contains(lowerCaseText)
                ||  coin.symbol.lowercased().contains(lowerCaseText)
                ||  coin.id.lowercased().contains(lowerCaseText)
        }
        
        return filteredCoins
    }
    
    private func mapGlobalMarketData(marketData: MarketDataModel?) -> [StatistictModel] {
        var stats: [StatistictModel] = []
        guard let data = marketData else {
            return stats
        }
        
        let marketCap = StatistictModel(title: "Market cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volumne = StatistictModel(title: "25h volume", value: data.volume)
        let btcDominate = StatistictModel(title: "BTC dominate", value: data.btcDominate)
        let portfolio = StatistictModel(title: "Portfolio value", value: "$0.0", percentageChange: 0)
        
        stats.append(contentsOf: [marketCap, volumne, btcDominate, portfolio])
        return stats
    }
}
