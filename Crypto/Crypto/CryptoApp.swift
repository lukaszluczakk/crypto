//
//  CryptoApp.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 18/07/2021.
//

import SwiftUI
import Firebase

@main
struct CryptoApp: App {
    @StateObject private var sessionService: SessionService = SessionServiceFactory.getService()
    @StateObject private var vm: HomeViewModel
    @State private var showLaunchView: Bool = true
    private let networkManager: NetworkingManager
    
    init() {
        FirebaseApp.configure()
        self.networkManager = NetworkManager()
        let coinDataService = CoinDataService(networkManager: networkManager)
        let marketDataService = MarketDataService(networkManager: networkManager)
        let homeViewModel = HomeViewModel(coinDataService: coinDataService, marketDataService: marketDataService)
        self._vm = .init(wrappedValue: homeViewModel)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                switch sessionService.state {
                case .loggedIn:
                    HomeView(networkManager: networkManager)
                        .environmentObject(sessionService)
                        .navigationBarHidden(true)
                case .loggedOut:
                    LoginView()
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(vm)

            
        }
    }
}
