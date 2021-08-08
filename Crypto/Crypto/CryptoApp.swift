//
//  CryptoApp.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 18/07/2021.
//

import SwiftUI

@main
struct CryptoApp: App {
    @StateObject private var vm: HomeViewModel
    @State private var showLaunchView: Bool = true
    private let networkManager: NetworkingManager
    
    init() {
        self.networkManager = NetworkManager()
        let homeViewModel = HomeViewModel(networkManager:  self.networkManager)
        self._vm = StateObject(wrappedValue: homeViewModel)
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UITableView.appearance().backgroundColor = UIColor.clear
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView(networkManager: networkManager)
                    .navigationBarHidden(true)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .environmentObject(vm)

            
        }
    }
}
