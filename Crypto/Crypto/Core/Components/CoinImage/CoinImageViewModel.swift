//
//  CoinImageViewModel.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 24/07/2021.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject  {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    private let coin: CoinModel
    private let dataService: CoinImageService
    private var cancellable = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        self.addSubscribers()
    }
    
    private func addSubscribers(){
        self.dataService.$image.sink { [weak self ](_) in
            self?.isLoading = false
        } receiveValue: { [weak self] (returnedImage) in
            self?.image = returnedImage
        }
        .store(in: &cancellable)
    }
}
