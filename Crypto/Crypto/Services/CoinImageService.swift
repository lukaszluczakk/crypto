//
//  CoinImageService.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 24/07/2021.
//

import Foundation
import Combine
import SwiftUI

class CoinImageService {
    
    @Published var image: UIImage? = nil
    private let networkManager: NetworkingManager
    private var imageSubscription: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName : String
    
    
    init(coin: CoinModel, networkManager: NetworkingManager){
        self.coin = coin
        self.imageName = coin.id
        self.networkManager = networkManager
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: coin.id, folderName: folderName) {
            image = savedImage
            print("`retrived image from local file manager")
        } else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage(){
        guard let url = URL(string: coin.image) else {
            return
        }
        
        imageSubscription = networkManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: self.networkManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
                print("image downloaded")
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = returnedImage
                self.imageSubscription?.cancel()
                Task.detached(priority: .background) {
                    self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
                }
            })
    }
}
