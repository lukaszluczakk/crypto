//
//  DetailViewModel.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 01/08/2021.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
    @Published var overviewStatistics: [StatistictModel] = []
    @Published var additionalStatistics: [StatistictModel] = []
    @Published var coin: CoinModel
    @Published var coinDescription: String? = nil
    @Published var websiteURL: String? = nil
    @Published var redditURl: String? = nil
    
    private let coinDetailDataService: CoinDetailDataService
    private var cancellable = Set<AnyCancellable>()
    
    init(coin: CoinModel, networkManager: NetworkingManager) {
        self.coin = coin
        self.coinDetailDataService = CoinDetailDataService(coin: coin, networkManager: networkManager)
        self.addSubscribers()
    }
    
    private func addSubscribers(){
        
        coinDetailDataService.$coinDetails
            .combineLatest($coin)
            .map(mapDataToStatistics)
            .sink { [weak self] (returnedArrays) in
                self?.overviewStatistics = returnedArrays.overview
                self?.additionalStatistics = returnedArrays.additional
            }
            .store(in: &cancellable)

        coinDetailDataService.$coinDetails
            .sink { [weak self] (returnedCoinDetails) in
                self?.coinDescription = returnedCoinDetails?.description?.en
                self?.websiteURL = returnedCoinDetails?.links?.homepage?.first
                self?.redditURl = returnedCoinDetails?.links?.subredditURL
            }
            .store(in: &cancellable)
    }
    
    private func mapDataToStatistics(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatistictModel], additional: [StatistictModel]) {
        let overviewStatistics = createOverviewArray(coinModel: coinModel)
        let additionalStatistics = createAdditionalArray(coinModel: coinModel, coinDetailModel: coinDetailModel)
        
        return (overviewStatistics, additionalStatistics)
    }
    
    private func createOverviewArray(coinModel: CoinModel) -> [StatistictModel] {
        let price = coinModel.currentPrice.asCurrencyWith6Decimals()
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceStat = StatistictModel(title: "Current price", value: price, percentageChange: pricePercentChange)
        
        let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapStat = StatistictModel(title: "Market capilization", value: marketCap, percentageChange: marketCapPercentChange )
        
        let rank = "\(coinModel.rank)"
        let rankStat = StatistictModel(title: "Rank", value: rank)
        
        let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = StatistictModel(title: "Volume", value: volume)
        
        let overviewStatistics: [StatistictModel] = [priceStat, marketCapStat, rankStat, volumeStat]
        return overviewStatistics
    }
    
    private func createAdditionalArray(coinModel: CoinModel, coinDetailModel: CoinDetailModel?) -> [StatistictModel] {
        let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = StatistictModel(title: "24h High", value: high)
        
        let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = StatistictModel(title: "24h Low", value: low)
        
        let priceChange = coinModel.priceChange24H?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercentChange = coinModel.priceChangePercentage24H
        let priceChangeStat = StatistictModel(title: "24h Price Change", value: priceChange, percentageChange: pricePercentChange)
        
        let marketCapChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange = coinModel.marketCapChangePercentage24H
        let marketCapChangeStat = StatistictModel(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange)
        
        let blockTime = coinDetailModel?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockTimeStat = StatistictModel(title: "Block time", value: blockTimeString)
        
        let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
        let hashingStat = StatistictModel(title: "Hashing algorithm", value: hashing)
        
        let additionalStatistics: [StatistictModel] = [highStat, lowStat, priceChangeStat, marketCapChangeStat, blockTimeStat, hashingStat]
        return additionalStatistics
    }
}
