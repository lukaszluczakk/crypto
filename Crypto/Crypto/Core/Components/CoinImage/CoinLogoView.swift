//
//  CoinLogoView.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 29/07/2021.
//

import SwiftUI

struct CoinLogoView: View {
    private let networkManager: NetworkingManager
    
    let coin: CoinModel
    
    init(coin: CoinModel, networkManager: NetworkingManager) {
        self.coin = coin
        self.networkManager = networkManager
    }
    
    var body: some View {
        VStack {
            CoinImageView(coin: coin, networkManager: self.networkManager)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.0)
            Text(coin.name)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
            
        }
    }
}

struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinLogoView(coin: dev.coin, networkManager: dev.networkManager)
                .preview(with: "Coin logo")
            CoinLogoView(coin: dev.coin, networkManager: dev.networkManager)
                .preferredColorScheme(.dark)
                .preview(with: "Dark coin logo")
        }
    }
}
