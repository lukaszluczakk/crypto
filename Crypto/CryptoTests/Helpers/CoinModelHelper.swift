//
//  CoinModelHelper.swift
//  CryptoTests
//
//  Created by Łukasz Łuczak on 15/09/2021.
//

import Foundation

class CoinModelHelper {
    static func createCoinModel(id: String, symbol: String = "btc", name: String = "bitcoin", marketCapRank: Double? = nil, currentPrice: Double = 0) -> CoinModel {
        CoinModel(
            id: id,
            symbol: symbol,
            name: name,
            image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
            currentPrice: 150,
            marketCap: 1141731099010,
            marketCapRank: 1,
            fullyDilutedValuation: 1285385611303,
            totalVolume: 67190952980,
            high24H: 61712,
            low24H: 56220,
            priceChange24H: 3952.64,
            priceChangePercentage24H: 6.87944,
            marketCapChange24H: 72110681879,
            marketCapChangePercentage24H: 6.74171,
            circulatingSupply: 18653043,
            totalSupply: 21000000,
            maxSupply: 21000000,
            ath: 61712,
            athChangePercentage: -0.97589,
            athDate: "2021-03-13T20:49:26.606Z",
            atl: 67.81,
            atlChangePercentage: 90020.24075,
            atlDate: "2013-07-06T00:00:00.000Z",
            lastUpdated: "2021-03-13T23:18:10.268Z",
            sparklineIn7D: SparklineIn7D(price: [
                54019.26878317463,
            ]),
            priceChangePercentage24HInCurrency: 3952.64,
            currentHoldings: 2.0)
    }
}
