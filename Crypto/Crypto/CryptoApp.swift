//
//  CryptoApp.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 18/07/2021.
//

import SwiftUI

@main
struct CryptoApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
        }
    }
}
