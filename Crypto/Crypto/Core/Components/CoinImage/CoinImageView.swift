//
//  CoinImageView.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 23/07/2021.
//

import SwiftUI

struct CoinImageView: View {
    @StateObject var vm: CoinImageViewModel
    
    init(coin: CoinModel, networkManager: NetworkingManager) {
        _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin, networkManager: networkManager))
    }
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if vm.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {
        CoinImageView(coin: dev.coin, networkManager: dev.networkManager)
            .preview(with: "Coin image")
    }
}
