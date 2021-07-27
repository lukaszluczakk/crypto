//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 20/07/2021.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var statistics: [StatistictModel] = [
        StatistictModel(title: "Statistic 1", value: "$12.12"),
        StatistictModel(title: "Statistic 2", value: "$12.12"),
        StatistictModel(title: "Statistic 3", value: "$12.12"),
        StatistictModel(title: "Statistic 4", value: "$12.12")
    ]
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    
    private let coinDataService = CoinDataService()
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
}
