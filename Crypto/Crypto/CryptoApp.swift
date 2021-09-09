//
//  CryptoApp.swift
//  Crypto
//
//  Created by Łukasz Łuczak on 18/07/2021.
//

import SwiftUI
import Firebase

//final class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//        return true
//    }
//}

@main
struct CryptoApp: App {
    
    //@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var sessionService = FirebaseSessionService()
    @StateObject private var vm: HomeViewModel
    @State private var showLaunchView: Bool = true
    private let networkManager: NetworkingManager
    //private let authenticationService: AuthenticationServiceProtocol = FirebaseAuthenticationService()
    
    init() {
        FirebaseApp.configure()
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
