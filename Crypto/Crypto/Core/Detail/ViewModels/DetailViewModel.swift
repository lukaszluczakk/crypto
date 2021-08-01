//
//  DetailViewModel.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 01/08/2021.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    private let coinDetailDataService: CoinDetailDataService
    private var cancellable = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coinDetailDataService = CoinDetailDataService(coin: coin)
    }
    
    private func addSubscribers(){
        coinDetailDataService.$coinDetails
            .sink { (returnedData) in
                print(returnedData)
            }
            .store(in: &cancellable)
    }
}
