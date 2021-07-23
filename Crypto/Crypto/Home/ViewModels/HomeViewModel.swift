//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 20/07/2021.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    
    private let coinDataService = CoinDataService()
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers(){
        coinDataService.$allCoins
            .sink { [weak self] (returnedData) in
                self?.allCoins = returnedData
            }
            .store(in: &cancellable)
    }
}
