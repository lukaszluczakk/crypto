//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 20/07/2021.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var statistics: [StatistictModel] = []
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    @Published var sortOption: SortOption = .holdings
    
    private let coinDataService: CoinDataService
    private let marketDataService: MarketDataService
    private let portfolioDataService = PortfolioDataService()
    private var cancellable = Set<AnyCancellable>()
    
    enum SortOption {
        case  rank, rankReversed, holdings, holdingsReversed, price, priceReversed
    }
    
    init(networkManager: NetworkingManager) {
        self.coinDataService = CoinDataService(networkManager: networkManager)
        self.marketDataService = MarketDataService(networkManager: networkManager)
        addSubscribers()
    }
    
    func addSubscribers(){
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSort)
            .sink { [weak self] (coins) in
                self?.allCoins = coins
            }
            .store(in: &cancellable)
        
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolioCoins)
            .sink { [weak self] (returnedCoins) in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellable)
        
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapGlobalMarketData)
            .sink { [weak self] (returnedStats) in
                self?.statistics = returnedStats
                self?.isLoading = false
            }
            .store(in: &cancellable)
    }
    
    public func updatePortfolio(coin: CoinModel, amount: Double){
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    public func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
    }
    
    private func filterAndSort(text: String, coins: [CoinModel], sort: SortOption) -> [CoinModel] {
        var filteredCoins = filterCoins(text: text, coins: coins)
        sortCoins(sort: sort, coins: &filteredCoins)
        return filteredCoins
    }
    
    private func sortCoins(sort: SortOption, coins: inout [CoinModel]) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: {$0.rank < $1.rank})
        case .rankReversed, .holdingsReversed:
            coins.sort(by: {$0.rank > $1.rank})
        case .price:
            coins.sort(by: {$0.currentPrice > $1.currentPrice})
        case .priceReversed:
            coins.sort(by: {$0.currentPrice < $1.currentPrice})
        }
    }
    
    private func sortPortfolioIfNeeded(coins: [CoinModel]) -> [CoinModel] {
        switch sortOption {
        case .holdings:
            return coins.sorted(by: {$0.currentHoldingsValue > $1.currentHoldingsValue})
        case .holdingsReversed:
            return coins.sorted(by: {$0.currentHoldingsValue < $1.currentHoldingsValue})
        default:
            return coins
        }
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
    
    private func mapAllCoinsToPortfolioCoins(allCoins: [CoinModel], portfolioCoins: [PortfolioEntity]) ->  [CoinModel] {
        return allCoins.compactMap { (coin) -> CoinModel? in
            guard let entity = portfolioCoins.first(where: {$0.coinID == coin.id}) else {
                return nil
            }
            
            return coin.updateHoldings(amount: entity.amount)
        }
    }
    
    private func mapGlobalMarketData(marketData: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatistictModel] {
        var stats: [StatistictModel] = []
        guard let data = marketData else {
            return stats
        }
        
        let marketCap = StatistictModel(title: "Market cap", value: data.marketCap, percentageChange: data.marketCapChangePercentage24HUsd)
        let volumne = StatistictModel(title: "25h volume", value: data.volume)
        let btcDominate = StatistictModel(title: "BTC dominate", value: data.btcDominate)
        
        let portfolioValue =
            portfolioCoins
            .map({ $0.currentHoldingsValue })
            .reduce(0, +)
        
        let previousValue =
            portfolioCoins
            .map { coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = coin.priceChangePercentage24H ?? 0 / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentChange = ((portfolioValue - previousValue) * portfolioValue)
        
        let portfolio = StatistictModel(title: "Portfolio value", value: portfolioValue.asCurrencyWith2Decimals(), percentageChange: percentChange)
        
        stats.append(contentsOf: [marketCap, volumne, btcDominate, portfolio])
        return stats
    }
}
